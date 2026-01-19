using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Certificate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && Request.QueryString["ResultID"] != null)
        {
            LoadCertificateDetails(Request.QueryString["ResultID"]);
        }
    }

    private void LoadCertificateDetails(string resultID)
    {
        string connString = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            string query = @"
                SELECT U.UserName, Q.QuizName, R.DateTaken
                FROM QuizResults R
                INNER JOIN Users U ON R.UserID = U.ID
                INNER JOIN Quizzes Q ON R.QuizID = Q.QuizID
                WHERE R.ResultID = @ResultID";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@ResultID", resultID);
                conn.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    // Display the correct username and quiz title
                    lblName.Text = reader["UserName"].ToString();       // Correct column
                    lblQuizTitle.Text = reader["QuizName"].ToString(); // Correct column
                    lblCompletionDate.Text = Convert.ToDateTime(reader["DateTaken"]).ToString("yyyy-MM-dd");
                }
                else
                {
                    lblMessage.Text = "❌ Error: No certificate found.";
                    lblMessage.Visible = true;
                }
            }
        }
    }

    protected void btnDownloadPDF_Click(object sender, EventArgs e)
    {
        // Future PDF generation logic
        Response.Write("<script>alert('Feature coming soon!');</script>");
    }
}
