using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace MajorAdviser.Data
{
    public class Category
    {
        internal int GetCategoryId(string categoryString)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager
                .ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                SqlCommand com = new SqlCommand();
                com.Connection = con;
                con.Open();
                com.CommandType = CommandType.Text;
                com.CommandText = "Select ID From Category Where Title = @categoryString";
                com.Parameters.Add("@categoryString", SqlDbType.NVarChar).Value = categoryString;
                return (int)com.ExecuteScalar();
            }
        }
    }
}