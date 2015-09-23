using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.ServiceRuntime;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Table;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InterroleCommons
{
    public class LoadBalancerCommons
    {
        /**Constants**/
        //umbrals of CPU utilisation
        public const double L = 1.3;
        public const double H = 0.7;
        
        //metrics
        public const string PROCESSOR = "\\Processor(_Total)\\% Processor Time";
        public const string MEMORY = "\\Memory\\Available MBytes";
        
        //MAX_MEMORY must be greater than zero
        public const int MAX_MEMORY = 7000;

        //MAX and MIN percentages
        public const double IDLE = 30;
        public const double H_LOADED = 85;

        public const double SPAN_TIME = -600;

        public static double obtenerMetricas(string instanceId, string role, bool processor)
        {
            //PERFORMANCE COUNTERS TABLE Query
            // Retrieve the storage account from the connection string.
            CloudStorageAccount storageAccount = CloudStorageAccount.Parse(
                CloudConfigurationManager.GetSetting("StorageConnectionString"));

            // Create the table client.
            CloudTableClient tableClient = storageAccount.CreateCloudTableClient();

            //Create the CloudTable object that represents the "people" table.
            CloudTable table = tableClient.GetTableReference("WADPerformanceCountersTable");

            //Sets the metric variable
            string metric = LoadBalancerCommons.MEMORY;
            if (processor)
            {
                metric = LoadBalancerCommons.PROCESSOR;
            }

            // span Partition Key
            DateTime now = DateTime.UtcNow;

            // Current Partition Key
            string partitionKeyNow = string.Format("0{0}", now.Ticks.ToString());
            
            DateTime minutesSpan = now.AddMinutes(LoadBalancerCommons.SPAN_TIME);
            string partitionKeyTenMinutesBack = string.Format("0{0}", minutesSpan.Ticks.ToString());

            // Create the table query.           
            TableQuery<PerformanceCountersEntity> rangeQuery = new TableQuery<PerformanceCountersEntity>().Where(
                TableQuery.CombineFilters(
                    TableQuery.CombineFilters(
                        TableQuery.CombineFilters(
                            TableQuery.GenerateFilterCondition("PartitionKey", QueryComparisons.LessThan, partitionKeyNow),
                            TableOperators.And,
                            TableQuery.GenerateFilterCondition("PartitionKey", QueryComparisons.GreaterThan, partitionKeyTenMinutesBack)),
                        TableOperators.And,
                        TableQuery.CombineFilters(
                            TableQuery.GenerateFilterCondition("Role", QueryComparisons.Equal, role),
                            TableOperators.And,
                            TableQuery.GenerateFilterCondition("RoleInstance", QueryComparisons.Equal, instanceId))
                        ),
                 TableOperators.And,
                 TableQuery.GenerateFilterCondition("CounterName", QueryComparisons.Equal, metric)
                ));

            //If Not processor => Memoria
            double avUsage = 0;
            double sum = 0;
            int count = 0;

            if (processor)
            {
                //Se calcula el uso promedio de CPU               
                foreach (PerformanceCountersEntity entity in table.ExecuteQuery(rangeQuery))
                {
                    count++;
                    sum += entity.CounterValue;
                }               
            }
            else
            {
                double percentage = 0;
                //Se calcula la utilizacion promedio de la memoria            
                foreach (PerformanceCountersEntity entity in table.ExecuteQuery(rangeQuery))
                {
                    percentage = (entity.CounterValue * 100) / LoadBalancerCommons.MAX_MEMORY;
                    count++;
                    sum += percentage;
                } 
            }

            if (count > 0)
            {
                avUsage = sum / count;
            }
           
            return avUsage;
        }       
    }
}
