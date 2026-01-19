<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" MasterPageFile="~/Site.Master" Inherits="Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="home-container">
        <h1 class="home-heading">Welcome to the Quiz Website</h1>
        
        <asp:Label ID="lblGreeting" runat="server" CssClass="greeting-text"></asp:Label>

        <p class="home-description">Test your general knowledge with fun and challenging quizzes! Earn points and track your progress.</p>

        <!-- Quiz Banner -->
        <div class="banner-container">
            <img src="photos/quiztime.png" alt="quiz image" border="0" alt="Quiz Image" class="quiz-banner" />
        </div>

        <!-- Start Quiz Button -->
        <div class="quiz-button-container">
            <asp:HyperLink ID="lnkStartQuiz" runat="server" NavigateUrl="StartQuiz.aspx" CssClass="btn btn-start-quiz">Start Quiz</asp:HyperLink>
        </div>
    </div>

    <style>
        .home-container {
            text-align: center;
            padding: 20px;
        }

        .home-heading {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .greeting-text {
            font-size: 18px;
            color: #333;
            margin-bottom: 10px;
            display: block;
        }

        .home-description {
            font-size: 16px;
            color: #666;
            margin-bottom: 20px;
        }

        .banner-container {
            display: flex;
            justify-content: center;
            margin: 20px 0;
        }

        /* ✅ Make image small and round */
        .quiz-banner {
            width: 150px; /* Adjust size */
            height: 150px; /* Keep aspect ratio */
            border-radius: 50%; /* Make it circular */
            object-fit: cover; /* Ensure it covers the round shape */
            border: 3px solid #333; /* Optional: Add a border */
        }

        .quiz-button-container {
            margin-top: 20px;
        }

        .btn-start-quiz {
            display: inline-block;
            padding: 10px 20px;
            font-size: 18px;
            color: white;
            background-color: #28a745;
            text-decoration: none;
            border-radius: 5px;
        }

        .btn-start-quiz:hover {
            background-color: #218838;
        }
    </style>
</asp:Content>
