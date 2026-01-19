using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminLogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Page load logic (if any)
    }

    protected void btnAdminLogin_Click(object sender, EventArgs e)
    {
        // Hardcoded admin credentials for testing
        string adminEmail = "admin@example.com";
        string adminPassword = "password123";

        // Check if entered credentials match
        if (txtAdminEmail.Text == adminEmail && txtAdminPassword.Text == adminPassword)
        {
            Session["UserRole"] = "Admin";  // Store role in session
            Response.Redirect("~/AdminDashboard.aspx");  // Redirect to the admin dashboard
        }
        else
        {
            lblErrorMessage.Text = "Invalid email or password."; // Display error message
            lblErrorMessage.Visible = true;  // Show error message
        }
    }
}


