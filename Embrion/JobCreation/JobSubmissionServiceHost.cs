using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using InterroleCommons;
using System.ServiceModel;

namespace JobCreation
{

    public delegate void JobSubmissionRecievedEventHandler(object sender, JobSubmissionMessage e);

    [ServiceBehavior(
        InstanceContextMode = InstanceContextMode.PerCall,
        ConcurrencyMode = ConcurrencyMode.Multiple,
        IncludeExceptionDetailInFaults = true,
        AddressFilterMode = AddressFilterMode.Any)]
    public class JobSubmissionServiceHost : IReceiveJobSubmission
    {
        public event JobSubmissionRecievedEventHandler JobSubmissionRecieved;

        public JobSubmissionServiceHost(){
            WorkerRole role = new WorkerRole();
            JobSubmissionRecieved += new JobSubmissionRecievedEventHandler(role.ServiceHost_JobSubmissionRecieved);
        }

        public void ReceiveJobSubmitionMessage(JobSubmissionMessage sender)
        {
            this.OnJobSubmissionRecieved(sender);
        }

        protected virtual void OnJobSubmissionRecieved(JobSubmissionMessage e)
        {
            JobSubmissionRecievedEventHandler handler = JobSubmissionRecieved;
            if (handler != null)
            {
                // Invokes the delegates.
                handler(this, e);
            }
        }

    }

}
