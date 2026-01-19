<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Profile.aspx.cs" MasterPageFile="~/Site.master" Inherits="ProfilePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <style>
        /* ========================== */
        /* 🎨 Profile Page Styles */
        /* ========================== */

        /* ✅ Profile Container */
        .profile-container {
            width: 100%;
            max-width: 500px;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            margin: 50px auto;
        }

        /* ✅ Heading */
        .profile-heading {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }

        /* ✅ Profile Photo */
        .profile-photo-section {
            margin-bottom: 20px;
        }

        .profile-photo {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #007bff;
        }

        .upload-btn {
            margin-top: 10px;
            display: block;
            width: 100%;
            max-width: 250px;
            padding: 8px;
            font-size: 14px;
        }

        /* ✅ Profile Info */
        .profile-info {
            text-align: left;
            margin-top: 20px;
        }

        .profile-info label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        /* ✅ Input Fields */
        .profile-input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            transition: 0.3s;
        }

        .profile-input:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }

        /* ✅ Save Button */
        .btn {
            display: block;
            width: 100%;
            padding: 12px;
            font-size: 16px;
            text-align: center;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
            border: none;
            margin-top: 20px;
        }

        .btn-save {
            background-color: #28a745;
            color: white;
        }

        .btn-save:hover {
            background-color: #218838;
        }

        /* ✅ Message Label */
        .message-label {
            color: #dc3545;
            font-size: 14px;
            margin-top: 10px;
            display: block;
        }

        /* ✅ Responsive Design */
        @media (max-width: 500px) {
            .profile-container {
                width: 90%;
                padding: 20px;
            }

            .btn {
                font-size: 14px;
                padding: 10px;
            }

            .upload-btn {
                font-size: 12px;
                padding: 6px;
            }
        }
    </style>

    <div class="profile-container">
        <h2 class="profile-heading">Edit Profile</h2>

        <!-- Profile Photo -->
        <div class="profile-photo-section">
            <asp:Image ID="imgProfile" runat="server" CssClass="profile-photo" ImageUrl="~/images/default-profile.png" />
            <br />
            <asp:FileUpload ID="fileUpload" runat="server" CssClass="upload-btn" />
        </div>

        <!-- Profile Info -->
        <div class="profile-info">
            <label for="txtName">Name:</label>
            <asp:TextBox ID="txtName" runat="server" CssClass="profile-input"></asp:TextBox>
            <br />

            <label for="txtEmail">Email:</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="profile-input" ReadOnly="true"></asp:TextBox>
            <br />

            <!-- Save Button -->
            <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="btn btn-save" OnClick="SaveProfile" />
        </div>

        <!-- Success/Error Message -->
        <asp:Label ID="lblMessage" runat="server" CssClass="message-label" ForeColor="Red"></asp:Label>
    </div>
</asp:Content>
