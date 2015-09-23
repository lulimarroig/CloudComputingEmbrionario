using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web_Role
{
    public partial class ResultPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            // A simple example using Page_Load
            List<JobResult> people = new List<JobResult>();
            for (int i = 0; i < 10; i++)
            {
               // people.Add(new JobResult() { Name = "Test", Age = 10, BirthDate = DateTime.Now, LastName = "Test" });
            }

            if (!IsPostBack)
            {
                repJobResults.DataSource = people;
                repJobResults.DataBind();
            }

        }
    }
}