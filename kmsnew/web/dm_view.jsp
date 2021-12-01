<%-- 
    Document   : home
    Created on : Nov 15, 2017, 11:30:13 PM
    Author     : Amol
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<jsp:forward page="dashboard.jsp"></jsp:forward>--%>
<%ResourceBundle rb = ResourceBundle.getBundle("msg"); %>
<%
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("6") || session.getAttribute("role").equals("3") || session.getAttribute("role").equals("5"))) {

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

        <!-- Favicon-->
        <link rel="icon" href="images/favicon.ico" type="image/x-icon">

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

        <link href="css/jquery-ui.css" rel="stylesheet">


        <script>
            //jQuery(function(){
            //$("#generaltag").autocomplete("list.jsp");
            //});
        </script>


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
        <% if (session.getAttribute("role").equals("5")) {%>
        <jsp:include page="userHeader1.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <%} else if (session.getAttribute("role").equals("6")) {%>
        <jsp:include page="dm_header.jsp"></jsp:include>
        <jsp:include page="dm_left.jsp"></jsp:include>
        <%}%>
        <%--<jsp:include page="dm_header.jsp"></jsp:include>--%>
        <%--<jsp:include page="dm_left.jsp"></jsp:include>--%>
        <!--<div id="txtAge" style="display:none">Age is something</div>-->

        <!-- SIDEBAR ENDS -->
        <%String getData = null, searchQuery = null, room = null, link = null;
//            if (request.getParameter("searchresult").equals("R")) {
//                getData = request.getParameter("searchresult");
//                room = "Raw Data Dataentry List";
//                link = "rawdata_dataentry_edit.jsp";
//            } else if (request.getParameter("searchresult").equals("N")) {
//                getData = request.getParameter("searchresult");
//                room = "Media Room Dataentry List";
//                link = "newsinformation_dataentry_edit_1.jsp";
//            } else if (request.getParameter("searchresult").equals("G")) {
//                getData = request.getParameter("searchresult");
//                room = "Creative Team Dataentry List";
//                link = "graphicsinformation_dataentry_edit.jsp";
//            }
            ConnectionDB connectionDB = new ConnectionDB();
            Connection conn = null;
            try {
                conn = connectionDB.getConnection();

//                String sql = "SELECT * FROM tbl_twitter_post  ";
////            String sql = "SELECT * FROM tbl_news_dataentry where workcode like '%D%' ";
//                //String sql = "Select subject,graphicspath,vdopath,docpath,audiopath  WHERE MATCH (subject, description, summary,general,teletag,districttag,talukatag,villagetag,additionaltag)  AGAINST ('" + subject + "' )";
//                //            String sql = "Select subject,graphicspath,vdopath,docpath,audiopath from tbl_news_dataentry where workcode =?";
//                System.out.println("sql:-" + sql);
//                PreparedStatement stm = ConnectionDB.getDBConnection().prepareStatement(sql);
//                //            stm.setString(1, s);
//                ResultSet rs = stm.executeQuery();
//                int number = 0;
        %>


        <section class="content">
            <div class="col-md-12"> 
                <!-- Unordered List -->
                <div class="row clearfix">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="card">
                            <div class="header">
                                <h2>Digital Media Data Entry List</h2>
                                <ul class="header-dropdown m-r--5">
<!--                                    <li class="dropdown"> <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="material-icons">more_vert</i> </a>
                                                                                <ul class="dropdown-menu pull-right">
                                                                                    <li><a href="javascript:void(0);">Action</a></li>
                                                                                    <li><a href="javascript:void(0);">Another action</a></li>
                                                                                    <li><a href="javascript:void(0);">Something else here</a></li>
                                                                                </ul>
                                    </li>-->
                                </ul>
                            </div>
                            
                            <div class="row clearfix">
                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                    <form action="dm_viewdatewise.jsp" id="myForm" method="get">

                                        <div class="form-group">
                                            <!--<form action="approver_export_data.jsp" method="post">-->
                                            <div class="col-sm-4">
                                                <input type="text" id="date-start1" name="fromSourceDate" class="form-control" placeholder="FROM DATE..." autocomplete="off" required>
                                            </div>
                                            <div class="col-sm-4">
                                                <input type="text" id="date-end1" name="toSourceDate" class="form-control" placeholder="TO DATE..." autocomplete="off" required>
                                            </div>
                                            <!--                        </div>-->
                                            <div class="col-sm-4">
                                                <!--<br>-->
                                                <div class="col-sm-12 text-center">
                                                    <button type="submit" class="btn btn-danger "  id="btnSaveVideo"  >SEARCH</button>
                                                    <!--                                                            <button type="submit" class="btn btn-danger " data-toggle="modal" data-target="#defaultModal" onclick="saveEditData()" id="btnSaveVideo"  >UPDATE</button>-->
                                                </div>
                                            </div>
                                        </div>
                                        <!--<div class="form-group"></div>-->
                                        <div class="form-group">
                                            <br>
                                            <br>
                                            <div class="form-line"></div>
                                        </div>
                                        <!--<hr>-->
                                    </form>

                                </div>

                            </div>
                  <%--          <div class="body clearfix">
                                <div class="table-responsive">

                                    <!--<table class="table table-bordered table-striped table-hover dataTable">-->
                                    <table  class="table table-bordered table-striped table-hover dataTable js-exportable">
                                        <!--<table id="exampledata" class="table table-bordered table-striped table-hover dataTable js-exportable">-->
                                        <thead>
                                            <tr>
                                                <th>Sr.No</th>
                                                <th>Source</th>
                                                <th>Topic</th>
                                                <th>URL</th>
                                                <th>Post</th>
                                                <th>Count</th>
                                                <th>Sentiment</th>
                                                <th>Sourcedate</th>
                                                <th>Edit </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                while (rs.next()) {
                                                    number++;

                                            %>
                                            <tr>
                                                <td><a href="dm_edit.jsp?workcode=" title="Click Here"  class="btn btn-warning waves-effect"> <%=number%> </a></td>
                                                <td><%=rs.getString("source")%></td>
                                                <td><%=rs.getString("topic")%></td>
                                                <td><%=rs.getString("url")%></td>
                                                <td>
                                                    <%if (rs.getString("post") != null) {%>
                                                    <%=rs.getString("post")%><%}%></td>
                                                <td><%=rs.getString("count")%></td>
                                                <td><%=rs.getString("sentiment")%></td>
                                                <td>--</td>


                                            </tr>
                                            <%}%>
                                        </tbody>
                                    </table>
                                </div>
                            </div>--%>
                        </div>
                    </div>
                </div>
                <!-- #END# Unordered List --> 
            </div>
            <%} catch (Exception e) {

                    e.printStackTrace();
                } finally {

                    if (conn != null) {
                        conn.close();
                    }
                }
            %>
        </section>

        <div class="modal fade m-t-125" id="defaultModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title text-center" id="defaultModalLabel">Media Room Video</h4>
                    </div>
                    <div class="modal-body text-center">
                        <div id="vdofile"></div>
                        <!--<iframe width="560" height="315" src="https://www.youtube.com/embed/u3xKgwKUQLc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>-->
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-link waves-effect" data-dismiss="modal">CLOSE</button>
                    </div>
                </div>
            </div>
        </div>
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

        <!-- Jquery DataTable Plugin Js -->
        <script src="plugins/jquery-datatable/jquery.dataTables.js"></script>
        <script src="plugins/jquery-datatable/skin/bootstrap/js/dataTables.bootstrap.js"></script>
        <script src="plugins/jquery-datatable/extensions/export/dataTables.buttons.min.js"></script>
        <script src="plugins/jquery-datatable/extensions/export/buttons.flash.min.js"></script>
        <script src="plugins/jquery-datatable/extensions/export/jszip.min.js"></script>
        <script src="plugins/jquery-datatable/extensions/export/pdfmake.min.js"></script>
        <script src="plugins/jquery-datatable/extensions/export/vfs_fonts.js"></script>
        <script src="plugins/jquery-datatable/extensions/export/buttons.html5.min.js"></script> 
        <script src="plugins/jquery-datatable/extensions/export/buttons.print.min.js"></script>

        <!-- Custom Js -->
        <script src="js/admin.js"></script>
        <script src="js/pages/tables/jquery-datatable.js"></script>
        <script src="js/pages/forms/form-validation.js"></script> 
        <script src="js/pages/forms/form-wizard.js"></script> 
        <!--        <script src="js/pages/forms/basic-form-elements.js"></script> 
                <script src="js/pages/forms/advanced-form-elements.js"></script> -->

        <!-- Demo Js --> 
        <script src="js/demo.js"></script> 

        <script>
//            $(document).ready(function () {
//                $('#exampledata').DataTable({
//                    dom: 'Bfrtip',
//                    buttons: [
//                        {
//                            extend: 'excelHtml5',
//                            title: 'Media Monitoring Sheet',
//                            orientation: 'landscape',
//                            pageSize: 'LEGAL',
//                            className: 'btn btn-primary btn-user btn-capsules btn-sm mob-btn btnExcel',
//                            //                    background: '#0053ba'
//                        },
//                        {
//                            extend: 'csvHtml5',
//                            title: 'Media Monitoring Sheet',
//                            orientation: 'landscape',
//                            pageSize: 'LEGAL',
//                            className: 'btn btn-success btn-user btn-capsules btn-sm mob-btn btnExcel',
//                        }, {
//                            extend: 'pdfHtml5',
//                            title: 'Media Monitoring Sheet',
//                            orientation: 'landscape',
//                            pageSize: 'LEGAL',
//                            className: 'btn btn-danger btn-user btn-capsules btn-sm mob-btn btnExcel',
//                        }
//                    ]
//                });
//            });
        </script>
        <script>
            $('#date-end').bootstrapMaterialDatePicker({weekStart: 0, time: false});
            $('#date-start').bootstrapMaterialDatePicker({weekStart: 0, time: false}).on('change', function (e, date)
            {
                $('#date-end').bootstrapMaterialDatePicker('setMinDate', date);
            });
        </script>
        <script>
//            $(function () {
//                function split(val) {
//                    return val.split(/,\s*/);
//                }
//                function extractLast(term) {
//                    return split(term).pop();
//                }
//
//                $("#generalTag input")
//                        .autocomplete({
//                            source: function (request, response) {
//                                $.getJSON("jsonfile_1.jsp?description=" + document.getElementById("generaltag").value, {
//                                    term: extractLast(request.term)
//                                }, response);
//                            },
//                            search: function () {
//                                // custom minLength
//                                var term = extractLast(this.value);
//                                //           alert(term);
//                                if (term.length < 2) {
//
//                                    return false;
//                                }
//                            },
//                        });
//            });
        </script>
        <script>
            $(document).ready(function () {
//                $(function () {
                function split(val) {
                    return val.split(/,\s*/);
                }
                function extractLast(term) {
                    return split(term).pop();
                }

                $("#generaltag")
//                $("#generalTag1 input")
                        .autocomplete({
                            source: function (request, response) {
//                                alert("tee");
                                $.getJSON("jsonfile_1.jsp?description=" + document.getElementById("generaltag").value, {
                                    term: extractLast(request.term)
                                }, response);
                            },
                            search: function () {
                                // custom minLength
                                var term = extractLast(this.value);
//                                           alert(term);
                                if (term.length < 2) {

                                    return false;
                                }
                            },
                        });
            });
//        });
        </script>
        <script>
            $('#date-end1').bootstrapMaterialDatePicker({weekStart: 0, time: false});
            $('#date-start1').bootstrapMaterialDatePicker({weekStart: 0, time: false}).on('change', function (e, date)
            {
                $('#date-end1').bootstrapMaterialDatePicker('setMinDate', date);
            });</script>
        <script>
            function showData() {
//                alert("test");
                var xmlhttp;
                var subject = document.getElementById("generaltag").value;
                var fromDate = document.getElementById("fromDate").value;
                var toDate = document.getElementById("toDate").value;
// var checkboxes = document.getElementsByName("chkkms");
//  var checkboxesChecked = [];
                var checkedBoxes;
//  // loop over them all
//  for (var i=0; i<checkboxes.length; i++) {
//     // And stick the checked ones onto an array...
//     if (checkboxes[i].checked) {
//       checkedBoxes= checkboxesChecked.push(checkboxes[i].value);
//     }
//  }
                var array = [];
                $('input[type="checkbox"]:checked').each(function () {
                    array.push($(this).val());
                });
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
                    xmlhttp.open("POST", "grid_category_all_data.jsp?generaltag=" + subject + "&fromdate=" + fromDate + "&todate=" + toDate + "&searchresult=" + array.join(','), true);
                    xmlhttp.send();
                } else {

                    document.getElementById("errGeneral").innerHTML = "Please enter the value";
                    document.getElementById("generaltag").focus();
                    return false;
//                alert("Please enter data");
                }
            }
            function errBlank(err) {
                document.getElementById(err).innerHTML = '';
            }
            function closeVdoFile() {
                document.getElementById("displayVdoFile").style.display = "none";
                var video = document.getElementById("videoContainer");

                video.pause();
                video.currentTime = 0;


            }
            function displayVdoFilesData(file) {

                var xhttp = new XMLHttpRequest();
//alert("hi");
                var urls = "videogrid_homepage_1.jsp?searchresult=" + file;
                xhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
//                        document.getElementById("displayVdoFile").style.display = "block";

                        document.getElementById("vdofile").innerHTML = this.responseText;
                    }
                };
                xhttp.open("GET", urls, true);
                xhttp.send();
            }
        </script>

    </body>
</html>
<%
    } else {
        response.sendRedirect("login.jsp");
    }%>