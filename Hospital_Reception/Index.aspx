﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Hospital_Reception.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="We are a prominent Doctor serving in rural as well as urban areas with an urge to spread smile across the patients, who have been struggling with fertility issues." />
    <meta name="keywords" content="Dr. Suresh Kamble,Docto Suresh Kamble,Suresh Kamble,Fertility Center,Dr. Suresh Kamble's Fertility Center, Fertility Clinic, Fertility center in Nashik,Infertility Problem, Low Sperm Count, Gynaecologist in Yeola,Gynaecologist in Nashik,yeola" />
    <meta name="author" content="Jerico Technologies" />
    <link rel="icon" href="#" />

    <title>Dr.Kambles Fertility Center</title>
    <link rel="shortcut icon" type="image/favicon.png" href="image/favicon.png" />
    <link rel="icon" type="image/favicon.png" href="image/favicon.png" />

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.css" rel="stylesheet" />
    <link href="vendor/bootstrap-datepicker/css/datepicker.min.css" rel="stylesheet" />

    <script src="js/ie-emulation-modes-warning.js"></script>

    <!-- Custom Fonts -->
    <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

    <link href="vendor/themify-icons/themify-icons.css" rel="stylesheet" type="text/css" />

    <!-- REVOLUTION STYLE SHEETS -->
    <link rel="stylesheet" type="text/css" href="vendor/revolution-slider/revolution/css/settings.css" />

    <!-- REVOLUTION LAYERS STYLES -->
    <link rel="stylesheet" type="text/css" href="vendor/revolution-slider/revolution/css/layers.css" />

    <!-- REVOLUTION NAVIGATION STYLES -->
    <link rel="stylesheet" type="text/css" href="vendor/revolution-slider/revolution/css/navigation.css" />

    <!-- PARTICLES ADD-ON FILES -->
    <link rel="stylesheet" type="text/css" href="vendor/revolution-slider/revolution-addons/particles/css/revolution.addon.particles4bf4.css?ver=1.0.3" />

    <!-- template CSS -->
    <link href="css/style.css" rel="stylesheet" />
    <link href="css/secondary_css.css" rel="stylesheet" />

    <!-- Custom CSS -->
    <link href="css/custom.css" rel="stylesheet" />

    <!-- Animation -->
    <link rel="stylesheet" href="css/animate.css" />
    <script src="js/wow.js"></script>
    <script src="cpanel/assets/js/jquery-1.10.0.min.js"></script>
    <!-- custom JavaScript -->
    <script src="js/custom.js"></script>

    <style>
        
    </style>
    <script>
        function validate() {
            if (document.getElementById('<%=txtMobile.ClientID%>').value == "") {
                document.getElementById("alrtMobile").style.display = "block";
                document.getElementById('<%=txtMobile.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtMobile.ClientID%>').value.length < 10) {
                document.getElementById("alrtMobile1").style.display = "block";
                document.getElementById('<%=txtMobile.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=ddlDate.ClientID%>').value == "") {
                document.getElementById("alrtDate").style.display = "block";
                document.getElementById('<%=ddlDate.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=ddlDate.ClientID%>').value == "0") {
                document.getElementById('<%=pnlAlert.ClientID%>').style.display = "block";
                document.getElementById('<%=lblalert.ClientID%>').innerHTML = "<span style='color:#e2a600;'>OPD close on Sunday!</span>"
                return false;
            }

            document.getElementById('<%=Mobile.ClientID%>').innerHTML = document.getElementById('<%=txtMobile.ClientID%>').value;
            document.getElementById('<%=txtMobile1.ClientID%>').value = document.getElementById('<%=txtMobile.ClientID%>').value;
            document.getElementById('<%=Date.ClientID%>').innerHTML = document.getElementById('<%=ddlDate.ClientID%>').options[document.getElementById('<%=ddlDate.ClientID%>').selectedIndex].innerHTML;
        }

        function btnLoginRegisterClick() {
            document.getElementById('<%=txtMobile1.ClientID%>').value = document.getElementById('<%=txtMobile.ClientID%>').value;
        }

        function registerValidation() {                      

            if (document.getElementById('<%=txtFirstName.ClientID%>').value == "") {
                document.getElementById('<%=lblRegisterAlert.ClientID%>').innerHTML = "Please Enter First Name";
                document.getElementById('<%=txtFirstName.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtLastName.ClientID%>').value == "") {
                document.getElementById('<%=lblRegisterAlert.ClientID%>').innerHTML = "Please Enter Last Name";
                document.getElementById('<%=txtLastName.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtDOB.ClientID%>').value == "") {
                document.getElementById('<%=lblRegisterAlert.ClientID%>').innerHTML = "Please Enter Age";
                document.getElementById('<%=txtDOB.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtAddress.ClientID%>').value == "") {                
                document.getElementById('<%=lblRegisterAlert.ClientID%>').innerHTML = "Please Enter Name of Town";
                document.getElementById('<%=txtAddress.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtMobile1.ClientID%>').value == "") {
                document.getElementById('<%=lblRegisterAlert.ClientID%>').innerHTML = "Please Enter Mobile number";
                document.getElementById('<%=txtMobile1.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtMobile1.ClientID%>').value.length < 10) {
                document.getElementById('<%=lblRegisterAlert.ClientID%>').innerHTML = "Please Enter Valid Mobile number 1";
                document.getElementById('<%=txtMobile1.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtMobile2.ClientID%>').value.length < 10 && document.getElementById('<%=txtMobile2.ClientID%>').value.length > 0) {
                document.getElementById('<%=lblRegisterAlert.ClientID%>').innerHTML = "Please Enter Valid Mobile number 2";
                document.getElementById('<%=txtMobile2.ClientID%>').focus();
                return false;
            }
        }

        function clearRegisterForm() {
            document.getElementById('<%=Mobile.ClientID%>').innerHTML = document.getElementById('<%=txtMobile.ClientID%>').value;
            document.getElementById('<%=Date.ClientID%>').innerHTML = document.getElementById('<%=ddlDate.ClientID%>').options[document.getElementById('<%=ddlDate.ClientID%>').selectedIndex].innerHTML;

            document.getElementById('<%=lblRegisterAlert.ClientID%>').innerHTML = " ";
            document.getElementById('<%=txtFirstName.ClientID%>').value = "";
            document.getElementById('<%=txtLastName.ClientID%>').value = "";
            document.getElementById('<%=txtMiddleName.ClientID%>').value = "";
            document.getElementById('<%=txtMobile1.ClientID%>').value = "";
            document.getElementById('<%=txtMobile2.ClientID%>').value = "";
            document.getElementById('<%=txtAddress.ClientID%>').value = "";
            document.getElementById('<%=txtDOB.ClientID%>').value = "";
        }

        function hideRegisterError() {
            document.getElementById('<%=lblRegisterAlert.ClientID%>').innerHTML = " ";
        }

        function hideMobilelbl() {
            document.getElementById("alrtMobile").style.display = "none";
            document.getElementById("alrtMobile1").style.display = "none";
        }

        function onClick(element) {
            document.getElementById("img01").src = element.src;
            document.getElementById("modal01").style.display = "block";
        }

        function isNumberKey(evt, obj) {

            var charCode = (evt.which) ? evt.which : event.keyCode
            var value = obj.value;
            var dotcontains = value.indexOf(".") != -1;
            if (dotcontains)
                if (charCode == 46) return false;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) return false;

            document.getElementById("lblArea").style.display = "none";
            document.getElementById("lblContactNo").style.display = "none";
            document.getElementById("lblContactNo1").style.display = "none";
            return true;
        }
    </script>
</head>

