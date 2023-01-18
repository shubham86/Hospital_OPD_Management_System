<%@ Page Title="One Day List" Language="C#" MasterPageFile="MasterCP.Master" AutoEventWireup="true" CodeBehind="OneDayList.aspx.cs" Inherits="Hospital_Reception.cpanel.OneDayList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="assets/bundles/libscripts.bundle.js"></script>
    <style>       
        .bootstrap-select.btn-group:not(.input-group-btn), .bootstrap-select.btn-group[class*="col-"] {
            width: 80px;
        }

        div.dataTables_wrapper div.dataTables_filter input {
            width: 300px;
        }

        .btnStatus {
            background-color: transparent;
            border-radius: 5px;
            font-weight: bold;
            font-size: 12px;
            padding: 3px 6px;   
        }

        .btnCheked {
            border: 1px solid #18ce0f;
            color: #18ce0f;
        }

            .btnCheked:hover {
                color: #18ce0f;
            }

        .btnPending {
            border: 1px solid #FFB236;
            color: #FFB236; 
        }

            .btnPending:hover {
                color: #FFB236;
            }

        .date-btn {
            margin-left:-45px;
            padding:11.5px 12px;
            background-color:rgb(78, 228, 229);
            border-top-right-radius: 25px;
            border-bottom-right-radius: 25px;
            color:#ffffff !important;
            font-weight:bold;
        }

        @media only screen and (min-width : 1024px) {
            .align-date {
                text-align: right;
            }
        }

        @media only screen and (min-device-width : 480px) and (max-device-width : 1024px) {
            
        }

        @media only screen and (min-device-width : 320px) and (max-device-width : 480px) {
            section.content:before {
                height: 180px;
            }
            .mobile-hide {
                display:none;
            }
            .align-date {
                text-align: center;
            }
        }      
    </style>

  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        window.setTimeout(function () { $(".alert").fadeTo(500, 0).slideUp(500, function () { $(this).remove(); }); }, 4000);
        window.onload = function () {
            document.getElementById("patient").setAttribute("class", "active open");
        };

        $(document).ready(function () {
            //var date = new Date();
            //var today = new Date(date.getFullYear(), date.getMonth(), date.getDate());

            $('#<%=datepicker.ClientID%>').datepicker({
                dateFormat: "dd-mm-yy"
            });

            //$('#<%=datepicker.ClientID%>').datepicker('setDate', today);
        });

        function Kyepress() {
            return false;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <section class="content">
    <div class="block-header">
        <div class="row">
            <div class="col-lg-7 col-md-4 col-sm-12">
                <h2>Checked Patient List
                <small>Welcome to Fertility Clinic</small>
                </h2>
            </div>
            <div class="col-lg-5 col-md-8 col-sm-12 mobile-hide">
                <ul class="breadcrumb float-md-right">
                    <li class="breadcrumb-item"><a href="Dashboard.aspx"><i class="zmdi zmdi-home"></i> Fertility Clinik</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Patient</a></li>
                    <li class="breadcrumb-item active">Check Patient List</li>
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

            <div class="col-lg-12 col-md-12 col-sm-12">
                <div class="card">
                    <div class="header" style="padding-bottom:0">
                        <div class="row">
                            <div  class="col-lg-6 col-md-6 col-sm-12 mobile-hide" style="">
                                <h2><strong>Checked Patient</strong> List</h2>
                            </div>
                            <div  class="col-lg-6 col-md-6 col-sm-12 align-date">
                                <input type="text" class="btn-round btn-simple" id="datepicker" runat="server" style="width:160px" onkeypress="return Kyepress();" onfocus="blur();"><a runat="server" class="btn-simple date-btn" onserverclick="Date_onclick">Go</a>
                            </div>
                        </div>
                    </div>
                    <div class="body" style="padding-top:0">
                        <div class="row clearfix">
                            <div class="card patients-list body">
                                <div class="tab-content m-t-10">
                                    <div class="tab-pane table-responsive active" id="All">
                                        <table class="table table-hover js-basic-example dataTable" style="border-collapse: collapse">
                                            <thead>
                                                <tr>
                                                    <th class="align-center">No.</th>
                                                    <th class="align-center">Token</th>
                                                    <th class="align-center">Name</th>
                                                    <th class="align-center">Age</th>
                                                    <th class="align-center">Address</th>
                                                    <th class="align-center">Mobile</th>
                                                    <th class="align-center">Last Visit</th>
                                                    <th class="align-center">Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater ID="rptrAppointment" runat="server" OnItemCommand="rptrPatient_RowCommand">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td class="align-center"><span class="list-name">
                                                                <asp:Label ID="lblID" runat="server" Text='<%# Container.ItemIndex+1 %>'></asp:Label></span></td>
                                                            <td class="align-center">
                                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("tokenNo") %>'></asp:Label></td>
                                                            <td class="align-center">
                                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("patientName") %>'></asp:Label></td>
                                                            <td class="align-center">
                                                                <asp:Label ID="lblAge" runat="server" Text='<%# Eval("age") %>'></asp:Label></td>
                                                            <td class="align-center">
                                                                <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("address") %>'></asp:Label></td>
                                                            <td class="align-center">
                                                                <asp:Label ID="lblMobile" runat="server" Text='<%# Eval("mobile1") %>'></asp:Label></td>
                                                            <td class="align-center">
                                                                <asp:Label ID="lblLastVisit" runat="server" Text='<%# string.Format("{0:dd/MM/yyyy}", Eval("lastvisit")) == "" ? "First Visit" : string.Format("{0:dd/MM/yyyy}", Eval("lastvisit")) %>'></asp:Label></td>
                                                            <td class="align-center">
                                                                <asp:LinkButton ID="btnCheck" CssClass='<%# "btnStatus " + (Convert.ToBoolean(Eval("isChecked")) ? "btnCheked" : "btnPending") %>' runat="server"  Text='<%# Convert.ToBoolean(Eval("isChecked")) ? "Checked" : "Pending" %>' CommandName="checked" CommandArgument='<%# Eval("patientID").ToString() + ";" + Eval("appointmentID").ToString() %>'/>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>   
</asp:Content>
