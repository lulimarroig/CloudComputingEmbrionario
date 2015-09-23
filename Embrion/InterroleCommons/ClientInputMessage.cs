using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;
using System.Json;

namespace InterroleCommons
{
    [DataContract(Namespace = "urn:ClientInput")]
    public class ClientInputMessage
    {
        [DataMember]
        public string idUsuario { get; set; }

        [DataMember]
        public String message { get; set; }
    }
}
