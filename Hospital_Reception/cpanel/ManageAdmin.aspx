<%@ Page Title="" Language="C#" MasterPageFile="../cpanel/MasterCP.Master" AutoEventWireup="true" CodeBehind="ManageAdmin.aspx.cs" Inherits="Hospital_Reception.cpanel.ManageAdmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">              
        <script src="assets/bundles/libscripts.bundle.js"></script>
    <script>
        window.setTimeout(function () { $(".alert").fadeTo(500, 0).slideUp(500, function () { $(this).remove(); }); }, 4000);

        function isDecimalNumber(evt, c) {
            var charCode = (evt.which) ? evt.which : event.keyCode;
            var dot1 = c.value.indexOf('.');
            var dot2 = c.value.lastIndexOf('.');

            if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            else if (charCode == 46 && (dot1 == dot2) && dot1 != -1 && dot2 != -1)
                return false;

            return true;
        }

        function reset() {
            document.getElementById('<%=txtPassword.ClientID%>').value = "";
            document.getElementById('<%=txtUserName.ClientID%>').value = "";
            document.getElementById('<%=txtName.ClientID%>').value = "";
            document.getElementById('<%=txtMobile.ClientID%>').value = "";
        }
                
        window.onload = function () {            
            document.getElementById("admin").setAttribute("class", "active open");
        };

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
                color: #18ce0f;
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
                color: #c10000;
            }


        @media only screen and (min-width : 1024px) {
            
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
        }      
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">  
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <section class="content">
    <div class="block-header">
        <div class="row">
            <div class="col-lg-7 col-md-4 col-sm-12">
                <h2>Manage Admin
                    <small>Welcome to Fertility Clinic</small>
                </h2>
            </div>
            <div class="col-lg-5 col-md-8 col-sm-12">
                <ul class="breadcrumb float-md-right">
                    <li class="breadcrumb-item"><a href="Dashboard.aspx"><i class="zmdi zmdi-home"></i>  Fertility Clinic</a></li>                    
                    <li class="breadcrumb-item active">Mange Admin</li>
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
                        <h2><strong>Manage</strong> Admin</h2>
                    </div>
                    <div class="body">
                        <div class="row clearfix">
                            <div class="col-sm-8">
                                <div class="form-group">
                                    <input type="text" id="txtName" class="form-control" placeholder="Full Name" required="required" runat="server">
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <input type="text" id="txtMobile" class="form-control" placeholder="Phone" runat="server" onkeypress='javascript:return isDecimalNumber(event,this);' maxlength="10">
                                </div>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <input type="text" id="txtUserName" class="form-control" placeholder="UserName" required="required" runat="server">
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <input type="text" id="txtPassword" class="form-control" placeholder="Password" required="required" runat="server">
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <asp:DropDownList ID="ddlRole" runat="server">
                                        <asp:ListItem Text="Receptionist" Value="reception"></asp:ListItem>
                                        <asp:ListItem Text="Admin" Value="admin"></asp:ListItem>                                        
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-sm-12 align-center">
                                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary btn-round" Text="Submit" OnClick="btnSave_Click" OnClientClick="return validation()"/>
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
                                                    <th class="align-center">No.</th>
                                                    <th class="align-center">Name</th>
                                                    <th class="align-center">Mobile</th>
                                                    <th class="align-center">UserName</th>
                                                    <th class="align-center">Pasword</th>
                                                    <th class="align-center">Role</th>
                                                    <th class="align-center">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater ID="rptrAdmin" runat="server" OnItemCommand="rptrAdmin_RowCommand">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td class="align-center"><span class="list-name">
                                                                <asp:Label ID="lblID" runat="server" Text='<%# Container.ItemIndex+1 %>'></asp:Label></span></td>
                                                            <td class="align-center">
                                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("adminName") %>'></asp:Label></td>
                                                            <td class="align-center">
                                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("Mobile").ToString() == "" ? "-" : Eval("Mobile")%>'></asp:Label></td>
                                                            <td class="align-center">
                                                                <asp:Label ID="lblAge" runat="server" Text='<%# Eval("Username") %>'></asp:Label></td>
                                                            <td class="align-center">
                                                                <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("Password") %>'></asp:Label></td>
                                                            <td class="align-center">
                                                                <asp:Label ID="lblMobile" runat="server" Text='<%# Eval("role") %>'></asp:Label></td>                                                            
                                                            <td class="align-center">
                                                                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btnStatus btnAbsent" Text="Delete" CommandArgument='<%# Eval("adminID") %>' CommandName="delete" />
                                                            
                                                                <asp:LinkButton ID="btnEdit" runat="server" CssClass="btnStatus btnEdit" Text="Edit" CommandArgument='<%# Eval("adminID") %>' CommandName="edit" />                                                                
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                        </table>
                                        <asp:Label ID="lblAdminID" runat="server" Text="0" ForeColor="White" Font-Size="1"></asp:Label>
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
