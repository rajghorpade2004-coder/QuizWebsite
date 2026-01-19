using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class QuizHistory : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            lblMessage.Text = "⚠ Error: User not logged in.";
            lblMessage.Visible = true;
            return;
        }

        if (!IsPostBack)
        {
            LoadQuizHistory();
        }

        // Check if a ResultID is provided for certificate generation
        if (!string.IsNullOrEmpty(Request.QueryString["ResultID"]))
        {
            string resultID = Request.QueryString["ResultID"];
            GenerateCertificate(resultID);
        }
    }

    private void LoadQuizHistory()
    {
        if (Session["UserID"] == null)
        {
            lblMessage.Text = "⚠ Error: User not logged in.";
            lblMessage.Visible = true;
            return;
        }

        int userID = Convert.ToInt32(Session["UserID"]);
        string connString = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            string query = @"
            SELECT CAST(R.ResultID AS NVARCHAR(50)) AS ResultID, 
                   R.QuizID, Q.QuizTitle, R.Score, Q.TotalQuestions, R.DateTaken
            FROM QuizResults R
            INNER JOIN Quizzes Q ON R.QuizID = Q.QuizID
            WHERE R.UserID = @UserID
            ORDER BY R.DateTaken DESC";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = userID;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    gvQuizHistory.DataSource = dt;
                    gvQuizHistory.DataBind();
                }
                else
                {
                    lblMessage.Text = "No quiz history found.";
                    lblMessage.Visible = true;
                }
            }
        }
    }

    protected void gvQuizHistory_RowCommand(object sender, GridViewCommandEventArgs e)
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

    protected void gvQuizHistory_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int score = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Score"));
            Button btnDownloadCertificate = (Button)e.Row.FindControl("btnDownloadCertificate");

            if (btnDownloadCertificate != null)
            {
                btnDownloadCertificate.Visible = (score >= 85);
            }
        }
    }

    private void GenerateCertificate(string resultID)
    {
        if (string.IsNullOrEmpty(resultID))
        {
            lblMessage.Text = "❌ Error: Invalid Result ID.";
            lblMessage.Visible = true;
            return;
        }

        Response.Redirect("Certificate.aspx?ResultID=" + resultID);
    }

    protected void gvQuizHistory_SelectedIndexChanged(object sender, EventArgs e)
    {
        int rowIndex = gvQuizHistory.SelectedIndex;

        if (rowIndex >= 0)
        {
            string resultID = gvQuizHistory.DataKeys[rowIndex].Value.ToString();
            Session["SelectedResultID"] = resultID;
            Response.Write("<script>alert('Selected Result ID: " + resultID + "');</script>");
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

        // Fix: Declare resultID before using it in TryParse
        int resultID;
        if (!int.TryParse(btn.CommandArgument, out resultID))
        {
            lblMessage.Text = "❌ Error: Invalid ResultID.";
            lblMessage.Visible = true;
            return;
        }

        string connString = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            string query = @"SELECT U.Name, Q.QuizTitle, R.DateTaken
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
                    Session["Name"] = reader["Name"].ToString();
                    Session["QuizTitle"] = reader["QuizTitle"].ToString();
                    Session["CompletionDate"] = Convert.ToDateTime(reader["DateTaken"]).ToString("yyyy-MM-dd HH:mm:ss");
                }
            }
        }

        Response.Redirect("Certificate.aspx");
    }
}
