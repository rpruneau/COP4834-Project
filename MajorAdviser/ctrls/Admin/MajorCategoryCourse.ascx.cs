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

namespace MajorAdviser.ctrls.Admin
{
    public partial class MajorCategoryCourse : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GridView1.DataSource = GetMajorCategoryCourse();
            GridView1.DataBind();

            GridViewHelper gridViewHelper = new GridViewHelper(this.GridView1, false, SortDirection.Ascending);
            gridViewHelper.RegisterGroup("Major", true, true);
            gridViewHelper.RegisterGroup("Category", true, true);
            gridViewHelper.GroupHeader += new GroupEvent(gridViewHelper_GroupHeader);
            gridViewHelper.ApplyGroupSort();
        }

        private void gridViewHelper_GroupHeader(string groupName, object[] values, GridViewRow row)
        {
            if (groupName == "Major")
            {
                row.BackColor = Color.DarkGray;
                row.Cells[0].Text = "" + row.Cells[0].Text;
            }
            if (groupName == "Category")
            {
                row.BackColor = Color.LightGray;
                row.Cells[0].Text = "" + row.Cells[0].Text;
            }
        }
        protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
        {
            DataTable dataTable = GetMajorCategoryCourse().Tables[0];
            dataTable.DefaultView.Sort = e.SortExpression;
            GridView1.DataSource = dataTable;
            GridView1.DataBind();
        }

        public DataSet GetMajorCategoryCourse()
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
                cmd.CommandText = "SELECT (SELECT Title FROM [Major] WHERE ID = (SELECT DISTINCT MajorID FROM MajorCategory WHERE MajorID = mc.MajorID)) AS Major " +
                    ",(SELECT Title FROM Category WHERE ID = (SELECT DISTINCT CategoryID FROM MajorCategory WHERE CategoryID = mc.CategoryID)) AS Category " +
                    ",c.Code, c.Title " +
                    "FROM [MajorCategoryCourse] mcc  " +
                    "LEFT JOIN MajorCategory mc ON mcc.MajorCategoryID = mc.ID  " +
                    "LEFT JOIN Course c ON mcc.CourseID = c.ID";
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
    }
}