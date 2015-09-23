using Microsoft.WindowsAzure.ServiceRuntime;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InterroleCommons
{
    public class LoadBalancerEntry
    {
        public RoleInstance rol { get; set; }
        public double cpuUsage { get; set; }
        public double memoryUsage { get; set; }

    }
}
