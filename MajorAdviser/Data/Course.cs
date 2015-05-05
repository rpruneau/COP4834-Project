using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace MajorAdviser.Data
{
    public class Course
    {
        public int CourseId { get; set; }

        public Course(string courseId)
        {
            CourseId = GetCourseId(courseId);
        }

        private int GetCourseId(string courseId)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager
                .ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                SqlCommand com = new SqlCommand();
                com.Connection = con;
                con.Open();
                com.CommandType = CommandType.Text;
                com.CommandText = "SELECT ID FROM Course WHERE ID = @courseId";
                com.Parameters.Add("@courseId", SqlDbType.Int).Value = courseId;
                return (int)com.ExecuteScalar();
            }
        }
    }
}