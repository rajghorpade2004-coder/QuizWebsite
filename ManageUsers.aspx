<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageUsers.aspx.cs" MasterPageFile="~/Admin.master" Inherits="ManageUsers" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <style>
            /* General Page Styling */
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
    text-align: center;
   
}

h2 {
    color: #333;
    margin-top: 20px;
}

p {
    font-size: 16px;
    color: #555;
}

/* Search Box */
.search-box {
    padding: 10px;
    width: 300px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 5px;
    margin-right: 10px;
}

/* Search Button */
.btn-search {
    background-color: #007BFF;
    color: white;
    padding: 10px 15px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
}

.btn-search:hover {
    background-color: #0056b3;
}

/* Table Container */
.table-container {
    width: 80%;
    margin: 20px auto;
    overflow-x: auto;
}

/* General Table Styling */
table {
    width: 80%;
    margin: 20px auto;
    border-collapse: collapse;
    background-color: white;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}

/* Table Header */
table th {
    background-color: #007BFF;
    color: white;
    padding: 12px;
    text-align: left;
    font-size: 16px;
}

/* Table Cells */
table td {
    padding: 10px;
    border-bottom: 1px solid #ddd;
    font-size: 15px;
}

/* Alternating Row Colors */
table tr:nth-child(even) {
    background-color: #f2f2f2;
}

/* Hover Effect */
table tr:hover {
    background-color: #ddd;
    transition: 0.3s;
}



/* Alternating Row Colors */
#gvUsers tr:nth-child(even) {
    background-color: #f8f9fa;
}

#gvUsers tr:hover {
    background-color: #e9ecef;
    transition: 0.3s;
}

/* Delete Button */
#gvUsers .GridViewDeleteButton {
    background-color: #dc3545;
    color: white;
    padding: 6px 12px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
}

#gvUsers .GridViewDeleteButton:hover {
    background-color: #c82333;
}

            </style>
    </head>
    <h2>Manage Users</h2>
     <link rel="stylesheet" type="text/css" href="styles.css" />


    <!-- 🔍 Search Users -->
    <asp:TextBox ID="txtSearch" runat="server" CssClass="search-box" Placeholder="Search by Name or Email"></asp:TextBox>
    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn-search" OnClick="btnSearch_Click" />

    <br /><br />

    <!-- 📋 Users Grid -->
<asp:GridView ID="gvUsers" runat="server" CssClass="table" AutoGenerateColumns="False"
    DataKeyNames="ID" OnRowDeleting="gvUsers_RowDeleting">
    
    <Columns>
        <asp:BoundField DataField="ID" HeaderText="User ID" ReadOnly="True" />
        <asp:BoundField DataField="Name" HeaderText="Name" />
        <asp:BoundField DataField="Email" HeaderText="Email" />
        <asp:CommandField ShowDeleteButton="True" ButtonType="Button" DeleteText="Delete" ControlStyle-CssClass="btn btn-delete" />
    </Columns>
</asp:GridView>



</asp:Content>
