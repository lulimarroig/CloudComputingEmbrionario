using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.UI.HtmlControls;
using System.Web.Services;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.Storage.Blob;
using System.Xml;
using System.Threading;
using InterroleCommons;
using System.Web.Script.Serialization;
using System.Net;
using System.Windows.Forms;

namespace Web_Role
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private Dictionary<string, string> init_parametrosMap = new Dictionary<string, string>();
        private Dictionary<string, string> init_fijos = new Dictionary<string, string>();
        private Dictionary<string, string> notif_parametrosMap = new Dictionary<string, string>();
        private Dictionary<string, string> warn_parametrosMap = new Dictionary<string, string>();
        private static List<Molecula> moleculas;
        private static List<Reaccion> reacciones;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                //Carga de datos para la simulación por defecto
                moleculas = new List<Molecula>();
                reacciones = new List<Reaccion>();

                iterationsValue.Value = "1000";
                timeStepValue.Value = "1e-05";

                x1.Value = "-1.5";
                y1.Value = "-1.5";
                z1.Value = "-1.5";

                x2.Value = "1.5";
                y2.Value = "1.5";
                z2.Value = "1.5";

                aspectRatioValue.Value = "";
                
                //Se setean aquí y adicionalmente en javascript - AccionesParametros.js
                moleculas.Add(new Molecula("A", "55e-08", "", 200));
                moleculas.Add(new Molecula("B", "30e-08", "", 200));

                //reacciones.Add(new Reaccion("Reaccion1", "A + B -> A ", 1.1e-6, 1.2e-6, 0.1e-6));
                //reacciones.Add(new Reaccion("Reaccion2", "A + A -> B ", 0.3, 0.4, 0.1));
                //reacciones.Add(new Reaccion("Reaccion1", "A + B -> A ", 0.06, 0.08, 0.01));

                nameListValue.Value = "A";
            }                      
        }


        #region Simulacion

        [WebMethod]
        public static int simular_Click(string data)
        {
            string[] parameters = data.Split('|');

            //Parseo de los parametros ingresados para la simulacion
            if (parameters.Length == 11)
            {

                string iterations = parameters[0];
                string timeStep = parameters[1];
                string aspectRatio = parameters[2];
                string nameList = parameters[3];

                string x1 = parameters[4];
                string y1 = parameters[5];
                string z1 = parameters[6];

                string x2 = parameters[7];
                string y2 = parameters[8];
                string z2 = parameters[9];

                string fernetMode = parameters[10];

                //Generación de json que será enviado al rol Message Processing
                string jsonmsg = "{\"init\":{\"iterations\":\"" + iterations + "\",\"timeStep\":\"" + timeStep + "\"},"
                    + "\"geometria\":{\"box\":{ \"nombre\":\"caja\",\"corners\":[[\"" + x1 + "\",\"" + y1 + "\",\"" + z1 + "\"],"
                    + "[\"" + x2 + "\",\"" + y2 + "\",\"" + z2 + "\"]],\"aspectRatio\":\"" + aspectRatio + "\"}},"
                    + "\"moleculas\":{\"nameList\":\"" + nameList + "\",\"defineMoleculas\":[";

                foreach (Molecula m in moleculas)
                {
                    jsonmsg += "{\"nombre\":\"" + m.getNombreMolecula() + "\",\"difusion3D\":\"" + m.getConstanteDifusion3D() + "\","
                        + "\"difusion2D\":\"" + m.getConstanteDifusion2D() + "\",\"cantidad\":\"" + m.getCantidad() + "\"},";
                }
                jsonmsg += "]},\"reacciones\":[";

                foreach (Reaccion r in reacciones)
                {
                    jsonmsg += "{\"reaccion\":\"" + r.getReaccion() + "\",\"nombre\":\"" + r.getNombreReaccion() + "\","
                        + "\"rate\":{\"rateInicio\":\"" + r.getRateInicio() + "\",\"rateFin\":\"" + r.getRateFin() + "\","
                        + "\"rateStep\":\"" + r.getRateStep() + "\"}},";
                }
                jsonmsg += "],\"fernet\":{"
                            + "\"mode\":\"" + fernetMode + "\""
                    + "}}";


                // Obtenemos Storage Account para obtener el Id del usuario
                // Ademas se actualiza este id en el blob
                CloudStorageAccount storageAccount = CloudStorageAccount.Parse(
                    CloudConfigurationManager.GetSetting("StorageConnectionString"));

                CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
                CloudBlobContainer container = blobClient.GetContainerReference(VariablesConfiguracion.containerName);

                CloudBlockBlob userIncrement = container.GetBlockBlobReference(VariablesConfiguracion.userIDVariable);

                if (!userIncrement.Exists())
                {
                    userIncrement.UploadText("0");
                }

                string mensaje = userIncrement.DownloadText();
                int userId = Convert.ToInt32(mensaje) + 1;
                userIncrement.UploadText(Convert.ToString(userId));

                string idString = Convert.ToString(userId);

                //Envío del json
                Thread myNewThread = new Thread(() => WebRole.SendClientInput(jsonmsg, idString));
                myNewThread.Start();

                //Actualización de metadatos
                CloudBlockBlob infoSimulation = container.GetBlockBlobReference(VariablesConfiguracion.infoSimulation + "-"+userId);
                infoSimulation.UploadText(VariablesConfiguracion.JOB_CREATING);

                return userId;
            }

            return -1;
        }   
    
        [WebMethod]
        public static void borrarMolecula_Click(string nombre){
            Molecula result = moleculas.Find(m => m.getNombreMolecula() == nombre);
            if (result != null)
            {
                moleculas.Remove(result);
            }

        }

        [WebMethod]
        public static void borrarReaccion_Click(string nombre)
        {
            Reaccion reaccion = reacciones.Find(r => r.getNombreReaccion() == nombre);
            if (reaccion != null)
            {
                reacciones.Remove(reaccion);
            }
            
        }

        [WebMethod]
        public static void agregarMolecula_Click(string data){
            string[] parameters = data.Split(',');
            moleculas.Add(new Molecula(parameters[0], parameters[1], parameters[2], Int32.Parse(parameters[3])));
        }

        [WebMethod]
        public static void agregarReaccion_Click(string data)
        {
            string[] parameters = data.Split(',');
            reacciones.Add(new Reaccion(parameters[0], parameters[1], Double.Parse(parameters[2]),
                Double.Parse(parameters[3]),
            Double.Parse(parameters[4])));
        }
        #endregion

        #region Resultados

        [WebMethod]
        public static string obtenerResultados_Click(string id)
        {            
            List<JobResult> results = new List<JobResult>();

            CloudStorageAccount storageAccount = CloudStorageAccount.Parse(
               CloudConfigurationManager.GetSetting("StorageConnectionString"));

            CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
            CloudBlobContainer container = blobClient.GetContainerReference(VariablesConfiguracion.containerName);            

            CloudBlockBlob infoSimulation = container.GetBlockBlobReference(VariablesConfiguracion.infoSimulation + "-" + id);

            //Si existe el id de usuario ingresado
            if (infoSimulation.Exists())
            {
                string msg;
                string prefix = VariablesConfiguracion.progressName + "-" + id + ".";                              
                Stream output = new MemoryStream();

                int i = -1;
                CloudBlockBlob simulationState = container.GetBlockBlobReference(prefix + i); ;
                for (int k = 0; k <= 3; k++)
                {
                    simulationState = container.GetBlockBlobReference(prefix + k);
                    if (simulationState.Exists())
                    {
                        i = k;
                        break;
                    }
                }
                //si ya se crearon sub jobs y estan corriendo en el cluster
                if (i != -1)
                {
                    //para cada sub job creo una entrada en la tabla de resultados
                    while (simulationState.Exists())
                    {
                        msg = simulationState.DownloadText();

                        JobResult result = new JobResult();
                        result.IdUsuario = id;
                        result.IdJob = i.ToString();
                        result.estado = msg;
                        result.showMdl = true;
                        result.showMcellOutput = true;

                        result.showResults = false;

                        string mcellText = VariablesConfiguracion.mcellOutput.Replace("ID", id + "." + i);
                        CloudBlockBlob mcellOut = container.GetBlockBlobReference(mcellText);

                        string mapperText = VariablesConfiguracion.mapperErrorOutput.Replace("ID", id + "." + i);
                        CloudBlockBlob mapperOut = container.GetBlockBlobReference(mapperText);

                        if (msg.Equals(VariablesConfiguracion.JOB_SUCCESS) || msg.Equals(VariablesConfiguracion.JOB_RUNNING))
                        {    
                            //dio succes y termino de correr el job
                            if (mcellOut.Exists())
                            {
                                string errorText = VariablesConfiguracion.mcellErrorOutput.Replace("ID", id + "." + i);
                                CloudBlockBlob errorBlob = container.GetBlockBlobReference(errorText);
                                if (errorBlob.Exists())
                                {
                                    result.estado = VariablesConfiguracion.JOB_FAIL;
                                }
                                else
                                {
                                    result.showResults = true;
                                    result.estado = VariablesConfiguracion.JOB_SUCCESS;
                                }
                            }
                            //Si dio success pero todavia no termino de correr el job, lo dejo como running
                            else
                            {
                                //Chequeo si fallo el mapper                                
                                if (mapperOut.Exists())
                                {
                                    result.estado = VariablesConfiguracion.JOB_FAIL;
                                    result.showMcellOutput = false;
                                }
                                else
                                {
                                    result.estado = VariablesConfiguracion.JOB_RUNNING;
                                    result.showMcellOutput = false;
                                }                                
                            }
                        }
                        else 
                        {
                            result.estado = VariablesConfiguracion.JOB_FAIL;
                            result.showMcellOutput = false;
                        }

                        results.Add(result);

                        //iteration step
                        i++;
                        simulationState = container.GetBlockBlobReference(prefix + i);
                    }
                }
                //Si existe el id de la simulacion ingresado pero aun no se lanzaron los jobs al cluster
                else
                {
                    JobResult result = new JobResult();
                    result.IdUsuario = id;
                    result.IdJob = "-";
                    result.estado = infoSimulation.DownloadText();
                    result.showMdl = false;
                    result.showMcellOutput = false;
                    result.showResults = false;

                    results.Add(result);
                }
            }
            // instanciar el serializador
            JavaScriptSerializer TheSerializer = new JavaScriptSerializer();
            TheSerializer.RegisterConverters(new JavaScriptConverter[] { });

            var json = TheSerializer.Serialize(results.ToList());

            return json;
           
        }       

        [WebMethod]
        public static string downloadMcellOutput_Click(string userId, string jobId)
        {
            //Conexion para acceder a la cuenta de almacenamiento
            CloudStorageAccount storageAccount = CloudStorageAccount.Parse(
               CloudConfigurationManager.GetSetting("StorageConnectionString"));

            CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
            CloudBlobContainer container = blobClient.GetContainerReference(VariablesConfiguracion.containerName);
            CloudBlobContainer publicContainer = blobClient.GetContainerReference(VariablesConfiguracion.publicContainerName);
            
            //Se obtiene la salida de MCell con los ids correspondientes
            string blobName = VariablesConfiguracion.mcellOutput.Replace("ID", userId + "." + jobId);
            CloudBlockBlob blob = container.GetBlockBlobReference(blobName);
            string result = "";
            if (blob.Exists())
            {
                string mcellOutput = blob.DownloadText();
                
                //Se copia el blob al contenedor publico para que pueda ser descargado por el usuario
                CloudBlockBlob publicBlob = publicContainer.GetBlockBlobReference("SalidaMcell_" + userId + "." + jobId + ".txt");
                publicBlob.UploadText(mcellOutput);     
                result = publicBlob.Uri.AbsoluteUri;
            }            
            return result;
            
        }

        [WebMethod]
        public static string downloadResults_Click(string userId, string jobId)
        {
            //Conexion para acceder a la cuenta de almacenamiento
            CloudStorageAccount storageAccount = CloudStorageAccount.Parse(
               CloudConfigurationManager.GetSetting("StorageConnectionString"));

            CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
            CloudBlobContainer container = blobClient.GetContainerReference(VariablesConfiguracion.containerName);
            CloudBlobContainer publicContainer = blobClient.GetContainerReference(VariablesConfiguracion.publicContainerName);

            //Se obtienen los resultados con los ids correspondientes
            string blobName = VariablesConfiguracion.outputResult.Replace("ID", userId + "." + jobId);
            CloudBlockBlob blob = container.GetBlockBlobReference(blobName);
            string result = "";
           
            if (blob.Exists())
            {
                //Se copia el blob al contenedor publico para que pueda ser descargado por el usuario
                CloudBlockBlob publicBlob = publicContainer.GetBlockBlobReference("Resultado_" + userId + "." + jobId + ".zip");
                publicBlob.StartCopyFromBlob(blob);                
                result = publicBlob.Uri.AbsoluteUri;
            }
            return result;
        }

        [WebMethod]
        public static string downloadJobMDL_Click(string userId, string jobId)
        {
            //Conexion para acceder a la cuenta de almacenamiento
            CloudStorageAccount storageAccount = CloudStorageAccount.Parse(
               CloudConfigurationManager.GetSetting("StorageConnectionString"));

            CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
            CloudBlobContainer container = blobClient.GetContainerReference(VariablesConfiguracion.containerName);
            CloudBlobContainer publicContainer = blobClient.GetContainerReference(VariablesConfiguracion.publicContainerName);

            string result = "";
            string blobName = VariablesConfiguracion.simulationMDL.Replace("ID", userId + "." + jobId);
            
            foreach (string value in VariablesConfiguracion.fernetModes.Values)
            {
                //Se obtienen los MDLs con los ids correspondientes
                string aux = blobName;
                CloudBlockBlob blob = container.GetBlockBlobReference(aux.Replace("MODE", value));
                if (blob.Exists())
                {
                    string mdl = blob.DownloadText();

                    //Se copia el blob al contenedor publico para que pueda ser descargado por el usuario
                    CloudBlockBlob publicBlob = publicContainer.GetBlockBlobReference("ArchivoMDL_" + userId + "." + jobId + ".mdl");
                    publicBlob.UploadText(mdl);
                    result = publicBlob.Uri.AbsoluteUri;
                    break;
                }
            } 
            return result;
        }



        #endregion

    }
}