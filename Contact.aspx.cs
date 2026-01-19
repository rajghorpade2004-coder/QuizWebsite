using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Contact : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string name = txtName.Text.Trim();
        string email = txtEmail.Text.Trim();
        string message = txtMessage.Text.Trim();

        if (!string.IsNullOrEmpty(name) && !string.IsNullOrEmpty(email) && !string.IsNullOrEmpty(message))
        {
            try
            {
                // Store message in the database
                string connStr = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "INSERT INTO Messages (Name, Email, Message, SentDate) VALUES (@Name, @Email, @Message, GETDATE())";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Message", message);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                lblStatus.Text = "Message sent successfully!";
                lblStatus.ForeColor = System.Drawing.Color.Green;

                // Clear fields after submission
                txtName.Text = "";
                txtEmail.Text = "";
                txtMessage.Text = "";
            }
            catch (Exception ex)
            {
                lblStatus.Text = "Error sending message: " + ex.Message;
                lblStatus.ForeColor = System.Drawing.Color.Red;
            }
        }
        else
        {
            lblStatus.Text = "Please fill in all fields.";
            lblStatus.ForeColor = System.Drawing.Color.Red;
        }
    }
}

