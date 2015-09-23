using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.WindowsAzure.Storage.Table.DataServices;
using Microsoft.WindowsAzure.Storage.Table;

namespace InterroleCommons
{
    public class PerformanceCountersEntity : TableEntity
    {
        /// <summary>
        /// Gets or sets the EventTickCount entry value.
        /// </summary>
        public long EventTickCount { get; set; }

        /// <summary>
        /// Gets or sets the DeploymentId entry value.
        /// </summary>
        public string DeploymentId { get; set; }

        /// <summary>
        /// Gets or sets the Role entry value.
        /// </summary>
        public string Role { get; set; }

        /// <summary>
        /// Gets or sets the RoleInstance entry value.
        /// </summary>
        public string RoleInstance { get; set; }

        /// <summary>
        /// Gets or sets the CounterName entry value.
        /// </summary>
        public string CounterName { get; set; }

        /// <summary>
        /// Gets or sets the CounterValue entry value.
        /// </summary>
        public double CounterValue { get; set; }
    }
}
