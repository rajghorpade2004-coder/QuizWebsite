<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminMessages.aspx.cs" MasterPageFile="~/Admin.master" Inherits="AdminMessages" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
<header>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        h2 {
            color: #333;
            margin-top: 20px;
            text-align: center;
            font-size: 28px;
            font-weight: bold;
        }

        /* Table Container */
        .table-container {
            width: 90%;
            max-width: 1000px;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            overflow-x: auto;
        }

        /* General Table Styling */
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        /* Table Header */
        table th {
            background-color: #007BFF;
            color: white;
            padding: 12px;
            text-align: center;
            font-size: 16px;
            font-weight: bold;
            border: 1px solid #ddd;
        }

        /* Table Cells */
        table td {
            padding: 12px;
            border: 1px solid #ddd;
            font-size: 15px;
            text-align: center;
            word-break: break-word;
        }

        /* Alternating Row Colors */
        table tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        /* Hover Effect */
        table tr:hover {
            background-color: #e9ecef;
            transition: 0.3s ease-in-out;
        }

        /* Print Button Styling */
        .btn-print {
            display: block;
            width: 200px;
            margin: 20px auto;
            padding: 12px;
            background-color: #28a745;
            color: white;
            text-align: center;
            font-size: 16px;
            font-weight: bold;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: 0.3s ease-in-out;
        }

        .btn-print:hover {
            background-color: #218838;
        }

        /* Responsive Design */
        @media screen and (max-width: 768px) {
            .table-container {
                width: 95%;
            }

            table th, table td {
                padding: 10px;
                font-size: 14px;
            }

            .btn-print {
                width: 100%;
                padding: 10px;
            }
        }
    </style>
</header>

<h2>Admin Messages</h2>

<!-- Print Button -->
<asp:Button ID="btnPrint" runat="server" Text="Print Messages" CssClass="btn-print" OnClientClick="printMessages(); return false;" />

<!-- Messages Table -->
<div class="table-container">
    <asp:GridView ID="gvMessages" runat="server" AutoGenerateColumns="False" CssClass="table" BorderWidth="1px">
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="ID" />
            <asp:BoundField DataField="Name" HeaderText="Name" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="Message" HeaderText="Message" />
            <asp:BoundField DataField="SentDate" HeaderText="Sent Date" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
        </Columns>
    </asp:GridView>
</div>

<!-- JavaScript for Printing -->
<script>
    function printMessages() {
        var printWindow = window.open('', '', 'width=900,height=600');
        var content = document.querySelector('.table-container').innerHTML;

        printWindow.document.write('<html><head><title>Print Messages</title>');
        printWindow.document.write('<style>');
        printWindow.document.write('body { font-family: Arial, sans-serif; text-align: center; }');
        printWindow.document.write('table { width: 100%; border-collapse: collapse; margin-top: 20px; }');
        printWindow.document.write('th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }');
        printWindow.document.write('th { background-color: #007BFF; color: white; }');
        printWindow.document.write('</style></head><body>');

        printWindow.document.write('<h2>Admin Messages</h2>');
        printWindow.document.write(content);
        printWindow.document.write('</body></html>');

        printWindow.document.close();
        printWindow.print();
    }
</script>

</asp:Content>
