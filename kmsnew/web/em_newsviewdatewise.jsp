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
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("2") || session.getAttribute("role").equals("3") || session.getAttribute("role").equals("6") || session.getAttribute("role").equals("5"))) {

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
        <link href="https://fonts.googleapis.com/css?family=Roboto:400,700&subset=latin,cyrillic-ext" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" type="text/css">


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
        <link href="css/jquery-ui.css" rel="stylesheet">
        <!-- AdminBSB Themes. You can choose a theme from css/themes instead of get all themes -->
        <link href="css/themes/all-themes.css" rel="stylesheet" />
        <link href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css" rel="stylesheet" />
        <style>
            /* Ensure that the demo table scrolls */
            th, td { white-space: nowrap; }
            div.dataTables_wrapper {
                margin: 0 auto;
            }

            div.container {
                width: 80%;
            }	
        </style>

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
        <!--Navbar-->
        <!--Navbar--> 
        <% if (session.getAttribute("role").equals("5")) {%>
        <jsp:include page="userHeader1.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <%} else if (session.getAttribute("role").equals("3")) {%>
        <jsp:include page="em_header.jsp"></jsp:include>
        <jsp:include page="em_left.jsp"></jsp:include>
        <%}%> <%
            Connection dh = null;

            PreparedStatement stm1 = null;
            ResultSet rs1 = null;
            PreparedStatement stm = null;
            ResultSet rs = null;
            ConnectionDB conn = new ConnectionDB();
            dh = conn.getConnection();
            String getData = null, searchQuery = null, room = null, link = null;
            String fromDate = null, toDate = null;
            String dateQuery = null;

            if (!request.getParameter("fromSourceDate").isEmpty() && !request.getParameter("toSourceDate").isEmpty()) {
                fromDate = request.getParameter("fromSourceDate");
                toDate = request.getParameter("toSourceDate");
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
//                    dateQuery = " (str_to_date(sourcedate,'%d/%m/%Y') >='" + fromDate + "' AND str_to_date(sourcedate,'%d/%m/%Y') <='" + toDate + "')";
                dateQuery = " (sourcedate BETWEEN '" + fromDate + "' AND '" + toDate + "')";
            } else {
                dateQuery = "";
            }
            try {
                if (session.getAttribute("role").equals("5")) {
                    String sql = "SELECT * from tbl_news_dataentry where " + dateQuery + " and workocode like ? ";
                    //String sql = "Select subject,graphicspath,vdopath,docpath,audiopath  WHERE MATCH (subject, description, summary,general,teletag,districttag,talukatag,villagetag,additionaltag)  AGAINST ('" + subject + "' )";
                    //            String sql = "Select subject,graphicspath,vdopath,docpath,audiopath from tbl_news_dataentry where workcode =?";
                    System.out.println("sql:-" + sql);
                    stm = dh.prepareStatement(sql);
                    stm.setString(1, "%EN%");
//                    stm.setString(2, "%N%");
                } else {
                    String sql = "SELECT * FROM tbl_news_dataentry where " + dateQuery + "  and workcode like ?  and userid=?";
//                 String sql = "SELECT workcode,brand,location,language,npname,edition,subedition,subject,titlemarathi,sourcedate,sentiment FROM tbl_news_dataentry where "+dateQuery+" and userid=? and  workcode  like ? and workcode not like ? ";
                    //String sql = "Select subject,graphicspath,vdopath,docpath,audiopath  WHERE MATCH (subject, description, summary,general,teletag,districttag,talukatag,villagetag,additionaltag)  AGAINST ('" + subject + "' )";
                    //            String sql = "Select subject,graphicspath,vdopath,docpath,audiopath from tbl_news_dataentry where workcode =?";
                    System.out.println("sql:-" + sql);
                    stm = dh.prepareStatement(sql);
//                stm.setString(1, request.getParameter("fromSourceDate"));
//                stm.setString(2, request.getParameter("toSourceDate"));
                    stm.setString(1, "%EN%");
//                    stm.setString(2, "%N%");
                    stm.setString(2, userid);
                }
                rs = stm.executeQuery();
                int number = 0;
        %><section class="content">
            <div class="col-md-12"> 
                <!-- Unordered List -->
                <div class="row clearfix">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="card">
                            <div class="header">
                                <h2>Electronic News Data Entry List</h2>
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
                                    <form action="em_newsviewdatewise.jsp" id="myForm" method="get">

                                        <div class="form-group">
                                            <!--<form action="approver_export_data.jsp" method="post">-->
                                            <div class="col-sm-4">
                                                <input type="text" id="date-start1" name="fromSourceDate" class="form-control" value="<%=request.getParameter("fromSourceDate")%>" placeholder="FROM DATE..." autocomplete="off">
                                            </div>
                                            <div class="col-sm-4">
                                                <input type="text" id="date-end1" name="toSourceDate" class="form-control" value="<%=request.getParameter("toSourceDate")%>" placeholder="TO DATE..." autocomplete="off">
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
                            <div class="body clearfix">
                                <div class="table-responsive">
                                    <table id="example"  class="table table-bordered table-striped table-hover ">
                                        <!--<table id="exampledata" class="table table-bordered table-striped table-hover dataTable js-exportable">-->
                                        <thead style="background:#fff">

                                            <tr>
                                                <th>Sr.No</th>
                                                <th>Dataentry Reference no</th>
                                                <th>Channel</th>
                                                <th>Title (English)</th>
                                                <th>Title (Marathi)</th>
                                                <!--<th>Description</th>-->
                                                <!--<th>Summary</th>-->
                                                <th>Source Date</th>
                                                <!--<th>Edit </th>-->
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                while (rs.next()) {
                                                    number++;

                                            %>
                                            <tr>
                                                <td>
                                                    <a href="em_newsedit.jsp?workcode=<%=rs.getString("workcode")%>&fromdate=<%=fromDate%>&todate=<%=toDate%>" title="Click Here"  class="btn btn-warning waves-effect"> <%=number%> </a>
                                                </td>
                                                <td><%=rs.getString("workcode")%></td>
                                                <td><%=rs.getString("chname")%></td>
                                                <td><%=rs.getString("subject")%></td>
                                                <td><%=rs.getString("titlemarathi")%></td>

                                                <td><%=rs.getString("sourcedate")%></td>

                                            </tr>
                                            <%}%>
                                        </tbody>

                                    </table></div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- #END# Unordered List --> 
            </div>
            <div class="modal fade bodyBackground" id="displayVdoFile" tabindex="-1" role="dialog" style="display: none">
                <div class="modal-dialog m-t-125" role="document">
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

            <%} catch (Exception e) {
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
        </section>
        <!--<script src="js/jquery-ui.js"></script>-->
        <!--<script src="js/jquery-ui.js" type="text/javascript"></script>-->
        <!--Load SCRIPT.JS which will create datepicker for input field-->  
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
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/fixedcolumns/3.3.0/js/dataTables.fixedColumns.min.js"></script>

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
            //      $("#example").dataTable().fnDestroy();
            $('#example').DataTable({
//                columnDefs: [
//                    {width: 50, targets: 1}
//                ],
//                // autoWidth: false,
//                scrollY: "400px",
//                scrollX: true,
//                scrollCollapse: true,
//                paging: false,
//                fixedColumns: {
//                    leftColumns: 3
//                },
//                paging: false,
                //      bDestroy: true,     
                //    searching: false,
                dom: 'Bfrtip',
                buttons: [
                    {
                        extend: 'excelHtml5',
                        title: 'Media Monitoring Sheet',
                        orientation: 'landscape',
                        pageSize: 'LEGAL',
                        className: 'btn btn-primary btn-user btn-capsules btn-sm mob-btn btnExcel',
                        //                    background: '#0053ba'
                    }
//                    {
//                        extend: 'csvHtml5',
//                        title: 'Media Monitoring Sheet',
//                        orientation: 'landscape',
//                        pageSize: 'LEGAL',
//                        className: 'btn btn-success btn-user btn-capsules btn-sm mob-btn btnExcel',
//                        //                }, {
//                        //                    extend: 'pdfHtml5',
//                        //                    title: 'Media Monitoring Sheet',
//                        //                    orientation: 'landscape',
//                        //                    pageSize: 'LEGAL',
//                        //                    className: 'btn btn-danger btn-user btn-capsules btn-sm mob-btn btnExcel',
//                    }
                ]
            });
            //          $('.dataTable').DataTable({
            //              paging: false,
            //            searching: false,
            //            destroy: true
            //        }
            //        );
        </script>
        <script>
            $('#date-end1').bootstrapMaterialDatePicker({weekStart: 0, time: false});
            $('#date-start1').bootstrapMaterialDatePicker({weekStart: 0, time: false}).on('change', function (e, date)
            {
                $('#date-end1').bootstrapMaterialDatePicker('setMinDate', date);
            });
            $('#date-end').bootstrapMaterialDatePicker({weekStart: 0, time: false});
            $('#date-start').bootstrapMaterialDatePicker({weekStart: 0, time: false}).on('change', function (e, date)
            {
                $('#date-end').bootstrapMaterialDatePicker('setMinDate', date);
            });
            $(function () {
                function split(val) {
                    return val.split(/,\s*/);
                }
                function extractLast(term) {
                    return split(term).pop();
                }

                $("#generaltag")
                        .autocomplete({
                            source: function (request, response) {
                                $.getJSON("jsonfile_printmedia.jsp?description=" + document.getElementById("generaltag").value, {
                                    term: extractLast(request.term)
                                }, response);
                            },
                            search: function () {
                                // custom minLength
                                var term = extractLast(this.value);
                                //           alert(term);
                                if (term.length < 2) {

                                    return false;
                                }
                            },
                        });
            });
            function displayVdoFilesData(file) {
                var x = document.createElement("VIDEO");

                if (x.canPlayType("video/mp4")) {
                    x.setAttribute("src", file);
                } else {
                    x.setAttribute("src", "movie.ogg");
                }

                x.setAttribute("width", "320");
                x.setAttribute("height", "240");
                x.setAttribute("controls", "controls");
                document.body.appendChild(x);
//                var xhttp = new XMLHttpRequest();
////                alert("hi");
//                var urls = "videogrid_homepage_1.jsp?searchresult=" + file;
//                xhttp.onreadystatechange = function () {
//                    if (this.readyState == 4 && this.status == 200) {
//
//                        alert(this.responseText);
//                        document.getElementById("displayVdoFile").style.display = "block";
//
//                        document.getElementById("vdofile").innerHTML = this.responseText;
//                    }
//                };
//                xhttp.open("GET", urls, true);
//                xhttp.send();
            }
        </script>
    </body>
</html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>