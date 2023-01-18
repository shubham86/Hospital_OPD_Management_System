<%@ Page Title="Dashboard" Language="C#" MasterPageFile="/cpanel/MasterCP.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Hospital_Reception.cpanel.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        window.onload = function () {
            document.getElementById("dash").setAttribute("class","active open");
        };                
    </script>
    <style>
        @media only screen and (min-width : 1024px) {
            
        }

        @media only screen and (min-device-width : 480px) and (max-device-width : 1024px) {
            
        }

        @media only screen and (min-device-width : 320px) and (max-device-width : 480px) {            
             .mobile-hide {
                display:none;
            }  
        }   
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content home">
    <div class="block-header">
        <div class="row">
            <div class="col-lg-5 col-md-5 col-sm-12">
                <h2>Dashboard
                <small>Welcome to Fertility Clinic</small>
                </h2>
            </div>            
            <div class="col-lg-7 col-md-7 col-sm-12 text-right">
                <div class="inlineblock text-center m-r-15 m-l-15 hidden-md-down mobile-hide">
                    <div class="sparkline" data-type="bar" data-width="97%" data-height="25px" data-bar-Width="2" data-bar-Spacing="5" data-bar-Color="#fff">3,2,6,5,9,8,7,9,5,1,3,5,7,4,6</div>
                    <small class="col-white">Patient</small>
                </div> 
                <ul class="breadcrumb float-md-right">
                    <li class="breadcrumb-item"><a href="Dashboard.aspx"><i class="zmdi zmdi-home"></i> Dashboard</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="container-fluid">
        <div class="row clearfix">
            <div class="col-lg-12 col-md-12 col-sm-12">
                <asp:Panel ID="pnlAlert" runat="server" class="" role="alert" Visible="false">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close" style="padding-top: 10px"><span aria-hidden="true">&times;</span></button>
                    <asp:Label ID="lblalert" runat="server" Text="" Font-Bold="true"></asp:Label>
                </asp:Panel>
            </div>

            <div class="col-lg-4 col-md-6">
                <a href="OneDayList.aspx">
                    <div class="card">
                        <div class="body">
                            <h3 id="h3Cecked" runat="server" class="number count-to m-b-0" data-from="0" data-speed="500" data-fresh-interval="700">
                                <asp:Label ID="lblCecked" runat="server" Text="0"></asp:Label>
                                <i class="zmdi zmdi-trending-up float-right"></i>
                            </h3>
                            <p class="text-muted">Checked Patients</p>
                            <div class="progress">
                                <div id="progressChecked" runat="server" class="progress-bar l-green" role="progressbar" aria-valuenow="68" aria-valuemin="0" aria-valuemax="100" style="width: 68%;"></div>
                            </div>
                            <small>
                                <asp:Label ID="lblCeckedPercent" runat="server" Text="0"></asp:Label></small>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-4 col-md-6">
                <a href="BookAppointment.aspx" id="middle" runat="server">
                <div class="card">
                    <div class="body">
                        <h3 id="h3Pending" runat="server" class="number count-to m-b-0" data-from="0" data-speed="500" data-fresh-interval="1000">
                            <asp:Label ID="lblPending" runat="server" Text="0"></asp:Label>
                            <i class="zmdi zmdi-trending-up float-right"></i>
                        </h3>
                        <p class="text-muted">Pending Patients</p>
                        <div class="progress">
                            <div id="progressPending" runat="server" class="progress-bar l-blush" role="progressbar" aria-valuenow="68" aria-valuemin="0" aria-valuemax="100" style="width: 68%;"></div>
                        </div>
                        <small><asp:Label ID="lblPendingPercent" runat="server" Text="0"></asp:Label></small>
                    </div>
                </div>
                    </a>
            </div>
            <div class="col-lg-4 col-md-12">
                <a href="OurPatient.aspx">
                    <div class="card">
                        <div class="body">
                            <h3 id="h3Total" runat="server" class="number count-to m-b-0" data-from="0" data-speed="500" data-fresh-interval="1000">
                                <asp:Label ID="lblHappyPatient" runat="server" Text="0"></asp:Label>
                                <i class="zmdi zmdi-trending-up float-right"></i>
                            </h3>
                            <p class="text-muted">Happy Patients <i class="zmdi zmdi-mood"></i></p>
                            <div class="progress">
                                <div class="progress-bar l-parpl" role="progressbar" aria-valuenow="68" aria-valuemin="0" aria-valuemax="100" style="width: 100%;"></div>
                            </div>
                            <small>100 %</small>
                        </div>
                    </div>
                </a>
            </div>
        </div>                
    </div>
</section>
    <!-- Jquery Core Js -->
    <script src="assets/bundles/libscripts.bundle.js"></script>
</asp:Content>
