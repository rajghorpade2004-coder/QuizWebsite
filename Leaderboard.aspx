<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="Leaderboard.aspx.cs" Inherits="Leaderboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .leaderboard-container {
            width: 80%;
            max-width: 800px;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            overflow-x: auto;
        }

        h2 {
            text-align: center;
            color: #222;
            font-size: 26px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .leaderboard-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        .leaderboard-table th, .leaderboard-table td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        .leaderboard-table th {
            background: #007BFF;
            color: white;
            font-weight: bold;
            text-transform: uppercase;
        }

        .leaderboard-table tr:nth-child(even) {
            background: #f9f9f9;
        }

        .leaderboard-table tr:hover {
            background: rgba(0, 123, 255, 0.2);
            transition: 0.3s ease-in-out;
        }

        .leaderboard-table td {
            font-size: 16px;
            color: #333;
        }

        /* 🎯 Responsive Table */
        @media (max-width: 768px) {
            .leaderboard-container {
                width: 95%;
                padding: 15px;
            }
            .leaderboard-table th, .leaderboard-table td {
                padding: 8px;
                font-size: 14px;
            }
        }
    </style>

    <h2>Leaderboard</h2>
    <div class="leaderboard-container">
        <asp:GridView ID="gvLeaderboard" runat="server" AutoGenerateColumns="False" CssClass="leaderboard-table">
            <Columns>
                <asp:BoundField DataField="Rank" HeaderText="Rank" />
                <asp:BoundField DataField="Username" HeaderText="Player Name" />
                <asp:BoundField DataField="Score" HeaderText="Score" />
            </Columns>
        </asp:GridView>
        <asp:Label ID="lblMessage" runat="server" CssClass="alert" Visible="false"></asp:Label>

    </div>
</asp:Content>
