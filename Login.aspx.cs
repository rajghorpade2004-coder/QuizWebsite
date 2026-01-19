using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // ✅ Redirect users if already logged in
        if (Session["UserEmail"] != null && Session["UserRole"] != null)
        {
            string role = Session["UserRole"].ToString();
            Response.Redirect(role == "Admin" ? "AdminDashboard.aspx" : "Home.aspx");
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        string password = txtPassword.Text.Trim();

        // ✅ Get connection string from Web.config
        string connString = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();

            // ✅ Query to fetch user details
            string query = "SELECT ID, Name, Email, Password, Role FROM Users WHERE Email = @Email";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Email", email);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        // ✅ Fetch data from the database
                        int userID = Convert.ToInt32(reader["ID"]);
                        string name = reader["Name"].ToString();
                        string storedHashedPassword = reader["Password"].ToString();
                        string role = reader["Role"].ToString();

                        // ✅ Compare entered password with stored hashed password
                        if (VerifyHashedPassword(storedHashedPassword, password))
                        {
                            // ✅ Store user information in Session
                            Session["UserID"] = userID;  // 🔥 Added UserID to session
                            Session["UserName"] = name;
                            Session["UserEmail"] = email;
                            Session["UserRole"] = role;

                            // ✅ Redirect based on role
                            Response.Redirect(role == "Admin" ? "AdminDashboard.aspx" : "Home.aspx");
                        }
                        else
                        {
                            ShowErrorMessage("⚠ Invalid email or password.");
                        }
                    }
                    else
                    {
                        ShowErrorMessage("⚠ Invalid email or password.");
                    }
                }
            }
        }
    }

    // ✅ Hash Password using SHA-256
    private string HashPassword(string password)
    {
        using (SHA256 sha256 = SHA256.Create())
        {
            byte[] bytes = Encoding.UTF8.GetBytes(password);
            byte[] hashBytes = sha256.ComputeHash(bytes);
            return Convert.ToBase64String(hashBytes);
        }
    }

    // ✅ Verify stored password hash against entered password
    private bool VerifyHashedPassword(string storedHash, string inputPassword)
    {
        string inputHash = HashPassword(inputPassword);
        return storedHash == inputHash;
    }

    // ✅ Display error messages in a consistent manner
    private void ShowErrorMessage(string message)
    {
        lblMessage.Text = message;
        lblMessage.ForeColor = System.Drawing.Color.Red;
    }
}
