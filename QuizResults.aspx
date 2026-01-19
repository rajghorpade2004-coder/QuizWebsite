<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QuizResults.aspx.cs" MasterPageFile="~/Admin.master" Inherits="QuizResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <style>
/* General Page Container */
.container {
    max-width: 1000px;
    margin: 30px auto;
    background: #fff;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

/* Page Heading */
h2 {
    text-align: center;
    color: #333;
    font-size: 26px;
    margin-bottom: 20px;
    font-weight: 600;
    text-transform: uppercase;
}

/* Table Styling */
.quiz-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    border-radius: 8px;
    overflow: hidden;
    font-size: 16px;
}

.quiz-table th,
.quiz-table td {
    padding: 12px;
    text-align: center;
    border: 1px solid #ddd;
}

.quiz-table th {
    background: #007bff;
    color: #fff;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.quiz-table td {
    background: #f9f9f9;
}

.quiz-table tr:hover {
    background: #e6f2ff;
    transition: 0.3s ease-in-out;
}

/* Button Styling */
.btn-certificate {
    background: #28a745;
    color: #fff;
    border: none;
    padding: 10px 16px;
    font-size: 14px;
    font-weight: 600;
    border-radius: 6px;
    cursor: pointer;
    transition: 0.3s ease-in-out;
    text-transform: uppercase;
    min-width: 120px;
    display: inline-block;
}

.btn-success:hover {
    background: #218838;
    transform: scale(1.05);
}

/* Error Message Styling */
.alert {
    color: #dc3545;
    font-weight: 600;
    text-align: center;
    padding: 10px;
    border-radius: 5px;
    background: #ffe6e6;
    border: 1px solid #dc3545;
}
    .btn-certificate.disabled {
         background: gray;
         cursor: not-allowed;
    }  



/* Responsive Design */
@media (max-width: 768px) {
    .container {
        width: 95%;
        padding: 20px;
    }

    .quiz-table th,
    .quiz-table td {
        font-size: 14px;
        padding: 10px;
    }

    .btn-success {
        font-size: 12px;
        padding: 8px 12px;
        min-width: 100px;
    }
}       

  </style>

    <div class="container">
        <h2>Quiz Results</h2>

        <asp:Label ID="lblMessage" runat="server" CssClass="alert" Visible="false"></asp:Label>

<asp:GridView ID="gvQuizResults" runat="server" AutoGenerateColumns="False"
    CssClass="quiz-table" DataKeyNames="ResultID" OnRowCommand="gvQuizResults_RowCommand"
    OnRowDataBound="gvQuizResults_RowDataBound">
    <Columns>
        <asp:BoundField DataField="ResultID" HeaderText="Result ID" />
        <asp:BoundField DataField="UserID" HeaderText="User ID" />
        <asp:BoundField DataField="UserName" HeaderText="Name" />
        <asp:BoundField DataField="Email" HeaderText="Email" />
        <asp:BoundField DataField="QuizName" HeaderText="Quiz Title" />
        <asp:BoundField DataField="Score" HeaderText="Score" />
        <asp:BoundField DataField="DateTaken" HeaderText="Date Taken" DataFormatString="{0:yyyy-MM-dd}" />

        <asp:TemplateField HeaderText="Certificate">
    <ItemTemplate>
       <asp:Button ID="btnDownloadCertificate" runat="server" Text="Download"
        CssClass="btn-certificate" CommandName="DownloadCertificate"
        CommandArgument='<%# Eval("ResultID") %>' />
    </ItemTemplate>
</asp:TemplateField>
        
    </Columns>
</asp:GridView>
    </div>
</asp:Content>
