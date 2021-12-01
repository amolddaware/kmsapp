<%-- 
    Document   : login
    Created on : Nov 15, 2017, 10:26:41 PM
    Author     : Amol
--%>

<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%ResourceBundle rb = ResourceBundle.getBundle("msg");
    response.addHeader("X-Frame-Options", "DENY");
//    if (session != null && session.getAttribute("username") != null) {
//        response.sendRedirect("workcontrol");
//    }
    String fail = "";
//    if (request.getParameter("fail") != null) {
//        fail = "Please enter correct Captcha";
//    }
    String jsessionid = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("JSESSIONID")) {
//                System.out.println("JSESSIONIDLoginpage=" + cookie.getValue());
                jsessionid = request.getSession().toString();
                break;
            }
        }
    }

//    RandomStringGenerator random=new RandomStringGenerator();
////    String captcha=random.getRandomCaptchaString(8);
////    
////    String captchaSplit[]=captcha.split("");
////    
////    String fullcaptcha=captchaSplit[0]+" "+captchaSplit[1]+" "+captchaSplit[2]+" "+captchaSplit[3]+" "+captchaSplit[4]+" "+captchaSplit[5]+" "+captchaSplit[6]+" "+captchaSplit[7];
//    
//    String captcha =random.getRandomStringGenerator();
//    System.out.println("captcha:-"+captcha);
//    String captchaSplit[]=captcha.split("");
////    
//    String fullcaptcha=captchaSplit[0]+" "+captchaSplit[1]+" "+captchaSplit[2]+" "+captchaSplit[3]+" "+captchaSplit[4]+" "+captchaSplit[5]+" "+captchaSplit[6]+" "+captchaSplit[7];
//    
//    String fail="";
    if (request.getParameter("fail") != null) {
        fail = "Incorrect Username or Password !!";
    }
