using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MajorAdviser.Student
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MajorAdviser.Data.Student student = new MajorAdviser.Data.Student(HttpContext.Current.User.Identity.Name);
            GridView1.DataSource = student.GetMyClasses();
            GridView1.DataBind();
        }
    }
}