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

      <% if (session.getAttribute("role").equals("1")) {%>
        <jsp:include page="header.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <%} else if (session.getAttribute("role").equals("5")) {%>
        <jsp:include page="userHeader1.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <% }%>      <!--End navbar-->
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
        %>
        <section class="content">
            <div class="panel-group" id="accordion_1" role="tablist" aria-multiselectable="true">
                <div class="panel panel-primary">
                    <div class="panel-heading" role="tab" id="headingOne_1">
                        <h4 class="panel-title"> <a role="button" data-toggle="collapse" data-parent="#accordion_1" href="#collapseOne_1" aria-expanded="true" aria-controls="collapseOne_1"> 
                                <span class="glyphicon glyphicon-menu-right "></span> Creative Team Filters </a> </h4>
                    </div>
                    <div id="collapseOne_1" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne_1">
                        <jsp:include page="cr_approver_export_filter_show.jsp"></jsp:include>
                    </div>
                </div>
            </div>
            <%-- <div class="col-md-12"> 
                 <!-- Unordered List -->
                 <div class="row clearfix">
                     <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

                        <div class="form-group">
                            <!--<form action="approver_export_data.jsp" method="post">-->
                            <div class="col-sm-3">

                                <input type="text" id="date-start1" name="fromSourceDate" class="form-control" placeholder="FROM DATE..." autocomplete="off">

                            </div>

                            <div class="col-sm-3">

                                <input type="text" id="date-end1" name="toSourceDate" class="form-control" placeholder="TO DATE..." autocomplete="off">

                            </div>

                            <div class="col-sm-3">
                                <select class="form-control" name="sentiment" id="sentiment" onchange="changeSentiment(this.value)">
                                    <option  value="">Sentiment</option>
                                    <%                                        String sqlSentiment = "SELECT * FROM tbl_sentiment_details ";
                                        System.out.println("sqlSelect-" + sqlSentiment);
                                        PreparedStatement stmSentiment = ConnectionDB.getDBConnection().prepareStatement(sqlSentiment);
                                        ResultSet rsSentiment = stmSentiment.executeQuery();
                                        while (rsSentiment.next()) {
                                    %>
                                    <option value="<%=rsSentiment.getString(2)%>"><%=rsSentiment.getString(2)%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="col-sm-3">
                                <select class="form-control" name="importance" id="importance" onchange="changeImportance(this.value)" >
                                    <option  value="">Importance</option>
                                    <option value="Very Important">Very Important</option>
                                    <option value="Important">Important</option>

                                </select>
                            </div>

                        </div>
                        <div class="form-group">
                            <br>
                            <div class="col-sm-12 text-center">
                                <button type="button" class="btn btn-danger "  onclick="exportPrintMediaData()"  id="btnSaveVideo"  >SEARCH</button>
                                <button type="button" class="dt-button buttons-pdf buttons-html5 btn btn-danger btn-user btn-capsules btn-sm mob-btn btnExcel "  onclick="printdiv('exportData')"  id="pdfPrint" style="position: absolute;top: 305%;    left: 12%;    padding: 7px 12px; display: none;z-index: 100" >PDF</button>

                                <!--                                                            <button type="submit" class="btn btn-danger " data-toggle="modal" data-target="#defaultModal" onclick="saveEditData()" id="btnSaveVideo"  >UPDATE</button>-->
                            </div>
                        </div>
                        <!--<div class="form-group"></div>-->
                        <div class="form-group">
                            <br>
                            <div class="form-line"></div>
                        </div>
                        <hr>
                        <!--</form>-->
                        <div id="loadExportData"></div>    
                    </div>

                </div>

            </div>--%>
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

        <!-- Jquery DataTable Plugin Js -->
        <!--        <script src="plugins/jquery-datatable/jquery.dataTables.js"></script>
                <script src="plugins/jquery-datatable/skin/bootstrap/js/dataTables.bootstrap.js"></script>
                <script src="plugins/jquery-datatable/extensions/export/dataTables.buttons.min.js"></script>
                <script src="plugins/jquery-datatable/extensions/export/buttons.flash.min.js"></script>
                <script src="plugins/jquery-datatable/extensions/export/jszip.min.js"></script>
                <script src="plugins/jquery-datatable/extensions/export/pdfmake.min.js"></script>
                <script src="plugins/jquery-datatable/extensions/export/vfs_fonts.js"></script>
                <script src="plugins/jquery-datatable/extensions/export/buttons.html5.min.js"></script> 
                <script src="plugins/jquery-datatable/extensions/export/buttons.print.min.js"></script>-->

        <!-- Custom Js -->
        <!--<script src="js/pages/tables/jquery-datatable.js"></script>-->
        <!--        <script src="js/pages/forms/form-validation.js"></script> 
                <script src="js/pages/forms/form-wizard.js"></script> -->
        <!--        <script src="js/pages/forms/basic-form-elements.js"></script> 
                <script src="js/pages/forms/advanced-form-elements.js"></script> -->

        <!-- Demo Js --> 
        <script src="js/demo.js"></script> 
        <script src="js/admin.js"></script>
<script>
    $(document).ready(function(){
        // Add minus icon for collapse element which is open by default
        $(".collapse.in").each(function(){
        	$(this).siblings(".panel-heading").find(".glyphicon").addClass(".rotate");
        });
        // Toggle plus minus icon on show hide of collapse element
        $(".collapse").on('show.bs.collapse', function(){
        	$(this).parent().find(".glyphicon").addClass(".rotate");
        }).on('hide.bs.collapse', function(){
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
             function  getMarathi(val) {
                var xmlhttp;
//               
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp = new XMLHttpRequest();
                } else
                {// code for IE6, IE5
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                var urls = "gr_getmarathidept.jsp?dept=" + val;


                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                    {
                        var resp = xmlhttp.responseText;
//                         alert(resp);
                        document.getElementById("deptmarathi").value = resp.trim();

                    }
                };
                xmlhttp.open("POST", urls, true);
                xmlhttp.send();

            }
                                    function submitExport()
                                    {
                                        var sellanguage = document.getElementById("language");
                                        var textsellanguage = sellanguage.options[sellanguage.selectedIndex].text;
                                        document.getElementById("language1").value = textsellanguage;
                                        var selnewspaper = document.getElementById("newspaper");
                                        var textnewspaper = selnewspaper.options[selnewspaper.selectedIndex].text;
                                        document.getElementById("newspaper1").value = textnewspaper;

                                        var seledition = document.getElementById("edition");
                                        var textedition = seledition.options[seledition.selectedIndex].text;
                                        document.getElementById("edition1").value = textedition;
                                        if (document.getElementById("subedition").value != "-1") {
                                            var selsubedition = document.getElementById("subedition");
                                            var textsubedition = selsubedition.options[selsubedition.selectedIndex].text;
                                            document.getElementById("subedition1").value = textsubedition;
                                        }
                                    }
                                    function printdiv(printpage)
                                    {
//                $("#exportData").DataTable({
//                    
//                    paging: false,
//                 dom: 'Bfrtip'});
//var headstr = "<html><head><title></title></head><body>";
//var footstr = "</body>";
//var newstr = document.all.item(printpage).innerHTML;
//var oldstr = document.body.innerHTML;
//document.body.innerHTML = headstr+newstr+footstr;
//window.print();
//document.body.innerHTML = oldstr;
//return false;
//                var restorepage = document.body.innerHTML;
//                var printcontent = document.getElementById(printpage).innerHTML;
//                document.body.innerHTML = printcontent;
////        window.open('width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');
//                window.print();
                                        var divToPrint = document.getElementById(printpage);

                                        $("table").css("border", "1px solid black");
                                        $("table").css("border-spacing", "0");
                                        $("th").css("border", "1px solid black");
//                $("th").css("background-color", "#f1f1f1");
                                        $("td").css("border", "1px solid black");
//                divToPrint.cell.styles.textColor = '#000000';
//// the same as
//                divToPrint.style.borderTopWidth = "4px";
//                divToPrint.style.borderTopColor = "green";
//                divToPrint.style.borderTopStyle = "dashed";
//                divToPrint.style.borderBottom = "1px solid red";
//                divToPrint.style.borderTop = "1px solid green";
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
            function selectNewsPaper1(val) {

                if (val == "lang") {
                    var xhttp = new XMLHttpRequest();
                    var language = document.getElementById("language").value;
                    var urls = "get_newspaper.jsp?language=" + language;
//                    alert(urls);
                    xhttp.onreadystatechange = function () {
                        if (this.readyState == 4 && this.status == 200) {
//                        alert(this.responseText);
                            document.getElementById("newspaper").innerHTML = this.responseText;
                            $('#edition').empty();
                            $('#edition').append($('<option>', {text: 'Select Edition', value: '-1', selected: true}))
                            $('#edition').change();
                            $('#subedition').empty();
                            $('#subedition').append($('<option>', {text: 'Select Sub Edition', value: '-1', selected: true}))
                            $('#subedition').change();
                        }
                    };
                    xhttp.open("POST", urls, true);
                    xhttp.send();
                } else if (val == 'np') {
//                      $('#edition').removeAttr('selected').find('option:first').attr('selected', 'selected');
//                     
                    var xhttp = new XMLHttpRequest();
                    var language = document.getElementById("newspaper").value;
                    var urls = "get_newspaper.jsp?newspaper=" + language;
                    xhttp.onreadystatechange = function () {
                        if (this.readyState == 4 && this.status == 200) {
//                            alert(this.responseText);
                            document.getElementById("edition").innerHTML = this.responseText;
                            $('#subedition').empty();
                            $('#subedition').append($('<option>', {text: 'Select Sub Edition', value: '-1', selected: true}))
                            $('#subedition').change();
                        }
                    };
                    xhttp.open("GET", urls, true);
                    xhttp.send();
                } else if (val == 'edition')
                {
                    var xhttp = new XMLHttpRequest();
                    var language = document.getElementById("edition").value;
                    var urls = "get_newspaper.jsp?edition=" + language;
                    xhttp.onreadystatechange = function () {
                        if (this.readyState == 4 && this.status == 200) {
//                        alert(this.responseText);
                            document.getElementById("subedition").innerHTML = this.responseText;
                        }
                    };
                    xhttp.open("GET", urls, true);
                    xhttp.send();
                }

            }

            $(document).ready(function () {
//                $(function () {
                function split(val) {
                    return val.split(/,\s*/);
                }
                function extractLast(term) {
                    return split(term).pop();
                }
                $("#title")
                        .autocomplete({
                            source: function (request, response) {
//                                alert("tee");
                                $.getJSON("pr_jsonfile.jsp?description=" + document.getElementById("title").value, {
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