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
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("5") || session.getAttribute("role").equals("1"))) {

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

        <% if (session.getAttribute("role").equals("1")) {%>
        <jsp:include page="header.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <%} else if (session.getAttribute("role").equals("5")) {%>
        <jsp:include page="userHeader1.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <% }%>       <!--End navbar-->
        <!--                <div class="container-fluid" style="background-color:#f2f7f8">
                            <div class="row row-offcanvas row-offcanvas-right">-->
        <%--<jsp:include page="userLeft.jsp"></jsp:include>--%>
        <!-- SIDEBAR ENDS -->
        <% String getData = null, searchQuery = null, room = null, link = null;

        %>
        <section class="content">
            <div class="panel-group" id="accordion_1" role="tablist" aria-multiselectable="true">
                <div class="panel panel-primary">
                    <div class=panel-heading role=tab id=headingOne_1>
                        <h4 class=panel-title> <a role=button data-toggle=collapse data-parent=#accordion_1 href=#collapseOne_1 aria-expanded=true aria-controls=collapseOne_1 onclick=""> 

                                <span class="glyphicon glyphicon-menu-right rotate"></span> All In One Report Filter </a> 
                        </h4>
                    </div>
                    <div class="panel-body">
                        <form action="admin_export_report_final.jsp" method="post"> 

                            <div class="row clearfix">

                                <div class="col-md-3">
                                    <div class="form-group">
                                        <!--<label class="labelFilter"  for="tags">Tags:</label>-->
                                        <div class="form-line">
                                            <input type="text" class="form-control" name="generaltag" id="tagallinone"  placeholder="Enter Keyword">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <%                                                       Connection dh = null;
                                            ConnectionDB connectionDB = new ConnectionDB();
                                            dh = connectionDB.getConnection();
                                            try { %>
                                        <!--<label class="labelFilter"  for="sentiment">Sentiment:</label>-->
                                        <select class="form-control show-tick form-line" name="sentiment">
                                            <option value="">-Sentiment-</option>
                                            <%  PreparedStatement stmSentiment = null;
                                                ResultSet rsSentiment = null;
                                                try {
                                                    String sqlSentiment = "SELECT * FROM tbl_sentiment_details ";
                                                    System.out.println("sqlSelect-" + sqlSentiment);
                                                    stmSentiment = dh.prepareStatement(sqlSentiment);
                                                    rsSentiment = stmSentiment.executeQuery();
                                                    while (rsSentiment.next()) {
                                            %>
                                            <option value="<%=rsSentiment.getString(2)%>"><%=rsSentiment.getString(2)%></option>
                                            <%
                                                    }
                                                } catch (Exception e) {
                                                    e.printStackTrace();
                                                } finally {
                                                    if (stmSentiment != null) {
                                                        stmSentiment.close();
                                                    }
                                                    if (rsSentiment != null) {
                                                        rsSentiment.close();
                                                    }
                                                }
                                            %>
                                        </select>
                                        <%} catch (Exception e) {

                                                e.printStackTrace();
                                            } finally {
                                                if (dh != null) {
                                                    dh.close();
                                                }
                                            }
                                        %>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="form-group">
                                        <!--<label class="labelFilter"  for="fromdate">From Date:</label>-->
                                        <input type="text" class="form-control form-line" id="date-start1" name="fromdate" placeholder="From Date">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <!--<label class="labelFilter"  for="todate">To Date:</label>-->
                                        <input type="text" class="form-control form-line"  id="date-end1"  name="todate" placeholder="To Date">
                                    </div>
                                </div>
                            </div>
                            <!--                            <div class="col-md-3">
                                                            <div class="form-group text-center">-->
                            <!--<label class="labelFilter"  for="todate">To Date:</label>-->
                            <button type="submit" class="btn bg-black waves-effect waves-light text-right" onclick="submitExport()" style="margin: 0px auto">SEARCH</button>


                            <!--                                </div>
                                                        </div>-->
                    
                    </form>
                </div>
                </div>
            </div>
        </div>
    </section>
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
    <!--<script src="plugins/node-waves/waves.js"></script>--> 

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
                                $(document).ready(function () {
                                    // Add minus icon for collapse element which is open by default
                                    $(".collapse.in").each(function () {
                                        $(this).siblings(".panel-heading").find(".glyphicon").addClass(".rotate");
                                    });
                                    // Toggle plus minus icon on show hide of collapse element
                                    $(".collapse").on('show.bs.collapse', function () {
                                        $(this).parent().find(".glyphicon").addClass(".rotate");
                                    }).on('hide.bs.collapse', function () {
                                        $(this).parent().find(".glyphicon").removeClass(".rotate");
                                    });
                                });
    </script>
    <script>
        function NumberOnly(evt)
        {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }

        function printdiv(printpage)
        {
            var divToPrint = document.getElementById(printpage);

            $("table").css("border", "1px solid black");
            $("table").css("border-spacing", "0");
            $("th").css("border", "1px solid black");
//                $("th").css("background-color", "#f1f1f1");
            $("td").css("border", "1px solid black");
            newWin = window.open("");
            $("th").css("background-color", " #00A0E3 !important");
            $("th").css("color", " #FFF !important");
            $("table#exportData tr:even").css("background-color", "#FFF");
            $("table#exportData tr:odd").css("background-color", "#eff0f1");
            newWin.document.write(divToPrint.outerHTML);
            newWin.print();
            newWin.close();
//                document.body.innerHTML = restorepage;
        }
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
        function exportPrintMediaData() {
//                alert("test");
            var xmlhttp;
            var fromDate = document.getElementById("date-start1").value;
            var toDate = document.getElementById("date-end1").value;
            var sentiment = document.getElementById("sentiment").value;
            var importance = document.getElementById("importance").value;

            if (fromDate == "") {
//                    alert(fromDate);
//                    document.getElementById("errFromDate").innerHTML = "Please select From Date";
                document.getElementById("date-start1").focus();
                return false;
            }
            if (toDate == "") {
                document.getElementById("date-end1").focus();
                return false;
            }
            var xhttp = new XMLHttpRequest();
            var urls = "getexportprintmediafield.jsp?tfulldate=" + toDate + "&ffulldate=" + fromDate + "&sentiment=" + sentiment + "&importance=" + importance;
//alert(urls);
            xhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
//                        document.getElementById("example").style.visibility = "hidden";
                    document.getElementById("loadExportData").innerHTML = this.responseText;
                    document.getElementById("pdfPrint").style.display = "block";

                    $('.dataTable').DataTable({
                        dom: 'Bfrtip',
                        paging: false,
                        buttons: [
                            {
                                extend: 'excelHtml5',
                                title: 'Media Monitoring Sheet',
                                orientation: 'landscape',
                                pageSize: 'LEGAL',
                                className: 'btn btn-primary btn-user btn-capsules btn-sm mob-btn btnExcel',
//                    background: '#0053ba'
                            },
                            {
                                extend: 'csvHtml5',
                                title: 'Media Monitoring Sheet',
                                orientation: 'landscape',
                                pageSize: 'LEGAL',
                                className: 'btn btn-success btn-user btn-capsules btn-sm mob-btn btnExcel',
//                                }, {
//                                    extend: 'pdfHtml5',
//                                    title: 'Media Monitoring Sheet',
//                                    orientation: 'landscape',
//                                    pageSize: 'LEGAL',
//                                    className: 'btn btn-danger btn-user btn-capsules btn-sm mob-btn btnExcel',
                            }
                        ]
                    });
                }
            };
            xhttp.open("POST", urls, true);
            xhttp.send();
        }

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
            $("#tagallinone")
                    .autocomplete({
                        source: function (request, response) {
//                                alert("tee");
                            $.getJSON("pr_jsonfile.jsp?description=" + document.getElementById("tagallinone").value, {
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
</body>
</html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>