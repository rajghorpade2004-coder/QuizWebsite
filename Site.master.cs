using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Site : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            UpdateNavBar(); // Update the navigation bar based on login status and role
        }
    }

    private void UpdateNavBar()
    {
        if (Session["UserEmail"] != null)
        {
            lnkHome.Visible = true;
            lnkLogin.Visible = false;
            lnkRegister.Visible = false;
            lnkLogout.Visible = true;
            lnkProfile.Visible = true;
            lnkStartQuiz.Visible = true;
            lnkQuizHistory.Visible = true;
            lnkLeaderboard.Visible = true;

            if (Session["UserRole"] != null && Session["UserRole"].ToString() == "Admin")
            {
                lnkAdminDashboard.Visible = false; // Hide Admin Dashboard in Site.Master
            }
        }
        else
        {
            lnkHome.Visible = false;
            lnkLogin.Visible = true;
            lnkRegister.Visible = true;
            lnkLogout.Visible = false;
            lnkProfile.Visible = false;
            lnkStartQuiz.Visible = false;
            lnkQuizHistory.Visible = false;
            lnkLeaderboard.Visible = false;
            lnkAdminDashboard.Visible = false;
        }
    }


    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        Session.Clear(); // Clear session to log the user out
        Response.Redirect("Home.aspx"); // Redirect to home page after logout
    }
}
