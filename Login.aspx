<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" MasterPageFile="~/Site.Master" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" type="text/css" href="css/styles.css" />
     <style>
        /* ========================== */
        /* 🎨 Login Page Styles */
        /* ========================== */

        /* Center the login container */
        .login-container {
            width: 100%;
            max-width: 400px;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            margin: 50px auto;
        }

        /* ✅ Heading */
        .heading {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }

        /* ✅ Form Group */
        .form-group {
            text-align: left;
            margin-bottom: 15px;
        }

        .form-group label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        /* ✅ Input Fields */
        .input-field {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            transition: 0.3s;
        }

        .input-field:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }

        /* ✅ Login Button */
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
            margin-top: 10px;
        }

        .btn-green {
            background-color: #28a745;
            color: white;
        }

        .btn-green:hover {
            background-color: #218838;
        }

        /* ✅ Error Message */
        .error-message {
            color: #dc3545;
            font-size: 14px;
            margin-top: 10px;
            display: block;
        }

        /* ✅ Register Link */
        .link-text {
            font-size: 14px;
            margin-top: 15px;
        }

        .link {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }

        .link:hover {
            text-decoration: underline;
        }

        /* ✅ Responsive Design */
        @media (max-width: 500px) {
            .login-container {
                width: 90%;
                padding: 20px;
            }

            .btn {
                font-size: 14px;
                padding: 10px;
            }
        }

    </style>

    <div class="container login-container">
        <h1 class="heading">User Login</h1>

        <div class="form-group">
            <label for="txtEmail">Email</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="input-field" placeholder="Enter Email"></asp:TextBox>
        </div>

        <div class="form-group">
            <label for="txtPassword">Password</label>
            <asp:TextBox ID="txtPassword" runat="server" CssClass="input-field" TextMode="Password" placeholder="Enter Password"></asp:TextBox>
        </div>

        <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn btn-green" />

        <asp:Label ID="lblMessage" runat="server" CssClass="error-message"></asp:Label>

        <p class="link-text">Don't have an account? <a href="Register.aspx" class="link">Register here</a></p>
    </div>
</asp:Content>
