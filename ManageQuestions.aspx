<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageQuestions.aspx.cs" MasterPageFile="~/Admin.master" Inherits="ManageQuestions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .container {
            width: 80%;
            max-width: 900px;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .input-field {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        .btn {
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .btn-green {
            background-color: #28a745;
            color: white;
        }

        .btn-green:hover {
            background-color: #218838;
        }

        .btn-edit {
            background-color: #ffc107;
            color: white;
        }

        .btn-edit:hover {
            background-color: #e0a800;
        }

        .btn-delete {
            background-color: #dc3545;
            color: white;
        }

        .btn-delete:hover {
            background-color: #c82333;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .table th, .table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        .table th {
            background-color: #007bff;
            color: white;
            text-align: center;
        }

        .table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .table tr:hover {
            background-color: #f1f1f1;
        }

        .status-message {
            font-size: 18px;
            color: #28a745;
            margin: 15px 0;
        }
    </style>

    <div class="container">
        <h2>Manage Questions</h2>

        <!-- Select Quiz -->
        <div class="form-group">
            <asp:DropDownList ID="ddlQuizzes" runat="server" CssClass="input-field" AutoPostBack="true" OnSelectedIndexChanged="ddlQuizzes_SelectedIndexChanged"></asp:DropDownList>
        </div>

        <!-- Add New Question -->
        <div class="form-group">
            <asp:TextBox ID="txtQuestion" runat="server" CssClass="input-field" Placeholder="Enter Question"></asp:TextBox>
            <asp:TextBox ID="txtOptionA" runat="server" CssClass="input-field" Placeholder="Option A"></asp:TextBox>
            <asp:TextBox ID="txtOptionB" runat="server" CssClass="input-field" Placeholder="Option B"></asp:TextBox>
            <asp:TextBox ID="txtOptionC" runat="server" CssClass="input-field" Placeholder="Option C"></asp:TextBox>
            <asp:TextBox ID="txtOptionD" runat="server" CssClass="input-field" Placeholder="Option D"></asp:TextBox>
            
            <asp:DropDownList ID="ddlCorrectOption" runat="server" CssClass="input-field">
                <asp:ListItem Text="Select Correct Option" Value="" />
                <asp:ListItem Text="A" Value="A" />
                <asp:ListItem Text="B" Value="B" />
                <asp:ListItem Text="C" Value="C" />
                <asp:ListItem Text="D" Value="D" />
            </asp:DropDownList>

            <asp:Button ID="btnAddQuestion" runat="server" Text="Add Question" CssClass="btn btn-green" OnClick="btnAddQuestion_Click" />
        </div>

        <!-- Display Message -->
        <asp:Label ID="lblMessage" runat="server" CssClass="status-message"></asp:Label>

        <!-- Questions Table -->
       <asp:GridView ID="gvQuestions" runat="server" CssClass="table" AutoGenerateColumns="False"
    DataKeyNames="QuestionID" OnRowEditing="gvQuestions_RowEditing"
    OnRowUpdating="gvQuestions_RowUpdating" OnRowCancelingEdit="gvQuestions_RowCancelingEdit"
    OnRowDeleting="gvQuestions_RowDeleting"> 
            
            <Columns>
                <asp:BoundField DataField="QuestionID" HeaderText="ID" ReadOnly="True" />
                <asp:BoundField DataField="QuestionText" HeaderText="Question" />
                <asp:BoundField DataField="OptionA" HeaderText="A" />
                <asp:BoundField DataField="OptionB" HeaderText="B" />
                <asp:BoundField DataField="OptionC" HeaderText="C" />
                <asp:BoundField DataField="OptionD" HeaderText="D" />
                <asp:BoundField DataField="CorrectOption" HeaderText="Answer" />

                <asp:CommandField ShowEditButton="True" ButtonType="Button" EditText="Edit" ControlStyle-CssClass="btn btn-edit" />
                <asp:CommandField ShowDeleteButton="True" ButtonType="Button" DeleteText="Delete" ControlStyle-CssClass="btn btn-delete" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
