<%-- 
    Document   : listsample
    Created on : Dec 5, 2018, 2:32:19 PM
    Author     : Amol
--%>

<%@page import="java.sql.Connection"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true" errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Jalyukt Abhiyan</title>
        <link rel="icon" type="image/png" href="images/mrsacLogo.jpg"/>
        <!--<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css"/>-->
<!--        <link rel="stylesheet" type="text/css" href="css/tabs.css"/>
        <link rel="stylesheet" type="text/css" href="css/username.css"/>
        <script type="text/javascript" src="js/pagesize.js"></script>
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/username_div.js"></script>
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <link href="css/popup.css" type="text/css" rel="stylesheet"/>-->

        <script>
            function setzoomSelectVill()
            {
//                document.getElementById("dataentrycontent").style.display = "none";
//                document.getElementById("showMobileDiv").style.display = "none";
                document.getElementById("popup1").style.display = "none";
//                var winH = window.innerHeight;
////                alert(winH);
//                document.getElementById('bodyall').style.height = (winH - 152) + "px";
//                var winW = window.innerWidth;
//                dataentrycontent
//                alert(winW);
//                document.getElementById('mahamap').style.height = ((winW / 12) * 2.2) + "px";
//                document.getElementById('mahamap').style.width = ((winW / 12) * 2.65) + "px";
//                hideDataEntryDiv();
            }

        </script>
        <script type="text/javascript">

        </script>
        <script language="javascript">

            function addOption(selectbox, text, value)
            {
                var optn = document.createElement("OPTION");
                optn.text = text;
                optn.value = value;
                selectbox.options.add(optn);
            }
            function addText(selectbox, text, value)
            {
                var optn = document.createElement("INPUT");
                optn.text = text;
                optn.id = value;

                selectbox.input.add(optn);
            }

            function removeOption(listbox, i)
            {
                listbox.remove(i);
            }

