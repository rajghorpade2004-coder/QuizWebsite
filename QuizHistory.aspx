<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QuizHistory.aspx.cs" MasterPageFile="~/Site.master" Inherits="QuizHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <style>
    h2 {
        text-align: center;
        margin-top: 20px;
        color: #333;
        font-weight: bold;
    }

    .quiz-history-container {
        width: 90%;
        max-width: 800px;
        margin: 20px auto;
        padding: 20px;
        background: #ffffff;
        border-radius: 8px;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    }

    .quiz-table {
        width: 100%;
        border-collapse: collapse;
        background: white;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    }

    .quiz-table th {
        background-color: #007bff;
        color: white;
        padding: 12px;
        text-align: center;
        font-size: 16px;
        font-weight: bold;
    }

    .quiz-table td {
        padding: 12px;
        text-align: center;
        border-bottom: 1px solid #ddd;
        font-size: 15px;
        color: #333;
    }

    .quiz-table tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    .quiz-table tr:hover {
        background-color: #f1f1f1;
    }

    .btn-certificate {
        background: #28a745;
        color: white;
        border: none;
        padding: 10px 16px;
        font-size: 14px;
        font-weight: bold;
        border-radius: 6px;
        cursor: pointer;
        transition: all 0.3s ease-in-out;
        text-transform: uppercase;
        display: inline-block;
        text-align: center;
        min-width: 120px;
    }

    .btn-certificate:hover {
        background: #218838;
        transform: translateY(-2px);
        box-shadow: 0 3px 6px rgba(0, 0, 0, 0.2);
    }

    .alert {
        color: red;
        font-weight: bold;
        text-align: center;
        margin-top: 15px;
        display: block;
    }
        .btn-certificate.disabled {
         background: gray;
         cursor: not-allowed;
    }  
           



    @media screen and (max-width: 768px) {
        .quiz-history-container {
            width: 95%;
            padding: 15px;
        }

        .quiz-table th, .quiz-table td {
            padding: 10px;
            font-size: 14px;
        }
    }
  </style>

  <div class="quiz-history-container">
      <h2>Quiz History</h2>

      <asp:Label ID="lblMessage" runat="server" CssClass="alert" Visible="false"></asp:Label>

<asp:GridView ID="gvQuizHistory" runat="server" AutoGenerateColumns="False"
    CssClass="quiz-table" OnRowCommand="gvQuizHistory_RowCommand" OnRowDataBound="gvQuizHistory_RowDataBound" OnSelectedIndexChanged="gvQuizHistory_SelectedIndexChanged">
    <Columns>
        <asp:BoundField DataField="ResultID" HeaderText="Result ID" />
        <asp:BoundField DataField="QuizID" HeaderText="Quiz ID" />
        <asp:BoundField DataField="QuizTitle" HeaderText="Quiz Title" />
        <asp:BoundField DataField="Score" HeaderText="Score" />
        <asp:BoundField DataField="TotalQuestions" HeaderText="Total Questions" />
        <asp:BoundField DataField="DateTaken" HeaderText="Date Taken" DataFormatString="{0:yyyy-MM-dd}" />

<asp:TemplateField HeaderText="Certificate">
    <ItemTemplate>
        <asp:Button ID="btnDownloadCertificate" runat="server" Text="Download"
            CssClass="btn-certificate" CommandName="DownloadCertificate"
            CommandArgument='<%# Eval("ResultID").ToString() %>' Visible="true" />
    </ItemTemplate>
</asp:TemplateField>
    </Columns>
</asp:GridView>
  </div>
</asp:Content>
