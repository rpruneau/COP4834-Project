using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MajorAdviser.ctrls.Admin
{
    public partial class Major : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Add")
            {
                SqlDataSource1.InsertParameters["code"].DefaultValue = ((TextBox)GridView1.FooterRow.FindControl("NewCode")).Text;
                SqlDataSource1.InsertParameters["title"].DefaultValue = ((TextBox)GridView1.FooterRow.FindControl("NewTitle")).Text;
                SqlDataSource1.InsertParameters["degreeId"].DefaultValue = ((DropDownList)GridView1.FooterRow.FindControl("NewDegreeID")).SelectedIndex.ToString();
                try
                {
                    SqlDataSource1.Insert();
                    ErrorMessage.Text = "New course added successfully";
                    ErrorMessage.ForeColor = System.Drawing.Color.Green;
                }
                catch (Exception ex)
                {
                    ErrorMessage.Text = ex.Message;
                    ErrorMessage.ForeColor = System.Drawing.Color.Red;
                }

            }
        }

        protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.Exception == null)
            {
                if (e.AffectedRows == 1)
                {
                    String keyFieldValue = e.Keys["ID"].ToString();

                    // Display a confirmation message.
                    ErrorMessage.Text = "Record " + keyFieldValue +
                      " updated successfully. ";
                    ErrorMessage.ForeColor = System.Drawing.Color.Green;

                }
                else
                {
                    // Display an error message.
                    ErrorMessage.Text = "An error occurred during the update operation.";
                    ErrorMessage.ForeColor = System.Drawing.Color.Red;
                    // When an error occurs, keep the GridView
                    // control in edit mode.
                    e.KeepInEditMode = true;
                }
            }
            else
            {
                // Insert the code to handle the exception.
                ErrorMessage.Text = e.Exception.Message;
                ErrorMessage.ForeColor = System.Drawing.Color.Red;
                // Use the ExceptionHandled property to indicate that the 
                // exception is already handled.
                e.ExceptionHandled = true;

                e.KeepInEditMode = true;
            }
        }
    }
}