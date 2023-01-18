<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DisplayScreen.aspx.cs" Inherits="Hospital_Reception.cpanel.DisplayScreen" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="../plugins/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/css/main.css" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <style>
        body {
            margin:0;
        }
        .header {
            background-color:#01d8da;
            height:100px;
            box-shadow: 0 3px 26px 2px #999;
        }
        .heading {
            margin-top:5%;
            text-align:center;
            margin:0 auto;
            font-size:26px;
            font-weight:500;
            color:#ffffff;
            margin-top:25px;
        }

        .patient {
            height:100px;            
            margin:10px auto;
            box-shadow:0px 3px 17px #999;
        }

        .first-patient{
            background: linear-gradient(45deg, #e8f9ff, #66ff79) !important;
        }

        .second-patient{
            background: linear-gradient(45deg, #fefae8, #ffe13e) !important;
        }

        table td {
            font-size:26px;
            font-weight:500;
            color:#424242;
            padding:30px;
        }
        a:hover {
            text-decoration:none;
        }
        .footer {
            bottom:0px;
            position:fixed;
            width:100%;
            padding:10px 30px;
            text-align:right !important;
        }
    </style>
    <script type="text/javascript">
        //refresh page after 4 sec
        setInterval('window.location.reload()', 4000);//4 sec

        window.setTimeout(function () { $(".alert").fadeTo(500, 0).slideUp(500, function () { $(this).remove(); }); }, 3000);

        //display date
        window.onload = function () {
            document.getElementById('<%=date.ClientID%>').innerHTML = (new Date()).toString().split(' ').splice(0, 4).join(' ');
        }

        var audio = new Audio("http://drkamblesfertilitycenter.in//cpanel/assets/bell.wav");

        function playAudio() {
            audio.play();
            window.setTimeout(function () {
                // Move to a new location or you can do something else
                window.location.href = "DisplayScreen.aspx";

            }, 3000);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <a id="next" runat="server" onserverclick="btnNext_Onclick">
                <div class="header">
                    <div class="row">
                        <div class="col-md-4"></div>
                        <span class="heading col-md-4">Dr. Kamble's Fertility Clinic</span>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="row" style="text-align: right">
                        <div class="col-md-12">
                            <span style="margin-right: 30px; color: #ffffff; font-weight: 500;">
                                <asp:Label ID="date" runat="server"></asp:Label></span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <asp:Panel ID="pnlAlert" runat="server" class="" role="alert" Visible="false">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <asp:Label ID="lblalert" runat="server" Text="" Font-Bold="true"></asp:Label>
                    </asp:Panel>
                </div>

                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div style="margin: 50px 30px; text-align: center">
                            <asp:Label ID="lblBlank" runat="server" Text="No one patient available in OPD" ForeColor="Red" Visible="false"></asp:Label>
                            <asp:Repeater ID="rptrPatient" runat="server" OnItemDataBound="OnItemDataBound">
                                <ItemTemplate>
                                    <div class="row">
                                        <asp:Panel class="" runat="server" ID="pnlName">
                                            <table width="100%">
                                                <tr>
                                                    <td width="35%" style="text-align: center">
                                                        <asp:Label ID="lblSrNo" runat="server" Text='<%# Eval("tokenNo") %>'></asp:Label></td>
                                                    <td width="65%" style="text-align: left">
                                                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("patientName") %>'></asp:Label></td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="footer">
                    <span style="font-size: 12px;color:#555555">Design and Developed by <span style="color: #00abad; font-weight: bold">Jerico Tchnologies, Pune.&nbsp <i class="zmdi zmdi-phone font-14"></i>&nbsp 8369-79-1005</span></span>
                </div>
            </a>
        </div>
        
        <asp:Label ID="lblFirstID" runat="server" Text="" ForeColor="Transparent" Font-Size="1px"></asp:Label>         
    </form>
</body>
</html>
