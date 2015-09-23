using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ServiceModel;

namespace InterroleCommons
{
    [ServiceContract(Namespace = "urn:ClientInput")]
    public interface IReceiveMessageFromClient 
    {
        [OperationContract]
        void ReceiveClientInputMessage(ClientInputMessage message);
    }
}