//            function addOption_list() {
//                for (i = document.drop_list.Category.options.length - 1; i >= 0; i--) {
//                    var Category = document.drop_list.Category;
//                    if (document.drop_list.Category[i].selected) {
//                        document.getElementById("Subcat").value;
////                        addText(document.drop_list.SubCat,
////                                document.drop_list.Category[i].text,
////                                document.drop_list.Category[i].value);
////                                
////                                                alert(document.drop_list.Category[i].value);
//                        removeOption(Category, i);
//                    }
//                }
//            }
            function addOption_list() {
                var optn = document.createElement("Input");
                for (i = document.drop_list.Category.options.length - 1; i >= 0; i--) {
                    var Category = document.drop_list.Category;
                    if (document.drop_list.Category[i].selected) {
                        addOption(document.drop_list.SubCat,
                                document.drop_list.Category[i].text,
                                document.drop_list.Category[i].value);

//                        addText(document.drop_list.SubCat,
//                                document.drop_list.Category[i].text,
//                                document.drop_list.Category[i].value);
//                                                alert(document.drop_list.Category[i].value);
                        removeOption(Category, i);
                    }
                }
            }
            function removeOption_list() {
                for (var i = document.drop_list.SubCat.options.length - 1; i >= 0; i--) {
                    var SubCat = document.drop_list.SubCat;
                    if (document.drop_list.SubCat[i].selected) {
                        addOption(document.drop_list.Category,
                                document.drop_list.SubCat[i].text,
                                document.drop_list.SubCat[i].value);
                        //                        alert(document.drop_list.Category[i].value);
                        removeOption(SubCat, i);
                    }
                }
            }


            function move_all_Option() {
                for (var i = document.drop_list.Category.options.length - 1; i >= 0; i--) {
                    var Category = document.drop_list.Category;
                    addOption(document.drop_list.SubCat,
                            document.drop_list.Category[i].text,
                            document.drop_list.Category[i].value);

                }
                removeAllOptions(document.drop_list.Category);
            }

            function remove_all_Option() {
                for (var i = document.drop_list.SubCat.options.length - 1; i >= 0; i--) {
                    var SubCat = document.drop_list.SubCat;
                    addOption(document.drop_list.Category,
                            document.drop_list.SubCat[i].text,
                            document.drop_list.SubCat[i].value);

                }
                removeAllOptions(document.drop_list.SubCat);
            }



            function removeAllOptions(selectbox)
            {
                var i;
                for (i = selectbox.options.length - 1; i >= 0; i--)
                {
                    //selectbox.options.remove(i);
                    selectbox.remove(i);

                }
            }
            function getValue(selectbox) {
                if (document.getElementById("SubCat") != "") {
                    //             var a;
//                var a = document.getElementById("id_getvillvalue").value;
                    document.getElementById("popup1").style.display = "block";
                    var table = document.getElementById("table1");

                    //    document.getElementById("demo").innerHTML = "You selected: " + x;

                    for (var i = 0; i <= selectbox.options.length; i++) {
                        var SubCat = document.drop_list.SubCat;
                        //            for(var j=0;j<=SubCat.lenght;j++){
                        var str = document.drop_list.SubCat[i].value;
                        var txt = document.drop_list.SubCat[i].text;
                        //                var str1=str.split(",");
                        //                
                        //                

                        var rowCount = table.rows.length;
                        var row = table.insertRow(rowCount);
                        var cell1 = row.insertCell(0);
                        cell1.innerHTML = rowCount + 1;

                        var cell2 = row.insertCell(1);
                        var element1 = document.createElement("input");
                        element1.type = "text";
                        element1.style = "height:20px;";
//            element1.name="villcode[]";
                        element1.value = txt;
                        element1.disabled = "disabled";

                        cell2.appendChild(element1);



                        var cell3 = row.insertCell(2);
                        var element2 = document.createElement("input");
                        element2.type = "text";
                        element2.name = "order_no[]";
                        element2.placeholder = "Order No";
                        element2.required = "true";
                        element2.style = "height:20px;";
//            element2.name = "txtbox[]";
//            element2.placeholder = "à¤®à¤°à¤¾à¤ à¥€ à¤—à¤¾à¤µà¤¾à¤šà¥‡ à¤¨à¤¾à¤µ";
//            element2.requied = "true";
//            element2.disabled="disabled";
                        cell3.appendChild(element2);

                        var cell4 = row.insertCell(3);
                        var element3 = document.createElement("input");
//            element3.type = "text";
//            element3.name = "order_no[]";
//            element3.placeholder = "à¤†à¤¦à¥‡à¤¶ à¤•à¥à¤°.";
//            element3.required = "true";
                        element3.type = "hidden";
                        element3.name = "villcode[]";
                        element3.value = str;
                        cell4.appendChild(element3);

// var cell5 = row.insertCell(4);
//            var element5 = document.createElement("input");
//            element5.type = "hidden";
//            element5.name="villcode[]";
//            element5.value=str;
////            element1.disabled="disabled";
//            cell5.appendChild(element5);
//                
                        //                    alert(str);
                        //            var str1[]=str;

//                    document.getElementById("id_getvillvalue").innerHTML += str + ",";
                        //            alert(str1);


                    }

                } else {
                    alert("please select villages");
                    return false;
                }
            }
            function getSelValue() {
//                var tblData = new Array();
                var table = document.getElementById("table1");
                var i;
                var txt;
                var txt2;
                var tr = table.getElementsByTagName('tr');
                for (i = 0; i < tr.length; i++) {
                    var td = tr[i].getElementsByTagName('td');
                    var td2 = td[1].childNodes[0].value;
                    var td1 = td[0].childNodes[0].value;
                    var td3 = td[2].childNodes[0].value;
                    var val = td2 + td3;

                    if (td2 != "" && td3 != "") {
                        document.getElementById("frm_select_vill").submit();

                    } else {
                        td3.focus();
//                td1.focus();
//                td3.focus();
                        return false;
                    }
//            alert(val);

                }
            }
            function delValue(selectbox) {
//                if( document.getElementById("SubCat").value==""){
                for (var i = 0; i <= document.drop_list.SubCat.options.length; i++) {
                    var SubCat = document.drop_list.SubCat;
                    if (document.drop_list.SubCat[i].selected) {
//                        addOption(document.drop_list.SubCat,
//                                document.drop_list.Category[i].text,
                        var str = document.drop_list.SubCat[i].value;

                        document.getElementById("id_delvalue").innerHTML += str + ",";
//                                        );
//                                        alert(str);
//                                        
                        document.getElementById("showMobileDiv").style.display = "block";
                        document.getElementById("dataentrycontent").style.display = "none";
                        //                        alert(document.drop_list.Category[i].value);
//                        removeOption(Category, i);
                    }
                    else {
//                        alert("please select the villages for deletion");
                    }
//                }
                }
            }
            function hideSelected() {

                var table = document.getElementById("table1");

                var rowCount = table.rows.length;
//        var j = rowCount.parentNode.parentNode.rowIndex;
//       alert(rowCount);

                for (var i = rowCount - 1; i >= 0; i--) {
//           alert(i);
                    document.getElementById("table1").deleteRow(i);

                }
                document.getElementById("popup1").style.display = "none";

//        for (var i = rowCount; i>=0; i--) {
////           var td = tr[i].getElementsByTagName('td');
////            var td2 = td[1].childNodes[0].value;
////            var td1 = td[0].childNodes[0].value;
////           var td3 = td[2].childNodes[0].value;
// 
//    document.getElementById("table1").deleteRow(i);
//        }
//                  document.getElementById("table1").removeChild(i);
//                }
//                document.getElementById("popup1").style.display="none";
////                 document.getElementById("table1").style.display="none";
//                 document.getElementById("frm_select_vill").reset();
//                 document.getElementById("table1").innerHTML="";
            }
        </script>
        <script>
            function sel_District() {
                var xmlhttp;
                //    var idDistrict = document.getElementById("id_district").value;
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp = new XMLHttpRequest();
                }
                else
                {// code for IE6, IE5
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                var urls = "delete_all_location.jsp?loc_dist";
                //    var urls = "loc_district.jsp";
                //    var urls = "loc_district.jsp?idDistrict=" + idDistrict;
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                    {
                        var resp = xmlhttp.responseText;
                        document.getElementById("id_sel_district").innerHTML = resp;
                        //            document.getElementById("id_disease_type").value="-1";
                        sel_Village();
                        //            diseaseType();
                    }
                };
                //    xmlhttp.open("GET", urls, true);
                xmlhttp.open("POST", urls, true);
                xmlhttp.send();
            }
            function sel_Tehsil() {
                var xmlhttp;
                var idDistrict = document.getElementById("id_sel_district").value;
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp = new XMLHttpRequest();
                }
                else
                {// code for IE6, IE5
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                var urls = "delete_all_location.jsp?idDistrict=" + idDistrict;
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                    {
                        var resp = xmlhttp.responseText;
                        document.getElementById("id_sel_tehsil").innerHTML = resp;
//                                    document.getElementById("SubCat").innerHtml="";
                        sel_Village();

                        //            diseaseType();
                    }
                };
                //    xmlhttp.open("GET", urls, true);
                xmlhttp.open("POST", urls, true);
                xmlhttp.send();
            }
            function sel_Village() {
                var xmlhttp;
                var id_tehsil = document.getElementById("id_sel_tehsil").value;
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp = new XMLHttpRequest();
                }
                else
                {// code for IE6, IE5
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                var urls = "delete_all_location.jsp?id_sel_Tehsil=" + id_tehsil;
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                    {
                        var resp = xmlhttp.responseText;
                        //            alert(resp);
                        document.getElementById("id_sel_village").innerHTML = resp;
                    }
                };
                //    xmlhttp.open("GET", urls, true);
                xmlhttp.open("POST", urls, true);
                xmlhttp.send();
            }</script>

        <style>

            .btnSaveSelected{
                float: right;margin-right: 25%;padding: 3px 8px;font-size: 18px;line-height: 1.33;  border-radius: 6px;cursor: pointer;    color: #fff;   background-color: #428bca;    border-color: #357ebd;
            }
            .btnDeleteSelected{
                width:80px;float: right;margin-right: 20%;padding: 3px 8px;   font-size: 18px;line-height: 1.33;  border-radius: 6px;cursor: pointer;    color: #fff;   background-color: #428bca;    border-color: #357ebd;
            }
            .btnShift{
                width:70%;margin-left: 10%;margin-right: 10%;padding: 3px 8px;   font-size: 18px;line-height: 1.33;  border-radius: 6px;cursor: pointer;    color: #fff;   background-color: #428bca;    border-color: #357ebd;
            }
            /*            .btnSaveSelected:hover{
                            background-color: #777;
                            border: 1px solid #428bca;
                        }*/
            #id_MainDiv{
                margin: 0 auto;
                width: 95%;
                /*border: 1px solid gainsboro;*/
                height: auto;padding: 0;
                font-size: 13px;
            }
            table#table1{
                width: 100%;
                /*text-align: center;*/
                /*overflow: auto;*/
                font-size: 13px;

            }
            table#table1 thead  {
                cursor: pointer;
            }
            table#table1 tr:nth-child(even) {
                background-color: #eee;
            }
            table#table1 tr:nth-child(odd) {
                background-color:#fff;
            }
            table#table1 th	{
                background-color: #428bca;
                color: white;
                border: 2px solid #ccc;
                text-align: center;
                font-weight: 600;
                /*font-size: 15px;*/
            }
            table#table1 td{
                border: 2px solid gainsboro;
            }
        </style>
    </head>
    <body  onload="setzoomSelectVill();
            sel_District();" >
        <%
            String username = session.getAttribute("username").toString();

            String userid = session.getAttribute("uid").toString();

            Connection dh = null;
            try {

        %>
        <div id="id_MainDiv" >
            <div id="id_headerDiv" style="float:left;width: 100%;">
                <%--<jsp:include page="admin_header.jsp"></jsp:include>--%>
                </div>
                <div id="id_ContentDiv" style="float:left;width: 100%;">
                    <div id="bodyall" style="width: 100%;background: white; margin: 0 auto;height: auto; min-height: 80vh;-moz-transition:-moz-transform 0.5s ease-in; -webkit-transition:-webkit-transform 0.5s ease-in; -o-transition:-o-transform 0.5s ease-in;">                  


                        <div style="height: 30px;width:95%; margin: 0 auto;">
                            <h4> <span style="margin-left:40%;width: 100%;float: left;color: #08c;text-underline-position: auto;"> <a style="text-decoration: none;font-size: 16px;">à¤—à¤¾à¤µ à¤µà¤—à¤³à¤£à¥à¤¯à¤¾à¤šà¥€ à¤ªà¥à¤°à¤•à¥à¤°à¤¿à¤¯à¤¾ à¥¨à¥¦à¥§à¥¬-à¥¨à¥¦à¥§à¥­</a></span></h4>
                        </div>
                        <!--<div  style="width:100%; background: white; margin: 0 auto; -moz-transition:-moz-transform 0.5s ease-in; -webkit-transition:-webkit-transform 0.5s ease-in; -o-transition:-o-transform 0.5s ease-in;">-->                  
                        <div  style="width: 100%;border-radius: 1px;background:none;padding-bottom:  1%;float: left;color: black; border:none; z-index:0; margin: 0 auto; text-align: justify;border-bottom:  1px solid #00887c;">
                            <br>
                            <div style="float: left;width: 15%;">
                                <label style="font-weight: 600;color:#777;float: right;margin-top: 1%;margin-right: 5%;">à¤¦à¤¿à¤¨à¤¾à¤‚à¤• :- </label>
                            </div>
                            <div style="float: left;width: 15%;">
                            
                            
                        </div>
                        <div style="float: left;width: 8%;">
                            <label style="font-weight: 600;color:#777;float: right;margin-top: 1%;margin-right: 5%;"> à¤œà¤¿à¤²à¥à¤¹à¤¾ </label>
                        </div>
                        <%
                            ConnectionDB conn = new ConnectionDB();
                            dh = conn.getConnection();

                        %>
                        <div style="float: left;width: 14%;">
                            <select name="district" id="id_sel_district" onchange="sel_Tehsil();
                                    errorBlank('err_district')" style=" margin-left: 0%; display: block;width: 100%;height: 34px;padding: 2px 12px;font-size: 14px;line-height: 1.428571429;color: #555;vertical-align: middle;background-color: #fff;border: 1px solid #ccc;border-radius: 4px;-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);-webkit-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;"  >
                                <option value="-1">à¤œà¤¿à¤²à¥à¤¹à¤¾ à¤¨à¤¿à¤µà¤¡à¤¾ </option>
                            </select>
                        </div>

                        <div style="float: left;width: 8%;">
                            <label style="font-weight: 600;color:#777;float: right;margin-top: 1%;margin-right: 5%;">à¤¤à¤¾à¤²à¥à¤•à¤¾ </label>
                        </div>
                        <div style="float: left;width: 14%;">
                            <select  id='id_sel_tehsil'  name="tehsilcode" onchange="sel_Village()" style=" margin-left: 0%; display: block;width: 100%;height: 34px;padding: 2px 12px;font-size: 14px;line-height: 1.428571429;color: #555;vertical-align: middle;background-color: #fff;border: 1px solid #ccc;border-radius: 4px;-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);-webkit-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;" >
                                <option value="-1">à¤¤à¤¾à¤²à¥à¤•à¤¾ à¤¨à¤¿à¤µà¤¡à¤¾ </option>

                            </select>
                        </div>
                        <!--                                                     <div style="float: left;width: 8%;">
                                                                                    <label style="font-weight: 600;color:#777;float: right;margin-top: 1%;margin-right: 5%;"> à¤—à¤¾à¤µ </label>
                                                                                </div>
                                                                                <div style="float: left;width: 14%;">
                                                                                    <select  id='id_sel_village'  name="villagecode"  style=" margin-left: 0%; display: block;width: 100%;height: 34px;padding: 2px 12px;font-size: 14px;line-height: 1.428571429;color: #555;vertical-align: middle;background-color: #fff;border: 1px solid #ccc;border-radius: 4px;-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);-webkit-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;" >
                                                                                        <option value="-1">à¤—à¤¾à¤µ  à¤¨à¤¿à¤µà¤¡à¤¾ </option>
                                                                                        
                                                        </select>
                                                    </div>-->
                        <div style="float: left;width: 10%;">
                            <!--<input type="button" value="à¤®à¤¾à¤¹à¤¿à¤¤à¥€ à¤¨à¥‹à¤‚à¤¦à¤µà¤¾"  style="margin-left: 10%;padding: 3px 8px;   font-size: 18px;line-height: 1.33;  border-radius: 6px;cursor: pointer;    color: #fff;   background-color: #428bca;    border-color: #357ebd;" onclick="return showContent11();"/>-->
                        </div>
                    </div>

                    <div id="dataentrycontent" style="border-radius: 1px;background:none;padding-bottom:  1%; color: black; border:none; z-index:0; margin: 0 auto; text-align: justify;width: 100%;float: left;margin-top: 2%;">
                        <div style="    width: 720px;margin: 0 auto;">
                            <form name="drop_list" action="<%=request.getContextPath()%>/getselvill.do" method="post">
                                <!--<input onclick="addOption_all_list()" ;="" value="Add All" type="button">--> 
                                 
                                <div style="width: 35%;float: left;margin-right: 5%">
                                    <div style="border: 1px solid #428bca;width: 100%;float: left;">
                                        <label style="float: left;font-size: 16px;font-weight: 600;margin-left: 10%;">à¤¨à¤¿à¤µà¤¡à¤²à¥‡à¤²à¥€ à¤—à¤¾à¤µà¥‡
                                            <br>
                                            <span style="font-size:14px;">( à¤¤à¤¾à¤²à¥à¤•à¥à¤¯à¤¾à¤®à¤§à¥€à¤² à¤—à¤¾à¤µà¤¾à¤‚à¤šà¥€ à¤¯à¤¾à¤¦à¥€ )</span>
                                        </label>
                                        <!--                                            <label style="float: left;font-size: 14px;font-weight: 600;margin-left: 10%;">( à¤¤à¤¾à¤²à¥à¤•à¥à¤¯à¤¾à¤®à¤§à¥€à¤² à¤—à¤¾à¤µà¤¾à¤‚à¤šà¥€ à¤¯à¤¾à¤¦à¥€)</label>-->
                                    </div>
                                    <div style="width: 100%;float: left;">
                                        <select name="Category" id="id_sel_village" multiple="multiple" size="15" style="width: 100%;min-height: 300px;height: auto;float: right;border: 1px solid #428bca;cursor: pointer;overflow: scroll;">

                                        </select>&nbsp;</div>
                                </div>
                                <div style="width: 10%;float: left;margin-top: 10%;">
                                    <div style="width: 100%;float: left;margin-bottom: 5%;">
                                        <input onclick="addOption_list();" value=">" type="button" class="btnShift" > 
                                        <!--<input onclick="addOption_list();" value=">" type="button" style="width: 100%" >--> 
                                    </div>
                                    <div style="width: 100%;float: left;margin-bottom: 5%;">
                                        <input onclick="move_all_Option()" value=">>" type="button" class="btnShift">
                                        <!--<input onclick="move_all_Option()" value=">>" type="button" style="width: 100%">-->
                                    </div>
                                    <div style="width: 100%;float: left;margin-bottom: 5%;">
                                        <input onclick="removeOption_list()" value="<" type="button" class="btnShift">
                                        <!--<input onclick="removeOption_list()" value="<" type="button" style="width: 100%">-->
                                    </div>
                                    <div style="width: 100%;float: left;">
                                        <input onclick="remove_all_Option()" value="<<" type="button" class="btnShift">
                                        <!--<input onclick="remove_all_Option()" value="<<" type="button" style="width: 100%">-->
                                    </div>
                                </div>
                                <div style="width: 35%;float: left;margin-left: 5%;">
                                    <div style="border: 1px solid #428bca;width: 100%;float: left;">
                                        <label style="float: left;font-size: 16px;font-weight: 600;margin-left: 10%;"> à¤µà¤—à¤³à¤²à¥‡à¤²à¥€  à¤—à¤¾à¤µà¥‡
                                            <br>
                                            <span style="font-size:14px;">( à¤¤à¤¾à¤²à¥à¤•à¥à¤¯à¤¾à¤®à¤§à¥€à¤² à¤—à¤¾à¤µà¤¾à¤‚à¤šà¥€ à¤¯à¤¾à¤¦à¥€ )</span>
                                        </label>
                                        <!--<label style="float: left;font-size: 14px;font-weight: 600;margin-left: 10%;">( à¤¨à¤¿à¤µà¤¡à¤²à¥‡à¤²à¥€ à¤—à¤¾à¤µà¥‡ )</label>-->
                                    </div>
                                    <div style="width: 100%;float: left;">
                                        <select id="SubCat" name="SubCat"  multiple="multiple" size="15" style="width:100%;min-height: 300px;height: auto;border: 1px solid #428bca;cursor: pointer;overflow: scroll ">

                                        </select>
                                        <!--                                            <span  id="foo" style="width:50%;cursor: pointer; "></span>-->

                                    </div>
                                </div>
                                <div style="width: 100%;float: left;">

                                    <!--<input type="button" value="Delete"  class="btnDeleteSelected">-->
                                    <!--<input type="button" value="Delete" onclick="delValue(SubCat);" class="btnDeleteSelected">-->
                                    <input type="button" value="Show Deleted" onclick="getValue(SubCat);" class="btnSaveSelected">
                                    <!--                                        <input type="submit" value="Save" onclick="getValue(SubCat);" class="btnSaveSelected">-->
                                    <!--<input type="submit" value="Save" onclick="getValue(SubCat);" style="width: 80px;float: right;margin-right: 2%;">-->
                                </div>
                                <!--<input onclick="removeAllOptions(SubCat)" value="Remove All" type="button">-->

                                <!--<input type="text"  id="getval">-->
                                <!--<select type="hidden" name="hiddenValue" id="hiddenValue"></select>-->
                                <textarea  id="id_getvillvalue" name="getvillvalue" style="display: none;"></textarea>
                                <!--<textarea  id="id_delvalue" name="delvillvalue" style="display: none;" ></textarea>-->
                            </form>
                        </div>
                    </div>
                </div>
                <div id="id_FooterDiv">
                    <jsp:include page="footer.jsp"></jsp:include>
                    </div>
                </div>
                <!--</div>-->
            </div>

            <div class="popup_sel_village" id="popup1">
                <div class="popup-inner_sel_village">
                    <div class="popupheading_sel_village">
                        <h2> à¤µà¤—à¤³à¤£à¥à¤¯à¤¾à¤¤ à¤†à¤²à¥‡à¤²à¥€ à¤—à¤¾à¤µà¥‡ à¥¨à¥¦à¥§à¥¬-à¥¨à¥¦à¥§à¥­</h2>
                    </div>
                    <form id="frm_select_vill" action="deletevillage.do" method="post">
                        <!--                <form id="frm_select_vill" action="getSelectedVill.jsp" method="get">-->
                        <!--<p id="generatedworkcode"></p>-->
                        <div class="generatecode_sel_village">

                            <table id="table1"  style="margin-top:5%;">

                            </table>
                            <!--<input type="text" id="generatedworkcode1" class="txtgeneratecode" readonly/>-->

                        </div>

                        <button class="btnclose" onclick=" return getSelValue();">Delete</button>
                        <input type="button" class="btnclose"  value="Close" onclick="hideSelected()">

                        <!--        <button class="btn"  onclick="hide()">Close</button>-->
                    </form>
                </div>
                <!--</div>-->


            </div>
        <% } catch (Exception e) {
                    System.out.println("Exception in creater user try catch block:-" + e.getMessage());
                } finally {
                    dh.close();
                }
           

        %>
    </body>
</html>
