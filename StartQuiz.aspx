<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StartQuiz.aspx.cs" MasterPageFile="~/Site.master" Inherits="StartQuiz" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="start-quiz-container">
        <h2 class="start-quiz-heading">Choose a Quiz</h2>

        <asp:Label ID="lblMessage" runat="server" CssClass="message-label"></asp:Label>

        <!-- Dropdown to select a quiz -->
        <div class="form-group">
            <asp:DropDownList ID="ddlQuizzes" runat="server" CssClass="dropdown" AppendDataBoundItems="True">
                <asp:ListItem Text="Select a Quiz" Value="" />
            </asp:DropDownList>
        </div>

        <!-- Start Quiz Button -->
        <div class="quiz-button-container">
            <asp:Button ID="btnStartQuiz" runat="server" Text="Start Quiz" CssClass="btn btn-start" OnClick="btnStartQuiz_Click" />
        </div>
    </div>

    <style>
        .start-quiz-container {
            text-align: center;
            padding: 20px;
        }

        .start-quiz-heading {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .message-label {
            font-size: 16px;
            color: red;
            margin-bottom: 10px;
            display: block;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .dropdown {
            width: 50%;
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .quiz-button-container {
            margin-top: 20px;
        }

        .btn-start {
            display: inline-block;
            padding: 10px 20px;
            font-size: 18px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn-start:hover {
            background-color: #0056b3;
        }
    </style>
</asp:Content>
