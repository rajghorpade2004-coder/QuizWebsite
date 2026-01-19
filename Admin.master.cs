using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Redirect users who are not Admins
        if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Admin")
        {
            Response.Redirect("~/Home.aspx"); // Redirect non-admins to Home
        }
    }

    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        Session.Clear(); // Clear session to log the admin out
        Response.Redirect("~/Home.aspx"); // Redirect to home page after logout
    }
}
