using System;
using System.Web;
using System.Web.UI;

public partial class Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // ✅ Restrict access to logged-in users with UserRole = "User"
        if (Session["UserRole"] == null || Session["UserRole"].ToString() != "User" || Session["UserName"] == null)
        {
            Response.Redirect("Login.aspx"); // Redirect unauthorized users
        }

        if (!IsPostBack)
        {
            // ✅ Display greeting with guaranteed non-null UserName
            lblGreeting.Text = "Welcome, " + Session["UserName"].ToString() + "!";
        }
    }
}
