using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ManageUsers : System.Web.UI.Page
{
    private readonly string connStr = ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadUsers();
        }
    }

    private void LoadUsers(string searchText = "")
    {
        try
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT ID, Name, Email FROM Users";

                if (!string.IsNullOrEmpty(searchText))
                {
                    query += " WHERE Name LIKE @Search OR Email LIKE @Search";
                }

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (!string.IsNullOrEmpty(searchText))
                    {
                        cmd.Parameters.AddWithValue("@Search", "%" + searchText + "%");
                    }

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvUsers.DataSource = dt;
                    gvUsers.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            ShowAlert("Error loading users: " + ex.Message);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string searchText = txtSearch.Text.Trim();
        LoadUsers(searchText);
    }

    protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            int userId = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "DELETE FROM Users WHERE ID = @ID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ID", userId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            LoadUsers();
            ShowAlert("User deleted successfully.");
        }
        catch (Exception ex)
        {
            ShowAlert("Error deleting user: " + ex.Message);
        }
    }

    private void ShowAlert(string message)
    {
        string script = "alert('" + message.Replace("'", "\\'") + "');";
        ScriptManager.RegisterStartupScript(this, GetType(), "alert", script, true);
    }
}
