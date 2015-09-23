using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.Diagnostics;
using Microsoft.WindowsAzure.ServiceRuntime;
using Microsoft.WindowsAzure.Storage;
using Newtonsoft.Json.Linq;
using System.IO;
using System.Security.Cryptography.X509Certificates;
using Microsoft.WindowsAzure.Storage.Blob;
using Microsoft.WindowsAzure.Management.HDInsight;
using Microsoft.Hadoop.Client;
using Microsoft.WindowsAzure.Storage.Auth;
using InterroleCommons;
using System.ServiceModel;



namespace JobCreation
{
    public class WorkerRole : RoleEntryPoint
    {
        private readonly CancellationTokenSource cancellationTokenSource = new CancellationTokenSource();
        private readonly ManualResetEvent runCompleteEvent = new ManualResetEvent(false);

        public ServiceHost ServiceHost { get; private set; }

        private void StartServiceHost()
        {            
            Trace.WriteLine("Starting Job Submission Service Host", "Information");
            
            ServiceHost = new ServiceHost(typeof(JobSubmissionServiceHost));
            this.ServiceHost.Faulted += (sender, e) =>
            {
                Trace.TraceError("Job Submission Service Host fault occured");
                this.ServiceHost.Abort();
                Thread.Sleep(500);
                this.StartServiceHost();
            };

            NetTcpBinding binding = new NetTcpBinding(SecurityMode.None);
            RoleInstanceEndpoint JobSubmissionServiceHostEndPoint = RoleEnvironment.CurrentRoleInstance.InstanceEndpoints["JobSubmissionServiceEndPoint"];

            this.ServiceHost.AddServiceEndpoint(
                typeof(IReceiveJobSubmission),
                binding,
                String.Format("net.tcp://{0}/JobSubmissionService", JobSubmissionServiceHostEndPoint.IPEndpoint)
                );

            try
            {
                this.ServiceHost.Open();
                Trace.TraceInformation("Job Submition Service Host Opened");
            }
            catch (TimeoutException timeoutException)
            {
                Trace.TraceError("Job Submission Service Host open failure, Time Out: " + timeoutException.Message);
            }
            catch (CommunicationException communicationException)
            {
                Trace.TraceError("Job Submission Service Host open failure, Communication Error: " + communicationException.Message);
            }

            Trace.WriteLine("Job Submission Service Host Started", "Information");
        }

        public void ServiceHost_JobSubmissionRecieved(object sender, JobSubmissionMessage e)
        {
            Trace.WriteLine("JobSubmissionRecieved Recieved User Id : " + e.idUsuario, "Warning");
            try
            {
                // Obtener la cuenta de almacenamiento
                // Para actualizar metadatos
                CloudStorageAccount storageAccount = CloudStorageAccount.Parse(
                    CloudConfigurationManager.GetSetting("StorageConnectionString"));

                CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
                CloudBlobContainer container = blobClient.GetContainerReference(VariablesConfiguracion.containerName);

                // Obtencion de variables para la conxion con el cluster
                string subscriptionID = VariablesConfiguracion.subscriptionID;
                string certFriendlyName = VariablesConfiguracion.certFriendlyName;                

                string clusterName = VariablesConfiguracion.clusterName;

                // Definicion de la tarea MapReduce
                MapReduceJobCreateParameters mrJobDefinition = new MapReduceJobCreateParameters()
                {
                    JarFile = "wasb:///CienciaCelularMR.jar",
                    ClassName = "Main",
                    StatusFolder = "wasb:///scicluster/test/status-" + e.idUsuario + "." + e.subIdUsuario,
                    
                };

                mrJobDefinition.Arguments.Add("wasb:///" + e.nomEntrada);
                mrJobDefinition.Arguments.Add("wasb:///scicluster/test/output-" + e.idUsuario + "." + e.subIdUsuario);

                // Obtener el objeto certificate
                X509Store store = new X509Store();
                store.Open(OpenFlags.ReadOnly);

                X509Certificate2 cert = FindCertificate(StoreLocation.CurrentUser, StoreName.My, X509FindType.FindByThumbprint, VariablesConfiguracion.thumbprint);
                JobSubmissionCertificateCredential creds = new JobSubmissionCertificateCredential(new Guid(subscriptionID), cert, clusterName);

                // Se crea un cliente Hadoop para conectarse con HDInsight
                var jobClient = JobSubmissionClientFactory.Connect(creds);

                //Actualizacion de metadatos
                CloudBlockBlob infoSimulation = container.GetBlockBlobReference(VariablesConfiguracion.infoSimulation + "-" + e.idUsuario);
                infoSimulation.UploadText(VariablesConfiguracion.JOB_STARTING);

                // Se lanza la ejecucion de los jobs MapReduce
                JobCreationResults mrJobResults = jobClient.CreateMapReduceJob(mrJobDefinition);

                // Esperar hasta que finalice la ejecucion
                WaitForJobCompletion(mrJobResults, jobClient, e.idUsuario, e.subIdUsuario);

            }
            catch (Exception ex)
            {
                Trace.TraceError(ex.Message);
                throw;
            }
        }

