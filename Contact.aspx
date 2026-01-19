<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Contact.aspx.cs" MasterPageFile="~/Site.Master" Inherits="Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="contact-container">
        <h1>Contact Us</h1>
        <p>If you have any questions or feedback, feel free to reach out to us.</p>

        <div class="contact-form">
            <asp:Label ID="lblName" runat="server" Text="Your Name:" CssClass="contact-label"></asp:Label>
            <asp:TextBox ID="txtName" runat="server" CssClass="contact-input"></asp:TextBox>
            
            <asp:Label ID="lblEmail" runat="server" Text="Your Email:" CssClass="contact-label"></asp:Label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="contact-input"></asp:TextBox>

            <asp:Label ID="lblMessage" runat="server" Text="Your Message:" CssClass="contact-label"></asp:Label>
            <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="5" CssClass="contact-textarea"></asp:TextBox>

            <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="contact-button" OnClick="btnSubmit_Click" />

            <asp:Label ID="lblStatus" runat="server" CssClass="status-message"></asp:Label>
        </div>
    </div>

    <style>
        .contact-container {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            background: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .contact-label {
            font-size: 16px;
            font-weight: bold;
            display: block;
            margin-top: 10px;
        }

        .contact-input, .contact-textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        .contact-button {
            background-color: #007bff;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            margin-top: 15px;
            cursor: pointer;
            width: 100%;
        }

        .contact-button:hover {
            background-color: #0056b3;
        }

        .status-message {
            color: green;
            margin-top: 10px;
            display: block;
        }
    </style>
</asp:Content>
