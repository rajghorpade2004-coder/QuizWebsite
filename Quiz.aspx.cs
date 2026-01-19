using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class Quiz : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["QuizID"] != null)
            {
                int quizID = Convert.ToInt32(Session["QuizID"]);

                // Load quiz title
                LoadQuizTitle(quizID);

                // Hide buttons initially
                btnNext.Visible = false;
                btnSubmitQuiz.Visible = false;
                btnQuizHistory.Visible = false;

                if (Session["QuizCompleted"] != null && (bool)Session["QuizCompleted"])
                {
                    btnQuizHistory.Visible = true;
                }
            }
            else
            {
                lblMessage.Text = "⚠ No quiz selected.";
            }
        }
    }

    private void LoadQuizTitle(int quizID)
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT QuizTitle FROM Quizzes WHERE QuizID = @QuizID";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@QuizID", quizID);

            conn.Open();
            object result = cmd.ExecuteScalar();
            if (result != null)
            {
                lblQuizTitle.Text = result.ToString();
            }
            else
            {
                lblQuizTitle.Text = "Quiz";
            }
        }
    }

    protected void btnStartQuiz_Click(object sender, EventArgs e)
    {
        if (Session["QuizID"] == null)
        {
            lblMessage.Text = "⚠ No quiz selected. Please select a quiz first.";
            return;
        }

        int quizID = Convert.ToInt32(Session["QuizID"]);
        LoadQuestions(quizID);

        if (Session["Questions"] == null || ((DataTable)Session["Questions"]).Rows.Count == 0)
        {
            lblMessage.Text = "⚠ No questions found for this quiz.";
            return;
        }

        Session["QuestionIndex"] = 0;
        Session["CorrectAnswers"] = 0;
        DisplayQuestion(0);

        btnNext.Visible = true;
        btnSubmitQuiz.Visible = false;
        btnStartQuiz.Visible = false;
    }

    private void LoadQuestions(int quizID)
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT * FROM Questions WHERE QuizID = @QuizID";
            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            da.SelectCommand.Parameters.AddWithValue("@QuizID", quizID);
            DataTable dt = new DataTable();
            da.Fill(dt);
            Session["Questions"] = dt;
        }
    }

    private void DisplayQuestion(int index)
    {
        DataTable dt = Session["Questions"] as DataTable;

        if (index < dt.Rows.Count)
        {
            DataRow row = dt.Rows[index];
            lblQuestion.Text = row["QuestionText"].ToString();

            rblOptions.Items.Clear();
            rblOptions.Items.Add(new ListItem(row["OptionA"].ToString(), "A"));
            rblOptions.Items.Add(new ListItem(row["OptionB"].ToString(), "B"));
            rblOptions.Items.Add(new ListItem(row["OptionC"].ToString(), "C"));
            rblOptions.Items.Add(new ListItem(row["OptionD"].ToString(), "D"));

            Session["CorrectAnswer"] = row["CorrectOption"].ToString();
        }
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (rblOptions.SelectedItem == null)
        {
            lblMessage.Text = "⚠ Please select an answer before moving to the next question.";
            return;
        }

        if (rblOptions.SelectedValue == Session["CorrectAnswer"].ToString())
        {
            Session["CorrectAnswers"] = (int)Session["CorrectAnswers"] + 1;
        }

        int index = (int)Session["QuestionIndex"] + 1;
        Session["QuestionIndex"] = index;

        if (index < ((DataTable)Session["Questions"]).Rows.Count)
        {
            DisplayQuestion(index);
        }
        else
        {
            btnNext.Visible = false;
            btnSubmitQuiz.Visible = true;
        }
    }

    protected void btnSubmitQuiz_Click(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            lblMessage.Text = "⚠ User not logged in. Please log in first.";
            Response.Redirect("Login.aspx");
            return;
        }

        int userID = Convert.ToInt32(Session["UserID"]);
        int quizID = Convert.ToInt32(Session["QuizID"]);
        int totalQuestions = ((DataTable)Session["Questions"]).Rows.Count;
        int correctAnswers = (int)Session["CorrectAnswers"];
        int score = (correctAnswers * 100) / totalQuestions;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "INSERT INTO QuizResults (UserID, QuizID, Score, DateTaken) VALUES (@UserID, @QuizID, @Score, GETDATE())";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@UserID", userID);
            cmd.Parameters.AddWithValue("@QuizID", quizID);
            cmd.Parameters.AddWithValue("@Score", score);
            conn.Open();
            cmd.ExecuteNonQuery();
        }

        btnQuizHistory.Visible = true;
        btnNext.Visible = false;
        btnSubmitQuiz.Visible = false;

        Session["QuizCompleted"] = true;
    }

    protected void btnQuizHistory_Click(object sender, EventArgs e)
    {
        Response.Redirect("QuizHistory.aspx");
    }
}
