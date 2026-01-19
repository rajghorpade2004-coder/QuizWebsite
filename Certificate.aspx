<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Certificate.aspx.cs" Inherits="Certificate" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Certificate</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #f8f9fa;
            font-family: 'Georgia', serif;
        }

        .certificate-container {
            width: 900px;
            margin: 50px auto;
            background: #fff;
            border: 10px solid #2c3e50;
            padding: 40px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }

        .certificate-container h2 {
            font-size: 32px;
            font-weight: bold;
            color: #2c3e50;
            text-transform: uppercase;
        }

        .certificate-title {
            font-size: 28px;
            font-weight: bold;
            color: #e67e22;
            margin-top: 10px;
            text-transform: uppercase;
        }

        .certificate-body {
            margin-top: 30px;
            font-size: 20px;
            color: #444;
        }

        .certificate-name {
            font-size: 26px;
            font-weight: bold;
            color: #16a085;
            margin-top: 10px;
        }

        .certificate-footer {
            margin-top: 40px;
            font-size: 18px;
        }

        .signature {
            font-size: 22px;
            font-style: italic;
            border-top: 2px solid #333;
            width: 250px;
            margin: 20px auto;
        }

        .print-button {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server"> 
        <div class="container mt-4 text-center">
            <div class="certificate-container" id="certificate">
                <h2>Certificate of Completion</h2>

                <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-danger" Visible="false"></asp:Label>

                <div class="certificate-title">This is to certify that</div>
                <h3 class="certificate-name">
                    <asp:Label ID="lblName" runat="server"></asp:Label>
                </h3>

                <div class="certificate-body">
                    has successfully completed the quiz <br>
                    <strong>
                        <asp:Label ID="lblQuizTitle" runat="server"></asp:Label>
                    </strong><br>
                    on <asp:Label ID="lblCompletionDate" runat="server"></asp:Label>
                </div>

                <div class="certificate-footer">
                    <div class="signature">Administrator</div>
                    <div>Quiz Website</div>
                </div>
            </div>

            
            <asp:Button ID="btnPrint" runat="server" CssClass="btn btn-primary print-button"
                Text="Print Certificate" OnClientClick="printCertificate(); return false;" />
        </div>
    </form>

    <script>
        function printCertificate() {
            var printContent = document.getElementById("certificate").innerHTML;
            var originalContent = document.body.innerHTML;

            document.body.innerHTML = printContent;
            window.print();
            document.body.innerHTML = originalContent;
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
