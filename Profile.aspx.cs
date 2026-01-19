using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;

public partial class ProfilePage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserEmail"] == null)
        {
            Response.Redirect("Login.aspx");
            return;
        }

        if (!IsPostBack)
        {
            LoadProfile();
        }
    }

    private void LoadProfile()
    {
        string email = Session["UserEmail"].ToString();
        string connString = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();
            string query = "SELECT Name, Email, ProfilePhoto FROM Users WHERE Email=@Email";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Email", email);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        txtName.Text = reader["Name"].ToString();
                        txtEmail.Text = reader["Email"].ToString();

                        if (reader["ProfilePhoto"] != DBNull.Value)
                        {
                            imgProfile.ImageUrl = "~/uploads/" + reader["ProfilePhoto"].ToString();
                        }
                        else
                        {
                            imgProfile.ImageUrl = "~/images/default-profile.png";
                        }
                    }
                }
            }
        }
    }

    protected void SaveProfile(object sender, EventArgs e)
    {
        string email = Session["UserEmail"].ToString();
        string name = txtName.Text.Trim();
        string profilePhoto = "";

        string uploadPath = Server.MapPath("~/uploads/");
        if (!Directory.Exists(uploadPath))
            Directory.CreateDirectory(uploadPath);

        if (fileUpload.HasFile)
        {
            string ext = Path.GetExtension(fileUpload.FileName).ToLower();
            if (ext == ".jpg" || ext == ".jpeg" || ext == ".png")
            {
                profilePhoto = email.Replace("@", "_").Replace(".", "_") + ext;
                fileUpload.SaveAs(Path.Combine(uploadPath, profilePhoto));
            }
            else
            {
                lblMessage.Text = "Only JPG, JPEG, PNG files allowed.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }
        }

        string connString = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();
            string query = "UPDATE Users SET Name=@Name" +
                           (profilePhoto != "" ? ", ProfilePhoto=@ProfilePhoto" : "") +
                           " WHERE Email=@Email";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Email", email);

                if (profilePhoto != "")
                    cmd.Parameters.AddWithValue("@ProfilePhoto", profilePhoto);

                cmd.ExecuteNonQuery();
            }
        }

        lblMessage.Text = "Profile updated successfully!";
        lblMessage.ForeColor = System.Drawing.Color.Green;
        LoadProfile();
    }
}
