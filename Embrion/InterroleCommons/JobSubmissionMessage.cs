using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace InterroleCommons
{
    [DataContract(Namespace = "urn:JobSubmission")]
    public class JobSubmissionMessage
    {
        [DataMember]
        public string idUsuario { get; set; }

        [DataMember]
        public String nomEntrada { get; set; }

        [DataMember]
        public string subIdUsuario { get; set; }

    }
}
