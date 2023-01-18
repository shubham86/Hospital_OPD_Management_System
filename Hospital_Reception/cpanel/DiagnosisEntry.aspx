<%@ Page Title="Add Diagnosis" Language="C#" MasterPageFile="../cpanel/MasterCP.Master" AutoEventWireup="true" CodeBehind="DiagnosisEntry.aspx.cs" Inherits="Hospital_Reception.cpanel.DiagnosisEntry" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="assets/bundles/libscripts.bundle.js"></script> 
    <script>
        window.setTimeout(function () { $(".alert").fadeTo(500, 0).slideUp(500, function () { $(this).remove(); }); }, 4000);
        
        function reset() {
            document.getElementById('<%=txtName.ClientID%>').value = "";
        }
    </script>
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
                color: #ffffff;
                background-color:#18ce0f;
            }

        .btnPending {
            border: 1px solid #FFB236;
            color: #FFB236;
        }

            .btnPending:hover {
                color: #ffffff;
                background-color:#FFB236;
            }
            
        .btnEdit {
        border: 1px solid #011176;
        color: #011176;
        }

            .btnEdit:hover {
                color: #011176;
            }

        .btnAbsent {
            border: 1px solid #c10000;
            color: #c10000;
        }

            .btnAbsent:hover {
                color: #ffffff;
                background-color: #c10000;
            }
        .ui-widget-header {
            background-color:#5c5c5c;
            border-color:#5c5c5c;
            background:#5c5c5c;
        }

        @media only screen and (min-width : 1024px) {
            
        }

        @media only screen and (min-device-width : 480px) and (max-device-width : 1024px) {
            
        }

        @media only screen and (min-device-width : 320px) and (max-device-width : 480px) {
            section.content:before {
                height: 120px;
            }
            .mobile-hide {
                display:none;
            }            
        }      
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <section class="content">
    <div class="block-header">
        <div class="row">
            <div class="col-lg-7 col-md-4 col-sm-12">
                <h2>Diagnosis Entry
                <small>Welcome to Fertility Clinic</small>
                </h2>
            </div>
            <div class="col-lg-5 col-md-8 col-sm-12 mobile-hide">
                <ul class="breadcrumb float-md-right">
                    <li class="breadcrumb-item"><a href="Dashboard.aspx"><i class="zmdi zmdi-home"></i>  Fertility Clinic</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Master Entry</a></li>
                    <li class="breadcrumb-item active">Diagnosis Entry</li>
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
                    <div class="header mobile-hide">
                        <h2><strong>Diagnosis</strong> Entry</h2>
                    </div>
                    <div class="body">
                        <div class="row clearfix">
                            <div class="col-sm-2">

                            </div>
                            <div class="col-sm-8 align-center ">
                                <div class="form-group ">
                                    <input  type="text" id="txtName" class="form-control" placeholder="Diagnosis" required="required" style="text-align: center" runat="server" onfocusout="fetchDetails()">
                                    <asp:HiddenField ID="hfAppointmentId" runat="server" />
                                </div>
                            </div>
                            <div class="col-sm-2">

                            </div>
                          
                        </div>
                   
                        <div class="row clearfix">
                            <div class="col-sm-12 align-center">
                                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary btn-round" Text="Submit" OnClick="btnSave_Click" />
                                <a id="btnCancel" class="btn btn-default btn-round btn-simple" onclick="reset()">Cancel</a>
                            </div>                            
                        </div>

                        <div class="row clearfix">
                            <div class="card patients-list body">
                                <div class="tab-content m-t-10">
                                    <div class="tab-pane table-responsive active" id="All">
                                        <table class="table table-hover js-basic-example dataTable" style="border-collapse: collapse">
                                            <thead>                                               
                                                <tr>
                                                    <th class="align-center " >No.</th>
                                                    <th class="align-center">Diagnosis</th>
                                                    <th class="align-center">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater ID="rptrDiagnosis" runat="server" OnItemCommand="rptrDiagnosis_RowCommand">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td class="align-center"><span class="list-name">
                                                                <asp:Label ID="lblID" runat="server" Text='<%# Container.ItemIndex+1 %>'></asp:Label></span></td>                                                         
                                                            <td class="align-center">
                                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("diagnosis") %>'></asp:Label></td>                                                      
                                                          <td class="align-center">
                                                                <asp:LinkButton ID="btnDelete" runat="server" CssClass="btnStatus btnAbsent"  CommandArgument='<%# Eval("diagnosisID") %>' CommandName="delete" Text="Delete" />
                                                                <asp:LinkButton ID="btnEdit" runat="server" CssClass="btnStatus btnEdit" Text="Edit" CommandArgument='<%# Eval("diagnosisID") + ";" + Eval("diagnosis")%>' CommandName="edit" />
                                                            </td>                                                          
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                        </table>                 
                                        <asp:Label ID="lblDiagnosisID" runat="server" Text="0" ForeColor="White" Font-Size="1"></asp:Label>                                        
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
