<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Quiz.aspx.cs" MasterPageFile="~/Site.master" Inherits="Quiz" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="quiz-container">
        <h2 class="quiz-heading">
            <asp:Label ID="lblQuizTitle" runat="server" Text="Quiz Title"></asp:Label>
        </h2>

        <div class="question-container">
            <asp:Label ID="lblQuestion" runat="server" CssClass="question-label"></asp:Label>
        </div>

        <div class="options-container">
            <asp:RadioButtonList ID="rblOptions" runat="server" CssClass="option-list"></asp:RadioButtonList>
        </div>

        <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn btn-next" OnClick="btnNext_Click" Visible="false" />
        <asp:Button ID="btnStartQuiz" runat="server" Text="Start Quiz" CssClass="btn btn-primary" OnClick="btnStartQuiz_Click" />
        <asp:Button ID="btnSubmitQuiz" runat="server" Text="Submit Quiz" CssClass="btn btn-success" OnClick="btnSubmitQuiz_Click" Visible="false" />
        <asp:Button ID="btnQuizHistory" runat="server" Text="Quiz History" CssClass="btn btn-history" OnClick="btnQuizHistory_Click" Visible="false" />

        <asp:Label ID="lblMessage" runat="server" CssClass="error-message" ForeColor="Red"></asp:Label>
    </div>

    <style>
/* General Styling */
body {
    font-family: Arial, sans-serif;
    background-color: #f4f7fc;
    margin: 0;
    padding: 0;
}

/* Main Quiz Container */
.quiz-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    background-color: white;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    width: 90%;
    max-width: 600px;
    margin: 50px auto;
}

/* Quiz Heading */
.quiz-heading {
    font-size: 28px;
    font-weight: bold;
    color: #333;
    text-align: center;
    margin-bottom: 20px;
}

/* Question Container */
.question-container {
    width: 100%;
    text-align: center;
    margin-bottom: 20px;
}

.question-label {
    font-size: 20px;
    font-weight: bold;
    color: #007bff;
    display: block;
}

/* Options List */
.options-container {
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-bottom: 20px;
}

.option-list {
    list-style-type: none;
    padding: 0;
    width: 100%;
    max-width: 400px;
    text-align: left;
}

.option-list input {
    margin-right: 10px;
}

/* Button Styles */
.btn {
    width: 100%;
    max-width: 250px;
    padding: 12px;
    font-size: 18px;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background 0.3s, transform 0.1s;
    margin-top: 10px;
    text-align: center;
}

/* Button Colors */
.btn-primary { background-color: #007bff; }
.btn-primary:hover { background-color: #0056b3; }

.btn-next { background-color: #28a745; }
.btn-next:hover { background-color: #218838; }

.btn-success { background-color: #17a2b8; }
.btn-success:hover { background-color: #138496; }

.btn-history { background-color: #ffc107; color: #333; }
.btn-history:hover { background-color: #e0a800; }

/* Click Effect */
.btn:active {
    transform: scale(0.98);
}

/* Error Message */
.error-message {
    font-size: 16px;
    font-weight: bold;
    color: red;
    text-align: center;
    margin-top: 10px;
}

/* Responsive Design */
        @media (max-width: 768px) {
            .quiz-container {
                width: 95%;
                padding: 20px;
            }

            .btn {
                font-size: 16px;
                padding: 10px;
            }
        }    </style>
</asp:Content>
