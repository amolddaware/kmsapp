<%-- 
    Document   : home
    Created on : Nov 15, 2017, 11:30:13 PM
    Author     : Amol
--%>

<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<jsp:forward page="dashboard.jsp"></jsp:forward>--%>
<%ResourceBundle rb = ResourceBundle.getBundle("msg"); %>
<%
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("5") || session.getAttribute("role").equals("1") || session.getAttribute("role").equals("4") || session.getAttribute("role").equals("3"))) {

//    String role = session.getAttribute("role").toString();
//    if (session != null && session.getAttribute("username") != null && session.getAttribute("role").equals("3")) {
        String username = session.getAttribute("username").toString();
        String userid = session.getAttribute("userid").toString();
        String token = session.getAttribute("csrfToken").toString();
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setDateHeader("Expires", 0);
        response.addHeader("X-Frame-Options", "DENY");

        int timeout = session.getMaxInactiveInterval();
//                System.out.println("timeout:-"+timeout);
        response.setHeader("refresh", timeout + ";URL=logout.jsp");%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <title><%=rb.getString("title")%></title>

        <!-- Favicon-->  <link rel="icon" href="images/favicon.ico" type="image/x-icon">

        <!-- Google Fonts -->
        <link href="css/font/materialicon.css" rel="stylesheet" type="text/css">
        <link href="css/font/googlefont.css" rel="stylesheet" type="text/css">


        <link href="plugins/bootstrap/css/bootstrap.css" rel="stylesheet">

        <!-- Waves Effect Css -->
        <link href="plugins/node-waves/waves.css" rel="stylesheet" />

        <!-- Animation Css -->
        <link href="plugins/animate-css/animate.css" rel="stylesheet" />

        <!-- Bootstrap Material Datetime Picker Css -->
        <link href="plugins/bootstrap-material-datetimepicker/css/bootstrap-material-datetimepicker.css" rel="stylesheet" />

        <!-- Bootstrap DatePicker Css -->
        <link href="plugins/bootstrap-datepicker/css/bootstrap-datepicker.css" rel="stylesheet" />

        <!-- Dropzone Css -->
        <!--<link href="plugins/dropzone/dropzone.css" rel="stylesheet"/>-->

        <!-- Bootstrap Select Css -->
        <link href="plugins/bootstrap-select/css/bootstrap-select.css" rel="stylesheet" />

        <!-- Custom Css -->
        <link href="css/style.css" rel="stylesheet" />

        <!-- AdminBSB Themes. You can choose a theme from css/themes instead of get all themes -->
        <link href="css/themes/all-themes.css" rel="stylesheet" />
        <!--<link href="css/jquery-ui.css" rel="stylesheet">-->

        <link href="css/jquery-ui.css" rel="stylesheet">

        <style>

        </style>
        <script>
            function errorBlank(err) {
                document.getElementById(err).innerHTML = "";
            }
        </script>
    </head>

    <body class="theme-blue">
        <!--<div id="txtAge" style="display:none">Age is something</div>-->
        <div class="overlay"></div>
        <!-- #END# Overlay For Sidebars --> 
        <!-- Top Bar -->
        <!--        <nav class="navbar">
                    <div class="container-fluid">
                        <div class="navbar-header"> <a href="javascript:void(0);" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse" aria-expanded="false"></a> <a href="javascript:void(0);" class="bars"></a> <a class="navbar-brand" href="index.html"><img class="img-responsive" width="120px" src="images/logo.png"></a> </div>
                        <div class="collapse navbar-collapse" id="navbar-collapse">
                            <ul class="nav navbar-nav navbar-right">
                                 Call Search 
                                <li><a class="search_input">
                                        <input type="text" class="form-control" placeholder="START TYPING...">
                                    </a></li>
                                <li><a class="search_input">
                                        <input type="text" id="date-start" class="form-control" placeholder="FROM DATE...">
                                    </a></li>
                                <li><a class="search_input">
                                        <input type="text" id="date-end" class="form-control" placeholder="TO DATE...">
                                    </a></li>
                                <li><a href="search_list.html" class="js-search" data-close="true"><i class="material-icons">search</i></a></li>
                                 #END# Call Search 
                            </ul>
                        </div>
                    </div>
                </nav>-->
        <% if (session.getAttribute("role").equals("4")) {%>
        <jsp:include page="pr_header.jsp"></jsp:include>
        <jsp:include page="pr_left.jsp"></jsp:include>

        <%} else if (session.getAttribute("role").equals("3")) {%>
        <jsp:include page="em_header.jsp"></jsp:include>
        <jsp:include page="em_left.jsp"></jsp:include>
        <%} else if (session.getAttribute("role").equals("5")) {%>
        <jsp:include page="userHeader1.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <% }%> <!--End navbar-->
        <!--                <div class="container-fluid" style="background-color:#f2f7f8">
                            <div class="row row-offcanvas row-offcanvas-right">-->
        <%--<jsp:include page="userLeft.jsp"></jsp:include>--%>
        <!-- SIDEBAR ENDS -->
        <% String getData = null, searchQuery = null, room = null, link = null;
//            if (request.getParameter("searchresult").equals("R")) {
//                getData = request.getParameter("searchresult");
//                room = "Raw Data Dataentry List";
//                link = "rawdata_dataentry_edit.jsp";
//            } else if (request.getParameter("searchresult").equals("N")) {
//                getData = request.getParameter("searchresult");
//                room = "Media Room Dataentry List";
//                link = "newsinformation_dataentry_approver_edit.jsp";
//            } else if (request.getParameter("searchresult").equals("G")) {
//                getData = request.getParameter("searchresult");
//                room = "Creative Team Dataentry List";
//                link = "graphicsinformation_dataentry_edit.jsp";
//            }

//                        String sql = "SELECT * FROM tbl_news_dataentry where workcode like '%" + getData + "%' ";
//                        //String sql = "Select subject,graphicspath,vdopath,docpath,audiopath  WHERE MATCH (subject, description, summary,general,teletag,districttag,talukatag,villagetag,additionaltag)  AGAINST ('" + subject + "' )";
//                        //            String sql = "Select subject,graphicspath,vdopath,docpath,audiopath from tbl_news_dataentry where workcode =?";
//                        System.out.println("sql:-" + sql);
//                        PreparedStatement stm = ConnectionDB.getDBConnection().prepareStatement(sql);
//                        //            stm.setString(1, s);
//                        ResultSet rs = stm.executeQuery();
//                        int number = 0;
            String table = "";
            request.setCharacterEncoding("UTF-8");
            Connection dh = null;
            String imag[];
            PreparedStatement stm = null;
            ResultSet rs = null;
            try {
                ConnectionDB conn = new ConnectionDB();
                dh = conn.getConnection();

                String fromdate = null, todate = null;
                String dateQuery = null;
//            Set<String> hash_Set = new HashSet<String>();
                String serchQuery = null;
//            String fromdate = null;
                StringBuffer query = new StringBuffer();
                StringBuffer querySearch = new StringBuffer();
//                                     String dateQuery = null;
                String generaltag = null;

                if (!request.getParameter("tag").isEmpty() && !request.getParameter("fromdate").isEmpty() && !request.getParameter("todate").isEmpty()) {
                    generaltag = request.getParameter("tag");
                    dateQuery = "and (sourcedate BETWEEN '" + request.getParameter("fromdate") + "' AND '" + request.getParameter("todate") + "') ";

                    querySearch.append(generaltag + " " + request.getParameter("fromdate") + " to " + request.getParameter("todate"));
                    query.append("MATCH (subject,titlemarathi,chname,additionaltag,sentiment,approvedtag,dm_source,dept,sector,name_of_program,place_of_program,district,npname,edition,location,brand) AGAINST ('" + generaltag + "') " + dateQuery + "  ");

                }
                if (!request.getParameter("tag").isEmpty() && request.getParameter("fromdate").isEmpty() && request.getParameter("todate").isEmpty()) {
                    generaltag = request.getParameter("tag");
//                dateQuery = "and (sourcedate BETWEEN '" + request.getParameter("fromdate") + "' AND '" + request.getParameter("todate") + "') ";

                    querySearch.append(generaltag);
                    query.append("MATCH (subject,titlemarathi,chname,additionaltag,sentiment,approvedtag,dm_source,dept,sector,name_of_program,place_of_program,district,npname,edition,location,brand) AGAINST ('" + generaltag + "') ");

                }
                if (request.getParameter("tag").isEmpty() && request.getParameter("fromdate") != null && request.getParameter("todate") != null) {
//                                        fromdate = request.getParameter("fromdate");
                    query.append(" (sourcedate BETWEEN '" + request.getParameter("fromdate") + "' AND '" + request.getParameter("todate") + "') ");
//                        dateQuery = " (sourcedate BETWEEN '" + request.getParameter("fromdate") + "' AND '" + request.getParameter("todate") + "') ";
                    //                        dateQuery = "and (datetime BETWEEN '" + ffulldate + "' AND '" + tfulldate + "')";
                    querySearch.append(request.getParameter("fromdate") + " to " + request.getParameter("todate"));

                } else {
                    dateQuery = "";
                }


        %>
        <section class="content">

            <div class="row">
                <p>Search By: <%=querySearch%></p>

            </div>
            <div class="row">
                <div id="all_rows">
                    <%
                        //                                    String querySearch = request.getParameter("querySearch");
//                        System.out.println("querySearch:-" + querySearch);
//                        System.out.println("brandquerry:-" + query);
                        String sqlQuery = "SELECT vdopath,graphicspath,subject,sourcedate FROM tbl_news_dataentry where " + query + " and workcode like ? and vdopath is not null group by workcode order by workcode ";

                        String sql = "SELECT vdopath,graphicspath,subject,sourcedate FROM tbl_news_dataentry where " + query + " and workcode like ? and vdopath is not null group by workcode order by workcode limit 0,12 ";
                        //                String sql = "SELECT * FROM tbl_news_dataentry WHERE " + query + " and workcode like ? and workcode not like ? limit 0,10";
                        System.out.println("sql11111:-" + sql);
                        stm = dh.prepareStatement(sql);
                        stm.setString(1, "%E%");
//                        stm.setString(2, "%EN%");
                        //                                    stm.setString(1, "%P%");
                        rs = stm.executeQuery();

                        String npname = null, tempNpname = null;
                        int flag = 0;
                        int flag1 = 0;
                        int count = 0;

                        while (rs.next()) {
                            //                  while()
                    %>
                    <div class="col-sm-4" >
                    <!--                        <div class="gal-detail thumb">
                                                <div class="image-popup" title="Screenshot-2">-->
                    <%
//                                                                        if (rs.getString("vdopath") != null) {
                        String fullpath[] = null;
                        if (rs.getString("vdopath").contains("::")) {
                            fullpath = rs.getString("vdopath").split("::");
                            for (int i = 0; i < fullpath.length; i++) {

                    %>
                    <!--<div class="col-sm-4" >-->
                        <div class="gal-detail thumb">
                            <!--<div class="image-popup" title="Screenshot-2">-->    
                                <a href="<%=fullpath[i].substring(25)%>" target="_blank">
                                    <video id="videoContainer"  width="200" height="100" controls >
                                        <source src="/kmsvdo/<%=fullpath[i].substring(25).replace('\\', '/')%>" type="video/mp4" height="300"  class="thumb-img" alt="<%=rs.getString("subject")%>" >
                                    </video>
                                    <%--<img src="<%=rs.getString("graphicspath").substring(34, rs.getString("graphicspath").length() - 2).replace(" ", "%20")%>" height="300"  class="thumb-img" alt="<%=rs.getString("subject")%>">--%>
                                </a>
                                 <h4 class="text-center"><%=rs.getString("subject")%></h4>
                    <div class="ga-border"></div>
                    <p class="text-muted text-center"><small><%=rs.getString("sourcedate")%></small></p>
                            </div>
                    <!--</div>-->
                    <!--</div>-->
                    <%}
                        } else {%>
                    <!--<div class="col-sm-4" >-->
                        <div class="gal-detail thumb">
                            <!--<div class="image-popup" title="Screenshot-2">-->
                                <a href="<%=rs.getString("vdopath").substring(25)%>" target="_blank">
                                    <video id="videoContainer"  width="200" height="100" controls >
                                        <source src="/kmsvdo/<%=rs.getString("vdopath").substring(25).replace('\\', '/')%>" type="video/mp4" height="300"  class="thumb-img" alt="<%=rs.getString("subject")%>" >
                                    </video>
                                    <%--<img src="<%=rs.getString("graphicspath").substring(34, rs.getString("graphicspath").length() - 2).replace(" ", "%20")%>" height="300"  class="thumb-img" alt="<%=rs.getString("subject")%>">--%>
                                </a>
                                 <h4 class="text-center"><%=rs.getString("subject")%></h4>
                    <div class="ga-border"></div>
                    <p class="text-muted text-center"><small><%=rs.getString("sourcedate")%></small></p>
                            <!--</div>-->
                        </div>
                    <!--</div>--> 
                    <%}%>

                   <%-- <%
                        if (!rs.getString("graphicspath").isEmpty()) {
                            String image[] = rs.getString("graphicspath").split("::");
                            for (int i = 0; i < image.length; i++) {
                    %>
                    <div class="col-sm-4" >  <div class="gal-detail thumb">
                            <div class="image-popup" title="Screenshot-2">   
                                <img src="/kmsvdo/<%=image[i].substring(25).replace(" ", "%20")%>"   height="100"  class="thumb-img" alt="<%=rs.getString("subject")%>" >
                            </div></div>
                    </div>
                    <%}
                        } else {
                        }%>
--%>
                    <!--</div>-->
                   
                </div>
            </div>
            <%}%>
            <input type="hidden" id="row_no" value="12">
            <input type="hidden" id="query" value="<%=sqlQuery%>">

            </div>
            </div>
        </section>
        <!--                    <div id="displayVdoFile" class="modal" style="display: none">
                                 Modal content 
                                <div class="modal-content">
                                    <div class="row mb-2 text-center">
                                        <span class="close">&times;</span>
                                        <div class="col-lg-12">
        
                                            <div id="vdofile"></div>
                                            <p class="text-success semi-bold" id="demotext" style="font-size:18px"> File format not match. Please dragndrop .mp4 file </p>
                                        </div>
                                        <div class="col-lg-12">
                                            <button class="btn btn-primary" onclick="closeVdoFile()">Close</button></a>
                                        </div>
                                    </div>
                                </div>
                            </div>-->
        <!--                </div>
        
                    </div>-->
        <%  } catch (ArrayIndexOutOfBoundsException e) {
                e.printStackTrace();

            } catch (Exception e) {
                e.printStackTrace();
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
        <!--<script src="plugins/dropzone/dropzone.js"></script>--> 

        <!-- Jquery Validation Plugin Css --> 
        <script src="plugins/jquery-validation/jquery.validate.js"></script> 

        <!-- JQuery Steps Plugin Js --> 
        <script src="plugins/jquery-steps/jquery.steps.js"></script> 

        <!-- Waves Effect Plugin Js --> 
        <script src="plugins/node-waves/waves.js"></script> 

        <!-- Autosize Plugin Js --> 
        <script src="plugins/autosize/autosize.js"></script> 

        <!--Moment Plugin Js-->  
        <script src="plugins/momentjs/moment.js"></script> 

        <!-- Bootstrap Material Datetime Picker Plugin Js --> 
        <script src="plugins/bootstrap-material-datetimepicker/js/bootstrap-material-datetimepicker.js"></script>

        <!-- Bootstrap Datepicker Plugin Js --> 
        <script src="plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script> 

        <!-- Demo Js --> 
        <script src="js/demo.js"></script> 
        <script src="js/admin.js"></script>
        <script>
            $('#date-end').bootstrapMaterialDatePicker({weekStart: 0, time: false});
            $('#date-start').bootstrapMaterialDatePicker({weekStart: 0, time: false}).on('change', function (e, date)
            {
                $('#date-end').bootstrapMaterialDatePicker('setMinDate', date);
            });
            $('#date-end1').bootstrapMaterialDatePicker({weekStart: 0, time: false});
            $('#date-start1').bootstrapMaterialDatePicker({weekStart: 0, time: false}).on('change', function (e, date)
            {
                $('#date-end1').bootstrapMaterialDatePicker('setMinDate', date);
            });
        </script>

        <script>
            function errBlank(err) {
                document.getElementById(err).innerHTML = "";
            }

            $(document).ready(function () {
//                $(function () {
                function split(val) {
                    return val.split(/,\s*/);
                }
                function extractLast(term) {
                    return split(term).pop();
                }
                $("#tag")
                        .autocomplete({
                            source: function (request, response) {
//                                alert("tee");
                                $.getJSON("pr_jsonfile.jsp?description=" + document.getElementById("tag").value, {
                                    term: extractLast(request.term)
                                }, response);
                            },
                            search: function () {
                                // custom minLength
                                var term = extractLast(this.value);
//                                alert(term);
                                if (term.length < 2) {

                                    return false;
                                }
                            }
                        });
            });

//            (function ($) {
//                $(document).ready(function () {
//                    $('.panel-collapse').removeClass('in');
//                    $('.panel-title > a').addClass('collapsed');
//                });
//            })(jQuery);
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
//                                alert("hi");
                var val = document.getElementById("row_no").value;
                var query = document.getElementById("query").value;

                //            alert(val);
                $.ajax({
                    type: 'post',
                    url: 'em_gallery_fetch.jsp',
                    data: {
                        getresult: val,
                        querySearch: query
                    },
                    success: function (response) {
                        var content = document.getElementById("all_rows");
                        content.innerHTML = content.innerHTML + response;
//alert("test");
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