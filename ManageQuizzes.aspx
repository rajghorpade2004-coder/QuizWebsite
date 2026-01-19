<%@ Page Language="C#" AutoEventWireup="true"
    CodeFile="ManageQuizzes.aspx.cs"
    MasterPageFile="~/Admin.master"
    Inherits="ManageQuizzes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .container {
            width: 80%;
            max-width: 800px;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .btn {
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }

        .btn-primary { background-color: #007bff; color: white; }
        .btn-primary:hover { background-color: #0056b3; }

        .btn-danger { background-color: #dc3545; color: white; }
        .btn-danger:hover { background-color: #a71d2a; }

        .form-control {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        .table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        .table th, .table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        .table th {
            background-color: #f2f2f2;
        }
    </style>

    <div class="container">
        <h2>Manage Quizzes</h2>

        <!-- 🔹 Add New Quiz -->
        <div class="form-group">
            <asp:TextBox ID="txtQuizTitle" runat="server" CssClass="form-control" placeholder="Enter Quiz Name"></asp:TextBox>
            <asp:Button ID="btnAddQuiz" runat="server" Text="Add Quiz" CssClass="btn btn-primary" OnClick="btnAddQuiz_Click" />
        </div>

        <!-- 🔹 Message Display -->
        <asp:Label ID="lblMessage" runat="server" CssClass="status-message" ForeColor="Red"></asp:Label>

        <!-- 🔹 Quiz GridView -->
        <asp:GridView ID="gvQuizzes" runat="server" CssClass="table" AutoGenerateColumns="False"
            DataKeyNames="QuizID"
            OnRowEditing="gvQuizzes_RowEditing"
            OnRowUpdating="gvQuizzes_RowUpdating"
            OnRowCancelingEdit="gvQuizzes_RowCancelingEdit"
            OnRowDeleting="gvQuizzes_RowDeleting">
            <Columns>
                <asp:BoundField DataField="QuizID" HeaderText="ID" ReadOnly="True" />

                <asp:TemplateField HeaderText="Quiz Title">
                    <ItemTemplate>
                        <asp:Label ID="lblQuizTitle" runat="server" Text='<%# Eval("QuizName") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEditQuizTitle" runat="server" CssClass="form-control" Text='<%# Eval("QuizName") %>'></asp:TextBox>  <!-- ✅ Updated ID -->
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:CommandField ShowEditButton="True" ButtonType="Button" EditText="Edit" ControlStyle-CssClass="btn btn-primary" />
                <asp:CommandField ShowDeleteButton="True" ButtonType="Button" DeleteText="Delete" ControlStyle-CssClass="btn btn-danger" />
            </Columns>
        </asp:GridView>
    </div>

</asp:Content>
