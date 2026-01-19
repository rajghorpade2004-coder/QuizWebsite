using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ManageQuizzes : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadQuizzes();
        }
    }

    private void LoadQuizzes()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT QuizID, QuizName FROM Quizzes";
            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gvQuizzes.DataSource = dt;
            gvQuizzes.DataBind();
        }
    }

    protected void btnAddQuiz_Click(object sender, EventArgs e)
    {
        string quizName = txtQuizTitle.Text.Trim();

        if (string.IsNullOrEmpty(quizName))  // ✅ Check if empty
        {
            lblMessage.Text = "⚠️ Please enter a quiz title.";
            lblMessage.CssClass = "alert alert-warning";
            lblMessage.Visible = true;
            return;  // ✅ Stop execution if empty
        }

        int totalQuestions = 0; // Default value

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "INSERT INTO Quizzes (QuizName, TotalQuestions) VALUES (@QuizName, @TotalQuestions)";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@QuizName", quizName);
                cmd.Parameters.AddWithValue("@TotalQuestions", totalQuestions);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        lblMessage.Text = "✅ Quiz added successfully!";
        lblMessage.CssClass = "alert alert-success";
        lblMessage.Visible = true;

        txtQuizTitle.Text = "";  // ✅ Clear input field
        LoadQuizzes();
    }

    protected void gvQuizzes_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridViewRow row = gvQuizzes.Rows[e.RowIndex];
        int quizID = Convert.ToInt32(gvQuizzes.DataKeys[e.RowIndex].Values[0]);
        TextBox txtEditQuizTitle = (TextBox)row.FindControl("txtEditQuizTitle");

        if (txtEditQuizTitle != null)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "UPDATE Quizzes SET QuizName = @QuizName WHERE QuizID = @QuizID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@QuizName", txtEditQuizTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@QuizID", quizID);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        gvQuizzes.EditIndex = -1;  // Exit edit mode
        LoadQuizzes();
    }

    protected void gvQuizzes_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvQuizzes.EditIndex = -1;  // Cancel edit mode
        LoadQuizzes();
    }

    protected void gvQuizzes_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int quizID = Convert.ToInt32(gvQuizzes.DataKeys[e.RowIndex].Values[0]);

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "DELETE FROM Quizzes WHERE QuizID = @QuizID";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@QuizID", quizID);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        LoadQuizzes();
    }
    protected void gvQuizzes_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvQuizzes.EditIndex = e.NewEditIndex;  // Set the index of the row to be edited
        LoadQuizzes();  // Reload the quiz data
    }

}
