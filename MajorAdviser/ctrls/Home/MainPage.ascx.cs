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
            if (!IsPostBack)
            {
                // Get majors and put them in drop down list
                ddlMajors.DataSource = GetMajors();
                ddlMajors.DataTextField = "Title";
                ddlMajors.DataValueField = "ID";
                ddlMajors.DataBind();
            }
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
                con.ConnectionString = ConfigurationManager
                    .ConnectionStrings["DefaultConnection"].ConnectionString;
                con.Open();
                cmd.Connection = con;
                cmd.CommandText = "SELECT * FROM dbo.Major order by Title asc";
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
            gvCourses.DataSource = GetCourse(ddlMajors.SelectedIndex);
            gvCourses.DataBind();
        }

        /// <summary>
        /// Get courses by major ID
        /// </summary>
        /// <param name="majorId"></param>
        /// <returns></returns>
        public DataSet GetCourse(int majorId)
        {
            SqlConnection con = new SqlConnection();
            SqlCommand cmd = new SqlCommand();
            DataSet myDataSet = new DataSet();
            try
            {
                con.ConnectionString = ConfigurationManager
                    .ConnectionStrings["DefaultConnection"].ConnectionString;
                con.Open();
                cmd.Connection = con;
                cmd.CommandText = "getCourses";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@majorId", SqlDbType.Int);
                cmd.Parameters["@majorId"].Value = majorId;
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
    }
}