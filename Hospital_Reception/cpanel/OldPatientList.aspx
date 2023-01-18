<%@ Page Title="Old Patient List" Language="C#" MasterPageFile="../cpanel/MasterCP.Master" AutoEventWireup="true" CodeBehind="OldPatientList.aspx.cs" Inherits="Hospital_Reception.cpanel.OldPatientList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"> 
    <script src="assets/bundles/libscripts.bundle.js"></script>
    <style>
        .bootstrap-select.btn-group:not(.input-group-btn), .bootstrap-select.btn-group[class*="col-"] {
            width: 80px;
        }

        div.dataTables_wrapper div.dataTables_filter input {
            width: 300px;
        }

        @media only screen and (min-width : 1024px) {
            
        }

        @media only screen and (min-device-width : 480px) and (max-device-width : 1024px) {
            
        }

        @media only screen and (min-device-width : 320px) and (max-device-width : 480px) {
            section.content:before {
                height: 100px;
            }
            .mobile-hide {
                display:none;
            }            
        }      
    </style>
    <script>
         window.onload = function () {
            document.getElementById("patient").setAttribute("class", "active open");
        };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content">
    <div class="block-header">
        <div class="row">
            <div class="col-lg-7 col-md-4 col-sm-12">
                <h2>Old Patients List
                <small>Welcome to Fertility Clinic</small>
                </h2>
            </div>
            <div class="col-lg-5 col-md-8 col-sm-12 mobile-hide">
                <ul class="breadcrumb float-md-right">
                    <li class="breadcrumb-item"><a href="Dashboard.aspx"><i class="zmdi zmdi-home"></i> Fertility Clinik</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Patient</a></li>
                    <li class="breadcrumb-item active">Our Patient</li>
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
                    <div class="body" style="padding-top: 0">
                        <div class="header mobile-hide">
                            <h2>Old <strong>Patients</strong></h2>
                        </div>
                        <div class="row clearfix">
                            <div class="card patients-list body">
                                <div class="tab-content m-t-10">
                                    <div class="tab-pane table-responsive active" id="All">
                                        <table class="table table-hover js-basic-example dataTable" style="border-collapse: collapse">
                                            <thead>
                                                <tr>
                                                    <th class="align-center">No.</th>
                                                    <th class="align-center">Name</th>
                                                    <th class="align-center">Age</th>
                                                    <th class="align-center">Address</th>
                                                    <th class="align-center">Mobile</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater ID="rptrPatient" runat="server">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td class="align-center"><span class="list-name">
                                                                <asp:Label ID="lblID" runat="server" Text='<%# Container.ItemIndex+1 %>'></asp:Label></span></td>
                                                            <td class="align-center">
                                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("name") %>'></asp:Label></td>
                                                            <td class="align-center">
                                                                <asp:Label ID="lblAge" runat="server" Text='<%# Eval("age") %>'></asp:Label></td>
                                                            <td class="align-center">
                                                                <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("address") %>'></asp:Label></td>
                                                            <td class="align-center">
                                                                <asp:Label ID="lblMobile" runat="server" Text='<%# Eval("mobile") %>'></asp:Label></td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                        </table>                                        
                                        <div class="align-center">
                                            <a ID="btnPDF" runat="server" class="btn btn-primary btn-round" style="color:white" onserverclick="ExportToPDF">Download PDF</a>
                                        </div>
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
