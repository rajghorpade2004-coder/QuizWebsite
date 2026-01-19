using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminDashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDashboardData();
        }
    }

    private void LoadDashboardData()
    {
        string connString = WebConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();

            // Count total users
            using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Users", conn))
            {
                lblTotalUsers.Text = cmd.ExecuteScalar().ToString();
            }

            // Count total quizzes
            using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Quizzes", conn))
            {
                lblTotalQuizzes.Text = cmd.ExecuteScalar().ToString();
            }

            // Count total quiz attempts
            using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM QuizAttempts", conn))
            {
                lblTotalAttempts.Text = cmd.ExecuteScalar().ToString();
            }
        }
    }
}
