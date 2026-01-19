<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminLogin.aspx.cs" MasterPageFile="~/Site.master" Inherits="AdminLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
    <title>Admin Login - Quiz Website</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="admin-login-container">
        <h2>Admin Login</h2>

        <asp:Label ID="lblErrorMessage" runat="server" CssClass="error-message" Visible="false"></asp:Label>

        <div class="form-group">
            <asp:Label ID="lblEmail" runat="server" Text="Email:" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtAdminEmail" runat="server" CssClass="admin-input" Placeholder="Admin Email"></asp:TextBox>
        </div>

        <div class="form-group">
            <asp:Label ID="lblPassword" runat="server" Text="Password:" CssClass="form-label"></asp:Label>
            <asp:TextBox ID="txtAdminPassword" runat="server" CssClass="admin-input" TextMode="Password" Placeholder="Password"></asp:TextBox>
        </div>

        <asp:Button ID="btnAdminLogin" runat="server" Text="Login" CssClass="btn-admin-login" OnClick="btnAdminLogin_Click" />
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Head" runat="server">
    <style>
        /* ========================== */
        /*      General Styles        */
        /* ========================== */

        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        /* ✅ Centered Container */
        .admin-login-container {
            width: 400px;
            margin: 50px auto;
            padding: 30px;
            background: #ffffff;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            text-align: center;
            border: 2px solid #ccc;
        }

        /* ✅ Headings */
        .admin-login-container h2 {
            font-size: 24px;
            color: #2d3e50;
            margin-bottom: 20px;
        }

        /* ✅ Form Group */
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }

        /* ✅ Input Fields */
        .admin-input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            display: block;
            margin-top: 5px;
        }

        /* ✅ Green Button */
        .btn-admin-login {
            width: 100%;
            padding: 12px;
            background: #28a745; /* Green Color */
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 18px;
            transition: 0.3s;
            margin-top: 10px;
        }

        .btn-admin-login:hover {
            background: #218838; /* Darker Green on Hover */
        }

        /* ✅ Error Messages */
        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 10px;
            text-align: center;
        }
    </style>
</asp:Content>
