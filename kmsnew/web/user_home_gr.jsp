<%-- 
    Document   : home
    Created on : Nov 15, 2017, 11:30:13 PM
    Author     : Amol
--%>

<%@page import="jcifs.smb.SmbFile"%>
<%@page import="jcifs.smb.NtlmPasswordAuthentication"%>
<%@page import="java.net.URI"%>
<%@page import="java.util.stream.Stream"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.io.IOException"%>
<%@page import="java.nio.file.DirectoryStream"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.nio.file.Path"%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<jsp:forward page="dashboard.jsp"></jsp:forward>--%>
<%ResourceBundle rb = ResourceBundle.getBundle("msg"); %>
<%
    
  
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("7") || session.getAttribute("role").equals("6") || session.getAttribute("role").equals("1"))) {

//    String role = session.getAttribute("role").toString();
//    if (session != null && session.getAttribute("username") != null && session.getAttribute("role").equals("3")) {
        String username = session.getAttribute("username").toString();
        String userid = session.getAttribute("userid").toString();
        System.out.println("useriduseriduseriduserid:-" + userid);
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
        <link rel="icon" href="favicon.ico" type="image/x-icon">

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

        <!-- Custom Css -->
        <link href="css/style.css" rel="stylesheet">

        <!-- AdminBSB Themes. You can choose a theme from css/themes instead of get all themes -->
        <link href="css/themes/all-themes.css" rel="stylesheet" />  

        <link href="css/jquery-ui.css" rel="stylesheet">
        <!--<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />-->
        <!--<link href="css/jquery.multiselect.css" rel="stylesheet" />-->
        <!--<link href="http://cdn.rawgit.com/davidstutz/bootstrap-multiselect/master/dist/css/bootstrap-multiselect.css"  rel="stylesheet" type="text/css" />-->
        <!--<script src="js/jquery.multiselect.js"></script>-->

        <!--<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>-->
        <!--<script src="js/jquery-1.11.2.js"></script>-->
    </head>

    <body class="theme-blue" >
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

        <jsp:include page="gruserheader.jsp"></jsp:include>
            <!--<div class=" container-scroller">-->
            <!--Navbar-->
        <% //if (session.getAttribute("role").equals("2")) {%>

        <%--<jsp:include page="userHeader_creative.jsp"></jsp:include>--%>
        <%//} else {%>
        <%--<jsp:include page="userHeader.jsp"></jsp:include>--%>
        <% //}%>
        <!-- #Top Bar -->

        <!--            <div class="container-fluid" style="background-color:#f2f7f8">
                        <div class="row row-offcanvas row-offcanvas-right">-->
        <jsp:include page="userLeft.jsp"></jsp:include>
            <!-- SIDEBAR ENDS -->

        <%
            String creativeTeam = null, mediaRoom = null, rawData = null, approverData = null, printMedia = null;

            String sqlPrint = "SELECT count(workcode) as tag FROM tbl_printmedia_dataentry";
            System.out.println("sqlPrint-" + sqlPrint);
            PreparedStatement stmPrint = ConnectionDB.getDBConnection().prepareStatement(sqlPrint);
            //            stm.setString(1, s);
            ResultSet rsPrint = stmPrint.executeQuery();
            while (rsPrint.next()) {
                printMedia = rsPrint.getString(1);
//                            System.out.println("result:-" + rs.getString(1));
            }
           

//            String user = "192.168.0.22;admin:FSC@1234";//domain name which you connect
////      NtlmPasswordAuthentication auth = new NtlmPasswordAuthentication(user);
////      String user = "user:password";
//            String path = "file://192.168.0.22/kms/" + username + "/Pending/";
//            NtlmPasswordAuthentication auth = new NtlmPasswordAuthentication(user);
//            SmbFile sFile = new SmbFile(path, auth);
//            boolean existss = sFile.exists();
////out.println("existssss");
////SmbFile file = new SmbFile("Z:/Amit/01.09.19/");
////boolean exists = file.exists();
//            SmbFile[] list = sFile.listFiles();
//out.print("count: " + list.length);
//            count = list.length;
        %>
        <%    String posforgovt = "", posforbjp = "", negforgovt = "", negforbjp = "", neutral = "", npname = "";
            Connection dh = null;
            ConnectionDB conn = new ConnectionDB();
            dh = conn.getConnection();
            try {
                //                        String sql = "SELECT vill_marathi,sum(estimated_wks),sum(approved_wks),sum(order_wks),sum(workstarted),sum(workcompleted) FROM total_d_d_t_v_d_w_main where thncode='" + distcode + "' group by villcode,thncode order by vill_marathi asc";
                String sqlCal = "select npname,sum(count_posforgovt),sum(count_negforgovt),sum(count_posforbjp),sum(count_negforbjp),sum(count_neutral)"
                        + " from total_np_calculation group by npname";
                System.out.println("sqlCal:-" + sqlCal);
                PreparedStatement pstmtCal = dh.prepareStatement(sqlCal);
                ResultSet rst = pstmtCal.executeQuery();
                while (rst.next()) {
                    System.out.println("rst.getString(1):-" + rst.getString(1));
                    npname = npname.concat("'" + rst.getString(1) + "'" + ",");
                    posforgovt = posforgovt.concat(rst.getString(2) + ",");
                    negforgovt = negforgovt.concat(rst.getString(3) + ",");
                    posforbjp = posforbjp.concat(rst.getString(4) + ",");
                    negforbjp = negforbjp.concat(rst.getString(5) + ",");
                    neutral = neutral.concat(rst.getString(6) + ",");

                }

                npname = npname.substring(0, (npname.length() - 1));
                System.out.println("npname:-" + npname);
                posforgovt = posforgovt.substring(0, (posforgovt.length() - 1));
                System.out.println("posforgovt:-" + posforgovt);
                negforgovt = negforgovt.substring(0, (negforgovt.length() - 1));
                System.out.println("negforgovt:-" + negforgovt);
                posforbjp = posforbjp.substring(0, (posforbjp.length() - 1));
                System.out.println("posforbjp:-" + posforbjp);
                negforbjp = negforbjp.substring(0, (negforbjp.length() - 1));
                System.out.println("negforbjp:-" + negforbjp);
                neutral = neutral.substring(0, (neutral.length() - 1));
                System.out.println(":neutral:-" + neutral);
        //         out.print(npname+":"+posforgovt+":"+negforgovt+":"+posforbjp+":"+negforbjp+":"+neutral);
        //                dh.close();
            } catch (Exception ex) {
                out.println("<marquee> <b style='color:#00ff00'>Data Not Available</marquee>");
    }%>
        <section class="content" style="overflow: hidden">
            <div class="col-md-12 ">
               <%
                    if (session.getAttribute("role").equals("6") || session.getAttribute("role").equals("1")) {%>
            <div class="row clearfix">
                <div class="col-md-4">

                    <div class="card">

                        <div class="body">
                            <div class="header text-center">
                                <h2> Digital Media </h2>
                                <ul class="header-dropdown m-r--5">
                                    <li class="dropdown">
                                        <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                            <i class="material-icons">more_vert</i>
                                        </a>
                                        <ul class="dropdown-menu pull-right">
                                            <li><a href="printmedia_dataentry.jsp">ADD</a></li>
                                            <li><a href="dataentry_edit_printmedia.jsp?searchresult=P">EDIT</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                            <div class="content bg-blue hover-zoom-effect text-center">
                                <div class="font-45 count-to card__num" data-from="0" data-to="125" data-speed="1000" data-fresh-interval="20"> 
                                    <i class="material-icons movie">movie</i><br><%=printMedia%></div>
                            </div>

                        </div>
                    </div>


                </div>

                <div class="col-lg-8 col-md-8 col-sm-12 col-xs-12">
                    <div class="card">

                        <div class="body">
                            <div class="header text-center">
                                <h2> RECENT UPLOADS</h2>
                                <ul class="header-dropdown m-r--5">
                                    <li class="dropdown">
                                        <!--                                              <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                                                                          <i class="material-icons">more_vert</i>
                                                                                      </a>
                                                                                      <ul class="dropdown-menu pull-right">
                                                                                          <li><a href="add_media.html">ADD</a></li>
                                                                                          <li><a href="edit_media.html">EDIT</a></li>
                                                                                      </ul>-->
                                    </li>
                                </ul>
                            </div>
                            <div class="content" style="max-height: 46vh;overflow: auto;">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-striped table-hovers" id="all_rows">
                                        <tbody>
                                            <%
                                                String sqlSelect = "SELECT subject,tags,imagepath,sourcedate FROM tbl_printmedia_dataentry WHERE userid=? order by iddataentry DESC limit 0,5 ";
                                                //            String sql = "SELECT subject,graphicspath,vdopath,docpath,audiopath FROM tbl_news_dataentry WHERE MATCH (subject, description, summary,general,teletag,districttag,talukatag,villagetag,additionaltag) AGAINST ('" + subject + "') ";
                                                //String sql = "Select subject,graphicspath,vdopath,docpath,audiopath  WHERE MATCH (subject, description, summary,general,teletag,districttag,talukatag,villagetag,additionaltag)  AGAINST ('" + subject + "' )";
                                                //            String sql = "Select subject,graphicspath,vdopath,docpath,audiopath from tbl_news_dataentry where workcode =?";
                                                System.out.println("sqlSelect-" + sqlSelect);
                                                PreparedStatement stmSelect = ConnectionDB.getDBConnection().prepareStatement(sqlSelect);
                                                stmSelect.setString(1, userid);
                                                ResultSet rsSelect = stmSelect.executeQuery();
                                                String sssss = null;

                                                while (rsSelect.next()) {
                                                    System.out.println("rsSelect.getString():-" + rsSelect.getString("imagepath"));
                                           

                                            %>
                                            <tr>
                                                <td style="text-align: center;vertical-align: bottom;">
                                              <%
                                                            if(!rsSelect.getString("imagepath").isEmpty()){
                                                            String path = rsSelect.getString("imagepath");
  //                                                        String fullpath=path.substring(19);
                                                            String replaceString = path.replace("\\", "/");
                                                            String fullpath = "/kmsvdo/vdo/" + replaceString.substring(14);
                                                            System.out.println("fullpath:-" + fullpath);

                                                            String whiteSpace = fullpath.replace(" ", "%20");


                                                        %>
                                                        <img src="<%=whiteSpace%>" id="imageContainer"  width="200" height="100"  >
                                                        <%}else{%>
                                                        <img src="" id="imageContainer" alt="Upload Image"  width="200" height="100"  >
                                                       
                                                        <%}%>            </td>
                                                <td><h4> <%=rsSelect.getString("subject")%>   </h4>
                                                    <p class="m-t-15 m-b-30"><%=rsSelect.getString("tags")%> </p>
                                                    <span class="badge bg-black"><%=rsSelect.getString("sourcedate")%> </span></td>
                                            </tr>
                                            <%
                                                }%>

                                        </tbody>
                                    </table>
                                </div>
                            </div>

                        </div>
                    </div>

                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="card">

                        <div class="body">
                            <div class="header text-center">
                                <h2> </h2>
                                <div class="row">
                                    <form action="printmediagraph.jsp" method="post">                                    <div class="col-sm-2"></div>
                                    <div class="col-sm-4">
                                        <!--                                        <input type="text" id="npname">
                                                                                <input type="text" id="posforgovt">
                                                                                <input type="text" id="negforgovt">
                                                                                <input type="text" id="posforbjp">
                                                                                <input type="text" id="negforbjp">
                                                                                <input type="text" id="neutral">-->
                                        <input type="text" id="date-start3" name="fromDateGraph"  class="form-control" placeholder="FROM DATE...">

                                    </div>
                                    <div class="col-sm-4">
                                        <input type="text" id="date-end3" name="toDateGraph"  class="form-control" placeholder="TO DATE...">

                                    </div>
                                    <div class="col-sm-2" >
                                        <!--<button class="btn btn-dark p-15"  style=" padding: 6px 12px;margin-top: -2px;border-radius: 3px;background: #1f1f1f;color: #fff;" >test</button>-->
                                        <button class="btn btn-dark p-15"  style=" padding: 6px 12px;margin-top: -2px;border-radius: 3px;background: #1f1f1f;color: #fff;" ><i class="material-icons">search</i></button>
                                    </div>
                                    </form>
                                </div>

                                <!--                                <ul class="header-dropdown m-r--5">
                                                                    <li class="dropdown">
                                                                        <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                                                            <i class="material-icons">more_vert</i>
                                                                        </a>
                                                                        <ul class="dropdown-menu pull-right">
                                                                            <li><a href="add_media.html">ADD</a></li>
                                                                            <li><a href="edit_media.html">EDIT</a></li>
                                                                        </ul>
                                                                    </li>
                                                                </ul>-->
                            </div>
                            <div class="content" style="max-height: auto;overflow: auto;">
                                <div class="table-responsive">
                                    <div id="sentimentgraph">

                                    </div>
                                    <div id="sentimentgraph1">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
            <%}%>
            <!-- #END# Unordered List -->
        </div>
    </section>

    <!--<div class="row">-->


    <!--</div>-->
    <!--<script src="js/jquery-ui.js"></script>-->
    <!--<script src="js/jquery-ui.js" type="text/javascript"></script>-->
    <!--Load SCRIPT.JS which will create datepicker for input field-->  
    <!--<script src="js/script.js" type="text/javascript"></script>-->


    <!-- Jquery Core Js --> 
    <!--<script src="plugins/jquery/jquery.min.js"></script>--> 
    <script src="js/jquery-1.12.4.js"></script>
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
    <!--<script src="js/pages/forms/basic-form-elements.js"></script>--> 
    <!--<script src="js/pages/forms/advanced-form-elements.js"></script>--> 

    <!-- Demo Js --> 
    <script src="js/demo.js"></script>


    <script src="js/highcharts.js"></script>
    <script src="js/exporting.js"></script>
    <script src="js/export-data.js"></script>
    <script src="js/accessibility.js"></script>


    <script>
                                            $('#date-end').bootstrapMaterialDatePicker({weekStart: 0, time: false});
                                            $('#date-start').bootstrapMaterialDatePicker({weekStart: 0, time: false}).on('change', function (e, date)
                                            {
                                                $('#date-end').bootstrapMaterialDatePicker('setMinDate', date);
                                            });
    </script>
    <script>
        $('#date-end3').bootstrapMaterialDatePicker({weekStart: 0, time: false});
        $('#date-start3').bootstrapMaterialDatePicker({weekStart: 0, time: false}).on('change', function (e, date)
        {
            $('#date-end3').bootstrapMaterialDatePicker('setMinDate', date);
        });
    </script>

    <%java.text.DateFormat df1 = new java.text.SimpleDateFormat("dd/MM/yyyy");%>
    <script>
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
//                $("#creativeTag input")
//                        .autocomplete({
//                            source: function (request, response) {
//                                $.getJSON("jsonfile_creative.jsp?description=" + document.getElementById("creativetag").value, {
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
        });
    </script>

    <!--<div id="printmediagraph"></div>-->
    <%java.text.DateFormat df = new java.text.SimpleDateFormat("dd/MM/yyyy");%>

    <script>
        Highcharts.setOptions({
            lang: {
                numericSymbols: null //otherwise by default ['k', 'M', 'G', 'T', 'P', 'E']
            }
        });
        Highcharts.chart('sentimentgraph', {
            chart: {
                type: 'column'
            },
            title: {
                text: 'Sentiment Report'
            }, subtitle: {
                text: '<b>Till  <%= df.format(new java.util.Date())%></b>',
                x: -20
            },
            xAxis: {
                categories: [<%=npname%>
                ]
            },
            yAxis: [{
                    min: 0,
                    title: {
                        text: ''
                    },
                    stackLabels: {
                        enabled: true,
                        style: {
                            fontWeight: 'bold',
                            color: (// theme
                                    Highcharts.defaultOptions.title.style &&
                                    Highcharts.defaultOptions.title.style.color
                                    ) || 'gray'
                        }
                    }
                }, {
                    title: {
                        text: 'Number of Records'
                    },
                    opposite: false
                }],
            legend: {
                shadow: false
            },
            tooltip: {
                headerFormat: '<b>{point.x}</b><br/>',
                pointFormat: '{series.name}: {point.y}<br/>Total: {point.stackTotal}'

            },

            plotOptions: {
                column: {
                    stacking: 'normal',
                    dataLabels: {
                        enabled: true
                    }
                }
            },
            credits: {
                enabled: false
            },
            series: [{
                    name: 'Positive For Government',
                    color: '#A1CBFF',
                    data: [<%=posforgovt%>],
                    pointPadding: 0.3,
                    pointPlacement: -0.2
                }, {
                    name: 'Negative For Government',
                    color: '#FAD7A0',
                    data: [<%=negforgovt%>],
                    pointPadding: 0.3,
                    pointPlacement: -0.2
                }, {
                    name: 'Positive For BJP/Opposition',
                    color: '#90EE78',
                    data: [<%=posforbjp%>],
                    pointPadding: 0.3,
                    pointPlacement: -0.2
                }, {
                    name: 'Negative For BJP/Opposition',
                    color: '#E9A46E',
                    data: [<%=negforbjp%>],
                    pointPadding: 0.3,
                    pointPlacement: -0.2

                },
                {
                    name: 'Neutral',
                    color: '#F07F76',
                    data: [<%=neutral%>],
                    pointPadding: 0.3,
                    pointPlacement: -0.2,
                    //yAxis: 1
                }
            ]
        });

    </script>

</body>
</html>
<% 
} else {
        response.sendRedirect("login.jsp");
    }

%>