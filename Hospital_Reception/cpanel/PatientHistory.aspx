<%@ Page Title="" Language="C#" MasterPageFile="../cpanel/MasterCP.Master" AutoEventWireup="true" CodeBehind="PatientHistory.aspx.cs" Inherits="Hospital_Reception.cpanel.PatientHistory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.9.2/themes/blitzer/jquery-ui.css" rel="Stylesheet" type="text/css" />
    <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.10.0.min.js" type="text/javascript"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.9.2/jquery-ui.min.js" type="text/javascript"></script>

    
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/json2/20130526/json2.min.js"></script>    
    <style>
        .card-prescription li {
            color: #777;
        }

        #diagnosisBtn button {
            background-color: #ff758e;
        }

        #medicinesBtn button {
            background-color: #FFB236;
        }

        #adviceBtn button {
            background-color: #50d38a;
        }

        .member-card .member-img img {
            width: 100px;
        }

        #timeline .header {
            padding: 0 0 20px;
        }

        #medicines, #advice {
            display: none;
        }

        #presMedi, #presDiagno, #presAdvice {
            cursor: pointer;
        }

        .medi-txt {
            padding: 1px;
            text-align: center;
            margin: 0 5px;
            border-radius: 5px;
            border: 1px solid #999999;
            color: #888888;
        }

        #ulMedicines select {
            font-size: 10px;
            color: #999999;
            padding: 0;
        }

        .medi-txt:focus {
            border: 1px solid #60bafd;
        }

        #ulMedicines li {
            padding: 5px 0;
        }

        .pres-header div {
            padding: 0;
            font-size: 12px;
            color: #999999;
            text-align: center;
            margin: 0 5px;
            padding: 1px;
        }

        @media only screen and (min-width: 700px) {
            .fixed-card {
                position: fixed;
                width: 347px;
                height: 100%;
            }

            .scroll-card {
                overflow-y: scroll;
                height: 100%;
            }
            /* width */
            ::-webkit-scrollbar {
                width: 5px;
            }

            /* Track */
            ::-webkit-scrollbar-track {
                background: #f1f1f1;
            }

            /* Handle */
            ::-webkit-scrollbar-thumb {
                background: #aaa;
                border-radius: 10px;
            }

                /* Handle on hover */
                ::-webkit-scrollbar-thumb:hover {
                    background: #888;
                }
        }

        .booking-date {
            cursor: pointer;
            font-weight: 500;
            color: #777;
        }

        .dashed {
            list-style:square;
            color:#333;
            font-size:12px;
        }

    </style>
    <script>
        window.onload = function () {
            $(function () {
                $(".randomColor").each(function () {
                    var hue = 'rgb(' + (Math.floor((200) * Math.random()) + 35) + ',' + (Math.floor((150) * Math.random()) + 15) + ',' + (Math.floor((100) * Math.random()) + 25) + ')';
                    $(this).css("border-color", hue);
                });
            });

            document.body.className = document.body.className.replace("theme-cyan", "theme-cyan ls-toggle-menu");
            fetchAllDiagnosisBtn();
            fetchAllMedicinesBtn();
            fetchAllAdviceBtn();

            document.getElementById('<%=txtDiagnosis.ClientID%>').addEventListener('keydown', function (event) {
                if (event.code == 'Backspace') {
                    $("#diagnosisBtn").empty();
                    if (document.getElementById('<%=txtDiagnosis.ClientID%>').value != "") {
                        PageMethods.searchDiagnosis(document.getElementById('<%=txtDiagnosis.ClientID%>').value, OnDiagnosisSuccess);
                    }
                    else {
                        fetchAllDiagnosisBtn();
                    }
                }
            });

            document.getElementById('<%=txtMedicines.ClientID%>').addEventListener('keydown', function (event) {
                if (event.code == 'Backspace') {
                    $("#medicinesBtn").empty();
                    if (document.getElementById('<%=txtMedicines.ClientID%>').value != "") {
                        PageMethods.searchMedicines(document.getElementById('<%=txtMedicines.ClientID%>').value, OnMedicinesSuccess);
                    }
                    else {
                        fetchAllMedicinesBtn();
                    }
                }
            });

            document.getElementById('<%=txtAdvice.ClientID%>').addEventListener('keydown', function (event) {
                if (event.code == 'Backspace') {
                    $("#adviceBtn").empty();
                    if (document.getElementById('<%=txtAdvice.ClientID%>').value != "") {
                        PageMethods.searchAdvice(document.getElementById('<%=txtAdvice.ClientID%>').value, OnAdviceSuccess);
                    }
                    else {
                        fetchAllAdviceBtn();
                    }
                }
            });
        }

        $(function () {
            $('.booking-date').click(function () {
                var date = $(this).text();
                var patientID = document.getElementById('<%=lblPatientID.ClientID%>').innerText;
                PageMethods.fetchOldPrescription(date, patientID, OnOldprescriptionSccess);
            });
        })

        function OnOldprescriptionSccess(response) {
            if (response != "") {
                var diagnoArry = new Array();
                var mediArry = new Array();
                var d = response[0];
                var m = response[1];

                document.getElementById('<%=lblLastVisit.ClientID%>').innerHTML = response[2];

                diagnoArry = d.split("$");
                mediArry = m.split("$");

                $("#ulOldDigno").empty();
                for (var i = 0; i < diagnoArry.length; i++) {
                    var li = document.createElement("li");
                    li.innerText = diagnoArry[i];
                    document.getElementById("ulOldDigno").appendChild(li);
                }

                $("#ulOldMedi").empty();
                for (var i = 0; i < mediArry.length; i++) {
                    var li = document.createElement("li");
                    li.innerHTML = "<div class='row'>" + mediArry[i] + "</div>";
                    document.getElementById("ulOldMedi").appendChild(li);
                }
            }
            else {
            }
        }

        function fetchAllDiagnosisBtn() {
            PageMethods.fetchAllDiagnosis(OnDiagnosisSuccess);
        }

        function fetchAllMedicinesBtn() {
            PageMethods.fetchAllMedicines(OnMedicinesSuccess);
        }

        function fetchAllAdviceBtn() {
            PageMethods.fetchAllAdvice(OnAdviceSuccess);
        }

        function insertDiagnosis() {
            PageMethods.insertDiagnosis(document.getElementById('<%=txtDiagnosis.ClientID%>').value, OnDiagnosisInsert);
        }

        function insertMedicine() {
            PageMethods.insertMedicine(document.getElementById('<%=txtMedicines.ClientID%>').value, OnMedicineInsert);
        }

        function insertAdvice() {
            PageMethods.insertAdvice(document.getElementById('<%=txtAdvice.ClientID%>').value, OnAdviceInsert);
        }

        function OnDiagnosisSuccess(response) {
            if (response != "") {
                var arry = new Array();
                arry = response.split("$");
                var half = arry.length / 2;
                for (var i = 0; i < half; i++) {
                    var btn = document.createElement("button");
                    btn.innerText = arry[i];
                    btn.type = "button";
                    btn.value = arry[(half + i)];
                    btn.classList = "btn btn-default waves-effect waves-light btn-round";
                    btn.setAttribute("onclick", "addDiagnosisOnCLick(this.innerText,this.value)");
                    document.getElementById("diagnosisBtn").appendChild(btn);
                    document.getElementById("diagnoSave").style.display = "none";
                }
            }
            else {
                document.getElementById("diagnoSave").style.display = "block";
            }
        }

        function OnMedicinesSuccess(response) {
            if (response != "") {
                var arry = new Array();
                arry = response.split("$");
                var half = arry.length / 2;
                for (var i = 0; i < half; i++) {
                    var btn = document.createElement("button");
                    btn.innerText = arry[i];
                    btn.type = "button";
                    btn.value = arry[(half + i)];
                    btn.classList = "btn btn-default waves-effect waves-light btn-round";
                    btn.setAttribute("onclick", "addMedicinesOnCLick(this.innerText,this.value)");
                    document.getElementById("medicinesBtn").appendChild(btn);
                }
            }
            else {
                document.getElementById("mediSave").style.display = "block";
            }
        }

        function OnAdviceSuccess(response) {
            if (response != "") {
                var arry = new Array();
                arry = response.split("$");
                var half = arry.length / 2;
                for (var i = 0; i < half; i++) {
                    var btn = document.createElement("button");
                    btn.innerText = arry[i];
                    btn.type = "button";
                    btn.value = arry[(half + i)];
                    btn.classList = "btn btn-default waves-effect waves-light btn-round";
                    btn.setAttribute("onclick", "addAdviceOnCLick(this.innerText,this.value)");
                    document.getElementById("adviceBtn").appendChild(btn);
                }
            }
            else {
                document.getElementById("adviceSave").style.display = "block";
            }
        }

        function OnDiagnosisInsert(response) {
            if (response != "") {
                if (response == "0") {
                    fetchAllDiagnosisBtn();
                    document.getElementById("lblDiagnoError").style.display = "block";
                    setTimeout(function () {
                        document.getElementById('lblDiagnoError').style.display = 'none';
                    }, 1500);
                    return false;
                }
                else {
                    var list = document.createElement("li");
                    var lblDiagnosis = document.createElement("lable");
                    var d = new Date();
                    var x = d.valueOf()
                    list.id = x;
                    lblDiagnosis.setAttribute("ondblclick", "this.parentElement.remove()");
                    lblDiagnosis.innerText = document.getElementById('<%=txtDiagnosis.ClientID%>').value;
                    lblDiagnosis.id = response;
                    lblDiagnosis.classList = "diagnosis-name";
                    document.getElementById("ulDiagnosis").appendChild(list);
                    document.getElementById(x).appendChild(lblDiagnosis);
                    document.getElementById('<%=txtDiagnosis.ClientID%>').value = "";
                    fetchAllDiagnosisBtn();
                    document.getElementById("diagnoSave").style.display = "none";
                }
            }
        }

        function OnMedicineInsert(response) {
            if (response != "") {
                if (response == "0") {
                    fetchAllMedicinesBtn();
                    document.getElementById("lblMediError").style.display = "block";
                    setTimeout(function () {
                        document.getElementById('lblMediError').style.display = 'none';
                    }, 1500);
                    return false;
                }
                else {
                    var list = document.createElement("li");
                    var lblMedicine = document.createElement("lable");
                    var txtSakal = document.createElement("input");
                    var txtDupar = document.createElement("input");
                    var txtSandhya = document.createElement("input");
                    var txtRatri = document.createElement("input");
                    var ddl = document.createElement("select");
                    var option1 = document.createElement("option");
                    var option2 = document.createElement("option");
                    var txtDays = document.createElement("input");
                    var d = new Date();
                    var x = d.valueOf()

                    list.id = x;
                    list.classList = "row";
                    lblMedicine.textContent = document.getElementById('<%=txtMedicines.ClientID%>').value;;
                    lblMedicine.id = response;
                    lblMedicine.classList = "medicine-name col-3";
                    lblMedicine.setAttribute("ondblclick", "this.parentElement.remove()");
                    txtSakal.classList = "sakal col-1 medi-txt";
                    txtSakal.value = "0";
                    txtSakal.type = "number";
                    txtSakal.step = "0.5";
                    txtSakal.min = "0";
                    txtDupar.classList = "dupar col-1 medi-txt";
                    txtDupar.value = "0";
                    txtDupar.type = "number";
                    txtDupar.step = "0.5";
                    txtDupar.min = "0";
                    txtSandhya.classList = "sandyakal col-1 medi-txt";
                    txtSandhya.value = "0";
                    txtSandhya.type = "number";
                    txtSandhya.step = "0.5";
                    txtSandhya.min = "0";
                    txtRatri.classList = "ratri col-1 medi-txt";
                    txtRatri.value = "0";
                    txtRatri.type = "number";
                    txtRatri.step = "0.5";
                    txtRatri.min = "0";
                    txtDays.value = "0";
                    txtDays.type = "number";
                    txtDays.step = "5";
                    txtDays.min = "0";
                    txtDays.classList = "days col-1 m-auto medi-txt";
                    ddl.id = x + 'd';
                    ddl.classList = "jevan col-1 medi-txt";
                    option1.innerText = "जेवणानंतर";
                    option2.innerText = "जेवणाआधी";

                    document.getElementById("ulMedicines").appendChild(list);
                    document.getElementById(x).appendChild(lblMedicine);
                    document.getElementById(x).appendChild(txtSakal);
                    document.getElementById(x).appendChild(txtDupar);
                    document.getElementById(x).appendChild(txtSandhya);
                    document.getElementById(x).appendChild(txtRatri);
                    document.getElementById(x).appendChild(ddl);
                    document.getElementById(x + 'd').appendChild(option1);
                    document.getElementById(x + 'd').appendChild(option2);
                    document.getElementById(x).appendChild(txtDays);
                    document.getElementById('<%=txtMedicines.ClientID%>').value = "";
                    document.getElementById("mediSave").style.display = "none";
                    fetchAllMedicinesBtn();
                }
            }
        }

        function OnAdviceInsert(response) {
            if (response != "") {
                if (response == "0") {
                    fetchAllAdviceBtn();
                    document.getElementById("lblAdviceError").style.display = "block";
                    setTimeout(function () {
                        document.getElementById('lblAdviceError').style.display = 'none';
                    }, 1500);
                    return false;
                }
                else {
                    var list = document.createElement("li");
                    var lblAdvice = document.createElement("lable");
                    var d = new Date();
                    var x = d.valueOf()
                    list.id = x;
                    lblAdvice.setAttribute("ondblclick", "this.parentElement.remove()");
                    lblAdvice.innerText = document.getElementById('<%=txtAdvice.ClientID%>').value;
                    lblAdvice.id = response;
                    lblAdvice.classList = "advice-name";
                    document.getElementById("ulAdvice").appendChild(list);
                    document.getElementById(x).appendChild(lblAdvice);
                    document.getElementById('<%=txtAdvice.ClientID%>').value = "";
                    fetchAllAdviceBtn();
                    document.getElementById("adviceSave").style.display = "none";
                }
            }
        }

        function addDiagnosisOnCLick(txt, val) {
            var list = document.createElement("li");
            var lblDiagnosis = document.createElement("lable");
            var d = new Date();
            var x = d.valueOf()
            list.id = x;
            lblDiagnosis.setAttribute("ondblclick", "this.parentElement.remove()");
            lblDiagnosis.innerText = txt;
            lblDiagnosis.id = val;
            lblDiagnosis.classList = "diagnosis-name";
            document.getElementById("ulDiagnosis").appendChild(list);
            document.getElementById(x).appendChild(lblDiagnosis);
            document.getElementById('<%=txtDiagnosis.ClientID%>').value = "";
            return false;

        }

        function addMedicinesOnCLick(txt, val) {
            var list = document.createElement("li");
            var lblMedicine = document.createElement("lable");
            var txtSakal = document.createElement("input");
            var txtDupar = document.createElement("input");
            var txtSandhya = document.createElement("input");
            var txtRatri = document.createElement("input");
            var ddl = document.createElement("select");
            var option1 = document.createElement("option");
            var option2 = document.createElement("option");
            var txtDays = document.createElement("input");
            var d = new Date();
            var x = d.valueOf()

            list.id = x;
            list.classList = "row";
            lblMedicine.textContent = txt;
            lblMedicine.id = val;
            lblMedicine.classList = "medicine-name col-3";
            lblMedicine.setAttribute("ondblclick", "this.parentElement.remove()");
            txtSakal.classList = "sakal col-1 medi-txt";
            txtSakal.value = "0";
            txtSakal.type = "number";
            txtSakal.step = "0.5";
            txtSakal.min = "0";
            txtDupar.classList = "dupar col-1 medi-txt";
            txtDupar.value = "0";
            txtDupar.type = "number";
            txtDupar.step = "0.5";
            txtDupar.min = "0";
            txtSandhya.classList = "sandyakal col-1 medi-txt";
            txtSandhya.value = "0";
            txtSandhya.type = "number";
            txtSandhya.step = "0.5";
            txtSandhya.min = "0";
            txtRatri.classList = "ratri col-1 medi-txt";
            txtRatri.value = "0";
            txtRatri.type = "number";
            txtRatri.step = "0.5";
            txtRatri.min = "0";
            txtDays.value = "0";
            txtDays.type = "number";
            txtDays.step = "5";
            txtDays.min = "0";
            txtDays.classList = "days col-1 m-auto medi-txt";
            ddl.id = x + 'd';
            ddl.classList = "jevan col-1 medi-txt";
            option1.innerText = "जेवणानंतर";
            option2.innerText = "जेवणाआधी";

            document.getElementById("ulMedicines").appendChild(list);
            document.getElementById(x).appendChild(lblMedicine);
            document.getElementById(x).appendChild(txtSakal);
            document.getElementById(x).appendChild(txtDupar);
            document.getElementById(x).appendChild(txtSandhya);
            document.getElementById(x).appendChild(txtRatri);
            document.getElementById(x).appendChild(ddl);
            document.getElementById(x + 'd').appendChild(option1);
            document.getElementById(x + 'd').appendChild(option2);
            document.getElementById(x).appendChild(txtDays);
            document.getElementById('<%=txtMedicines.ClientID%>').value = "";
            return false;

        }

        function addAdviceOnCLick(txt, val) {
            var list = document.createElement("li");
            var lblAdvice = document.createElement("lable");
            var d = new Date();
            var x = d.valueOf()
            list.id = x;
            lblAdvice.setAttribute("ondblclick", "this.parentElement.remove()");
            lblAdvice.innerText = txt;
            lblAdvice.id = val;
            lblAdvice.classList = "advice-name";
            document.getElementById("ulAdvice").appendChild(list);
            document.getElementById(x).appendChild(lblAdvice);
            document.getElementById('<%=txtAdvice.ClientID%>').value = "";
            return false;

        }

        function addDiagnosis() {
            $("#diagnosisBtn").empty();

            if (document.getElementById('<%=txtDiagnosis.ClientID%>').value != "") {
                PageMethods.searchDiagnosis(document.getElementById('<%=txtDiagnosis.ClientID%>').value, OnDiagnosisSuccess);
            }
            else {
                fetchAllDiagnosisBtn();
            }

        }

        function addMedicines() {
            $("#medicinesBtn").empty();

            if (document.getElementById('<%=txtMedicines.ClientID%>').value != "") {
                PageMethods.searchMedicines(document.getElementById('<%=txtMedicines.ClientID%>').value, OnMedicinesSuccess);
            }
            else {
                fetchAllMedicinesBtn();
            }

        }

        function addAdvice() {
            $("#adviceBtn").empty();

            if (document.getElementById('<%=txtAdvice.ClientID%>').value != "") {
                PageMethods.searchAdvice(document.getElementById('<%=txtAdvice.ClientID%>').value, OnAdviceSuccess);
            }
            else {
                fetchAllAdviceBtn();
            }

        }

        function presDiagnoClick() {
            document.getElementById("diagnosis").style.display = "block";
            document.getElementById("medicines").style.display = "none";
            document.getElementById("advice").style.display = "none";
        }

        function presMediClick() {
            document.getElementById("medicines").style.display = "block";
            document.getElementById("diagnosis").style.display = "none";
            document.getElementById("advice").style.display = "none";
        }

        function presAdviceClick() {
            document.getElementById("advice").style.display = "block";
            document.getElementById("medicines").style.display = "none";
            document.getElementById("diagnosis").style.display = "none";
        }

        function btnSubmitCLick() {

            var diagnosis = "";
            var medicine = "";
            var morning = "";
            var afternoon = "";
            var evening = "";
            var night = "";
            var dose = "";
            var days = "";

            var advice = "";

            for (const li of document.querySelectorAll('#ulDiagnosis>li>.diagnosis-name')) {
                diagnosis += li.id + ",";
            }
            for (const li of document.querySelectorAll('#ulMedicines>li>.medicine-name')) {
                medicine += li.id + ",";
            }
            for (const sakal of document.querySelectorAll('#ulMedicines>li>.sakal')) {
                morning += sakal.value + ",";
            }
            for (const dupar of document.querySelectorAll('#ulMedicines>li>.dupar')) {
                afternoon += dupar.value + ",";
            }
            for (const sandyakal of document.querySelectorAll('#ulMedicines>li>.sandyakal')) {
                evening += sandyakal.value + ",";
            }
            for (const ratri of document.querySelectorAll('#ulMedicines>li>.ratri')) {
                night += ratri.value + ",";
            }
            for (const jevan of document.querySelectorAll('#ulMedicines>li>.jevan')) {
                dose += jevan.value + ",";
            }
            for (const day of document.querySelectorAll('#ulMedicines>li>.days')) {
                days += day.value + ",";
            }

            for (const li of document.querySelectorAll('#ulAdvice>li>.advice-name')) {
                advice += li.id + ",";
            }

            if (diagnosis == "" && medicine == "" && advice == "") {
                alert("Prescription is empty");
            }
            else {
                var x = confirm("Are you sure you want to save?");
                if (x) {
                    var id = document.getElementById('<%=lblPatientID.ClientID%>').innerHTML;
                            var aid = document.getElementById('<%=lblAppointmentID.ClientID%>').innerHTML;
                    PageMethods.btnSaveClick(id, diagnosis, medicine, morning, afternoon, evening, night, dose, days, advice, aid, OnSaveSuccess);
                    return false;
                }
                else {
                    return false;
                }
            }
        }

        function OnSaveSuccess(response) {
            if (response != "") {
                if (response == "Success") {
                    Print();
                    window.location.replace("OneDayList.aspx?action=insert");
                }
                else {
                    alert(response);
<%--                    document.getElementById('<%=pnlAlert.ClientID%>').classList = "alert alert-danger";
                    document.getElementById('<%=pnlAlert.ClientID%>').style.display = "block";
                    document.getElementById('<%=pnlAlert.ClientID%>').innerHTML = response;--%>
                }
            }
        }

        function Print() {
            $("#ulPrintDiagno").empty();
            $("#tblPrintMedicine").empty();
            $("#ulPrintAdvice").empty();
            var today = new Date();
            var dd = String(today.getDate()).padStart(2, '0');
            var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
            var yyyy = today.getFullYear();

            today = dd + '/' + mm + '/' + yyyy;

            document.getElementById('<%=printName.ClientID%>').innerHTML = document.getElementById('<%=lblName.ClientID%>').innerHTML;
            document.getElementById('<%=printPRN.ClientID%>').innerHTML = document.getElementById('<%=lblPRN.ClientID%>').innerHTML;
            document.getElementById('<%=printDate.ClientID%>').innerHTML = today;
            document.getElementById('<%=printAgeAndGender.ClientID%>').innerHTML = document.getElementById('<%=lblAge.ClientID%>').innerHTML;


            for (const li of document.querySelectorAll('#ulDiagnosis>li>.diagnosis-name')) {
                var list = document.createElement("li");
                var lblDiagnosis = document.createElement("lable");
                var d = new Date();
                var x = (d.getDate() + "" + d.getHours() + "" + d.getMinutes() + "" + d.getSeconds() + "" + d.getMinutes()) * Math.random();
                list.id = x + "d";
                lblDiagnosis.innerText = li.innerText;
                lblDiagnosis.style.fontSize = "20px";
                li.style.color = "#000";
                document.getElementById("ulPrintDiagno").appendChild(list);
                document.getElementById(list.id).appendChild(lblDiagnosis);
            }

            for (const li of document.querySelectorAll('#ulMedicines>li')) {
                var tblRow = "<td width=\"39%\"  class=\"pl-2\" style=\"color:#000;padding:4px 0\">" + li.children[0].innerText + "</td><td width=\"8%\" align=\"center\">" + ((li.children[1].value == 0.5) ? "1/2" : li.children[1].value) + "</td><td width=\"8%\" align=\"center\">" + ((li.children[2].value == 0.5) ? "1/2" : li.children[2].value) + "</td><td width=\"8%\" align=\"center\">" + ((li.children[3].value == 0.5) ? "1/2" : li.children[3].value) + "</td><td width=\"8%\" align=\"center\">" + ((li.children[4].value == 0.5) ? "1/2" : li.children[4].value) + "</td><td width=\"14%\" align=\"right\" style=\"color:#000;font-size:16px\">" + li.children[5].value + "</td><td width=\"15%\" align=\"right\" class=\"pr-2\">" + li.children[6].value + "</td>";
                var tr = document.createElement("tr");
                tr.setAttribute("style", "font-size:20px;color:#000;border-bottom:1px dashed #ccc");
                tr.innerHTML = tblRow;
                document.getElementById("tblPrintMedicine").appendChild(tr);
                //alert(li.children[0].innerText);
            }

            for (const li of document.querySelectorAll('#ulAdvice>li>.advice-name')) {
                var list = document.createElement("li");
                var lblAdvice = document.createElement("lable");
                var d = new Date();
                var x = (d.getDate() + "" + d.getHours() + "" + d.getMinutes() + "" + d.getSeconds() + "" + d.getMinutes()) * Math.random();
                list.id = x + "a";
                lblAdvice.innerText = li.innerText;
                lblAdvice.style.fontSize = "18px";
                lblAdvice.style.color = "#000";
                document.getElementById("ulPrintAdvice").appendChild(list);
                document.getElementById(list.id).appendChild(lblAdvice);
            }

           printDiv();
        }

        $(window).scroll(function () {
            var scroll = $(window).scrollTop();

            if (scroll >= 60) {
                $(".fixed-card").css("top", "65px");
            }
            else {
                $(".fixed-card").css("top", "150px");
            }
        });

        function printDiv() {
            var printContents = document.getElementById("printableArea").innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;
            window.print();
            document.body.innerHTML = originalContents;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <section class="content profile-page">
        <div class="block-header">
            <div class="row">
                <div class="col-lg-7 col-md-5 col-sm-12">
                    <h2>Patient Profile
                <small>Welcome to Fertility Clinic
                    <asp:Label ID="lblPatientID" runat="server" Text="0" ForeColor="#01d8da" Font-Size="1px"></asp:Label>
                    <asp:Label ID="lblAppointmentID" runat="server" Text="0" ForeColor="#01d8da" Font-Size="1px"></asp:Label>
                </small>
                    </h2>
                </div>
                <div class="col-lg-5 col-md-7 col-sm-12">
                    <ul class="breadcrumb float-md-right">
                        <li class="breadcrumb-item"><a href="index.html"><i class="zmdi zmdi-home"></i>Fertility Center</a></li>
                        <li class="breadcrumb-item"><a href="OneDayList.aspx">Patients</a></li>
                        <li class="breadcrumb-item active">Patient Profile</li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="container-fluid">
            <div class="row clearfix">
                <div class="col-lg-2 col-md-12 col-sm-12">
                    <div class="card member-card">
                        <div class="header l-coral" style="min-height: 130px">
                            <span class="font-20 font-weight-normal m-t-10">
                                <asp:Label ID="lblPRN" runat="server" Text=""></asp:Label>
                            </span>
                        </div>
                        <div class="member-img">
                            <a href="patient-invoice.html">
                                <img id="imgPatientPhoto" src="../images/female.png" runat="server" class="rounded-circle" alt="profile-image">
                            </a>
                        </div>
                        <div class="body">
                            <span class="font-16 font-weight-normal">
                                <asp:Label ID="lblName" runat="server" Text="" ForeColor="#f96332"></asp:Label>
                            </span>
                            <hr>
                            <strong>Age</strong>
                            <p>
                                <asp:Label ID="lblAge" runat="server" Text=""></asp:Label>
                            </p>
                            <strong>Address</strong>
                            <p>
                                <asp:Label ID="lblAddress" runat="server" Text=""></asp:Label>
                            </p>
                            <strong>Mobile</strong>
                            <p>
                                <asp:Label ID="lblMobiles" runat="server" Text=""></asp:Label>
                            </p>
                            <strong>Register Date</strong>
                            <p>
                                <asp:Label ID="lblDOR" runat="server" Text=""></asp:Label>
                            </p>
                        </div>
                    </div>
                    <div class="card" id="timeline">
                        <div class="body">
                            <div class="header">
                                <h2>Previous<strong> Checkup</strong></h2>
                            </div>
                            <div class="timeline-body">
                                <div class="timeline m-border">
                                    <asp:Repeater ID="rptrCheckup" runat="server">
                                        <ItemTemplate>
                                            <div class="timeline-item randomColor">
                                                <div class="item-content">
                                                    <div class="text-small">
                                                        <asp:Label ID="lbl6" CssClass="booking-date" runat="server" Text='<%#  Eval("bookingDate") %>'></asp:Label></td>
                                                    </div>
                                                    <p>
                                                        <asp:Label ID="Label1" runat="server" Text='<%# (Container.ItemIndex) == 0 ? "First Visit" : "Routine Checkup" %>'></asp:Label></td>
                                                    </p>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-7 col-md-12 col-sm-12">
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <asp:Panel ID="pnlAlert" runat="server" class="" role="alert" Style="display: none">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close" style="padding-top: 10px"><span aria-hidden="true">&times;</span></button>
                            <asp:Label ID="lblalert" runat="server" Text="" Font-Bold="true"></asp:Label>
                        </asp:Panel>
                    </div>
                    <div class="card" id="oldPrescription" runat="server">
                        <div class="body">
                            <p>
                                Last visit on
                                <asp:Label ID="lblLastVisit" runat="server" Text="" Font-Bold="true" ForeColor="Gray"></asp:Label>

                            </p>
                            <div class="row">
                                <div class="col-lg-5">
                                    <p style="color:#00cfd1;font-weight:500">Diagnosis</p>
                                    <ul class="dashed" id="ulOldDigno" style="border-right: 1px dashed #c8c8c8">
                                        <asp:Repeater ID="rptrHistoryDigno" runat="server">
                                            <ItemTemplate>
                                                <li>
                                                    <asp:Label ID="lbl1" runat="server" Text='<%# Eval("diagnosis") %>'></asp:Label>
                                                </li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ul>
                                </div>
                                
                                <div class="col-lg-7">
                                    <p style="color:#00cfd1;font-weight:500">Medication</p>
                                    <ul class="dashed" id="ulOldMedi">
                                        <asp:Repeater ID="rptrHistoryMedi" runat="server">
                                            <ItemTemplate>
                                                <li>
                                                    <div class="row">
                                                        <div class="col-lg-6 align-left">
                                                            <asp:Label ID="lbl1" runat="server" Text='<%# Eval("medicineName") %>'></asp:Label>
                                                        </div>
                                                        <div class="col-lg-3 align-center">
                                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("morning") + "-" + Eval("afternoon") + "-" + Eval("evening") + "-" + Eval("night")%>'></asp:Label>
                                                        </div>
                                                        <div class="col-lg-3 align-center">
                                                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("days") + " days" %>'></asp:Label>
                                                        </div>
                                                    </div>                                                    
                                                </li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="todayPrescription" class="card card-prescription" runat="server">
                        <div class="body">
                            <div class="header" style="padding: 0 0 20px;">
                                <h2>Patient <strong>Prescription</strong></h2>
                            </div>
                            <div id="presDiagno" onclick="presDiagnoClick()">
                                <small class="font-weight-bold colorblue">Diagnosis :</small>
                                <div style="margin-bottom: 10px"></div>
                                <ul id="ulDiagnosis" class="pl-4" style="color:#000"></ul>
                            </div>
                            <hr />
                            <div id="presMedi" onclick="presMediClick()">
                                <small class="font-weight-bold colorblue">Medicines :</small>
                                <div style="margin-bottom: 10px"></div>
                                <div class="pl-4">
                                    <div class="row  pres-header">
                                        <div class="col-3" style="padding: 0 15px; margin: 0"></div>
                                        <div class="col-1">सकाळी</div>
                                        <div class="col-1">दुपारी</div>
                                        <div class="col-1">संध्याकाळी</div>
                                        <div class="col-1">रात्री</div>
                                        <div class="col-1"></div>
                                        <div class="col-3 align-right"></div>
                                    </div>
                                    <hr class="mt-0 mb-1" />
                                </div>
                                <ul id="ulMedicines" class="pl-4"></ul>
                            </div>
                            <hr />
                            <div id="presAdvice" onclick="presAdviceClick()">
                                <small class="font-weight-bold colorblue">Advice :</small>
                                <div style="margin-bottom: 10px"></div>
                                <ul id="ulAdvice" class="pl-4"></ul>
                            </div>

                            <div class=" align-center">
                                <button type="button" class="btn btn-primary waves-effect waves-light btn-round" onclick="btnSubmitCLick()">Submit</button>
                            </div>

                            <div id="printableArea" style="display:none;font-size:20px">
                                <div>
                                <hr style=" border:2px solid #000"/>
                                    <table width="96%" align="center">                                        
                                        <tr>
                                            <td width="13%" style="font-size:20px"><b>PRN</b></td>
                                            <td width="2%" style="font-size:20px">:</td>
                                            <td width="30%" style="font-size:20px"><asp:Label ID="printPRN" runat="server" ForeColor="Black"></asp:Label></td>
                                            <td width="13%" style="font-size:20px"><b>Date</b></td>                                            
                                            <td width="2%" style="font-size:20px">:</td>
                                            <td width="30%" style="font-size:20px"><asp:Label ID="printDate" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td width="13%" style="font-size:20px"><b>Name</b></td>
                                            <td width="2%" style="font-size:20px">:</td>
                                            <td width="13%" style="font-size:20px"><asp:Label ID="printName" runat="server" Font-Bold="true" ForeColor="Black"></asp:Label></td>
                                            <td width="30" style="font-size:20px"><b>Age & Gender</b></td>
                                            <td width="52" style="font-size:20px">:</td>
                                            <td width="30%" style="font-size:20px"><asp:Label ID="printAgeAndGender" runat="server"></asp:Label></td>
                                        </tr>
                                    </table>
                                <hr/>
                                <table width="96%" align="center">
                                    <tr>
                                        <td >
                                            <span style="font-weight: bold;">Diagnosis :</span>
                                            <ul id="ulPrintDiagno" class="mt-2"></ul>
                                        </td>
                                    </tr>
                                </table>
                                <table width="96%" align="center">
                                    <tr>
                                        <td colspan="7">
                                            <span style="font-weight: bold" class="mb-2">Medication :</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="7"></td>
                                    </tr>
                                    <tr style="font-size:16px;color:#000;">
                                        <td width="39%" class="pl-2"></td>
                                        <td width="8%" align="center">सकाळी</td>
                                        <td width="8%" align="center">दुपारी</td>
                                        <td width="8%" align="center">संध्याकाळी</td>
                                        <td width="8%" align="center">रात्री</td>
                                        <td width="14%" align="center"></td>
                                        <td width="15%" align="right" class="pr-2"></td>
                                    </tr>
                                    <tr><td colspan="7"><hr style="margin:5px 0"/></td></tr>                                    
                                </table>
                                <table width="96%" align="center" id="tblPrintMedicine">
                                </table>
                                <table width="96%" align="center">
                                    <tr><td colspan="7" style="font-size:8px">&nbsp</td></tr>  
                                    <tr>
                                        <td >
                                            <span style="font-weight: bold;">Advice :</span>
                                            <ul id="ulPrintAdvice" class="mt-2"></ul>
                                        </td>
                                    </tr>
                                </table>
                                <table width="96%" align="center">
                                    <tr><td>&nbsp</td></tr>
                                    <tr><td>&nbsp</td></tr>
                                    <tr><td align="right"><b>Dr. Suresh Kamble</b></td></tr>
                                </table>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-3 col-md-12 col-sm-12">
                    <div class="card h-100">
                        <div class="fixed-card">
                            <div class="scroll-card">
                                <div class="header pb-0">
                                    <h2><strong>Search</strong></h2>
                                </div>
                                <div class="body" id="diagnosis">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="form-group">
                                                <input id="txtDiagnosis" type="text" class="form-control" runat="server" onkeypress="return addDiagnosis()" placeholder="Diagnosis" />
                                                <span id="diagnoSave" class="font-bold pr-2 float-right pt-2" style="cursor:pointer;color:#ff758e;text-decoration:underline;display:none" onclick="insertDiagnosis()">Save</span>
                                                <label id="lblDiagnoError" style="padding: 5px 0 5px 20px;font-size: 12px;color: red;display:none">Already Exist !</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="diagnosisBtn"></div>
                                </div>
                                <div class="body" id="medicines">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="form-group">
                                                <input id="txtMedicines" type="text" class="form-control" runat="server" onkeypress="return addMedicines()" placeholder="Medicines" />
                                                <span id="mediSave" class="font-bold pr-2 float-right pt-2" style="cursor:pointer;color:#FFB236;text-decoration:underline;display:none" onclick="insertMedicine()">Save</span>
                                                <label id="lblMediError" style="padding: 5px 0 5px 20px;font-size: 12px;color: red;display:none">Already Exist !</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="medicinesBtn"></div>
                                </div>
                                <div class="body" id="advice">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="form-group">
                                                <input id="txtAdvice" type="text" class="form-control" runat="server" onkeypress="return addAdvice()" placeholder="Advice" />
                                                <span id="adviceSave" class="font-bold pr-2 float-right pt-2" style="cursor:pointer;color:#50d38a;text-decoration:underline;display:none" onclick="insertAdvice()">Save</span>
                                                <label id="lblAdviceError" style="padding: 5px 0 5px 20px;font-size: 12px;color: red;display:none">Already Exist !</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="adviceBtn"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </section>
    <%--<script src="assets/bundles/libscripts.bundle.js"></script>--%>
    <!-- Bootstrap JS and jQuery v3.2.1 -->
</asp:Content>