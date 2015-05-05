using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace MajorAdviser.Data
{
    public class Student
    {
        public int StudentId { get; set; }
        public string Email { get; set; }
        public Student(string email)
        {
            Email = email;
            StudentId = GetStudentId(email);
        }

        private int GetStudentId(string email)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager
                .ConnectionStrings["DefaultConnection"].ConnectionString)) 
            {
                SqlCommand com = new SqlCommand();
                com.Connection = con;
                con.Open();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "getStudentId";
                com.Parameters.Add("@email", SqlDbType.NVarChar).Value = email;
                return (int)com.ExecuteScalar();
            }
        }

        internal void AddClass(int courseId)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager
                .ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                //command
                SqlCommand com = new SqlCommand();
                com.CommandType = CommandType.Text;
                com.CommandText = "Insert Into StudentCourse " +
                    "(StudentID, CourseID) Values (@studentId, @courseId)";
                com.Parameters.Add("@studentId", SqlDbType.Int).Value = StudentId;
                com.Parameters.Add("@courseId", SqlDbType.Int).Value = courseId;
                //command connection
                com.Connection = con;
                con.Open();
                //execute
                com.ExecuteNonQuery();
            }
        }

        internal void RemoveClass(int courseId)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager
                .ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                //command
                SqlCommand com = new SqlCommand();
                com.CommandType = CommandType.Text;
                com.CommandText = "Delete From StudentCourse " +
                    "Where StudentID = @studentId And CourseID = @courseId";
                com.Parameters.Add("@studentId", SqlDbType.Int).Value = StudentId;
                com.Parameters.Add("@courseId", SqlDbType.Int).Value = courseId;
                //command connection
                com.Connection = con;
                con.Open();
                //execute
                com.ExecuteNonQuery();
            }
        }

        internal bool HasClass(string courseId)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager
               .ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                //command
                SqlCommand com = new SqlCommand();
                com.CommandType = CommandType.Text;
                com.CommandText = "Select Count(*) From StudentCourse " +
                    "Where StudentID = @studentId And CourseID = @courseId";
                com.Parameters.Add("@studentId", SqlDbType.Int).Value = StudentId;
                com.Parameters.Add("@courseId", SqlDbType.Int).Value = courseId;
                //command connection
                com.Connection = con;
                con.Open();
                //execute
                int result = (int)com.ExecuteScalar();
                if (result > 0)
                {
                    return true;
                }
                else {
                    return false;
                }
            }
        }

        internal DataSet GetMyClasses()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager
               .ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                //command
                SqlCommand com = new SqlCommand();
                com.CommandType = CommandType.Text;
                com.CommandText = @"SELECT c.ID, c.Code, c.Title, c.Description, c.CreditHours
                  FROM StudentCourse sc
                  Left join Course c on sc.CourseID = c.ID
                  WHERE sc.StudentID = @studentId";
                com.Parameters.Add("@studentId", SqlDbType.Int).Value = StudentId;
                //command connection
                com.Connection = con;
                con.Open();
                //execute
                DataSet myDataSet = new DataSet();
                SqlDataAdapter mySqlDataAdapter = new SqlDataAdapter(com);
                mySqlDataAdapter.Fill(myDataSet);
                return myDataSet;
            }
        }
    }
}