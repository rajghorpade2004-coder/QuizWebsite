using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class QuizResult : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindQuizResults();
        }
    }

    private void BindQuizResults()
    {
        DataTable dt = GetQuizResults(); // Fetch quiz results from DB
        if (dt.Rows.Count > 0)
        {
            gvQuizResults.DataSource = dt;
            gvQuizResults.DataBind();
        }
        else
        {
            lblMessage.Text = "No quiz results found.";
            lblMessage.Visible = true;
        }
    }

    private DataTable GetQuizResults()
    {
        DataTable dt = new DataTable();
        string connString = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            string query = @"
            SELECT QuizResults.ResultID, QuizResults.UserID, Users.Username, Users.Email, 
            QuizResults.Score, Quizzes.QuizName AS QuizName, QuizResults.DateTaken
                          FROM QuizResults
            INNER JOIN Users ON QuizResults.UserID = Users.ID
            INNER JOIN Quizzes ON QuizResults.QuizID = Quizzes.QuizID";
 
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    conn.Open();
                    da.Fill(dt);
                }
            }
        }
        return dt;
    }
    protected void gvQuizResults_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DownloadCertificate")
        {
            string resultID = e.CommandArgument.ToString(); // GUID, not INT

            if (!string.IsNullOrEmpty(resultID))
            {
                Response.Redirect("Certificate.aspx?ResultID=" + resultID);
            }
            else
            {
                lblMessage.Text = "❌ Error: Invalid Result ID. (Debug Info: " + resultID + ")";
                lblMessage.Visible = true;
            }
        }
    }

    protected void btnDownloadCertificate_Click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        if (btn == null || string.IsNullOrEmpty(btn.CommandArgument))
        {
            lblMessage.Text = "❌ Error: CommandArgument is missing.";
            lblMessage.Visible = true;
            return;
        }

        int resultID;
        if (!int.TryParse(btn.CommandArgument, out resultID))
        {
            lblMessage.Text = "❌ Error: Invalid ResultID.";
            lblMessage.Visible = true;
            return;
        }

        // ✅ Use the correct connection string
        string connString = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            string query = @"SELECT U.Name, Q.QuizName, R.DateTaken
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
                    // ✅ Store values in session before redirecting
                    Session["Name"] = reader["Name"].ToString();
                    Session["QuizName"] = reader["QuizName"].ToString();
                    Session["CompletionDate"] = Convert.ToDateTime(reader["DateTaken"]).ToString("yyyy-MM-dd HH:mm:ss");
                }
            }
        }

        // ✅ Redirect to Certificate Page
        Response.Redirect("Certificate.aspx");
    }

    protected void gvQuizResults_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int score = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Score"));
            Button btnCertificate = (Button)e.Row.FindControl("btnDownloadCertificate");

            if (score < 85)
            {
                btnCertificate.Enabled = false;
                btnCertificate.Text = "Not Eligible";
                btnCertificate.CssClass = "btn-certificate disabled"; // Add a disabled style
            }
        }
    }

    // Example method for handling certificate download
    private void GenerateCertificate(string resultID)
    {
        // Validate the resultID (GUID)
        if (string.IsNullOrEmpty(resultID))
        {
            lblMessage.Text = "❌ Error: Invalid Result ID.";
            lblMessage.Visible = true;
            return;
        }

        // Redirect to the Certificate Generation Page
        Response.Redirect("Certificate.aspx?ResultID=" + resultID);
    }

}
