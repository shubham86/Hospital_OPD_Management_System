    
<%@ Page Title="" Language="C#" MasterPageFile="../cpanel/MasterCP.Master" AutoEventWireup="true" CodeBehind="BookAppointment.aspx.cs" Inherits="Hospital_Reception.cpanel.BookAppointment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">          
    <link href="https://ajax.aspnetcdn.com/ajax/jquery.ui/1.9.2/themes/blitzer/jquery-ui.css" rel="Stylesheet" type="text/css" />
    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.10.0.min.js" type="text/javascript"></script>
    <script src="https://ajax.aspnetcdn.com/ajax/jquery.ui/1.9.2/jquery-ui.min.js" type="text/javascript"></script>

<%--    <script src="assets/bundles/libscripts.bundle.js"></script>
   <link href="https://ajax.aspnetcdn.com/ajax/jquery.ui/1.9.2/themes/blitzer/jquery-ui.css" rel="Stylesheet" type="text/css" />--%>
    <script>
        window.setTimeout(function () { $(".alert").fadeTo(500, 0).slideUp(500, function () { $(this).remove(); }); }, 4000);

        function isNumberKey(evt, obj) {

            var charCode = (evt.which) ? evt.which : event.keyCode
            var value = obj.value;
            var dotcontains = value.indexOf(".") != -1;
            if (dotcontains)
                if (charCode == 46) return false;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) return false;
            return true;
        }

        function reset() {
            document.getElementById('<%=txtAddress.ClientID%>').value = "";
            document.getElementById('<%=txtDOB.ClientID%>').value = "";
            document.getElementById('<%=txtDate.ClientID%>').value = "";
            document.getElementById('<%=txtName.ClientID%>').value = "";
            document.getElementById('<%=txtMobile1.ClientID%>').value = "";
            document.getElementById('<%=txtMobile2.ClientID%>').value = "";

            var date = new Date();
            var today = new Date(date.getFullYear(), date.getMonth(), date.getDate());            
            $('#<%=txtDate.ClientID%>').datepicker('setDate', today);
        }

        window.onload = function () {
            document.getElementById("appo").setAttribute("class", "active open");
            
            document.getElementById("<%=txtName.ClientID%>").tabIndex = "1";
            document.getElementById("<%=txtDOB.ClientID%>").tabIndex = "2";
            document.getElementById("<%=txtMobile1.ClientID%>").tabIndex = "3";
            document.getElementById("<%=txtMobile2.ClientID%>").tabIndex = "4";
            document.getElementById("<%=txtAddress.ClientID%>").tabIndex = "5";
            document.getElementById("<%=btnSave.ClientID%>").tabIndex = "6";
            document.getElementById("btnCancel").tabIndex = "7";
        };

        $(function () {
            $("[id$=txtName]").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: '<%=ResolveUrl("BookAppointment.aspx/GetPatient") %>',
                        data: "{ 'prefix': '" + request.term + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.split('-')[0]
                                }
                            }))
                        },
                        error: function (response) {
                            alert(response.responseText);
                        },
                        failure: function (response) {
                            alert(response.responseText);
                        }
                    });
                },
                minLength: 1,
            });
        });

        $(function () {
            $("[id$=txtMobile1]").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: '<%=ResolveUrl("BookAppointment.aspx/GetPatientByMobile") %>',
                        data: "{ 'prefix': '" + request.term + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.split('-')[0]
                                }
                            }))
                        },
                        error: function (response) {
                            alert(response.responseText);
                        },
                        failure: function (response) {
                            alert(response.responseText);
                        }
                    });
                },
                minLength: 1,
            });
        });

        function fetchDetails() {
            PageMethods.GetDetails(document.getElementById("<%=txtName.ClientID%>").value, OnSuccess);
        }

        function fetchDetailsByMobile() {
            PageMethods.GetDetailsByMobile(document.getElementById("<%=txtMobile1.ClientID%>").value, OnSuccess);
        }

        function OnSuccess(response) {
            if (response != "") {
                var arry = new Array();
                arry = response.split(",");
                document.getElementById("<%=txtDOB.ClientID%>").value = arry[0];
                document.getElementById("<%=txtMobile1.ClientID%>").value = arry[1];
                document.getElementById("<%=txtMobile2.ClientID%>").value = arry[2];
                document.getElementById("<%=txtAddress.ClientID%>").value = arry[3];
                document.getElementById("<%=lblPatientID.ClientID%>").value = arry[4];
                document.getElementById("<%=txtName.ClientID%>").value = arry[5];
                
                $(function () {
                        var radio = $("[id*=rdblGender] input[value=" + arry[6] + "]");
                        radio.attr("checked", "checked");
                        return false;                    
                }); 
            }
            else {
                document.getElementById("<%=lblPatientID.ClientID%>").value = "0";
            }
        }

        $(document).ready(function () {
            var date = new Date();
            var today = new Date(date.getFullYear(), date.getMonth(), date.getDate());

            $('#<%=txtDate.ClientID%>').datepicker({
                dateFormat: "dd-MM-yy",

                //beforeShowDay: function(date) {
                //var day = date.getDay();
                //    return [(day!=0 && day != 3 && day != 4 && day != 5 && day != 6)];
                //}
                minDate: 0,
                maxDate: 6
            });
            
            $('#<%=txtDate.ClientID%>').datepicker('setDate', today);
        });

        function Kyepress() {
            return false;
        }
        
        $(document).ready(function () {
            document.getElementsByName("DataTables_Table_0_length").value = "50";
        });

        function absentClick(token)
        {
            alert(token);

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
                <h2>Book Appointment
                <small>Welcome to Fertility Clinic</small>
                </h2>
            </div>
            <div class="col-lg-5 col-md-8 col-sm-12 mobile-hide">
                <ul class="breadcrumb float-md-right">
                    <li class="breadcrumb-item"><a href="Dashboard.aspx"><i class="zmdi zmdi-home"></i>  Fertility Clinic</a></li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);">Appointment</a></li>
                    <li class="breadcrumb-item active">Book Appointment</li>
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
                        <div class="row">
                            <div class="col-lg-11">
                                <h2><strong>Book</strong> Appointment 
                            <asp:TextBox ID="lblPatientID" runat="server" Text="0" Width="1px" BorderStyle="None" ForeColor="White"></asp:TextBox></h2>
                            </div>
                            <div class="col-lg-1">
                                <a runat="server" onserverclick="btnRefreshDB_Click" style="color:#00cfd1" title="Refresh Database"><i class="zmdi zmdi-refresh float-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <div class="body">
                        <div class="row clearfix">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <input type="text" id="txtName" class="form-control" placeholder="Full Name" required="required" runat="server" onfocusout="fetchDetails()">
                                    <asp:HiddenField ID="hfAppointmentId" runat="server" />
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">                                    
                                    <input type="text" class="form-control" id="txtDate" runat="server" onkeypress="return Kyepress();" onfocus="blur();" />
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">                                    
                                    <input type="text" class="form-control" id="txtDOB" runat="server" required="required" placeholder="Age" maxlength="2" onkeypress='javascript:return isNumberKey(event,this);'/>
                                </div>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-sm-2">
                                <div class="form-group radio m-2">
                                    <asp:RadioButtonList ID="rdblGender" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Text="Female" Value="Female" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="male" Value="Male"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <input type="text" id="txtMobile1" class="form-control" placeholder="Mobile number 1" required="required" runat="server" onkeypress='javascript:return isNumberKey(event,this);' maxlength="10"  onfocusout="fetchDetailsByMobile()">
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <input type="text" id="txtMobile2" class="form-control" placeholder="Mobile number 2" runat="server"  onkeypress='javascript:return isNumberKey(event,this);' maxlength="10">
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <input type="text" id="txtAddress" class="form-control" placeholder="Address" required="required" runat="server">
                                </div>
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
                                                    <th class="align-center"></th>
                                                    <th class="align-center">No.</th>
                                                    <th class="align-center">Time</th>
                                                    <th class="align-center">Name</th>
                                                    <th class="align-center">Age</th>
                                                    <th class="align-center">Address</th>
                                                    <th class="align-center">Mobile</th>
                                                    <th class="align-center">Last Visit</th>
                                                    <th class="align-center">Status</th>
                                                    <th class="align-center">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater ID="rptrAppointment" runat="server" OnItemCommand="rptrAppointment_RowCommand">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td class="align-center"><span class="list-name">
                                                                <asp:Label ID="lblID" runat="server" Text='<%# Container.ItemIndex+1 %>'></asp:Label></span></td>
                                                            <td class="align-center">
                                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("tokenNo") %>'></asp:Label></td>
                                                            <td class="align-center">
                                                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("allotedTime") %>'></asp:Label></td>
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
                                                                <asp:LinkButton ID="btnStatus" runat="server" CssClass='<%# "btnStatus " + (Convert.ToBoolean(Eval("isChecked")) ? "btnCheked" : "btnPending") %>' Text='<%# Convert.ToBoolean(Eval("isChecked")) ? "Checked" : "Pending" %>' CommandArgument='<%# Eval("appointmentID") %>' CommandName="status" OnClientClick="return confirm('Are you sure patient want to go without checkup?')"/>
                                                            </td>
                                                            <td class="align-center">
                                                                <asp:LinkButton ID="LinkButton1" CssClass="btnStatus btnAbsent" runat="server" Text="Absent" CommandName="absent" CommandArgument='<%# Eval("appointmentID") + ";" + Eval("sequence") + ";" + Eval("tokenNo") %>' OnClientClick="return confirm('Are you sure patient is absent?')" />
                                                            </td>
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
    
    <%--<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>--%>
</asp:Content>
