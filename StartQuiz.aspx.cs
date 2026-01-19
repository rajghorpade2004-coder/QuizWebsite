using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class StartQuiz : System.Web.UI.Page
{
    // Database Connection String
    string connStr = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadQuizzes();
        }
    }

    // ✅ Load Quizzes into DropDownList
    private void LoadQuizzes()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT QuizID, QuizName FROM Quizzes";
            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlQuizzes.DataSource = dt;
            ddlQuizzes.DataTextField = "QuizName";
            ddlQuizzes.DataValueField = "QuizID";
            ddlQuizzes.DataBind();
        }

       
    }

    // ✅ Start Quiz Button Click
    protected void btnStartQuiz_Click(object sender, EventArgs e)
    {
        if (ddlQuizzes.SelectedValue != "")
        {
            Session["QuizID"] = ddlQuizzes.SelectedValue; // ✅ Store QuizID in session
            Response.Redirect("Quiz.aspx"); // Redirect to Quiz Page
        }
        else
        {
            lblMessage.Text = "Please select a quiz before starting.";
        }
    }
}

