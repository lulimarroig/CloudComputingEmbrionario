using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.IO;
using System.Threading;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.ServiceRuntime;
using Microsoft.WindowsAzure.Diagnostics;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Auth;
using Microsoft.WindowsAzure.Storage.Blob;
using InterroleCommons;
using System.ServiceModel;
using Newtonsoft.Json;
using Mustache;
using System.Collections;
using Microsoft.WindowsAzure.Storage.Table;
using System.Globalization;


namespace MessageProcessing
{
    public class WorkerRole : RoleEntryPoint
    {
        ManualResetEvent CompletedEvent = new ManualResetEvent(false);

        public ServiceHost ServiceHost { get; private set; }


        public CloudStorageAccount storageAccount;
        public CloudBlobClient blobClient;
        public CloudBlobContainer container;

        private void StartServiceHost()
        {
            Trace.WriteLine("Starting Client Input Service Host", "Information");          
            ServiceHost = new ServiceHost(typeof(ClientInputServiceHost));            
            
            this.ServiceHost.Faulted += (sender, e) =>
            {
                Trace.TraceError("Client Input Service Host fault occured");
                this.ServiceHost.Abort();
                Thread.Sleep(500);
                this.StartServiceHost();
            };

            NetTcpBinding binding = new NetTcpBinding(SecurityMode.None);
            RoleInstanceEndpoint clientInputServiceHostEndPoint = RoleEnvironment.CurrentRoleInstance.InstanceEndpoints["ClientInputServiceEndPoint"];

            this.ServiceHost.AddServiceEndpoint(
                typeof(IReceiveMessageFromClient),
                binding,
                String.Format("net.tcp://{0}/ClientInputService", clientInputServiceHostEndPoint.IPEndpoint)
                );

            try
            {
                this.ServiceHost.Open();
                Trace.TraceInformation("Service Host Opened");
            }
            catch (TimeoutException timeoutException)
            {
                Trace.TraceError("Service Host open failure, Time Out: " + timeoutException.Message);
            }
            catch (CommunicationException communicationException)
            {
                Trace.TraceError("Service Host open failure, Communication Error: " + communicationException.Message);
            }

            Trace.WriteLine("Service Host Started", "Information");
        }

