<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminDashboard.aspx.cs" MasterPageFile="~/Admin.master" Inherits="AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="dashboard-title">Admin Dashboard</h2>

    <div class="dashboard-container">
        <div class="dashboard-card">
            <h3>Total Users</h3>
            <p><asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label></p>
        </div>

        <div class="dashboard-card">
            <h3>Total Quizzes</h3>
            <p><asp:Label ID="lblTotalQuizzes" runat="server" Text="0"></asp:Label></p>
        </div>

        <div class="dashboard-card">
            <h3>Total Quiz Attempts</h3>
            <p><asp:Label ID="lblTotalAttempts" runat="server" Text="0"></asp:Label></p>
        </div>
    </div>

    <style>
        .dashboard-container {
            display: flex;
            gap: 20px;
            margin-top: 20px;
        }
        .dashboard-card {
            background: #007bff;
            color: white;
            padding: 20px;
            border-radius: 10px;
            width: 200px;
            text-align: center;
        }
    </style>
</asp:Content>