        private X509Certificate2 FindCertificate(StoreLocation storeLocation, StoreName storeName, X509FindType findType, object searchCriteria)
        {
            X509Store certificateStore = new X509Store(storeName, storeLocation);
            certificateStore.Open(OpenFlags.ReadOnly);
            X509Certificate2Collection certificates = certificateStore.Certificates;
            X509Certificate2Collection matchingCertificates = certificates.Find(findType, searchCriteria, false);
            if (matchingCertificates != null && matchingCertificates.Count > 0)
            {
                return matchingCertificates[0];
            }
            throw new ArgumentException("No es posible encontrar el certificado especificado. Por favor modifique el criterio de búsqueda.");
        }

        public override void Run()
        {
            Trace.TraceInformation("JobCreation is running");

            try
            {
                this.StartServiceHost();
                //Pare prevenir que el worker role se recicle
                while (true) { };
            }
            finally
            {
                this.runCompleteEvent.Set();
            }
        }

        public override bool OnStart()
        {
            // Set the maximum number of concurrent connections
            ServicePointManager.DefaultConnectionLimit = 12;

            // For information on handling configuration changes
            // see the MSDN topic at http://go.microsoft.com/fwlink/?LinkId=166357.

            bool result = base.OnStart();

            Trace.TraceInformation("JobCreation has been started");

            return result;
        }

        public override void OnStop()
        {
            Trace.TraceInformation("JobCreation is stopping");

            this.cancellationTokenSource.Cancel();
            this.runCompleteEvent.WaitOne();

            base.OnStop();

            Trace.TraceInformation("JobCreation has stopped");
        }

        private static void WaitForJobCompletion(JobCreationResults jobResults, IJobSubmissionClient client, String idUsuario, String subIdUsuario)
        {
            try
            {
                // Retrieve storage account from connection string.
                CloudStorageAccount storageAccount = CloudStorageAccount.Parse(
                    CloudConfigurationManager.GetSetting("Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString"));

                // Create the blob client.
                CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();

                // Retrieve reference to a previously created container.
                CloudBlobContainer container = blobClient.GetContainerReference(VariablesConfiguracion.containerName);
                CloudBlockBlob blockBlob = container.GetBlockBlobReference("pruebaProgreso-" + idUsuario + "." + subIdUsuario);

                JobDetails jobInProgress = client.GetJob(jobResults.JobId);
                while (jobInProgress.StatusCode != JobStatusCode.Completed && jobInProgress.StatusCode != JobStatusCode.Failed)
                {
                    blockBlob.UploadText(VariablesConfiguracion.JOB_RUNNING);
                    jobInProgress = client.GetJob(jobInProgress.JobId);
                }

                if (jobInProgress.StatusCode == JobStatusCode.Failed)
                {
                    blockBlob.UploadText(VariablesConfiguracion.JOB_FAIL);
                }
                else if (jobInProgress.StatusCode == JobStatusCode.Completed)
                {
                    blockBlob.UploadText(VariablesConfiguracion.JOB_SUCCESS);
                }                
            }
            catch (Exception ex)
            {
                Trace.TraceError(ex.Message);
                throw;
            }
            finally {

            }
        }

    }
}
