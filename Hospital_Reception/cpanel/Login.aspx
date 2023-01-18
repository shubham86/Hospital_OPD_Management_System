<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Hospital_Reception.cpanel.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport"/>

    <title>:: Cpanel :: Sign In</title>
    <!-- Favicon-->
    <link rel="icon" href="favicon.ico" type="image/x-icon"/>
    <!-- Custom Css -->
    <link rel="stylesheet" href="../plugins/bootstrap/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="assets/css/main.css"/>
    <link rel="stylesheet" href="assets/css/authentication.css"/>
    <link rel="stylesheet" href="assets/css/color_skins.css"/>
    
    <link rel="shortcut icon" type="../image/favicon.png" href="../image/favicon.png"/>
    <link rel="icon" type="../image/favicon.png" href="../image/favicon.png"/>
    <script>
        window.setTimeout(function () {
            $(".alert").fadeTo(500, 0).slideUp(500, function () {
                $(this).remove();
            });
        }, 4000);
    </script>  
</head>

<body class="theme-cyan authentication sidebar-collapse">    
    <!-- End Navbar -->
    <div class="page-header">
        <div class="page-header-image" style="background-image: url(../images/login.jpg)"></div>
        <div class="container">
            <div class="col-md-12 content-center">
                <div class="card-plain" style="max-width:none">
                    <asp:Panel ID="pnlAlert" runat="server" class="" role="alert" Visible="false">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close" style="padding-top:10px"><span aria-hidden="true">&times;</span></button>
                        <asp:Label ID="lblalert" runat="server" Text="" Font-Bold="true"></asp:Label>
                    </asp:Panel>
                </div>
                <div class="card-plain">
                    <form class="form" runat="server">
                        <div class="header">
                            <div class="logo-container">
                                <img src="https://thememakker.com/templates/oreo/hospital/html/images/logo.svg" alt="" />
                            </div>
                            <h5>Log in</h5>
                        </div>
                        <div class="content">
                            <div class="input-group input-lg">
                                <input id="txtUsername" type="text" class="form-control" placeholder="Enter User Name" required="required" runat="server" />
                                <span class="input-group-addon">
                                    <i class="zmdi zmdi-account-circle" style="padding-top: 10px"></i>
                                </span>
                            </div>
                            <div class="input-group input-lg">
                                <input id="txtPassword" type="password" placeholder="Password" class="form-control" required="required" runat="server" />
                                <span class="input-group-addon">
                                    <i class="zmdi zmdi-lock" style="padding-top: 10px"></i>
                                </span>
                            </div>
                        </div>
                        <div class="footer text-center">
                            <asp:Button ID="Button1" runat="server" class="btn btn-primary btn-round btn-lg btn-block" Text="SIGN IN" OnClick="btnLogin_Click" />
                            <h5><a href="forgot-password.html" class="link">Forgot Password?</a></h5>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <footer class="footer">
            <div class="container">
                <div class="copyright">
                    &copy;
                <script>
                    2019
                </script>
                    ,
                <span>Designed & Developed by <a href="http://jericotechnologies.in/" target="_blank" style="color:#38d5ff;font-weight:bold">Jerico Technologies</a></span>
                </div>
            </div>
        </footer>
    </div>

    <!-- Jquery Core Js -->
    <script src="assets/bundles/libscripts.bundle.js"></script>
    <script src="assets/bundles/vendorscripts.bundle.js"></script>
    <!-- Lib Scripts Plugin Js -->

    <script>
        $(".navbar-toggler").on('click', function () {
            $("html").toggleClass("nav-open");
        });
        //=============================================================================
        $('.form-control').on("focus", function () {
            $(this).parent('.input-group').addClass("input-group-focus");
        }).on("blur", function () {
            $(this).parent(".input-group").removeClass("input-group-focus");
        });
    </script>
</body>
</html>