<body id="home">
    <div class="se-pre-con">
        <table align="center" height="100%">
            <tr>
                <td>
                    <img src="image/Preloader_6.png" class="rotate" /></td>
            </tr>
        </table>

    </div>

    <div class="clearfix"></div>

    <!-- Start Nav bar -->
    <nav class="navbar navbar-default navbar-fixed navbar-transparent dark navbar-scrollspy divinnav dart-mb-0" data-minus-value-desktop="70" data-minus-value-mobile="55" data-speed="1000">

        <div class="container">
            <!-- Start Header Navigation -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-menu">
                    <i class="fa fa-bars"></i>
                </button>
                <a class="navbar-brand" href="Index.aspx">
                    <div class="logo logo-display">
                        <span style="color: white; font-size: 14px; float: right; font-weight: 500">Dr. Suresh Kamble's</span>
                        <p style="color: white; font-weight: bold; margin: 0; line-height: 1; letter-spacing: 2px">FERTILITY CENTER</p>
                    </div>
                </a>
                <a class="navbar-brand" href="Index.aspx">
                    <div class="logo logo-scrolled">
                        <span style="color: #131313; font-size: 14px; float: right; font-weight: 500">Dr. Suresh Kamble's</span>
                        <p style="color: #f05697; font-weight: bold; margin: 0; line-height: 1; letter-spacing: 1px">FERTILITY CENTER</p>
                    </div>
                </a>
            </div>
            <!-- End Header Navigation -->

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="navbar-menu">

                <ul class="nav navbar-nav navbar-right">
                    <li class="scroll active"><a href="#home">Home</a></li>
                    <li class="scroll"><a href="#appointment">Appointment</a></li>
                    <li class="scroll"><a href="#about">About Us</a></li>
                    <li class="scroll"><a href="#work">Services</a></li>
                    <li class="scroll"><a href="#blog">Certificates</a></li>
                    <li class="scroll"><a href="#contact">Contact Us</a></li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
    </nav>
    <!-- End Nav bar -->

    <!-- Start Slider -->

    <section class="dart-no-padding-tb" id="slider">
        <article class="content">
            <div id="rev_slider_348_1_wrapper" class="rev_slider_wrapper fullscreen-container" data-alias="overexposure" data-source="gallery" style="background: transparent; padding: 0px;">
                <!-- START REVOLUTION SLIDER 5.4.3.3 fullscreen mode -->
                <div id="rev_slider_348_1" class="rev_slider fullscreenbanner" style="display: none;" data-version="5.4.3.3">
                    <div class="scroll"><a href="#appointment" class="btn btn-booked">Book An Appointment</a></div>
                    <ul>
                        <!-- SLIDE  -->
                        <li data-index="rs-968" data-transition="brightnesscross" data-slotamount="default" data-hideafterloop="0" data-hideslideonmobile="off" data-easein="default" data-easeout="default" data-masterspeed="default" data-rotate="0" data-saveperformance="off" data-title="Slide" data-param1="" data-param2="" data-param3="" data-param4="" data-param5="" data-param6="" data-param7="" data-param8="" data-param9="" data-param10="" data-description="">
                            <!-- MAIN IMAGE -->
                            <img src="image/slider-1.jpg" alt="" data-lazyload="image/slider-1.jpg" data-bgposition="center center" data-bgfit="cover" data-bgrepeat="no-repeat" data-bgparallax="6" class="rev-slidebg" data-no-retina />
                            <!-- LAYERS -->
                            <div id="rrzm_968" class="rev_row_zone rev_row_zone_middle" style="z-index: 11;">
                                <!-- LAYER NR. 1 -->
                                <div class="tp-caption   rs-parallaxlevel-4"
                                    id="slide-968-layer-7"
                                    data-x="['left','left','left','left']" data-hoffset="['100','100','100','100']"
                                    data-y="['middle','middle','middle','middle']" data-voffset="['0','0','0','0']"
                                    data-width="none"
                                    data-height="none"
                                    data-whitespace="nowrap"
                                    data-type="row"
                                    data-columnbreak="2"
                                    data-responsive_offset="on"
                                    data-responsive="off"
                                    data-frames='[{"delay":10,"speed":300,"frame":"0","from":"opacity:0;","to":"o:1;","ease":"Power3.easeInOut"},{"delay":"wait","speed":300,"frame":"999","to":"opacity:0;","ease":"Power3.easeInOut"}]'
                                    data-margintop="[0,0,0,0]"
                                    data-marginright="[0,0,0,0]"
                                    data-marginbottom="[0,0,0,0]"
                                    data-marginleft="[0,0,0,0]"
                                    data-textalign="['inherit','inherit','inherit','inherit']"
                                    data-paddingtop="[0,0,0,0]"
                                    data-paddingright="[50,50,30,30]"
                                    data-paddingbottom="[0,0,0,0]"
                                    data-paddingleft="[50,50,30,30]"
                                    style="z-index: 5; white-space: nowrap; font-size: 20px; line-height: 22px; font-weight: 400; color: #ffffff; letter-spacing: 0px;">
                                    <!-- LAYER NR. 2 -->
                                    <div class="tp-caption  "
                                        id="slide-968-layer-8"
                                        data-x="['left','left','left','left']" data-hoffset="['100','100','100','100']"
                                        data-y="['top','top','top','top']" data-voffset="['100','100','100','100']"
                                        data-width="none"
                                        data-height="none"
                                        data-whitespace="nowrap"
                                        data-type="column"
                                        data-responsive_offset="on"
                                        data-responsive="off"
                                        data-frames='[{"delay":"+0","speed":300,"frame":"0","from":"opacity:0;","to":"o:1;","ease":"Power3.easeInOut"},{"delay":"wait","speed":300,"frame":"999","to":"opacity:0;","ease":"Power3.easeInOut"}]'
                                        data-columnwidth="50%"
                                        data-verticalalign="top"
                                        data-margintop="[0,0,0,0]"
                                        data-marginright="[0,0,0,0]"
                                        data-marginbottom="[0,0,0,0]"
                                        data-marginleft="[0,0,0,0]"
                                        data-textalign="['inherit','inherit','inherit','inherit']"
                                        data-paddingtop="[0,0,0,0]"
                                        data-paddingright="[20,20,0,0]"
                                        data-paddingbottom="[0,0,0,0]"
                                        data-paddingleft="[0,0,0,0]"
                                        style="z-index: 6; width: 100%;">

                                        <!-- LAYER NR. 4 -->
                                        <div class="tp-caption   tp-resizeme"
                                            id="slide-968-layer-1"
                                            data-x="['left','left','left','left']" data-hoffset="['0','50','50','40']"
                                            data-y="['top','top','top','top']" data-voffset="['0','170','170','167']"
                                            data-fontsize="['60','50','40','40']"
                                            data-lineheight="['90','75','60','60']"
                                            data-letterspacing="['15','15','10','7']"
                                            data-width="['100%','100%','561','401']"
                                            data-height="none"
                                            data-whitespace="normal"
                                            data-type="text"
                                            data-responsive_offset="on"
                                            data-frames='[{"delay":"+290","split":"chars","splitdelay":0.05000000000000000277555756156289135105907917022705078125,"speed":2000,"split_direction":"forward","frame":"0","from":"opacity:0;","color":"#000000","to":"o:1;","ease":"Power4.easeInOut"},{"delay":"wait","speed":1000,"frame":"999","color":"transparent","to":"opacity:0;","ease":"Power3.easeInOut"}]'
                                            data-margintop="[0,0,0,0]"
                                            data-marginright="[0,0,0,0]"
                                            data-marginbottom="[30,31,26,26]"
                                            data-marginleft="[0,0,0,0]"
                                            data-textalign="['inherit','inherit','inherit','inherit']"
                                            data-paddingtop="[0,0,0,0]"
                                            data-paddingright="[0,0,0,0]"
                                            data-paddingbottom="[0,0,0,0]"
                                            data-paddingleft="[0,0,0,0]"
                                            style="z-index: 8; min-width: 100%; max-width: 100%; white-space: normal; font-size: 60px; line-height: 90px; font-weight: 400; color: #ffffff; letter-spacing: 15px; display: block; font-family: Oswald; text-transform: uppercase;">
                                            WE OWE OUR GRATITUDE TO OTHER PEOPLE.
                                        </div>

                                        <!-- LAYER NR. 5 -->
                                        <div class="tp-caption tp-shape tp-shapewrapper  tp-resizeme"
                                            id="slide-968-layer-3"
                                            data-x="['left','left','left','left']" data-hoffset="['0','53','53','42']"
                                            data-y="['top','top','top','top']" data-voffset="['0','440','498','373']"
                                            data-width="50"
                                            data-height="1"
                                            data-whitespace="['normal','nowrap','nowrap','nowrap']"
                                            data-type="shape"
                                            data-responsive_offset="on"
                                            data-frames='[{"delay":"+1490","speed":2000,"frame":"0","from":"sX:0;opacity:0;","to":"o:1;","ease":"Power4.easeInOut"},{"delay":"wait","speed":1000,"frame":"999","to":"opacity:0;","ease":"Power3.easeInOut"}]'
                                            data-margintop="[0,0,0,0]"
                                            data-marginright="[0,0,0,0]"
                                            data-marginbottom="[0,0,0,0]"
                                            data-marginleft="[0,0,0,0]"
                                            data-textalign="['inherit','inherit','inherit','inherit']"
                                            data-paddingtop="[0,0,0,0]"
                                            data-paddingright="[0,0,0,0]"
                                            data-paddingbottom="[0,0,0,0]"
                                            data-paddingleft="[0,0,0,0]"
                                            style="z-index: 9; display: block; background-color: rgb(255,255,255);">
                                        </div>
                                    </div>

                                    <!-- LAYER NR. 6 -->
                                    <div class="tp-caption  "
                                        id="slide-968-layer-9"
                                        data-x="['left','left','left','left']" data-hoffset="['100','100','100','100']"
                                        data-y="['top','top','top','top']" data-voffset="['100','100','100','100']"
                                        data-width="none"
                                        data-height="none"
                                        data-whitespace="nowrap"
                                        data-type="column"
                                        data-responsive_offset="on"
                                        data-responsive="off"
                                        data-frames='[{"delay":"+0","speed":300,"frame":"0","from":"opacity:0;","to":"o:1;","ease":"Power3.easeInOut"},{"delay":"wait","speed":300,"frame":"999","to":"opacity:0;","ease":"Power3.easeInOut"}]'
                                        data-columnwidth="50%"
                                        data-verticalalign="top"
                                        data-margintop="[0,0,0,0]"
                                        data-marginright="[0,0,0,0]"
                                        data-marginbottom="[0,0,0,0]"
                                        data-marginleft="[0,0,0,0]"
                                        data-textalign="['inherit','inherit','inherit','inherit']"
                                        data-paddingtop="[0,0,0,0]"
                                        data-paddingright="[0,0,0,0]"
                                        data-paddingbottom="[0,0,0,0]"
                                        data-paddingleft="[0,0,0,0]"
                                        style="z-index: 10; width: 100%;">
                                    </div>
                                </div>

                                <!-- LAYER NR. 7 -->
                                <div class="tp-caption   rs-parallaxlevel-5"
                                    id="slide-968-layer-10"
                                    data-x="['left','left','left','left']" data-hoffset="['100','100','100','100']"
                                    data-y="['middle','middle','middle','middle']" data-voffset="['0','0','0','0']"
                                    data-width="none"
                                    data-height="none"
                                    data-whitespace="nowrap"
                                    data-type="row"
                                    data-columnbreak="2"
                                    data-responsive_offset="on"
                                    data-responsive="off"
                                    data-frames='[{"delay":10,"speed":300,"frame":"0","from":"opacity:0;","to":"o:1;","ease":"Power3.easeInOut"},{"delay":"wait","speed":300,"frame":"999","to":"opacity:0;","ease":"Power3.easeInOut"}]'
                                    data-margintop="[0,0,0,0]"
                                    data-marginright="[0,0,0,0]"
                                    data-marginbottom="[0,0,0,0]"
                                    data-marginleft="[0,0,0,0]"
                                    data-textalign="['inherit','inherit','inherit','inherit']"
                                    data-paddingtop="[0,0,0,0]"
                                    data-paddingright="[50,50,30,30]"
                                    data-paddingbottom="[0,0,0,0]"
                                    data-paddingleft="[50,50,30,30]"
                                    style="z-index: 11; white-space: nowrap; font-size: 20px; line-height: 22px; font-weight: 400; color: #ffffff; letter-spacing: 0px;">
                                    <!-- LAYER NR. 8 -->
                                    <div class="tp-caption  "
                                        id="slide-968-layer-11"
                                        data-x="['left','left','left','left']" data-hoffset="['100','100','100','100']"
                                        data-y="['top','top','top','top']" data-voffset="['100','100','100','100']"
                                        data-width="none"
                                        data-height="none"
                                        data-whitespace="nowrap"
                                        data-type="column"
                                        data-responsive_offset="on"
                                        data-responsive="off"
                                        data-frames='[{"delay":"+0","speed":300,"frame":"0","from":"opacity:0;","to":"o:1;","ease":"Power3.easeInOut"},{"delay":"wait","speed":300,"frame":"999","to":"opacity:0;","ease":"Power3.easeInOut"}]'
                                        data-columnwidth="50%"
                                        data-verticalalign="top"
                                        data-margintop="[0,0,0,0]"
                                        data-marginright="[0,0,0,0]"
                                        data-marginbottom="[0,0,0,0]"
                                        data-marginleft="[0,0,0,0]"
                                        data-textalign="['inherit','inherit','inherit','inherit']"
                                        data-paddingtop="[0,0,0,0]"
                                        data-paddingright="[0,0,0,0]"
                                        data-paddingbottom="[0,0,0,0]"
                                        data-paddingleft="[0,0,0,0]"
                                        style="z-index: 12; width: 100%;">
                                    </div>

                                    <!-- LAYER NR. 9 -->
                                    <div class="tp-caption  "
                                        id="slide-968-layer-12"
                                        data-x="['left','left','left','left']" data-hoffset="['100','100','100','100']"
                                        data-y="['top','top','top','top']" data-voffset="['100','100','100','100']"
                                        data-width="none"
                                        data-height="none"
                                        data-whitespace="nowrap"
                                        data-type="column"
                                        data-responsive_offset="on"
                                        data-responsive="off"
                                        data-frames='[{"delay":"+0","speed":300,"frame":"0","from":"opacity:0;","to":"o:1;","ease":"Power3.easeInOut"},{"delay":"wait","speed":300,"frame":"999","to":"opacity:0;","ease":"Power3.easeInOut"}]'
                                        data-columnwidth="50%"
                                        data-verticalalign="top"
                                        data-margintop="[0,0,0,0]"
                                        data-marginright="[0,0,0,0]"
                                        data-marginbottom="[0,0,0,0]"
                                        data-marginleft="[0,0,0,0]"
                                        data-textalign="['inherit','inherit','inherit','inherit']"
                                        data-paddingtop="[0,0,0,0]"
                                        data-paddingright="[0,0,0,0]"
                                        data-paddingbottom="[0,0,0,0]"
                                        data-paddingleft="[20,20,0,0]"
                                        style="z-index: 13; width: 100%;">
                                    </div>
                                </div>
                            </div>
                        </li>
                        <!-- SLIDE  -->
                        <li data-index="rs-969" data-transition="brightnesscross" data-slotamount="default" data-hideafterloop="0" data-hideslideonmobile="off" data-easein="default" data-easeout="default" data-masterspeed="default" data-rotate="0" data-saveperformance="off" data-title="Slide" data-param1="" data-param2="" data-param3="" data-param4="" data-param5="" data-param6="" data-param7="" data-param8="" data-param9="" data-param10="" data-description="">
                            <!-- MAIN IMAGE -->
                            <img src="image/slider-2.jpg" alt="" data-lazyload="image/slider-2.jpg" data-bgposition="center center" data-bgfit="cover" data-bgrepeat="no-repeat" data-bgparallax="6" class="rev-slidebg" data-no-retina />
                            <!-- LAYERS -->
                            <div id="rrzm_969" class="rev_row_zone rev_row_zone_middle" style="z-index: 11;">
                                <!-- LAYER NR. 12 -->
                                <div class="tp-caption   rs-parallaxlevel-4"
                                    id="slide-969-layer-7"
                                    data-x="['left','left','left','left']" data-hoffset="['100','100','100','100']"
                                    data-y="['middle','middle','middle','middle']" data-voffset="['0','0','0','0']"
                                    data-width="none"
                                    data-height="none"
                                    data-whitespace="nowrap"
                                    data-type="row"
                                    data-columnbreak="2"
                                    data-responsive_offset="on"
                                    data-responsive="off"
                                    data-frames='[{"delay":10,"speed":300,"frame":"0","from":"opacity:0;","to":"o:1;","ease":"Power3.easeInOut"},{"delay":"wait","speed":300,"frame":"999","to":"opacity:0;","ease":"Power3.easeInOut"}]'
                                    data-margintop="[0,0,0,0]"
                                    data-marginright="[0,0,0,0]"
                                    data-marginbottom="[0,0,0,0]"
                                    data-marginleft="[0,0,0,0]"
                                    data-textalign="['inherit','inherit','inherit','inherit']"
                                    data-paddingtop="[0,0,0,0]"
                                    data-paddingright="[50,50,30,30]"
                                    data-paddingbottom="[0,0,0,0]"
                                    data-paddingleft="[50,50,30,30]"
                                    style="z-index: 5; white-space: nowrap; font-size: 20px; line-height: 22px; font-weight: 400; color: #ffffff; letter-spacing: 0px;">
                                    <!-- LAYER NR. 13 -->
                                    <div class="tp-caption  "
                                        id="slide-969-layer-8"
                                        data-x="['left','left','left','left']" data-hoffset="['100','100','100','100']"
                                        data-y="['top','top','top','top']" data-voffset="['100','100','100','100']"
                                        data-width="none"
                                        data-height="none"
                                        data-whitespace="nowrap"
                                        data-type="column"
                                        data-responsive_offset="on"
                                        data-responsive="off"
                                        data-frames='[{"delay":"+0","speed":300,"frame":"0","from":"opacity:0;","to":"o:1;","ease":"Power3.easeInOut"},{"delay":"wait","speed":300,"frame":"999","to":"opacity:0;","ease":"Power3.easeInOut"}]'
                                        data-columnwidth="50%"
                                        data-verticalalign="top"
                                        data-margintop="[0,0,0,0]"
                                        data-marginright="[0,0,0,0]"
                                        data-marginbottom="[0,0,0,0]"
                                        data-marginleft="[0,0,0,0]"
                                        data-textalign="['inherit','inherit','inherit','inherit']"
                                        data-paddingtop="[0,0,0,0]"
                                        data-paddingright="[20,20,0,0]"
                                        data-paddingbottom="[0,0,0,0]"
                                        data-paddingleft="[0,0,0,0]"
                                        style="z-index: 6; width: 100%;">

                                        <!-- LAYER NR. 15 -->
                                        <div class="tp-caption   tp-resizeme"
                                            id="slide-969-layer-1"
                                            data-x="['left','left','left','left']" data-hoffset="['0','50','50','40']"
                                            data-y="['top','top','top','top']" data-voffset="['0','170','170','167']"
                                            data-fontsize="['60','50','40','40']"
                                            data-lineheight="['90','75','60','60']"
                                            data-letterspacing="['15','15','10','7']"
                                            data-width="['100%','100%','561','401']"
                                            data-height="none"
                                            data-whitespace="normal"
                                            data-type="text"
                                            data-responsive_offset="on"
                                            data-frames='[{"delay":"+290","split":"chars","splitdelay":0.05000000000000000277555756156289135105907917022705078125,"speed":2000,"split_direction":"forward","frame":"0","from":"opacity:0;","color":"#000000","to":"o:1;","ease":"Power4.easeInOut"},{"delay":"wait","speed":1000,"frame":"999","color":"transparent","to":"opacity:0;","ease":"Power3.easeInOut"}]'
                                            data-margintop="[0,0,0,0]"
                                            data-marginright="[0,0,0,0]"
                                            data-marginbottom="[30,31,26,26]"
                                            data-marginleft="[0,0,0,0]"
                                            data-textalign="['inherit','inherit','inherit','inherit']"
                                            data-paddingtop="[0,0,0,0]"
                                            data-paddingright="[0,0,0,0]"
                                            data-paddingbottom="[0,0,0,0]"
                                            data-paddingleft="[0,0,0,0]"
                                            style="z-index: 8; min-width: 100%; max-width: 100%; white-space: normal; font-size: 60px; line-height: 90px; font-weight: 400; color: #ffffff; letter-spacing: 15px; display: block; font-family: Oswald; text-transform: uppercase;">
                                            9 month preparing to fall in love for lifetime<%--You never understand life until it grows inside of you--%>
                                        </div>

                                        <!-- LAYER NR. 16 -->
                                        <div class="tp-caption tp-shape tp-shapewrapper  tp-resizeme"
                                            id="slide-969-layer-3"
                                            data-x="['left','left','left','left']" data-hoffset="['0','53','53','42']"
                                            data-y="['top','top','top','top']" data-voffset="['0','440','498','373']"
                                            data-width="50"
                                            data-height="1"
                                            data-whitespace="['normal','nowrap','nowrap','nowrap']"
                                            data-type="shape"
                                            data-responsive_offset="on"
                                            data-frames='[{"delay":"+1490","speed":2000,"frame":"0","from":"sX:0;opacity:0;","to":"o:1;","ease":"Power4.easeInOut"},{"delay":"wait","speed":1000,"frame":"999","to":"opacity:0;","ease":"Power3.easeInOut"}]'
                                            data-margintop="[0,0,0,0]"
                                            data-marginright="[0,0,0,0]"
                                            data-marginbottom="[0,0,0,0]"
                                            data-marginleft="[0,0,0,0]"
                                            data-textalign="['inherit','inherit','inherit','inherit']"
                                            data-paddingtop="[0,0,0,0]"
                                            data-paddingright="[0,0,0,0]"
                                            data-paddingbottom="[0,0,0,0]"
                                            data-paddingleft="[0,0,0,0]"
                                            style="z-index: 9; display: block; background-color: rgb(255,255,255);">
                                        </div>
                                    </div>

                                    <!-- LAYER NR. 17 -->
                                    <div class="tp-caption  "
                                        id="slide-969-layer-9"
                                        data-x="['left','left','left','left']" data-hoffset="['100','100','100','100']"
                                        data-y="['top','top','top','top']" data-voffset="['100','100','100','100']"
                                        data-width="none"
                                        data-height="none"
                                        data-whitespace="nowrap"
                                        data-type="column"
                                        data-responsive_offset="on"
                                        data-responsive="off"
                                        data-frames='[{"delay":"+0","speed":300,"frame":"0","from":"opacity:0;","to":"o:1;","ease":"Power3.easeInOut"},{"delay":"wait","speed":300,"frame":"999","to":"opacity:0;","ease":"Power3.easeInOut"}]'
                                        data-columnwidth="50%"
                                        data-verticalalign="top"
                                        data-margintop="[0,0,0,0]"
                                        data-marginright="[0,0,0,0]"
                                        data-marginbottom="[0,0,0,0]"
                                        data-marginleft="[0,0,0,0]"
                                        data-textalign="['inherit','inherit','inherit','inherit']"
                                        data-paddingtop="[0,0,0,0]"
                                        data-paddingright="[0,0,0,0]"
                                        data-paddingbottom="[0,0,0,0]"
                                        data-paddingleft="[0,0,0,0]"
                                        style="z-index: 10; width: 100%;">
                                    </div>
                                </div>

                                <!-- LAYER NR. 18 -->
                                <div class="tp-caption   rs-parallaxlevel-5"
                                    id="slide-969-layer-10"
                                    data-x="['left','left','left','left']" data-hoffset="['100','100','100','100']"
                                    data-y="['middle','middle','middle','middle']" data-voffset="['0','0','0','0']"
                                    data-width="none"
                                    data-height="none"
                                    data-whitespace="nowrap"
                                    data-type="row"
                                    data-columnbreak="2"
                                    data-responsive_offset="on"
                                    data-responsive="off"
                                    data-frames='[{"delay":10,"speed":300,"frame":"0","from":"opacity:0;","to":"o:1;","ease":"Power3.easeInOut"},{"delay":"wait","speed":300,"frame":"999","to":"opacity:0;","ease":"Power3.easeInOut"}]'
                                    data-margintop="[0,0,0,0]"
                                    data-marginright="[0,0,0,0]"
                                    data-marginbottom="[0,0,0,0]"
                                    data-marginleft="[0,0,0,0]"
                                    data-textalign="['inherit','inherit','inherit','inherit']"
                                    data-paddingtop="[0,0,0,0]"
                                    data-paddingright="[50,50,30,30]"
                                    data-paddingbottom="[0,0,0,0]"
                                    data-paddingleft="[50,50,30,30]"
                                    style="z-index: 11; white-space: nowrap; font-size: 20px; line-height: 22px; font-weight: 400; color: #ffffff; letter-spacing: 0px;">
                                    <!-- LAYER NR. 19 -->
                                    <div class="tp-caption  "
                                        id="slide-969-layer-11"
                                        data-x="['left','left','left','left']" data-hoffset="['100','100','100','100']"
                                        data-y="['top','top','top','top']" data-voffset="['100','100','100','100']"
                                        data-width="none"
                                        data-height="none"
                                        data-whitespace="nowrap"
                                        data-type="column"
                                        data-responsive_offset="on"
                                        data-responsive="off"
                                        data-frames='[{"delay":"+0","speed":300,"frame":"0","from":"opacity:0;","to":"o:1;","ease":"Power3.easeInOut"},{"delay":"wait","speed":300,"frame":"999","to":"opacity:0;","ease":"Power3.easeInOut"}]'
                                        data-columnwidth="50%"
                                        data-verticalalign="top"
                                        data-margintop="[0,0,0,0]"
                                        data-marginright="[0,0,0,0]"
                                        data-marginbottom="[0,0,0,0]"
                                        data-marginleft="[0,0,0,0]"
                                        data-textalign="['inherit','inherit','inherit','inherit']"
                                        data-paddingtop="[0,0,0,0]"
                                        data-paddingright="[0,0,0,0]"
                                        data-paddingbottom="[0,0,0,0]"
                                        data-paddingleft="[0,0,0,0]"
                                        style="z-index: 12; width: 100%;">
                                    </div>

                                    <!-- LAYER NR. 20 -->
                                    <div class="tp-caption  "
                                        id="slide-969-layer-12"
                                        data-x="['left','left','left','left']" data-hoffset="['100','100','100','100']"
                                        data-y="['top','top','top','top']" data-voffset="['100','100','100','100']"
                                        data-width="none"
                                        data-height="none"
                                        data-whitespace="nowrap"
                                        data-type="column"
                                        data-responsive_offset="on"
                                        data-responsive="off"
                                        data-frames='[{"delay":"+0","speed":300,"frame":"0","from":"opacity:0;","to":"o:1;","ease":"Power3.easeInOut"},{"delay":"wait","speed":300,"frame":"999","to":"opacity:0;","ease":"Power3.easeInOut"}]'
                                        data-columnwidth="50%"
                                        data-verticalalign="top"
                                        data-margintop="[0,0,0,0]"
                                        data-marginright="[0,0,0,0]"
                                        data-marginbottom="[0,0,0,0]"
                                        data-marginleft="[0,0,0,0]"
                                        data-textalign="['inherit','inherit','inherit','inherit']"
                                        data-paddingtop="[0,0,0,0]"
                                        data-paddingright="[0,0,0,0]"
                                        data-paddingbottom="[0,0,0,0]"
                                        data-paddingleft="[20,20,0,0]"
                                        style="z-index: 13; width: 100%;">
                                    </div>
                                </div>
                            </div>
                        </li>

                    </ul>
                </div>
            </div>
            <!-- END REVOLUTION SLIDER -->

        </article>
    </section>
    <!-- End Slider -->

    <!--Start Services -->
    <section class="light-gray dart-pt-0" id="services">
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-sm-4">
                    <div id="icon_box_1" class="icon_box3_simple">
                        <div class="icon_circle">
                            <div class="simple_sub_circle"></div>
                            <i class="fa fa-trophy"></i>
                        </div>
                        <a href="#" target="_blank">
                            <h4>Honored by "Vaidyak-Ratna" Award</h4>
                        </a>
                        <p>We are felicitated by many of the honors for our outstanding contribution to medical field. Our Doctor are also honored by national level ‘Vaidyak-Ratna Award’ for our contribution in healthcare services.</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div id="icon_box_2" class="icon_box3_simple">
                        <div class="icon_circle">
                            <div class="simple_sub_circle"></div>
                            <i class="fa fa-stethoscope"></i>
                        </div>
                        <a href="#" target="_blank">
                            <h4>We Spread Smiles</h4>
                        </a>
                        <p>Spreading smiles across more than 6000 couples worldwide. Dr has fulfilled the dreams of couples of being a parent by nurturing their interests with required counselling.</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div id="icon_box_3" class="icon_box3_simple">
                        <div class="icon_circle">
                            <div class="simple_sub_circle"></div>
                            <i class="fa fa-microphone"></i>
                        </div>
                        <a href="#" target="_blank">
                            <h4>Delivered Speech at London</h4>
                        </a>
                        <p>Awarded as “Arogya Shiromani” by Minister of health and family welfare Mr. Ram Shinde. Dr Suresh Kamble was invited to deliver international level speech on research in sterility.</p>
                    </div>
                </div>

            </div>
        </div>
    </section>
    <!-- End Services -->

    <!-- Start Appointment -->
    <section id="appointment" class="appointment" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-md-6 col-sm-8">
                    <div class="appo-form">
                        <div class="dart-heading">
                            <h1 class="dart-mt-0">Appointment</h1>
                            <hr />
                            <p class="white">Just submit your details and we’ll be in touch shortly. You can also e-mail us for any further concern.
                                <asp:Label ID="lblSMSMobile" runat="server" Text="" Font-Bold="true"></asp:Label>
                            </p>
                        </div>
                        <div class="reservation-form">
                            <form class="form-inline" id="bookappointment" name="bookappointment" method="post" runat="server" autocomplete="off" aria-autocomplete="none">

                                <div class="form-inline clearfix">
                                    <div class="form-group col-sm-12">
                                        <input type="tel" id="txtMobile" class="form-control" name="mobile" placeholder="Mobile Number" runat="server" onkeypress='javascript:return isNumberKey(event,this);' maxlength="10" onclick="hideMobilelbl()" />
                                        <label id="alrtMobile" class="lbl-alert">Please enter Mobile number</label>
                                        <label id="alrtMobile1" class="lbl-alert">Please enter valid Mobile number</label>
                                    </div>
                                    <div class="form-group col-sm-12">
                                        <div class="input-group date " id="start">
                                            <%--<input type="text" class="form-control" id="txtDate" runat="server"/>--%>
                                            <asp:DropDownList ID="ddlDate" runat="server" CssClass="form-control" Style="min-height: 35px; color: #555555" onclick="hideDatelbl()"></asp:DropDownList>
                                            <span class="input-group-addon">
                                                <i class="glyphicon glyphicon-calendar"></i>
                                            </span>
                                        </div>
                                        <label id="alrtDate" class="lbl-alert">Please select appointment date</label>
                                    </div>
                                </div>
                                <div class="clearfix">
                                    <div class="col-sm-12">
                                        <a id="ModelLink" href="#loginModal" onclick="return validate()">                                            
                                            <asp:Button ID="btnAppointment" runat="server" Text="Book an Appointment" CssClass="btn btn-default" Style="border-radius: 20px; color: #f05697; font-weight: bold" OnClick="btnBookAppointment_Click"/>
                                        </a>
                                    </div>
                                </div>

                                <hr style="width: 95%" />
                                <asp:Panel ID="pnlAlert" runat="server" class="alert pnl-alert" role="alert" Style="display: none">
                                    <button type="button" class="alert-close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <asp:Label ID="lblalert" runat="server" Text="" Font-Bold="true"></asp:Label>
                                </asp:Panel>

                                <div id="loginModal" class="modalDialog" runat="server">
                                    <div id="loginModalDiv">
                                        <a href="#close" title="Close" class="close">X</a>
                                        <h4 class="card-title" style="text-align: center; font-weight: bold; color: #949494;margin-bottom:10px">Confirm your Appointment Date</h4>

                                        <table id="popupdate" align="center">
                                            <tr>
                                                <td width="50%" style="text-align: right; padding-right: 10px">Mobile :</td>
                                                <td>
                                                    <asp:Label ID="Mobile" runat="server" Font-Bold="true"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right; padding-right: 10px">Appointment Date :</td>
                                                <td>
                                                    <asp:Label ID="Date" runat="server" Font-Bold="true"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <div runat="server" id="Loginalert" style="padding-top: 15px;text-align:center">
                                            <asp:Label ID="lblLoginAllert" runat="server" Font-Bold="true"></asp:Label>
                                        </div>
                                       <%-- <table id="tblLogin" align="center" runat="server">
                                            <tr>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td width="50%" style="text-align: center;" colspan="2">
                                                    <input type="password" id="txtPassword" class="form-control" name="Password" placeholder="Enter Password" runat="server" maxlength="20" onkeypress="hideLoginError()"/>
                                                    <label id="alrtPassword" class="popupAlert" style="font-weight:normal;padding-top:5px">Please enter Password</label>
                                                    <asp:Label ID="alrtPassword1" runat="server" Text="Password is wrong" class="popupAlert"></asp:Label>

                                                    <div style="padding-top: 5px">
                                                        <asp:Label ID="lblLoginAllert" runat="server" Font-Bold="true"></asp:Label>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right; padding-right: 10px">
                                                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-save" OnClientClick="return LoginValidation()" OnClick="btnLogin_Click"/>
                                                </td>
                                                <td><a href="#rgisterModal" id="btnRegister" class="btn-cancel" onclick="btnLoginRegisterClick()">Register</a></td>
                                            </tr>
                                        </table>--%>

                                        <table id="tblDetails" align="center" runat="server" visible="false">
                                            <tr>
                                                <td width="50%" style="text-align: right; padding-right: 10px">Patient Name :</td>
                                                <td>
                                                    <asp:Label ID="lblName" runat="server" Font-Bold="true"></asp:Label><asp:Label ID="lblID" runat="server" Text="0" Font-Size="1" ForeColor="#fff"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right; padding-right: 10px">Date of Birth :</td>
                                                <td>
                                                    <asp:Label ID="lblDOB" runat="server" Font-Bold="true"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: right; padding-right: 10px">Town :</td>
                                                <td>
                                                    <asp:Label ID="lblAddress" runat="server" Font-Bold="true"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        
                                        <table id="tblBtn" align="center" runat="server">
                                            <tr>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td id="tdConfirmBtn" runat="server" style="text-align: right; padding-right: 10px">
                                                    <input type="button" id="btnConfirm" value="Confirm" class="btn-save" runat="server" onclick="if (this.value === 'Booking...') { return false; } else { this.value = 'Booking...'; }" onserverclick="btnSave_Click" /></td>
                                                <td runat="server" id="tdRegisterBtn"><a href="#rgisterModal" id="btnRegister" class="btn-save" onclick="btnLoginRegisterClick()">Register</a></td>
                                                <td style="padding-left: 10px;text-align:left"><a href="Index.aspx" id="btnCancel" class="btn-cancel" runat="server">Cancel</a></td>                                                
                                            </tr>
                                        </table>

                                    </div>
                                </div>

                                <div id="rgisterModal" class="modalDialog" runat="server">
                                    <div>
                                        <a href="#close" title="Close" class="close">X</a>
                                        <h4 class="card-title" style="text-align: center; font-weight: bold; color: #949494;margin-bottom:10px">Patient Registration</h4>

                                        <div class="row">
                                            <div class="col-lg-1"></div>
                                            <div class="col-lg-10">
                                                <div class="col-12">&nbsp</div>
                                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                                                    <asp:TextBox ID="txtFirstName" runat="server" class="form-control" placeholder="First Name" onkeypress="hideRegisterError()"></asp:TextBox>
                                                </div>
                                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                                                    <asp:TextBox ID="txtMiddleName" runat="server" class="form-control" placeholder="Middle Name"></asp:TextBox>
                                                </div>
                                                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                                                    <asp:TextBox ID="txtLastName" runat="server" class="form-control" placeholder="Last Name" onkeypress="hideRegisterError()"></asp:TextBox>
                                                </div>
                                                <div class="col-lg-3 col-md-3 col-sm-2 col-xs-12">
                                                    <asp:DropDownList ID="ddlGender" runat="server" style="border: 1px solid #ccc;text-align-last:center;padding: 5px 10px;margin: 5px;height: 34px;color:#555;width:100%">
                                                        <asp:ListItem Text="Female" Value="Female" Selected="True" ></asp:ListItem>
                                                        <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-lg-4 col-md-3 col-sm-5 col-xs-12">
                                                    <input id="txtDOB" type="tel" runat="server" class="form-control" placeholder="Age (Years)" maxlength="2" onkeypress='javascript: hideRegisterError(); return isNumberKey(event,this);' />
                                                </div>
                                                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">  
                                                    <asp:TextBox ID="txtAddress" runat="server" class="form-control" placeholder="Name of Town" onkeypress="hideRegisterError()"></asp:TextBox>
                                                </div>
                                                <div class="col-lg-6 col-md-4 col-sm-6 col-xs-12">
                                                    <input id="txtMobile1" type="tel" runat="server" class="form-control" placeholder="Mobile Number 1" maxlength="10" onkeypress='javascript: hideRegisterError(); return isNumberKey(event,this);' />
                                                </div>
                                                <div class="col-lg-6 col-md-4 col-sm-6 col-xs-12">
                                                    <input id="txtMobile2" type="tel" runat="server" class="form-control" placeholder="Mobile Number 2 (Optional)" maxlength="10" onkeypress='javascript:return isNumberKey(event,this);' />
                                                </div>
                                                <%--<div class="col-lg-6 col-md-4 col-sm-6 col-xs-12">
                                                    <asp:TextBox ID="txtSignUpPassword" runat="server" TextMode="Password" class="form-control" placeholder="Password" MaxLength="20" onkeypress="hideRegisterError()"></asp:TextBox>
                                                </div>
                                                <div class="col-lg-6 col-md-4 col-sm-6 col-xs-12">
                                                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" class="form-control" placeholder="Confirm Password" MaxLength="20" onkeypress="hideRegisterError()"></asp:TextBox>
                                                </div>--%>
                                                <div class="col-12" style="text-align: center;">
                                                    <asp:Label ID="lblRegisterAlert" runat="server" ForeColor="#f05697"></asp:Label>&nbsp
                                                </div>
                                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center">
                                                    <asp:Button ID="btnRegisterConfirm" runat="server" Text="Register" CssClass="btn-save" OnClientClick="return registerValidation()" OnClick="btnRegister_Click" />
                                                    <a href="#loginModal" id="btnRegisterCancel" class="btn-cancel" onclick="clearRegisterForm()">Cancel</a>
                                                </div>
                                            </div>
                                            <div class="col-lg-1"></div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--End Appintment -->

    <!-- Start About Us -->
    <section id="about" class="fullWidthOne" style="padding-top: 100px">
        <div class="container">
            <div class="row">
                <div class="col-md-6 col-sm-6">
                    <img class="img-responsive" src="image/img-3.jpg" alt="" />
                </div>
                <div class="col-md-6 col-sm-6">
                    <div class="dart-headingstyle-one text-left dart-mb-30 cs-mob-mt">
                        <!--Style 1-->
                        <h2 class="dart-heading">Welcome</h2>
                    </div>
                    <p class="text-justify">We are a prominent Doctor serving in rural as well as urban areas with an urge to spread smile across the patients, who have been struggling with fertility issues. With our professional expertise and wealth of experience of over 50 years, we have been able to treat the patients with utmost care to their sensitive problems. This has lead to a trustworthy relationship with our patients.</p>
                    <p class="text-justify">We are felicitated by many of the honors for our outstanding contribution to medical field. Our Doctor are also honored by national level ‘Vaidyak-Ratna Award’ for our contribution in healthcare services.</p>
                    <p class="text-justify">From traditional treatments to latest technological advanced treatments we proactively engage with our patients to develop a healthy country and society.</p>

                    <div class="scroll"><a href="#work" class="btn btn-default-1 dart-btn-xs dart-mt-20">See More</a></div>
                </div>
            </div>
        </div>
    </section>
    <!-- End About Us -->


    <!-- Start our work -->
    <section class="bg-img" id="work">
        <div class="container">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="dart-headingstyle-one text-center dart-mb-30">
                        <!--Style 1-->
                        <h2 class="dart-heading">Our Services</h2>
                    </div>
                </div>
            </div>
            <div class="row no-gutter">
                <div class="col-md-3 col-sm-6">
                    <div id="icon_box_4" class="icon_box10_full">
                        <div class="icon_circle">
                            <div class="sub_circle"></div>
                            <i class="fa fa-venus"></i>
                        </div>
                        <a href="#" target="_blank">
                            <h4>Womens Health Care</h4>
                        </a>
                        <p>
                            Infertility Problem,<br />
                            Abnormal Menstruation (Periods),<br />
                            ovulation deficiency,<br />
                            Polycystic Ovary Syndrome (PCOD),<br />
                            Tube block,<br />
                            Harmonal Imbalance
                        </p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div id="icon_box_5" class="icon_box10_full">
                        <div class="icon_circle">
                            <div class="sub_circle"></div>
                            <i class="fa fa-mars"></i>
                        </div>
                        <a href="#" target="_blank">
                            <h4>Mens Health Care</h4>
                        </a>
                        <p>
                            Azoospermia (Absence of Sperm),
                            <br />
                            Low Sperm Count,<br />
                            Ejaculatory duct obstruction (EDO)<br />
                            Erectile dysfunction,<br />
                            Sex related problems
                        </p>
                        <br />
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div id="icon_box_6" class="icon_box10_full">
                        <div class="icon_circle">
                            <div class="sub_circle"></div>
                            <i class="fa fa-medkit"></i>
                        </div>
                        <a href="#" target="_blank">
                            <h4>Pregnancy Care</h4>
                        </a>
                        <p>
                            Diet<br />
                            Personal Care,<br />
                            Pregnancy Lifestyle,<br />
                            <br />
                            <br />
                            <br />
                        </p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div id="icon_box_7" class="icon_box10_full">
                        <div class="icon_circle">
                            <div class="sub_circle"></div>
                            <i class="fa fa-child"></i>
                        </div>
                        <a href="#" target="_blank">
                            <h4>Baby Care</h4>
                        </a>
                        <p>Baby care basics,<br />
                           Baby disease diagnosis,<br /> 
                           Health tips,<br /> 
                            Baby soothers</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End Our Work -->

    <!-- Start testimonials -->
    <%--<section class="testimonialEight light-gray" id="testimonials">
        <div class="container">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="dart-headingstyle-one text-center dart-mb-30">
                        <!--Style 1-->
                        <h2 class="dart-heading">testimonials</h2>
                    </div>
                </div>
            </div>
            <div class="row text-center">
                <div class="col-md-12">
                    <!--<div class="quote"><i class="fa fa-quote-left fa-4x"></i></div>-->
                    <div class="carousel slide" id="dart-quote-carousel" data-ride="carousel" data-interval="3000">
                        <!-- Carousel indicators -->

                        <!-- Carousel items -->
                        <div class="carousel-inner">
                            <div class="active item">
                                <div class="profile-circle">
                                    <img src="image/avtar-1.png" />
                                </div>
                                <blockquote>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <p><i>"dictumst quisque sagittis. Pretium vulputate sapien nec sagittis aliquam malesuada bibendum arcu. Consectetur a erat nam at lectus urna duis convallis convallis. Quis commodo odio aenean sed adipiscing diam donec is quas aperiam recusandae consequatur ullam quibusdam cum  diam donec.”</i></p>
                                            <span class="name dart-fs-16">- max Watson</span><br />
                                            <span class="position dart-fs-12">MadiCare Inc.</span>
                                        </div>
                                    </div>
                                </blockquote>
                            </div>
                            <div class="item">
                                <div class="profile-circle">
                                    <img src="image/avtar-2.png" />
                                </div>
                                <blockquote>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <p><i>"lacinia at quis risus sed vulputate. Tortor id aliquet lectus proin nibh. Consectetur adipiscing elit ut aliquam purus sit. In hac habitasse platea dictumst quisque sagittis. Pretium vulputate endum arcu. Consectetur a erat nam at lectus urna duis  Quis commodo odio aenean sed adipiscing.”</i></p>
                                            <span class="name dart-fs-16">- Stephen Hudson</span><br />
                                            <span class="position dart-fs-12">MadiCare Inc.</span>
                                        </div>
                                    </div>
                                </blockquote>
                            </div>
                            <div class="item">
                                <div class="profile-circle">
                                    <img src="image/avtar-3.png" />
                                </div>
                                <blockquote>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <p><i>"Incidunt deleniti blanditiis quas aperiam recusandae consequatur ullam quibusdam cum libero illo rerum! Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.”</i></p>
                                            <span class="name dart-fs-16">- John Doe</span><br />
                                            <span class="position dart-fs-12">MadiCare Inc.</span>
                                        </div>
                                    </div>
                                </blockquote>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>--%>
    <!-- End testimonials -->

    <!--Start Counter -->
    <!-- Start the Style Of Counter with  With image background Here -->
    <section class="dart-counter-image-background counter" id="">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-6 text-center">
                    <i class="fa fa-smile-o dart-fs-48"></i>
                    <div class="row">
                        <div class="col-md-8 col-xs-8" style="padding: 0; text-align: right">
                            <h1 class="count dart-fs-42">6000</h1>
                        </div>
                        <div class="col-md-4 col-xs-4" style="padding: 0; text-align: left">
                            <h1>+</h1>
                        </div>
                    </div>
                    <h5 style="margin: 0">HAPPY PATIENTS</h5>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-6 text-center">
                    <i class="fa fa-globe dart-fs-48"></i>
                    <div class="row">
                        <div class="col-md-7 col-xs-6" style="padding: 0; text-align: right">
                            <h1 class="count dart-fs-42">93</h1>
                        </div>
                        <div class="col-md-5 col-xs-6" style="padding: 0; text-align: left">
                            <h1>%</h1>
                        </div>
                    </div>
                    <h5 style="margin: 0">SUCCESS RATE</h5>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-6 text-center">
                    <i class="fa fa-bullhorn dart-fs-48"></i>
                    <h1 class="count dart-fs-42">32</h1>
                    <h5>CAMPAIGN</h5>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-6 text-center">
                    <i class="fa fa-fire dart-fs-48"></i>
                    <h1 class="count dart-fs-42">7</h1>
                    <h5>AWARDS</h5>
                </div>
            </div>
        </div>
    </section>
    <!-- Start the Style Of Counter  With image background Here -->
    <!-- End Counter -->

    <!-- Start Blog -->
    <!-- Blog Post Style 3 --->
    <section class="blogstyle-3" id="blog">
        <div class="container" style="width: 96%">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="dart-headingstyle-one text-center dart-mb-30">
                        <!--Style 1-->
                        <h2 class="dart-heading">Certificates</h2>
                    </div>
                </div>
            </div>
            <div class="row cert-row">                
                <div class="container1 col-lg-3 col-md-3 col-xs-12">
                    <img src="image/Cert.jpg" style="max-width: 100%; cursor: pointer" onclick="onClick(this)" class="modal-hover-opacity h450" />
                </div>
                <div class="container1 col-lg-3 col-md-3 col-xs-12">
                    <img src="image/ISO.png" style="max-width: 100%; cursor: pointer" onclick="onClick(this)" class="modal-hover-opacity h450" />
                </div>
                <div class="container1 col-lg-3 col-md-3 col-xs-12">
                    <img src="image/PSRLI.png" style="max-width: 100%; cursor: pointer" onclick="onClick(this)" class="modal-hover-opacity h450" />
                </div>
            </div>
        </div>
    </section>
    <!-- End Blog -->

    <section id="gallary" style="padding-top: 0">
        <div class="container" style="width: 96%">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="dart-headingstyle-one text-center dart-mb-30">
                        <!--Style 1-->
                        <h2 class="dart-heading">News</h2>
                    </div>
                </div>
            </div>

            <div class="container1 col-lg-2 col-md-2 col-xs-6">
                <img src="image/gallary/1.jpg" style="max-width: 100%; cursor: pointer" onclick="onClick(this)" class="modal-hover-opacity" />
            </div>
            <div class="container1 col-lg-2 col-md-2 col-xs-6">
                <img src="image/gallary/2.jpg" style="max-width: 100%; cursor: pointer" onclick="onClick(this)" class="modal-hover-opacity" />
            </div>
            <div class="container1 col-lg-2 col-md-2 col-xs-6">
                <img src="image/gallary/3.jpg" style="max-width: 100%; cursor: pointer" onclick="onClick(this)" class="modal-hover-opacity" />
            </div>
            <div class="container1 col-lg-2 col-md-2 col-xs-6">
                <img src="image/gallary/4.jpg" style="max-width: 100%; cursor: pointer" onclick="onClick(this)" class="modal-hover-opacity" />
            </div>
            <div class="container1 col-lg-2 col-md-2 col-xs-6">
                <img src="image/gallary/5.jpg" style="max-width: 100%; cursor: pointer" onclick="onClick(this)" class="modal-hover-opacity" />
            </div>
            <div class="container1 col-lg-2 col-md-2 col-xs-6">
                <img src="image/gallary/6.jpg" style="max-width: 100%; cursor: pointer" onclick="onClick(this)" class="modal-hover-opacity" />
            </div>
            <div class="container1 col-lg-2 col-md-2 col-xs-6">
                <img src="image/gallary/7.jpg" style="max-width: 100%; cursor: pointer" onclick="onClick(this)" class="modal-hover-opacity" />
            </div>
            <div class="container1 col-lg-2 col-md-2 col-xs-6">
                <img src="image/gallary/8.jpg" style="max-width: 100%; cursor: pointer" onclick="onClick(this)" class="modal-hover-opacity" />
            </div>
            <div class="container1 col-lg-2 col-md-2 col-xs-6">
                <img src="image/gallary/9.jpg" style="max-width: 100%; cursor: pointer" onclick="onClick(this)" class="modal-hover-opacity" />
            </div>
            <div class="container1 col-lg-2 col-md-2 col-xs-6">
                <img src="image/gallary/10.jpg" style="max-width: 100%; cursor: pointer" onclick="onClick(this)" class="modal-hover-opacity" />
            </div>
            <div class="container1 col-lg-2 col-md-2 col-xs-6">
                <img src="image/gallary/11.jpg" style="max-width: 100%; cursor: pointer" onclick="onClick(this)" class="modal-hover-opacity" />
            </div>
            <div class="container1 col-lg-2 col-md-2 col-xs-6">
                <img src="image/gallary/12.png" style="max-width: 100%; cursor: pointer" onclick="onClick(this)" class="modal-hover-opacity" />
            </div>

            <div id="modal01" class="modal1" onclick="this.style.display='none'">
                <span class="close1">&times;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <div class="modal-content">
                    <img id="img01" src="" style="max-width: 110%" />
                </div>
            </div>
        </div>
    </section>


    <%--<div id="map" style="height:300px">
    	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBk25E4mNfVIEt3tNl3K1HwNZVruVoFBlA&callback=gMap" async="" defer=""></script>
    </div>--%>
    <div class="mapouter">
        <div class="gmap_canvas">
            <iframe height="300" id="gmap_canvas" src="https://maps.google.com/maps?q=dr%20suresh%20kamble&t=&z=11&ie=UTF8&iwloc=&output=embed&callback=gMap" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe>
            Google Maps Generator by <a href="https://www.embedgooglemap.net">embedgooglemap.net</a>
        </div>
    </div>
    <!-- End Contact Form -->

    <!--Start Footer -->
    <footer id="contact">
        <div class="container">
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="footer-block">
                        <div class="logo logo-scrolled">
                            <span style="color: #cccccc; font-size: 14px; font-weight: bold">Dr. Suresh Kamble's</span>
                            <p style="color: #f05697; font-size: 22px; font-weight: bold; margin: 0; line-height: 1; letter-spacing: 1px">FERTILITY CENTER</p>
                        </div>
                        <p>
                            <a href="https://www.google.com/maps/place/Dr.+Suresh+Kamble/@20.0386819,74.4905709,17z/data=!3m1!4b1!4m5!3m4!1s0x3bdc39b92964fa85:0xbfb8bd528423c6df!8m2!3d20.0386769!4d74.4927596" style="color: #cccccc;" target="_blank"><i class="fa fa-map-marker"></i>&nbsp Sr. No. 25/3/a, Plot. No. 24-25 Behind Axis Bank,<br />
                                Vitthal Nagar, Aurangabad Road, Yeola,
                                <br />
                                Nashik, Maharashtra 423401</a><br />
                            <hr style="width: 30%; margin: 0 auto; padding-bottom: 10px; border-top: 1px solid #cccccc;" />
                            <a href="tel:9960923911" style="color: #cccccc;"><i class="fa fa-phone"></i>&nbsp 9960 92 9311<br />
                            </a>
                            <a href="mailto:care@drkamblesfertilitycenter.in" style="color: #cccccc;"><i class="fa fa-envelope-o"></i>&nbsp care@drkamblesfertilitycenter.in</a>
                        </p>
                        <ul class="list-inline social-link">
                            <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                            <li><a href="#"><i class="fa fa-instagram"></i></a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="row copy">
                <div class="col-md-6 col-sm-6">
                    <p><span class="pink">© Dr.Kambles Fertility Center</span> | All Rights Reserved</p>
                </div>
                <div class="col-md-6 col-sm-6">
                    <p class="text-right">Design and Developed by<a href="http://www.jericotechnologies.in" target="_blank" style="color: #38d5ff"> Jerico Technologies</a></p>
                </div>
            </div>
        </div>
    </footer>

    <!-- End Footer -->

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>

    <!-- jQuery -->
    <script src="vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Nav JavaScript -->
    <script src="js/divineartnav.js"></script>

    <!-- REVOLUTION JS FILES -->
    <script type="text/javascript" src="vendor/revolution-slider/revolution/js/jquery.themepunch.tools.min.js"></script>
    <script type="text/javascript" src="vendor/revolution-slider/revolution/js/jquery.themepunch.revolution.min.js"></script>
    <script type="text/javascript" src="vendor/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>

    <!-- SLIDER REVOLUTION 5.0 EXTENSIONS  (Load Extensions only on Local File Systems !  The following part can be removed on Server for On Demand Loading) -->
    <script type="text/javascript" src="vendor/revolution-slider/revolution/js/extensions/revolution.extension.actions.min.js"></script>
    <script type="text/javascript" src="vendor/revolution-slider/revolution/js/extensions/revolution.extension.carousel.min.js"></script>
    <script type="text/javascript" src="vendor/revolution-slider/revolution/js/extensions/revolution.extension.kenburn.min.js"></script>
    <script type="text/javascript" src="vendor/revolution-slider/revolution/js/extensions/revolution.extension.layeranimation.min.js"></script>
    <script type="text/javascript" src="vendor/revolution-slider/revolution/js/extensions/revolution.extension.migration.min.js"></script>
    <script type="text/javascript" src="vendor/revolution-slider/revolution/js/extensions/revolution.extension.navigation.min.js"></script>
    <script type="text/javascript" src="vendor/revolution-slider/revolution/js/extensions/revolution.extension.parallax.min.js"></script>
    <script type="text/javascript" src="vendor/revolution-slider/revolution/js/extensions/revolution.extension.slideanims.min.js"></script>
    <script type="text/javascript" src="vendor/revolution-slider/revolution/js/extensions/revolution.extension.video.min.js"></script>

    <!-- PARTICLES ADD-ON FILES -->
    <script type="text/javascript" src="vendor/revolution-slider/revolution-addons/particles/js/revolution.addon.particles.min4bf4.js?ver=1.0.3"></script>
    <!-- template JavaScript -->
    <script src="js/template-demo.js"></script>

</body>
</html>