        public void ServiceHost_ClientInputRecieved(object sender, ClientInputMessage e)
        {
            Trace.WriteLine("ClientInputRecieved Recieved User Id : " + e.idUsuario, "Warning");
            try
            {
                /*Crear Blob desde un Stream*/
                // Se obtiene la cuenta de almacenamiento
                storageAccount = CloudStorageAccount.Parse(
                    CloudConfigurationManager.GetSetting("StorageConnectionString"));

                // Se crea el cliente de blobs
                blobClient = storageAccount.CreateCloudBlobClient();

                // Obtencion del container
                container = blobClient.GetContainerReference(VariablesConfiguracion.containerName);

                Int64 subid = 1;

                String mustacheTemplateStr = File.ReadAllText(AppDomain.CurrentDomain.BaseDirectory + "/App_Data/mustacheCloud.txt");
               
                //Template para generar los MDL
                FormatCompiler compiler = new FormatCompiler();
                Generator generatorMDL = compiler.Compile(mustacheTemplateStr);
               
                //Obtener parametros del cliente
                SimulacionParameters parametros = JsonConvert.DeserializeObject<SimulacionParameters>(e.message);
                
                //Barrido paramétrico
                //Especificar número de parámetros, n
                Int32 n = parametros.reacciones.Count(r => r.rate != null);
                if (n > 0)
                {
                    //Inicializo vector de inicios, fines y steps
                    LinkedList<Double> inicios = new LinkedList<Double>();
                    LinkedList<Double> fines = new LinkedList<Double>();
                    LinkedList<Double> steps = new LinkedList<Double>();
                    foreach (var reaccion in parametros.reacciones.FindAll(r => r.rate != null))
                    {
                        var inicio = reaccion.rate.rateInicio;
                        var fin = reaccion.rate.rateFin;
                        var step = reaccion.rate.rateStep;
                        inicios.AddLast(inicio);
                        fines.AddLast(fin);
                        steps.AddLast(step);
                    }

                    var iniciosArray = inicios.ToArray();
                    var finesArray = fines.ToArray();
                    var stepsArray = steps.ToArray();


                    //Defino vector lógico L para hacer barrido selectivo
                    Int32[] vectorLogico = new Int32[n];
                    for (int i = 0; i < n; i++)
                    {
                        //vectorLogico[i] = i < 5 ? 1 : 100;
                        vectorLogico[i] = 1000;
                    }

                    // Inicialización del vector j
                    Double[] j = new Double[n];
                    for (var k = 0; k < n; k++)
                    {
                        if (k == vectorLogico[k])
                        {
                            iniciosArray[k] += stepsArray[k];
                        }
                        j[k] = iniciosArray[k];
                    }

                    LinkedList<Double[]> jotas = new LinkedList<double[]>();
                    //Barrido parametrico
                    Int32 z = n - 1;
                    while (z >= 0)
                    {
                        if ((j[z] - finesArray[z]) * stepsArray[z] > 0)
                        {
                            j[z] = iniciosArray[z];
                            z--;
                        }
                        else
                        {
                            jotas.AddLast((double[])j.Clone()); //Para ver las combinaciones que creo
                            var auxId = subid;
                            Thread thread = new Thread(() => CrearMDL(e, auxId, (double[])j.Clone(), parametros, generatorMDL));
                            thread.Start();
                            //CrearMDL(e, subid, (double[])j.Clone(), parametros, generatorMDL);
                            z = n - 1;
                            subid++;
                        }
                        if (z >= 0)
                        {
                            j[z] += stepsArray[z];
                            if (z == vectorLogico[z])
                            {
                                j[z] += stepsArray[z];
                            }
                        }
                    }

                }
                else {
                    List<Double> valores = new List<double>();
                    CrearMDL(e, 0, valores.ToArray(), parametros, generatorMDL);           
                }
                

            }
            catch (Exception ex)
            {
                Trace.TraceError(ex.Message);
                throw;
            }
        }

