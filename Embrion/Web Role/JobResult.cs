using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Web_Role
{
    class JobResult
    {
        public String IdUsuario { get; set; }
        public String IdJob { get; set; }
        public String estado { get; set; }
        public String mcellMessageUrl { get; set; }
        public String resultsUrl { get; set; }
        public Boolean showResults { get; set; }
        public Boolean showMcellOutput { get; set; }
        public Boolean showMdl { get; set; }
    }
}
