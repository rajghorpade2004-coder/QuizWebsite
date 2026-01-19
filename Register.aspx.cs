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
using System.Xml.Linq;

public partial class Register : System.Web.UI.Page
{
    protected void btnRegister_Click(object sender, EventArgs e)
    {
        string username = txtUsername.Text.Trim();
        string email = txtEmail.Text.Trim();
        string password = txtPassword.Text.Trim();

        if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
        {
            lblMessage.Text = "All fields are required!";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        // Hash the password before storing
        string hashedPassword = HashPassword(password);

        string connString = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();

            // Check if email already exists
            string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
            using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
            {
                checkCmd.Parameters.AddWithValue("@Email", email);
                int count = Convert.ToInt32(checkCmd.ExecuteScalar());

                if (count > 0)
                {
                    lblMessage.Text = "This email is already registered. Please use a different email.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }
            }

            // Insert new user
            string insertQuery = "INSERT INTO Users (Username, Email, Password, Role) VALUES (@Username, @Email, @Password, @Role)";
            using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
            {
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", hashedPassword);
                cmd.Parameters.AddWithValue("@Role", "User"); // Default role: User

                int result = cmd.ExecuteNonQuery();
                if (result > 0)
                {
                    Response.Redirect("Login.aspx"); // Redirect after successful registration
                }
                else
                {
                    lblMessage.Text = "Registration failed. Please try again.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }

    // Hashing function for password security
    private string HashPassword(string password)
    {
        using (SHA256 sha256 = SHA256.Create())
        {
            byte[] bytes = Encoding.UTF8.GetBytes(password);
            byte[] hashBytes = sha256.ComputeHash(bytes);
            return Convert.ToBase64String(hashBytes);
        }
    }
}
