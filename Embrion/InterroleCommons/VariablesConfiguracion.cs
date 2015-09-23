using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InterroleCommons
{
    public static class VariablesConfiguracion
    {
        //Variables del Cluster 
        public static string clusterName = "scicluster";
        public static string containerName = "scicluster";
        public static string publicContainerName = "publicsci";

        //Nombres de Blobs
        public static string userIDVariable = "userIncrement";
        public static string infoSimulation = "infoSimulation";
        public static string progressName = "pruebaProgreso";
        public static string mcellOutput = "scicluster/test/output-ID/controloutput-m-00000";
        public static string outputResult = "data/ID-resultados.zip";
        public static string mcellErrorOutput = "scicluster/test/output-ID/errormcell-m-00000";
        public static string mapperErrorOutput = "user/admin/errorMapper-ID.txt";
        public static string simulationMDL = "Scene.main.mdl-MODE-ID";
        
        //Certificados
        public static string subscriptionID = "5d01debf-b668-42ef-b66b-eb1f0da7177a";
        public static string certFriendlyName = "Cami";//"Azpas436EGL9240-1-25-2015-credentials";
        public static string thumbprint = "FD1985AFB3067FC6DA78A0BE7711C68BD5B33150";    
        
        //Estados de las tareas
        public static string JOB_CREATING = "Creando simulación";
	    public static string JOB_STARTING = "Inicializando jobs en el cluster";
	    public static string JOB_RUNNING = "Ejecutándose";
	    public static string JOB_SUCCESS = "Tarea finalizada con éxito";
        public static string JOB_FAIL = "Tarea fallida";	    

        //Modos de fernet
        public static Dictionary<string, string> fernetModes = new Dictionary<string, string>
        {
	        {"POINT", "point"},
	        {"MULTI", "multi"}
	    };
    }
}
