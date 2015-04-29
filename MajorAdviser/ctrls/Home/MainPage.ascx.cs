using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
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
                ddlMajors.Items.Insert(0,new ListItem("Please select a major..."));
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
            gvCourses.DataSource = GetCourse(ddlMajors.SelectedIndex);
            gvCourses.DataBind();

            GridViewHelper gridViewHelper = new GridViewHelper(this.gvCourses, false, SortDirection.Ascending);
            gridViewHelper.RegisterGroup("Title2", true, true);
            gridViewHelper.GroupHeader += new GroupEvent(gridViewHelper_GroupHeader);
            gridViewHelper.ApplyGroupSort();
        }

        private void gridViewHelper_GroupHeader(string groupName, object[] values, GridViewRow row)
        {
            if(groupName == "Title2")
            {
                row.BackColor = Color.LightGray;
                row.Cells[0].Text = "" + row.Cells[0].Text;
            }
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
        protected void gvCourses_Sorting(object sender, GridViewSortEventArgs e)
        {
            DataTable dataTable = GetCourse(ddlMajors.SelectedIndex).Tables[0];
            dataTable.DefaultView.Sort = e.SortExpression;
            gvCourses.DataSource = dataTable;
            gvCourses.DataBind();
        }
    }
}