//    
    request.setAttribute("jession", jsessionid);
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title><%=rb.getString("title")%></title>
        <!--        <link rel="stylesheet" href="node_modules/font-awesome/css/font-awesome.min.css" />
                <link rel="stylesheet" href="node_modules/perfect-scrollbar/dist/css/perfect-scrollbar.min.css" />-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery.perfect-scrollbar/0.8.1/css/perfect-scrollbar.min.css" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>

        <link rel="stylesheet" href="css/style.css" />
        <link rel="shortcut icon" href="images/Maharastra1.jpg" />
        <!--          <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
                  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>-->

        <link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
        <link href="css/jquery.multiselect.css" rel="stylesheet" />
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <link href="http://cdn.rawgit.com/davidstutz/bootstrap-multiselect/master/dist/css/bootstrap-multiselect.css"  rel="stylesheet" type="text/css" />
        <script src="js/jquery.multiselect.js"></script>
        <script>
            $(function () {

                $('#generaltag').keypress(function () {
                    $.ajax({
                        url: "jsonfile.jsp",
                        type: "post",
                        data: '',
                        success: function (data) {
                            $("#generaltag").autocomplete({
                                source: data
                            });

                        }, error: function (data, status, er) {
                            console.log(data + "_" + status + "_" + er);
                        },
                    });

                });

            });
        </script>
        <script>
            function showData() {
             document.getElementById("myForm").submit();
//                var xmlhttp;
//                var subject = document.getElementById("generaltag").value;
//                var fromDate = document.getElementById("fromDate").value;
//                var toDate = document.getElementById("toDate").value;
//                // var checkboxes = document.getElementsByName("chkkms");
//                //  var checkboxesChecked = [];
//                //  var checkedBoxes ;
//                var selected = $("#idCategory option:selected");
//                var message = "";
//                selected.each(function () {
//                    message += $(this).val() + ",\n";
//                    //                        message += $(this).text() + " " + $(this).val() + "\n";
//                });
//                //                    alert("message:-"+message);
//                //                    document.getElementById("idCategoryList").value=message;
//                //  // loop over them all
//                //  for (var i=0; i<checkboxes.length; i++) {
//                //     // And stick the checked ones onto an array...
//                //     if (checkboxes[i].checked) {
//                //       checkedBoxes= checkboxesChecked.push(checkboxes[i].value);
//                //     }
//                //  }
//                // var array = [];
//                //  $('input[type="checkbox"]:checked').each(function() {
//                //      array.push($(this).val());
//                //    });
//                //alert(array.join(','));
//                //var searchresult=array.join(',');
//                //var checkedBoxes = document.querySelectorAll('input[name=chkkms]:checked');
//                //alert(searchresult);
//                if (subject != "") {
//                    if (window.XMLHttpRequest)
//                    {// code for IE7+, Firefox, Chrome, Opera, Safari
//                        xmlhttp = new XMLHttpRequest();
//                    } else
//                    {// code for IE6, IE5
//                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
//                    }
//                    //                    var urls = "grid_all_data.jsp?generaltag=" + subject + "&fromdate=" + fromDate + "&todate=" + toDate;
//                    //                    var urls = "fetchdata_new_1.jsp?generaltag=" + subject;
//                    //                alert(urls);
//                    xmlhttp.onreadystatechange = function ()
//                    {
//                        if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
//                        {
//                            var resp = xmlhttp.responseText;
//                            //                        alert(resp);
//
//                            document.getElementById("fetchData").innerHTML = resp;
//
//                            document.getElementById("generaltag1").value = subject;
//                            document.getElementById("fromDate1").value = fromDate;
//                            document.getElementById("toDate1").value = toDate;
//
//                            //                        selectVillage();
//                            //            diseaseType();
//                        }
//                    };
//                    //    xmlhttp.open("GET", urls, true);
//                    xmlhttp.open("POST", "grid_category_all_data.jsp?generaltag=" + subject + "&fromdate=" + fromDate + "&todate=" + toDate + "&searchresult=" + message, true);
//                    xmlhttp.send();
                } else {

                    document.getElementById("errGeneral").innerHTML = "Please enter the value";
                    document.getElementById("generaltag").focus();
                    return false;
                    //                alert("Please enter data");
                }
            }</script>
        <style>.chk{cursor: pointer;}
            .txtSearch{
                width:90%;font-size:0.8rem;border-radius: 3px;padding: 12px 6px;line-height: 1.628571429;color: #000;vertical-align: middle;background-color: #fff;margin-top: 7px;border: none;
            }
            .txtFrom{
                width:70%;font-size:0.8rem;border-radius: 3px;padding: 12px 6px;line-height: 1.428571429;color: #000;vertical-align: middle;background-color: #fff;border: none;
            }
            .txtTo{
                width:70%;font-size:0.8rem;border-radius: 3px;padding: 12px 6px;line-height: 1.428571429;color: #000;vertical-align: middle;background-color: #fff;border: none;
            }
            .txtCmbCategory{
                width:100%;display: block;border: none;font-size:0.8rem;border-radius: 3px;padding: 12px 6px; line-height: 1.428571429;color: #000;vertical-align: middle;background-color: #fff;border: 0.5px solid  #00b8e6 ;-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,0.075); box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);-webkit-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            }
            .txtSearch:enabled {
                width:100%;display: block;border-radius: 3px;padding: 12px 6px;line-height: 1.428571429;color: #000;vertical-align: middle;background-color: #fff;margin-top: 7px;
            }
            .divSearch{
                border-radius: 2px;
                -webkit-box-shadow: inset 0 2px 2px rgba(0,0,0,0.075); box-shadow: inset 0 2px 2px rgba(0,0,0,0.075);-webkit-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
                /*margin-left: 10px;*/
                height: 50px;
            }
            .divSearchDate{
                /*margin-left: 10px;*/
                border-radius: 2px;
                -webkit-box-shadow: inset 0 2px 2px rgba(0,0,0,0.075); box-shadow: inset 0 2px 2px rgba(0,0,0,0.075);-webkit-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;

            }

            .z1asCe, .qa__svg-icon {
                display: inline-block;
                fill: currentColor;
                height: 24px;
                line-height: 24px;
                position: relative;
                width: 24px;
            }.sbico {
                display: inline-block;
                height: 30px;
                width: 30px;
                cursor: pointer;
                vertical-align: middle;
                color: #FFF;
            }
            .sbico-c {
                background: transparent;
                border: 0;
                float: right;
                height: 50px;
                line-height: 50px;
                margin-top: -1px;
                outline: 0;
                padding-right: 8px;
                position: relative;
                top: -1px;
            }
            .logina{
                font-size: 20px;
                text-decoration: none;
                font-family: auto;
                border: 2px solid gray;
                padding: 3px 20px;
                border-radius: 3px;
            }
            .logina:hover{
                text-decoration: none;
                color: #FFF;
            }
        </style>

    </head>

    <body >
        <!--<img src="images/bg.png">-->
        <!--<div class="container-scroller" >-->
        <div class="container-scroller" style="background-image: url(images/bg.png);background-repeat: round;width: 100%;">

            <div class="container-fluid">
                <div class="row"><br>
                    <div class="col-sm-2 offset-11">
                        <a href="login_1.jsp" class="logina"><img src="images/login_icon.png"> &nbsp;Login</a>
                    </div>
                    <div class="content-wrapper full-page-wrapper d-flex align-items-center">

                        <div class="card col-lg-6 offset-lg-3">
                            <div class="card-block">
                                <h3 class="card-title text-primary text-center mb-3 mt-4">
                                    <img src="images/logo_2.png">
                                    <!--<i class="fa fa-user" style="font-size:100px;color:lightblue;text-shadow:2px 2px 4px #000000;"></i>-->
                                </h3>
                                <form action="innerhomepage.jsp" id="myForm" method="get">
                                <div class="form-group">
                                    <div class="input-group">
                                        <div class="col-sm-12">
                                            <!--<span class="input-group-addon"><i class="fa fa-user"></i></span>-->
                                            <input class="txtSearch form-control p_input "  type="text" name="generaltag" id="generaltag"  oninput="errBlank('errGeneral')" placeholder="Enter Keyword">

                                            <!--<input type="text" name="username" class="form-control p_input" placeholder="Enter Email Id" required>-->
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">

                                    <div class="input-group">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <!--<div class="col-sm-12">-->
                                        <div class="col-sm-3 divSearchDate bg-white ">
                                            <input class="txtFrom classdatepicker"  type="text"  name="fromDate" id="fromDate" autocomplete="off"  oninput="errBlank('errGeneral')" placeholder="From Date">
                                            <i class="fa fa-calendar classdatepicker" style="font-size:22px;color:#b6b6b6;margin-top: 10px"></i>
                                        </div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <div class="col-sm-3  divSearchDate bg-white ">
                                            <input class="txtTo classdatepicker"  type="text" name="toDate" id="toDate" autocomplete="off"  oninput="errBlank('errGeneral')" placeholder="To Date">
                                            <i class="fa fa-calendar classdatepicker" style="font-size:22px;color:#b6b6b6;margin-top: 10px"></i>

                                        </div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <div class="col-sm-4  divSearchDate bg-white ">
                                            <select name="searchresult" id="idCategory" multiple="multiple" class="3col active txtCmbCategory">
<!--                                            <select name="basic[]" id="idCategory" multiple="multiple" class="3col active txtCmbCategory">-->
                                                <!--<select id="idCategory1" class="txtCmb" multiple="multiple">-->
                                                <option value="G">Creative Team</option>
                                                <option value="N">Media Room</option>
                                                <option value="R">Raw Data</option>
                                            </select>
                                        </div>
                                        &nbsp;&nbsp;&nbsp;&nbsp;<div class="text-center col-sm-1  bg-primary divSearch align-middle ">
                                            <button class="sbico-c" value="Search" aria-label="" onclick="showData()" type="submit"><span class="sbico z1asCe MZy1Rb offset-5"><svg focusable="false" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M15.5 14h-.79l-.28-.27A6.471 6.471 0 0 0 16 9.5 6.5 6.5 0 1 0 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"></path></svg></span></button>

                                        </div>
                                        <!--</div>-->
                                        <!--<span class="input-group-addon"><i class="fa fa-lock"></i></span>-->
                                        <!--<input type="password" name="password" class="form-control p_input" placeholder="Password" required>-->
                                    </div>
                                </div>
                                </form>
                            </div>

                            <div class="row mb-2" >
                                <div class="col-lg-12">
                                    <div class="col-sm-12 " style="border-bottom: 1px solid #b6b6b6" > 
                                        <!--<div class="col-sm-3"></div>-->
                                        <div class="col-sm-8 offset-3 text-left" >
                                            <!--<hr style="color:gray">-->
                                            <br>
                                        </div>
                                    </div>
                                    <div class="card">

                                        <!--<hr>-->

                                        <div class="card-block">

                                            <!--<h5 class="card-title mb-4">System Users</h5>-->
                                            <!--<div class="table-responsive">-->
                                            <div id="fetchData" > </div>

                                            <div id="fetchCategoryData" > </div>
                                            <!--</div>-->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script> 
          <script src="js/jquery-ui.js" type="text/javascript"></script>
                <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js"></script>
                 <script src="http://cdn.rawgit.com/davidstutz/bootstrap-multiselect/master/dist/js/bootstrap-multiselect.js" type="text/javascript"></script>
                <script type="text/javascript">
                    $(function () {
                        $('#idCategory1').multiselect({
                            includeSelectAllOption: true;
        //                    columns: 4,
        //                            placeholder: 'Select options'
        
                        });
        
                    });
                </script>-->
        <!--<script src="js/jquery-ui.js"></script>-->
        <!--<script src="js/jquery-ui.js" type="text/javascript"></script>-->
        <!--Load SCRIPT.JS which will create datepicker for input field-->  
        <script src="js/script.js" type="text/javascript"></script>
        <script>
                                                $(function () {
                                                    $('select[multiple].active.3col').multiselect({
                                                        columns: 1,
                                                        placeholder: 'Select Category',
                                                        search: true,
                                                        searchOptions: {
                                                            'default': 'Search Category'
                                                        },
                                                        selectAll: true
                                                    });

                                                });
        </script>
        <!--<script src="node_modules/jquery/dist/jquery.min.js"></script>-->
        <!--<script src="node_modules/tether/dist/js/tether.min.js"></script>-->
        <!--<script src="node_modules/bootstrap/dist/js/bootstrap.min.js"></script>-->
        <!--<script src="node_modules/perfect-scrollbar/dist/js/perfect-scrollbar.jquery.min.js"></script>-->
        <!--<script src="js/misc.js"></script>-->
    </body>

</html>