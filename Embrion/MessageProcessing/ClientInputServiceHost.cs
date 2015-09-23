using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using InterroleCommons;
using System.ServiceModel;

namespace MessageProcessing
{

    public delegate void ClientInputRecievedEventHandler(object sender, ClientInputMessage e);

    [ServiceBehavior(
        InstanceContextMode = InstanceContextMode.PerCall,
        ConcurrencyMode = ConcurrencyMode.Multiple,        
        IncludeExceptionDetailInFaults = true,
        AddressFilterMode = AddressFilterMode.Any)]
    public class ClientInputServiceHost : IReceiveMessageFromClient
    {
        public event ClientInputRecievedEventHandler ClientInputRecieved;

        public ClientInputServiceHost(){
            WorkerRole rol = new WorkerRole();
            ClientInputRecieved += new ClientInputRecievedEventHandler(rol.ServiceHost_ClientInputRecieved);
        }

        public void ReceiveClientInputMessage(ClientInputMessage sender)
        {
            this.OnClientInputRecieved(sender);
        }

        protected virtual void OnClientInputRecieved(ClientInputMessage e)
        {
            ClientInputRecievedEventHandler handler = ClientInputRecieved;
            if (handler != null)
            {
                // Invokes the delegates.
                handler(this, e);
            }
        }

    }

}
