using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MajorAdviser.ctrls.Home
{
    public partial class MainPage : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Get majors and put them in drop down list
            ddl_majors.DataSource = GetMajors();
            ddl_majors.DataTextField = "Title";
            ddl_majors.DataValueField = "ID";
            ddl_majors.DataBind();
        }

        /// <summary>
        /// Get all majors from dbo.Major ordered by Title asc
        /// </summary>
        /// <returns></returns>
        public DataSet GetMajors()
        {
            SqlConnection con = new SqlConnection();
            SqlCommand cmd = new SqlCommand();
            DataSet myDataSet = new DataSet();
            try
            {
                con.ConnectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                con.Open();
                cmd.Connection = con;
                                  // Filter Query to include Computer Science Major's only
                cmd.CommandText = "SELECT * FROM dbo.Major WHERE Code LIKE '0%' AND Code NOT LIKE '0100' OR Code LIKE '2%' ORDER BY Title ASC";
                cmd.CommandType = CommandType.Text;
                SqlDataAdapter mySqlDataAdapter = new SqlDataAdapter(cmd);
                mySqlDataAdapter.Fill(myDataSet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                cmd.Dispose();
                con.Close();
            }
            return myDataSet;
        }

        /// <summary>
        /// Turn the results display on
        /// </summary>
        public void DisplayResults(Object sender, EventArgs e)
        {
            Panel1.Visible = true;
        }
    }
}