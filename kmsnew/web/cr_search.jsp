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
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("2") )) {

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
        <link rel="icon" href="favicon.ico" type="image/x-icon">

        <!-- Coogle Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Roboto:400,700&subset=latin,cyrillic-ext" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" type="text/css">

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

        <jsp:include page="cr_header.jsp"></jsp:include>
        <jsp:include page="cr_left.jsp"></jsp:include>
            <!--<div class="container-scroller" style="background-image: url(images/bg.png);background-repeat: round;width: 100%;">-->


        <%
            String table = "";
            request.setCharacterEncoding("UTF-8");
            Connection dh = null;
            String imag[];
            //            String s = "Narendra modi";
            String s = request.getParameter("generaltagcreative");
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
                query.append("MATCH (subject, description,sector,name_of_program,place_of_program,additionaltag) AGAINST ('" + subject + "') " + dateQuery);
//                    query.append("MATCH (subject, description, summary,general,teletag,districttag,talukatag,villagetag,approvedtag) AGAINST ('" + subject + "') " + dateQuery);
                System.out.println("query=" + query);
                //String generaltag=request.getParameter("generaltag").toString();
                String sqlQuery = "SELECT subject, description,sector,name_of_program,place_of_program,additionaltag,sourcedate FROM tbl_news_dataentry WHERE " + query ;
//                    String sql = "SELECT workcode,subject,description,graphicspath,vdopath,docpath,audiopath FROM tbl_news_dataentry WHERE " + query + serchQuery ;
                String sql = "SELECT * FROM tbl_news_dataentry WHERE " + query +  " limit 0,10";
                  System.out.println("sql11111:-" + sql);
                PreparedStatement stm = ConnectionDB.getDBConnection().prepareStatement(sql);
                //            stm.setString(1, s);
                ResultSet rs = stm.executeQuery();
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
                                                    <%                                    
                                                         sssss = rs.getString("vdopath");
                                                    vdo = sssss.split(",");
                                                    if (!sssss.isEmpty()) {
                                                        String extension = "";

                                                        int j = rs.getString("vdopath").lastIndexOf('.');
                                                        if (j > 0) {
                                                            extension = rs.getString("vdopath").substring(j + 1);
                                                        }
                                                        System.out.println("extension:-" + extension);
                                                        if (extension.equals("MXF")) {
                                                    %>
                                                    <a href="/kmsvdo/vdo/<%=rs.getString("vdopath").substring(14)%>" class="btn btn-danger btn-circle waves-effect waves-circle waves-float" data-toggle="modal" data-target="#defaultModal" download> <i class="material-icons">play_arrow</i> </a>
                                                        <%
                                                            }

                                                            if (extension.equals("mov")) {
                                                        %>
                                                    <a href="/kmsvdo/vdo/<%=rs.getString("vdopath").substring(14)%>" class="btn btn-danger btn-circle waves-effect waves-circle waves-float" data-toggle="modal" data-target="#defaultModal" download> <i class="material-icons">play_arrow</i> </a>
                                                        <%
                                                            }
                                                            if (extension.equals("mp4")) {
                                                        %>
                                                    <!--<video id="videoContainer" class="w-90" height="200" controls >-->


                                                    <video id="videoContainer"  width="200" height="100" controls >
                                                        <source src="<%="/kmsvdo/vdo/" + vdo[0].substring(14)%>" type="video/mp4" >
                                                    </video>
                                                        <%
                                                            }
                                                            if (extension.equals("3gp")) {
                                                        %>
                                                    <!--<video id="videoContainer" class="w-90" height="200" controls >-->


                                                    <video id="videoContainer"  width="200" height="100" controls >
                                                        <source src="<%="/kmsvdo/vdo/" + vdo[0].substring(14)%>" type="video/mp4" >
                                                    </video>
                                                    <%}}%>
                                                </td>
                                                <td ><h4> <%=rs.getString("subject")%>   </h4>
                                                    <p class="m-t-15 m-b-30"><%=rs.getString("description")%> <br>
                                                        <%=rs.getString("sector")%> 
                                                        <br> 
                                                        <%=rs.getString("name_of_program")%> &nbsp;<%=rs.getString("place_of_program")%> 
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
                    </div>
                </div>
                <!-- #END# Unordered List --> 
            </div>
        </section>
        <%} catch (Exception e) {
                System.out.println("error in innerhomepage:-" + e.getMessage());
            }%>     
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

    </script>           
       
    </body>

</html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>