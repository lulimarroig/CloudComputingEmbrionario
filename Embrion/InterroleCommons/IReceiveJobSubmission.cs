using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ServiceModel;

namespace InterroleCommons
{
    [ServiceContract(Namespace = "urn:JobSubmission")]
    public interface IReceiveJobSubmission
    {
        [OperationContract]
        void ReceiveJobSubmitionMessage(JobSubmissionMessage message);
    }
}
