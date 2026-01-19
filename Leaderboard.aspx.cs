using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Leaderboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadLeaderboard();
        }
    }

    private void LoadLeaderboard()
    {
        string connStr = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = @"
            SELECT 
                ROW_NUMBER() OVER (ORDER BY MaxScore DESC) AS Rank, 
                Users.Username, 
                MaxScore AS Score
            FROM 
            (
                SELECT 
                    UserID, 
                    MAX(Score) AS MaxScore
                FROM QuizResults
                GROUP BY UserID
            ) AS HighestScores
            INNER JOIN Users ON HighestScores.UserID = Users.ID
            ORDER BY MaxScore DESC";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                try
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        gvLeaderboard.DataSource = dt;
                        gvLeaderboard.DataBind();
                    }
                    else
                    {
                        lblMessage.Text = "No leaderboard data available.";
                        lblMessage.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "❌ Error loading leaderboard: " + ex.Message;
                    lblMessage.Visible = true;
                }
            }
        }
    }
}
