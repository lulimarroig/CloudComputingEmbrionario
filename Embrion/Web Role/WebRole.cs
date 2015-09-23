using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.Diagnostics;
using Microsoft.WindowsAzure.ServiceRuntime;
using System.Diagnostics;
using System.Net;
using System.Threading;
using Microsoft.WindowsAzure.Storage;
using System.ServiceModel;
using System.IO;
using Microsoft.WindowsAzure.Storage.Table;
using Microsoft.WindowsAzure.Storage.Auth;
using InterroleCommons;
using Microsoft.WindowsAzure.Storage.Blob;

namespace Web_Role
{
    public class WebRole : RoleEntryPoint
    {
        public override bool OnStart()
        {
            // To enable the AzureLocalStorageTraceListner, uncomment relevent section in the web.config  
            DiagnosticMonitorConfiguration diagnosticConfig = DiagnosticMonitor.GetDefaultInitialConfiguration();
            diagnosticConfig.Directories.ScheduledTransferPeriod = TimeSpan.FromMinutes(1);
            diagnosticConfig.Directories.DataSources.Add(AzureLocalStorageTraceListener.GetLogDirectory());
            
            // For information on handling configuration changes
            // see the MSDN topic at http://go.microsoft.com/fwlink/?LinkId=166357.           
            
            return base.OnStart();
        }

        

        public static void SendClientInput(String msg, String id)
        {
            var role = RoleEnvironment.Roles["MessageProcessing"];
            Trace.WriteLine("Number of Instances found: " + role.Instances.Count, "Information");

            /*
             * ALGORITMO LOAD BALANCER
             * instance - La instancia que se seleccionara como resultado final del algoritmo LB
             * idles, lows, normals listas para categorizar los nodos segun utilizacion de CPU y memoria mediante el algoritmo de LB
             * Los nodos categorizados como high no se almacenan porque seran automaticamente descartados por el algoritmo
             * Se utiliza la estructura EntradaLoadBalancer para almacenar informacion relevante para el algoritmo
             * L, H - constantes para determinar el umbral de carga de utilizacion de CPU (definidas arriba)           
             * */
            RoleInstance instance = role.Instances.FirstOrDefault<RoleInstance>();
            List<LoadBalancerEntry> nodos = new List<LoadBalancerEntry>();
            List<LoadBalancerEntry> idles = new List<LoadBalancerEntry>();
            List<LoadBalancerEntry> lows = new List<LoadBalancerEntry>();
            List<LoadBalancerEntry> normals = new List<LoadBalancerEntry>();
            
            //Recoleccion de metricas de utilizacion de CPU y memoria para cada instancia
            if (role.Instances.Count > 0)
            {
                double sumCpu = 0;                
                foreach (var i in role.Instances)
                {
                    double cpu = LoadBalancerCommons.obtenerMetricas(i.Id, "MessageProcessing", true);
                    double memory = LoadBalancerCommons.obtenerMetricas(i.Id, "MessageProcessing", false);

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
                foreach (LoadBalancerEntry e in nodos)
                {
                    if (e.cpuUsage <= LoadBalancerCommons.IDLE)
                    {
                        idles.Add(e);
                    }
                    else if (e.cpuUsage <= lUmbral && (!(e.memoryUsage >= LoadBalancerCommons.H_LOADED)))
                    {
                        lows.Add(e);
                    }
                    else if ((!(e.memoryUsage >= LoadBalancerCommons.H_LOADED)) && (!(e.cpuUsage >= hUmbral)))
                    {
                        normals.Add(e);
                    }
                }

                /* ETAPA DE CLASIFICACION
                *  Como los servidores cuentan con Balance de Carga, siempre debe haber al menos uno que no este en la
                *  categoria High, es decir que siempre habra elementos en alguna de las siguientes 3 categorias
                */
                if (idles.Count > 0)
                {
                    instance = idles.First().rol;
                }
                else if (lows.Count > 0)
                {
                    instance = lows.First().rol;
                }
                else if (normals.Count > 0)
                {
                    instance = normals.First().rol;
                }
                Debug.WriteLine("*************************Instancia: "+instance.Id+"************************************");
            }
            //END ALGORITMO LOAD BALANCER
     

            RoleInstanceEndpoint clientInputServiceHostEndPoint = instance.InstanceEndpoints["ClientInputServiceEndPoint"];
                                   
            NetTcpBinding binding = new NetTcpBinding(SecurityMode.None, false);

            EndpointAddress myEndpoint = new EndpointAddress(
                String.Format("net.tcp://{0}/ClientInputService", clientInputServiceHostEndPoint.IPEndpoint)
                );

            try
            {
                ChannelFactory<InterroleCommons.IReceiveMessageFromClient> myChanFac = new ChannelFactory<InterroleCommons.IReceiveMessageFromClient>(binding, myEndpoint);
                InterroleCommons.IReceiveMessageFromClient myClient = myChanFac.CreateChannel();
                myClient.ReceiveClientInputMessage(new InterroleCommons.ClientInputMessage() { idUsuario = id, message = msg });
            }
            catch (Exception ex)
            {
                Trace.WriteLine("An error occured trying to notify the instances: " + ex.Message, "Warning");
            }
            
        }
            
    }
}
