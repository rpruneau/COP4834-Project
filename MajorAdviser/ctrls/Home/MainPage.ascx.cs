using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Providers.Entities;
using System.Web.UI;
using System.Web.UI.WebControls;
using MajorAdviser.Data;

namespace MajorAdviser.ctrls.Home
{
    public partial class MainPage : System.Web.UI.UserControl
    {
        public string UserID { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get majors and put them in drop down list
                ddlMajors.DataSource = GetMajors();
                ddlMajors.DataTextField = "Title";
                ddlMajors.DataValueField = "ID";
                ddlMajors.DataBind();
                ddlMajors.Items.Insert(0, new ListItem("Please select a major..."));
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

            GriedViewHelperMethod();
        }

        private void GriedViewHelperMethod()
        {
            GridViewHelper gridViewHelper = new GridViewHelper(this.gvCourses, false, SortDirection.Ascending);
            gridViewHelper.RegisterGroup("Title2", true, true);
            gridViewHelper.GroupHeader += new GroupEvent(gridViewHelper_GroupHeader);
            gridViewHelper.ApplyGroupSort();
        }

        private void gridViewHelper_GroupHeader(string groupName, object[] values, GridViewRow row)
        {
            if (groupName == "Title2")
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

        protected void CheckBox(object sender, EventArgs e)
        {
            CheckBox checkbox = sender as CheckBox;
            //Get course ID
            string courseId = SelectedCourseId.Value.ToString();
            Course course = new Course(courseId);

            //Get student id
            MajorAdviser.Data.Student student = new MajorAdviser.Data.Student(HttpContext.Current.User.Identity.Name);

            //Get the check box value
            bool isChecked = checkbox.Checked;
            if (isChecked)
            {
                student.AddClass(course.CourseId);
            }
            else
            {
                student.RemoveClass(course.CourseId);
            }
            //Rebuild grid
            GriedViewHelperMethod();
        }

        protected void gvCourses_OnRowDataBound(Object sender, GridViewRowEventArgs e)
        {
            //Make checkbox checked if student has class
            //Get student id
            MajorAdviser.Data.Student student = new MajorAdviser.Data.Student(HttpContext.Current.User.Identity.Name);
            // If student has class mark checkbox and change class
            if (e.Row.DataItem != null)
            {
                DataKey key = gvCourses.DataKeys[e.Row.DataItemIndex];
                if(student.HasClass(key.Value.ToString()))
                {
                    ((CheckBox)e.Row.FindControl("CheckBox1")).Checked = true;
                }
            }
        }
    }
}