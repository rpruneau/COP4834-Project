using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace MajorAdviser.Data
{
    public class MajorCategory
    {
        internal string RequiredCredits(int major, string categoryString)
        {
            Category category = new Category();
            int categoryId = category.GetCategoryId(categoryString);
            using (SqlConnection con = new SqlConnection(ConfigurationManager
                .ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                SqlCommand com = new SqlCommand();
                com.Connection = con;
                con.Open();
                com.CommandType = CommandType.Text;
                com.CommandText = @"Select CreditsRequired From MajorCategory 
                    Where MajorID = @major And CategoryID = @categoryId";
                com.Parameters.Add("@categoryId", SqlDbType.Int).Value = categoryId;
                com.Parameters.Add("@major", SqlDbType.Int).Value = major;
                return com.ExecuteScalar().ToString();
            }
        }
    }
}