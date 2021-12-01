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

//    RandomStringCenerator random=new RandomStringCenerator();
////    String captcha=random.getRandomCaptchaString(8);
////    
////    String captchaSplit[]=captcha.split("");
////    
////    String fullcaptcha=captchaSplit[0]+" "+captchaSplit[1]+" "+captchaSplit[2]+" "+captchaSplit[3]+" "+captchaSplit[4]+" "+captchaSplit[5]+" "+captchaSplit[6]+" "+captchaSplit[7];
//    
//    String captcha =random.getRandomStringCenerator();
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

        <!-- Coogle Fonts -->
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
        <link href="css/print.css" rel="stylesheet"/>

    </head>
    <body class="theme-blue">
        <!-- Page Loader -->
        <!--        <div class="page-loader-wrapper">
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
            <!--<div class="container-scroller" style="background-image: url(images/bg.png);background-repeat: round;width: 100%;">-->


        <%
            String table = "";
            request.setCharacterEncoding("UTF-8");
            Connection dh = null;
            String imag[];
            ConnectionDB conn = new ConnectionDB();
            dh = conn.getConnection();
            PreparedStatement stm = null;
            ResultSet rs = null;
            //            String s = "Narendra modi";
            String s = request.getParameter("generaltagprint");
            try {
//            String s = null;

//            String generaltag = request.getParameter("generaltagprint");
//        s.getBytes("UTF-8");
//            s = new String(generaltag.getBytes("ISO-8859-1"), "UTF-8");
                StringBuilder str = new StringBuilder();

                StringBuilder subject = new StringBuilder();
                String spliWord[] = s.split(" ");
                for (int k = 0; k < spliWord.length; k++) {
                    subject.append("+" + spliWord[k].trim());
                }

                String fromDate = null, toDate = null;
                String dateQuery = null;

                if (!request.getParameter("fromDate").isEmpty() && !request.getParameter("toDate").isEmpty()) {
                    fromDate = request.getParameter("fromDate");
                    toDate = request.getParameter("toDate");
//                        String fdate[] = fromDate.split("/");
//                        String fdd = fdate[0];
//                        String fmm = fdate[1];
//                        String fyy = fdate[2];
//                        String ffulldate = fyy + "-" + fmm + "-" + fdd;
//                        String tdate[] = toDate.split("/");
//                        String tdd = tdate[0];
//                        String tmm = tdate[1];
//                        String tyy = tdate[2];
//                        String tfulldate = tyy + "-" + tmm + "-" + tdd;
//                        ? and str_to_date(sourcedate,'%d/%m/%Y') <=?
                    dateQuery = "and (str_to_date(sourcedate,'%d/%m/%Y') >='" + fromDate + "' AND str_to_date(sourcedate,'%d/%m/%Y') <='" + toDate + "')";
//                        dateQuery = "and (datetime BETWEEN '" + ffulldate + "' AND '" + tfulldate + "')";
                } else {
                    dateQuery = "";
                }
                String serchQuery = null;

                System.out.println("datequerry:-" + dateQuery);
                try {
                    StringBuilder query = new StringBuilder();
                    query.append("MATCH (subject,npname,district,edition,subedition,titlemarathi,additionaltag) AGAINST ('" + subject + "') " + dateQuery);
//                    query.append("MATCH (subject, description, summary,general,teletag,districttag,talukatag,villagetag,approvedtag) AGAINST ('" + subject + "') " + dateQuery);
                    System.out.println("query=" + query);
                    //String generaltag=request.getParameter("generaltag").toString();
                    String sqlQuery = "SELECT subject, npname,district,edition,subedition,titlemarathi,additionaltag FROM tbl_news_dataentry WHERE " + query;
//                    String sql = "SELECT workcode,subject,description,graphicspath,vdopath,docpath,audiopath FROM tbl_news_dataentry WHERE " + query + serchQuery ;
                    String sql = "SELECT * FROM tbl_news_dataentry WHERE " + query + " and workcode like ? order by npname   ";
//                String sql = "SELECT * FROM tbl_news_dataentry WHERE " + query + " and workcode like ? and workcode not like ? limit 0,10";
                    System.out.println("sql11111:-" + sql);
                    stm = dh.prepareStatement(sql);
                    stm.setString(1, "%P%");
//                            stm.setString(2, "%PW%");
                    rs = stm.executeQuery();
        %>

        <section class="content">
            <div class="col-md-12"> 
                <!-- Unordered List -->
                <div class="row clearfix">
                    <%--<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="card">
                            <div class="body clearfix">
                                <div class="table-responsive" id="all_rows">
                                    <table class="table table-bordered table-striped table-hovers" id="all_rows">
                                        <tbody>
                                            <% int count = 0;
                                                String sssss = null;

                                                String imag1[], vdo[] = null, doc[] = null, audio[] = null;
                                                while (rs.next()) {
                                                    count++;
                                                    //                            if (rs.getString(3) != null) {
                                                    //                                strImg.append(rs.getString(3));
                                                    //                                 System.out.println("strimg:-" + strImg);
                                                    //                            }

                                            %>
                                            <tr>
                                                <td style="text-align: center;vertical-align: bottom;width: 200px;">
                                                    <img src="<%=rs.getString("graphicspath")%>" width="200" height="100">
                                                </td>
                                                <td ><h4> <%=rs.getString("subject")%>   </h4>
                                                    <p class="m-t-15 m-b-30"><%=rs.getString("titlemarathi")%> <br>
                                                        <%=rs.getString("npname")%> 
                                                        <br> 
                                                        <%=rs.getString("edition")%> <br>
                                                        <%=rs.getString("webmedianame")%> &nbsp;<%=rs.getString("district")%> 
                                                        <br><%=rs.getString("additionaltag")%>   </p>
                                                    <span class="badge bg-black"><%=rs.getString("sourcedate")%> </span></td>
                                            </tr>
                                            <%}

                                                if (count == 0) {%>
                                        <div class="text-center text-danger"><%
                                            out.println("No record found for this query");
                                            %></div><%
                                                }
                                            %>
                                        <input type="hidden" id="row_no" value="10">
                                        <input type="hidden" id="query" value="<%=sqlQuery%>">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>--%>
                    <!-- Print Div Start-->
                    <div id="printablediv">
                        <div class="col-md-12">
                            <input class="btn bg-black pull-right" type="button" value="Print" onclick="javascript:printDiv('printablediv')" /><br><br>
                            <div class="card profile-card"><br>
                                <div class="header">
                                    <div class="content-area clearfix">
                                        <div class="col-md-12">
                                            <div class="pull-left text-left">
                                                <h3>User Keyword Search Report (Print Media User)</h3>
                                                <!--                                                <h3>Weekly Report (Print Media User)</h3>-->
                                                <!--<p>03/02/2020 to 09/02/2020</p>-->
                                            </div>
                                            <div class="pull-right"> <img class="img-responsive text-right" src="images/logo_circle.png"> </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="border">
                                    <div id="blue"></div>
                                    <div id="black"></div>
                                </div>
                                <div class="profile-body profile-footer clearfix">
                                    <div class="row">
                                        <div class="col-md-12"><br>
                                            <div class="panel panel-default panel-post">
                                                <%
                                                    String npname = "";
                                                    int flag = 0;
                                                    int flag1 = 0;
                                                    int count = 0;
                                                    while (rs.next()) {
//                                                       
                                                        npname = npname + " " + rs.getString("npname");
// System.out.println("npname:-" + npname);
                                                        String words[] = npname.split(" ");

                                                        System.out.println("Duplicate words in a given string : ");
                                                        for (int i = 0; i < words.length; i++) {
                                                            count = 1;
                                                            for (int j = i + 1; j < words.length; j++) {
                                                                if (words[i].equals(words[j])) {
                                                                    count++;
                                                                    //Set words[j] to 0 to avoid printing visited word  
                                                                    words[j] = "0";
                                                                }
                                                            }

                                                            //Displays the duplicate word if count is greater than 1  
                                                            if (count > 1 && words[i] != "0") {
                                                                System.out.println("aaaa:-" + words[i]);
                                                                flag1 = 1;
                                                            } else {
                                                                System.out.println("wwww:-" + words[i]);
                                                                flag = 0;
                                                                flag1 = 0;
                                                            }
                                                            System.out.println("flag:-" + flag);
                                                            System.out.println("flag1:-" + flag1);
//                                                        }
//                                                        if (!rs.getString("npname").equals(npname)) {
//                                                           npname=rs.getString("npname");
//                                                            System.out.println("npanme:-" + npname);
                                                            if (flag == 0 && flag1 != 1) {
                                                %>

                                                <div class="panel-heading clearfix">
                                                    <div class="col-md-2 col-sm-2">

                                                        <img src="images/epaper/<%=rs.getString("npname")%>.jpeg" width="120" > 

                                                    </div>
                                                    <div class="col-md-9 col-sm-9 m-t-10">


                                                        <h3>  
                                                            <%=rs.getString("npname")%></h3>
                                                    </div>
                                                    <%--if (rs.getString("npname") != null) {%>
                                                    <div class="col-md-1 col-sm-1">
                                                        <i class="material-icons font-40 m-t-15"> description</i>
                                                    </div>
                                                    <%} else if (rs.getString("webmedianame") != null) {%>
                                                    <div class="col-md-1 col-sm-1">
                                                        <i class="material-icons font-40 m-t-15">language</i>
                                                    </div>
                                                    <%}%>--%>
                                                    <!--                                                    <div class="col-md-1 col-sm-1">
                                                                                                            <i class="material-icons font-40 m-t-15">language</i>
                                                                                                        </div>-->

                                                </div>
                                                <%}
                                                        break;
                                                    }%>
                                                <div class="panel-body"><br>
                                                    <div class="col-md-12">
                                                        <div class="well">
                                                            <div class="card-about-me">
                                                                <div class="body padding-0">
                                                                    <div class="row">

                                                                        <%
                                                                            String image[] = rs.getString("graphicspath").split(",");
                                                                            for (int i = 0; i < image.length; i++) {
                                                                        %> <div class="col-md-4 col-sm-4"> 
                                                                            <img class="img-responsive img-rounded" src="<%=image[i].substring(34).replace(",", "")%>" width="300" height="150"> </div>
                                                                            <%}%>
                                                                    </div>

                                                                    <!--<div class="col-md-5 col-sm-5">--> 



                                                                    <!--</div>-->
                                                                    <div class="well bg-white">
                                                                        <ul>
                                                                            <li>
                                                                                <div class="title"> <i class="material-icons">date_range</i> Date</div>
                                                                                <div class="content"> <%=rs.getString("sourcedate")%> </div>
                                                                            </li>
                                                                            <li>
                                                                                <div class="title"> <i class="material-icons">language</i> Language</div>
                                                                                <div class="content"> <%=rs.getString("language")%> </div>
                                                                            </li>
                                                                            <li>
                                                                                <div class="title"> <i class="material-icons">edit</i> Edition </div>
                                                                                <div class="content"> <%=rs.getString("edition")%> </div>
                                                                            </li>
                                                                            <li>
                                                                                <div class="title"> <i class="material-icons">subtitles</i> Sub Edition </div>
                                                                                <div class="content"><%=rs.getString("subedition")%> </div>
                                                                            </li>
                                                                            <li>
                                                                                <div class="title"> <i class="material-icons">title</i> Title (English) </div>
                                                                                <div class="content"> <%=rs.getString("subject")%></div>
                                                                            </li>
                                                                            <li>
                                                                                <div class="title"> <i class="material-icons">title</i> Title (Marathi) </div>
                                                                                <div class="content"> <%=rs.getString("titlemarathi")%> </div>
                                                                            </li>
                                                                            <%--<li>
                                                                                <div class="title"> <i class="material-icons">label</i> Additional Tags </div>
                                                                                <div class="content">  
                                                                                    <%
                                                                                        String tag[] = null;
                                                                                        if (rs.getString("additionaltag") != null) {
                                                                                            tag = rs.getString("additionaltag").split(" ");
                                                                                            for (int i = 0; i < tag.length; i++) {

                                                                                                if (tag[i].length() != 0) {
                                                                                    %>
                                                                                    <span class="label font-13 m-b-20 "><%=tag[i].trim()%></span>
                                                                                    <!--                                                                                    <span class="label bg-teal">JavaScript</span>
                                                                                                                                                                        <span class="label bg-blue">PHP</span>
                                                                                                                                                                        <span class="label bg-amber">Node.js</span>-->
                                                                                    <%}
                                                                                            }
                                                                                        }%>
                                                                                </div>
                                                                            </li>--%>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="hr_dotted"></div>


                                                    </div>
                                                </div>
                                                <%}%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--Print Div End -->
                </div>
                <!-- #END# Unordered List --> 
            </div>

        </section>
        <%      } catch (Exception e) {
                    System.out.println("error in innerhomepage:-" + e.getMessage());
                }
            } catch (Exception e) {
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

        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <!--<script src="plugins/jquery/jquery.min.js"></script>-->
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

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
                    url: 'cr_uploadfetch.jsp',
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
            function printDiv(divID) {
                //Get the HTML of div
                var divElements = document.getElementById(divID).innerHTML;
                //Get the HTML of whole page
                var oldPage = document.body.innerHTML;

                //Reset the page's HTML with div's HTML only
                document.body.innerHTML =
                        "<html><head><title></title></head><body>" +
                        divElements + "</body>";

                //Print Page
                window.print();

                //Restore orignal HTML
                document.body.innerHTML = oldPage;


            }

        </script>           
        <script>$(document).ready(function () {
                $('.card-about-me .body ul li .content :nth-child(odd)').addClass("bg-black");
                $('.card-about-me .body ul li .content :nth-child(even)').addClass("bg-blue");
//                $('.card-about-me .body ul li .content :nth-child(3)').addClass("bg-blue");
//                $('.card-about-me .body ul li .content :nth-child(4)').addClass("bg-amber");
            });
        </script>
    </body>

</html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>