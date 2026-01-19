using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ManageQuestions : System.Web.UI.Page
{
    private string connStr = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadQuizzes();  // Load available quizzes
            LoadQuestions();  // Load questions for the selected quiz (if any)
        }
    }

    private void LoadQuizzes()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT QuizID, QuizName FROM Quizzes";
            SqlCommand cmd = new SqlCommand(query, conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlQuizzes.DataSource = dt;
            ddlQuizzes.DataTextField = "QuizName";
            ddlQuizzes.DataValueField = "QuizID";
            ddlQuizzes.DataBind();

            ddlQuizzes.Items.Insert(0, new ListItem("-- Select a Quiz --", ""));
        }
    }

    private void LoadQuestions()
    {
        if (string.IsNullOrEmpty(ddlQuizzes.SelectedValue))
        {
            gvQuestions.DataSource = null;
            gvQuestions.DataBind();
            return;
        }

        int quizID = Convert.ToInt32(ddlQuizzes.SelectedValue);

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = @"SELECT QuestionID, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption 
                         FROM Questions 
                         WHERE QuizID = @QuizID";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@QuizID", quizID);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvQuestions.DataSource = dt;
            gvQuestions.DataBind();
        }
    }

    protected void ddlQuizzes_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadQuestions(); // Reload questions when quiz selection changes
    }

    protected void btnAddQuestion_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(ddlQuizzes.SelectedValue))
        {
            lblMessage.Text = "⚠ Please select a quiz before adding a question.";
            return;
        }

        int quizID = Convert.ToInt32(ddlQuizzes.SelectedValue);

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string checkQuery = "SELECT COUNT(*) FROM Questions WHERE QuizID = @QuizID";
            SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
            checkCmd.Parameters.AddWithValue("@QuizID", quizID);
            conn.Open();
            int questionCount = (int)checkCmd.ExecuteScalar();

            if (questionCount >= 15)
            {
                lblMessage.Text = "⚠ Maximum of 15 questions per quiz reached!";
                return;
            }
        }

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = @"INSERT INTO Questions (QuizID, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption) 
                             VALUES (@QuizID, @QuestionText, @A, @B, @C, @D, @Correct)";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@QuizID", quizID);
            cmd.Parameters.AddWithValue("@QuestionText", txtQuestion.Text);
            cmd.Parameters.AddWithValue("@A", txtOptionA.Text);
            cmd.Parameters.AddWithValue("@B", txtOptionB.Text);
            cmd.Parameters.AddWithValue("@C", txtOptionC.Text);
            cmd.Parameters.AddWithValue("@D", txtOptionD.Text);
            cmd.Parameters.AddWithValue("@Correct", ddlCorrectOption.SelectedValue);

            conn.Open();
            cmd.ExecuteNonQuery();
        }

        lblMessage.Text = "✅ Question added successfully!";
        LoadQuestions(); // Refresh the grid after adding a question
    }

    protected void gvQuestions_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvQuestions.EditIndex = e.NewEditIndex;
        LoadQuestions(); // Reload questions for editing
    }

    protected void gvQuestions_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvQuestions.EditIndex = -1;
        LoadQuestions(); // Cancel edit mode and reload
    }

    protected void gvQuestions_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int questionID = Convert.ToInt32(gvQuestions.DataKeys[e.RowIndex].Value);
        GridViewRow row = gvQuestions.Rows[e.RowIndex];

        TextBox txtQuestionText = (TextBox)row.Cells[1].Controls[0];
        string updatedText = txtQuestionText.Text.Trim();

        if (string.IsNullOrEmpty(updatedText))
        {
            lblMessage.Text = "⚠ Question text cannot be empty!";
            return;
        }

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "UPDATE Questions SET QuestionText = @QuestionText WHERE QuestionID = @QuestionID";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@QuestionText", updatedText);
            cmd.Parameters.AddWithValue("@QuestionID", questionID);

            conn.Open();
            cmd.ExecuteNonQuery();
        }

        gvQuestions.EditIndex = -1;
        LoadQuestions(); // Refresh after updating
    }

    protected void gvQuestions_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int questionID = Convert.ToInt32(gvQuestions.DataKeys[e.RowIndex].Value);

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "DELETE FROM Questions WHERE QuestionID = @QuestionID";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@QuestionID", questionID);

            conn.Open();
            cmd.ExecuteNonQuery();
        }

        lblMessage.Text = "❌ Question deleted!";
        LoadQuestions(); // Refresh after deletion
    }
}