        private void CrearMDL(ClientInputMessage e, Int64 subid, Double[] valores, SimulacionParameters parametros,
            Generator generatorMDL)
        {
            try
            {
                MDLParametros mdlParametros = new MDLParametros();
                mdlParametros.iteraciones = parametros.init.iterations;
                mdlParametros.timeStep = parametros.init.timeStep;
                mdlParametros.box = new BoxParametros();
                mdlParametros.box.nombre = parametros.geometria.box.nombre;
                mdlParametros.box.aspectRatio = parametros.geometria.box.aspectRatio;
                LinkedList<String> cornerList = new LinkedList<String>();
                foreach (var corner in parametros.geometria.box.corners)
                {
                    String cornerString = "[" + String.Join(",", corner) + "]";
                    cornerList.AddLast(cornerString);
                }
                mdlParametros.box.corners = String.Join(" , ", cornerList);
                mdlParametros.moleculas = new DefMoleculas();
                mdlParametros.moleculas.defineMoleculas = new LinkedList<MoleculasParametros>();
                mdlParametros.moleculas.nameList = parametros.moleculas.nameList;

                foreach (var molecula in parametros.moleculas.defineMoleculas)
                {
                    MoleculasParametros mol = new MoleculasParametros();
                    mol.nombre = molecula.nombre;
                    mol.cantidad = molecula.cantidad;
                    mol.diffusion2D = molecula.difusion2D;
                    mol.diffusion3D = molecula.difusion3D;
                    mdlParametros.moleculas.defineMoleculas.AddLast(mol);
                }

                mdlParametros.reacciones = new LinkedList<ReacParametros>();
                var numReaccion = 0;
                foreach (var reaccion in parametros.reacciones)
                {
                    ReacParametros reac = new ReacParametros();
                    reac.reaccion = reaccion.reaccion;
                    reac.rate = valores[numReaccion];
                    reac.nombre = reaccion.nombre;
                    mdlParametros.reacciones.AddLast(reac);
                    numReaccion++;
                }
                mdlParametros.hayReacciones = mdlParametros.reacciones.Count > 0;

                string fernetMode = parametros.fernet.mode;

                Thread.CurrentThread.CurrentCulture = new CultureInfo("en-US");//("en-US");
                string result = generatorMDL.Render(mdlParametros);

                // Se obtiene una referencia al blob (que no existia previamente)
                CloudBlockBlob blockBlob = container.GetBlockBlobReference("Scene.main.mdl-" + fernetMode + "-" + e.idUsuario + "." + subid);

                // Se guarda el mdl en blob
                blockBlob.UploadText(result);

                //enviar mensaje al JobCreation Role
                var role = RoleEnvironment.Roles["JobCreation"];
                Trace.WriteLine("Number of JobCreation Instances found: " + role.Instances.Count, "Information");

                RoleInstance instance = role.Instances.FirstOrDefault<RoleInstance>();

                /*
             * ALGORITMO LOAD BALANCER
             * instance - La instancia que se seleccionara como resultado final del algoritmo LB
             * idles, lows, normals listas para categorizar los nodos segun utilizacion de CPU y memoria mediante el algoritmo de LB
             * Los nodos categorizados como high no se almacenan porque seran automaticamente descartados por el algoritmo
             * Se utiliza la estructura EntradaLoadBalancer para almacenar informacion relevante para el algoritmo
             * L, H - constantes para determinar el umbral de carga de utilizacion de CPU (definidas arriba)           
             * */
                DateTime StartDate = DateTime.Now;

                List<LoadBalancerEntry> nodos = new List<LoadBalancerEntry>();
                List<LoadBalancerEntry> idles = new List<LoadBalancerEntry>();
                List<LoadBalancerEntry> lows = new List<LoadBalancerEntry>();
                List<LoadBalancerEntry> normals = new List<LoadBalancerEntry>();
                Double cpuUsageInstance = 0;

                //Recoleccion de metricas de utilizacion de CPU y memoria para cada instancia
                if (role.Instances.Count > 0)
                {
                    double sumCpu = 0;
                    LoadBalancerCommons lbo = new LoadBalancerCommons();
                    foreach (var i in role.Instances)
                    {
                        double cpu = LoadBalancerCommons.obtenerMetricas(i.Id, "JobCreation", true);
                        double memory = LoadBalancerCommons.obtenerMetricas(i.Id, "JobCreation", false);

                        LoadBalancerEntry entrada = new LoadBalancerEntry();
                        entrada.cpuUsage = cpu;
                        entrada.memoryUsage = memory;
                        entrada.rol = i;
                        nodos.Add(entrada);

                        sumCpu += cpu;
                    }

                    double avCPUClusterUsage = sumCpu / (role.Instances.Count);
                    double lUmbral = LoadBalancerCommons.L * avCPUClusterUsage;
                    double hUmbral = LoadBalancerCommons.H * avCPUClusterUsage;

                    /* Agrupamos los nodos en categorias dependiendo de la intensidad de uso de CPU y Memoria 
                    *  Si tienen alto uso de Cpu y memoria simultaneamente son automaticamente descartados por el algoritmo 
                    */                    
                    foreach (LoadBalancerEntry entry in nodos)
                    {
                        if (entry.cpuUsage <= LoadBalancerCommons.IDLE)
                        {
                            idles.Add(entry);
                        }
                        else if (entry.cpuUsage <= lUmbral && (!(entry.memoryUsage >= LoadBalancerCommons.H_LOADED)))
                        {
                            lows.Add(entry);
                        }
                        else if ((!(entry.memoryUsage >= LoadBalancerCommons.H_LOADED)) && (!(entry.cpuUsage >= hUmbral)))
                        {
                            normals.Add(entry);
                        }
                    }

                    /* ETAPA DE CLASIFICACION
                    *  Como los servidores cuentan con Balance de Carga, siempre debe haber al menos uno que no este en la
                    *  categoria High, es decir que siempre habra elementos en alguna de las siguientes 3 categorias
                    */
                    if (idles.Count > 0)
                    {
                        instance = idles.First().rol;
                        cpuUsageInstance = idles.First().cpuUsage;
                    }
                    else if (lows.Count > 0)
                    {
                        instance = lows.First().rol;
                        cpuUsageInstance = lows.First().cpuUsage;
                    }
                    else if (normals.Count > 0)
                    {
                        instance = normals.First().rol;
                        cpuUsageInstance = normals.First().cpuUsage;
                    }
                }
                //END ALGORITMO LOAD BALANCER
                DateTime EndDate = DateTime.Now;
                Int32 resta = (EndDate - StartDate).Milliseconds;

                CloudBlockBlob loadBalancerMetrics = container.GetBlockBlobReference("loadBalancerMetrics");

                if (!loadBalancerMetrics.Exists())
                {
                    loadBalancerMetrics.UploadText(DateTime.Now.ToShortTimeString() + ": Load balancer demoró " + resta + " ms y eligió " + instance.Id + " con " + cpuUsageInstance + "% CPU");
                }
                else {
                    String aux = loadBalancerMetrics.DownloadText();
                    aux = aux + "\n" + DateTime.Now.ToShortDateString() + ": Load balancer demoró " + resta + " ms y eligió " + instance.Id + " con " + cpuUsageInstance + "% CPU";

                    loadBalancerMetrics.UploadText(aux);
                }
                
                RoleInstanceEndpoint jobSubmissionServiceHostEndPoint = instance.InstanceEndpoints["JobSubmissionServiceEndPoint"];

                NetTcpBinding binding = new NetTcpBinding(SecurityMode.None, false);

                EndpointAddress myEndpoint = new EndpointAddress(
                    String.Format("net.tcp://{0}/JobSubmissionService", jobSubmissionServiceHostEndPoint.IPEndpoint)
                    );

                try
                {
                    ChannelFactory<InterroleCommons.IReceiveJobSubmission> myChanFac = new ChannelFactory<InterroleCommons.IReceiveJobSubmission>(binding, myEndpoint);
                    InterroleCommons.IReceiveJobSubmission myClient = myChanFac.CreateChannel();
                    myClient.ReceiveJobSubmitionMessage(new InterroleCommons.JobSubmissionMessage() { idUsuario = e.idUsuario, nomEntrada = "Scene.main.mdl-" + fernetMode + "-" + e.idUsuario + "." + subid, subIdUsuario = Convert.ToString(subid) });
                }
                catch (Exception ex)
                {
                    Trace.WriteLine("An error occured trying send Job Submission to the instances: " + ex.Message, "Warning");
                }

            }
            catch (Exception ex)
            {
                Trace.TraceError(ex.Message);
                throw;
            }
        }

        public override void Run()
        {
            Trace.WriteLine("Starting processing of messages");

            this.StartServiceHost();
            //loop infinito
            while (true) { };            
        }

        public override bool OnStart()
        {
            // Set the maximum number of concurrent connections 
            ServicePointManager.DefaultConnectionLimit = 12;

            RoleEnvironment.Changing += RoleEnvironmentChanging;            

            return base.OnStart();
        }


        private void RoleEnvironmentChanging(object sender, RoleEnvironmentChangingEventArgs e)
        {
            // If a configuration setting is changing
            if (e.Changes.Any(change => change is RoleEnvironmentConfigurationSettingChange))
            {
                // Set e.Cancel to true to restart this role instance
                e.Cancel = true;
            }
        }

        public override void OnStop()
        {
            base.OnStop();
        }       
        
    }
}
