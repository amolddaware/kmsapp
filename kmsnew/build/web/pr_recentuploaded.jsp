<%-- 
    Document   : login
    Created on : Nov 15, 2017, 10:26:41 PM
    Author     : Amol
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    ResourceBundle rb = ResourceBundle.getBundle("msg");
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("4"))) {

// if (session != null && session.getAttribute("username") != null && session.getAttribute("role").equals("3")) {
        String username = session.getAttribute("username").toString();
        String userid = session.getAttribute("userid").toString();
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

        <!-- Favicon-->
       <link rel="icon" href="images/favicon.ico" type="image/x-icon">

        <!-- Google Fonts -->
        <link href="css/font/materialicon.css" rel="stylesheet" type="text/css">
        <link href="css/font/googlefont.css" rel="stylesheet" type="text/css">

        <!-- Bootstrap Core Css -->
        <link href="plugins/bootstrap/css/bootstrap.css" rel="stylesheet">

        <!-- Waves Effect Css -->
        <link href="plugins/node-waves/waves.css" rel="stylesheet" />

        <!-- Animation Css -->
        <link href="plugins/animate-css/animate.css" rel="stylesheet" />

        <!-- Bootstrap Material Datetime Picker Css -->
        <link href="plugins/bootstrap-material-datetimepicker/css/bootstrap-material-datetimepicker.css" rel="stylesheet" />

        <!-- JQuery DataTable Css -->
        <link href="plugins/jquery-datatable/skin/bootstrap/css/dataTables.bootstrap.css" rel="stylesheet">

        <!-- Custom Css -->
        <link href="css/style.css" rel="stylesheet">

        <!-- AdminBSB Themes. You can choose a theme from css/themes instead of get all themes -->
        <link href="css/themes/all-themes.css" rel="stylesheet"/>
        <!--</head>-->
        <link href="css/jquery-ui.css" rel="stylesheet">


    </head>
    <body class="theme-blue">
        <!-- Page Loader -->
        <!--    <div class="page-loader-wrapper">
                <div class="loader">
                    <div class="preloader">
                        <div class="spinner-layer pl-blue">
                            <div class="circle-clipper left">
                                <div class="circle"></div>
                            </div>
                            <div class="circle-clipper right">
                                <div class="circle"></div>
                            </div>
                        </div>
                    </div>
                    <p>Please wait...</p>
                </div>
            </div>-->
        <!-- #END# Page Loader --> 
        <!-- Overlay For Sidebars -->
        <div class="overlay"></div>
        <!--<img src="images/bg.png">-->
        <!--<div class="container-scroller" >-->
        <!--    <div class="container-scroller" >
                <div class="container-scroller" style="background-image: url(images/bg.png);background-repeat: round;width: 100%;">
        
                <div class="container-fluid">-->

        <jsp:include page="pr_header.jsp"></jsp:include>
        <jsp:include page="pr_left.jsp"></jsp:include>
            <!--<div class="row">-->

        <%
            //                    System.out.println("searchresult:-" + request.getParameter("searchresult"));
            String table = "";
            request.setCharacterEncoding("UTF-8");
            Connection dh = null;
            String imag[];
            ConnectionDB connectionDB = new ConnectionDB();
            dh = connectionDB.getConnection();
            PreparedStatement stm = null;
            ResultSet rs = null;
            try {
                //String generaltag=request.getParameter("generaltag").toString();
                String sqlQuery = "SELECT workcode,subject,language,npname,edition,titlemarathi,link,sourcedate,graphicspath FROM tbl_news_dataentry WHERE  userid=? and workcode like ? and workcode not like ? order by iddataentry desc";
                //                    String sql = "SELECT workcode,subject,description,graphicspath,vdopath,docpath,audiopath FROM tbl_news_dataentry WHERE " + query + serchQuery ;
                String sql = "SELECT workcode,subject,language,npname,edition,titlemarathi,link,sourcedate,graphicspath FROM tbl_news_dataentry WHERE userid=? and workcode like ? and workcode not like ? limit 0,10 order by iddataentry desc" ;
                //            String sql = "SELECT subject,graphicspath,vdopath,docpath,audiopath FROM tbl_news_dataentry WHERE MATCH (subject, description, summary,general,teletag,districttag,talukatag,villagetag,additionaltag) AGAINST ('" + subject + "') ";
                System.out.println("sql11111:-" + sql);
                stm = dh.prepareStatement(sql);
                stm.setString(1, userid);
                stm.setString(2, "%P%");
                stm.setString(3, "%PW%");
                rs = stm.executeQuery();
        %>

        <section class="content">
            <div class="col-md-12"> 
                <!-- Unordered List -->
                <div class="row clearfix">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="card">
                            <div class="body clearfix">
                                <div class="table-responsive" id="all_rows">
                                    <table class="table table-bordered table-striped table-hovers" id="all_rows">
                                        <tbody>
                                            <tr>
                                                <th colspan="2"><h3 class="text-center"> Recent Uploaded Information</h3></th>
                                            </tr>
                                            <%
                                                String sssss = null;

                                                String imag1[], vdo[] = null, doc[] = null, audio[] = null;
                                                while (rs.next()) {
                                                    //                            if (rs.getString(3) != null) {
                                                    //                                strImg.append(rs.getString(3));
                                                    //                                 System.out.println("strimg:-" + strImg);
                                                    //                            }
//                                                        withoutLastCharacterPMP = withoutFirstCharacterPMP.toString().substring(0, withoutFirstCharacterPMP.toString().length() - 1);
       
                                                    sssss=rs.getString("graphicspath").substring(25,rs.getString("graphicspath").length()-1);
                                                    System.out.println("ssss:-"+sssss);

                                            %>
                                            <tr>
                                                <td style="text-align: center;vertical-align: bottom;width: 30%;">
                                                    <img src="<%=sssss%>" id="imageContainer"  width="200" height="100"  >

                                                </td>
                                                <td >

                                                    <h4> <%=rs.getString("subject")%>   </h4>
                                                    <p class="m-t-15 m-b-30"><%=rs.getString("titlemarathi")%> </p>
                                                    <p class="m-t-15 m-b-30"><%=rs.getString("npname")%> </p>
                                                    <p class="m-t-15 m-b-30"><%=rs.getString("edition")%> </p>
                                                    <span class="badge bg-black"><%=rs.getString("sourcedate")%> </span></td>
                                            </tr>
                                            <%
                                                }%>
                                        <input type="hidden" id="row_no" value="10">
                                        <input type="hidden" id="query" value="<%=sqlQuery%>">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- #END# Unordered List --> 
            </div>
        </section>
        <%} catch (Exception e) {
                System.out.println("error in innerhomepage:-" + e.getMessage());
            } finally {
                if (stm != null) {
                    stm.close();
                }
                if (rs != null) {
                    rs.close();
                }
                if (dh != null) {
                    dh.close();
                }
            }
        %>
        <!-- Jquery Core Js --> 
        <!--<script src="plugins/jquery/jquery.min.js"></script>--> 

        <script src="js/jquery-1.12.4.js"></script>
        <!--<script src="plugins/jquery/jquery.min.js"></script>-->
        <script src="js/jquery-ui.js"></script>

        <!-- Bootstrap Core Js --> 
        <script src="plugins/bootstrap/js/bootstrap.js"></script> 

        <!-- Select Plugin Js --> 
        <script src="plugins/bootstrap-select/js/bootstrap-select.js"></script> 

        <!-- Slimscroll Plugin Js --> 
        <script src="plugins/jquery-slimscroll/jquery.slimscroll.js"></script> 

        <!-- Bootstrap Colorpicker Js --> 
        <script src="plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script> 

        <!-- Dropzone Plugin Js --> 
        <script src="plugins/dropzone/dropzone.js"></script> 

        <!-- Jquery Validation Plugin Css --> 
        <script src="plugins/jquery-validation/jquery.validate.js"></script> 

        <!-- JQuery Steps Plugin Js --> 
        <script src="plugins/jquery-steps/jquery.steps.js"></script> 

        <!-- Waves Effect Plugin Js --> 
        <script src="plugins/node-waves/waves.js"></script> 

        <!-- Autosize Plugin Js -->
        <script src="plugins/autosize/autosize.js"></script>

        <!-- Moment Plugin Js -->
        <script src="plugins/momentjs/moment.js"></script>

        <!-- Bootstrap Material Datetime Picker Plugin Js -->
        <script src="plugins/bootstrap-material-datetimepicker/js/bootstrap-material-datetimepicker.js"></script>

        <!-- Bootstrap Datepicker Plugin Js -->
        <script src="plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>

        <!-- Custom Js --> 
        <script src="js/admin.js"></script> 
        <script src="js/pages/forms/form-validation.js"></script> 
        <script src="js/pages/forms/form-wizard.js"></script> 
        <!--    <script src="js/pages/forms/basic-form-elements.js"></script> 
            <script src="js/pages/forms/advanced-form-elements.js"></script> -->

        <!-- Demo Js --> 
        <script src="js/demo.js"></script>

        <script>
            $('#date-end').bootstrapMaterialDatePicker({weekStart: 0, time: false});
            $('#date-start').bootstrapMaterialDatePicker({weekStart: 0, time: false}).on('change', function (e, date)
            {
                $('#date-end').bootstrapMaterialDatePicker('setMinDate', date);
            });
        </script>

        <script>
            //            $(document).ready(function () {
            //                alert("gdfd");
            $(window).scroll(function ()
            {
                //                    if ($(document).height() <= window.scrollMaxY || (document.documentElement.scrollHeight - document.documentElement.clientHeight))
                if ($(document).height() <= $(window).scrollTop() + $(window).height())
                {
                    //                        alert("test");
                    loadmore();

                    //                        alert(window.scrollMaxY  +"adadsad:"+document.documentElement.scrollHeight - document.documentElement.clientHeight))
                    //                    alert($(document).height()+" window heitgh:" +$(window).height()+" window scroll:"+$(window).scrollTop() );
                }
            });
            //            });
            function loadmore()
            {
                //                alert("hi");
                var val = document.getElementById("row_no").value;
                var query = document.getElementById("query").value;

                //            alert(val);
                $.ajax({
                    type: 'post',
                    url: 'pr_uploadedfetch.jsp',
                    data: {
                        getresult: val,
                        querySearch: query
                    },
                    success: function (response) {
                        var content = document.getElementById("all_rows");
                        content.innerHTML = content.innerHTML + response;

                        // We increase the value by 10 because we limit the results by 10
                        document.getElementById("row_no").value = Number(val) + 10;
                    }
                });
            }

        </script>
        <script>
            function showData() {
                //                alert("test");
                var xmlhttp;
                var subject = document.getElementById("generaltag").value;
                var fromDate = document.getElementById("fromDate").value;
                var toDate = document.getElementById("toDate").value;
                var searchresult = document.getElementById("searchresult").value;
                // var checkboxes = document.getElementsByName("chkkms");
                //  var checkboxesChecked = [];
                //  var checkedBoxes ;
                //                var selected = $("#idCategory option:selected");
                //                var message = "";
                //                selected.each(function () {
                //                    message += $(this).val() + ",\n";
                //                    //                        message += $(this).text() + " " + $(this).val() + "\n";
                //                });
                //                    alert("message:-"+message);
                //                    document.getElementById("idCategoryList").value=message;
                //  // loop over them all
                //  for (var i=0; i<checkboxes.length; i++) {
                //     // And stick the checked ones onto an array...
                //     if (checkboxes[i].checked) {
                //       checkedBoxes= checkboxesChecked.push(checkboxes[i].value);
                //     }
                //  }
                // var array = [];
                //  $('input[type="checkbox"]:checked').each(function() {
                //      array.push($(this).val());
                //    });
                //alert(array.join(','));
                //var searchresult=array.join(',');
                //var checkedBoxes = document.querySelectorAll('input[name=chkkms]:checked');
                //alert(searchresult);
                if (subject != "") {
                    if (window.XMLHttpRequest)
                    {// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp = new XMLHttpRequest();
                    } else
                    {// code for IE6, IE5
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    //                    var urls = "grid_all_data.jsp?generaltag=" + subject + "&fromdate=" + fromDate + "&todate=" + toDate;
                    //                    var urls = "fetchdata_new_1.jsp?generaltag=" + subject;
                    //                alert(urls);
                    xmlhttp.onreadystatechange = function ()
                    {
                        if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                        {
                            var resp = xmlhttp.responseText;
                            //                        alert(resp);

                            document.getElementById("fetchData").innerHTML = resp;

                            document.getElementById("generaltag1").value = subject;
                            document.getElementById("fromDate1").value = fromDate;
                            document.getElementById("toDate1").value = toDate;

                            //                        selectVillage();
                            //            diseaseType();
                        }
                    };
                    //    xmlhttp.open("GET", urls, true);
                    xmlhttp.open("POST", "grid_category_all_data.jsp?generaltag=" + subject + "&fromdate=" + fromDate + "&todate=" + toDate + "&searchresult=" + searchresult, true);
                    xmlhttp.send();
                } else {

                    document.getElementById("errGeneral").innerHTML = "Please enter the value";
                    document.getElementById("generaltag").focus();
                    return false;
                    //                alert("Please enter data");
                }
            }
        </script>
    </body>

</html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>