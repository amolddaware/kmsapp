<%-- 
    Document   : home
    Created on : Nov 15, 2017, 11:30:13 PM
    Author     : Amol
--%>

<%@page import="org.mygov.handler.DateTimeUTC"%>
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

    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("1") || session.getAttribute("role").equals("5"))) {

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
        <!-- Custom Css -->
        <link href="css/style.css" rel="stylesheet">
        <!-- AdminBSB Themes. You can choose a theme from css/themes instead of get all themes -->
        <link href="css/themes/all-themes.css" rel="stylesheet" />  
        <link href="css/jquery-ui.css" rel="stylesheet">
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

        <% if (session.getAttribute("role").equals("1")) {%>
        <jsp:include page="header.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <%} else if (session.getAttribute("role").equals("5")) {%>
        <jsp:include page="userHeader1.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <% }%>    <!-- SIDEBAR ENDS -->

        <%
            Connection dh = null;
            String logintime = "";
            ConnectionDB conn = new ConnectionDB();
            dh = conn.getConnection();
            String creativeTeam = null, mediaRoom = null, rawData = null, approverData = null, printMedia = null;

            String sql = "SELECT count(workcode) as workcode FROM tbl_news_dataentry WHERE workcode like ?";
            System.out.println("sql:-" + sql);
            PreparedStatement stm = dh.prepareStatement(sql);
            stm.setString(1, "%G%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                printMedia = rs.getString(1);
            }

            String sqlCreative = "SELECT a.userid,a.name,count(b.userid) as count,max(b.datetime),a.pic as pic,a.color as color from createuser a inner join  tbl_news_dataentry b on a.userid=b.userid WHERE a.userid <> ? and a.role=? group by a.userid ";
            System.out.println("sqlElectronic-" + sqlCreative);
            PreparedStatement stmCreative = dh.prepareStatement(sqlCreative);
            stmCreative.setString(1, "1");
            stmCreative.setString(2, "7");
            ResultSet rsCreative = stmCreative.executeQuery();

            String posforgovt = "", posforbjp = "", negforgovt = "", negforbjp = "", neutral = "", npname = "";
        %>
        <section class="content" style="overflow: hidden">
            <div class="col-md-12 ">
                <!-- Unordered List -->
                <% if (session.getAttribute("role").equals("5") || session.getAttribute("role").equals("1")) {%>
                <div class="row clearfix">
                    <%--<div class="col-md-4">
                        <div class="card">
                            <div class="body">
                                <div class="header text-center">
                                    <h2> CREATIVE MEDIA </h2>
                                    <ul class="header-dropdown m-r--5">
                                        <!--                                <li class="dropdown">
                                                                            <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                                                                <i class="material-icons">more_vert</i>
                                                                            </a>
                                                                            <ul class="dropdown-menu pull-right">
                                                                                <li><a href="printmedia_dataentry.jsp">ADD</a></li>
                                                                                <li><a href="dataentry_edit_printmedia.jsp?searchresult=P">EDIT</a></li>
                                                                            </ul>
                                                                        </li>-->
                                    </ul>
                                </div>
                                <div class="content bg-blue hover-zoom-effect text-center">
                                    <div class="font-45 count-to card__num" data-from="0" data-to="125" data-speed="1000" data-fresh-interval="20"> 
                                        <i class="material-icons movie">movie</i><br><%=printMedia%></div>
                                </div>
                            </div>
                        </div>
                    </div>--%>
                    <%
                        String sqlworkcode = "SELECT  UPPER(LEFT(workcode, 1)) AS first_char,COUNT(*) as count,max(CAST(datetime as date)) as maxdate FROM tbl_news_dataentry where workcode like ? ";
                        System.out.println("sql:-" + sqlworkcode);
                        PreparedStatement stmWorkcode = dh.prepareStatement(sqlworkcode);
                        stmWorkcode.setString(1, "%G%");
                        ResultSet rsWorkcode = stmWorkcode.executeQuery();
                        while (rsWorkcode.next()) {
                            System.out.println("rsWorkcode.getString(maxdate):" + rsWorkcode.getString("maxdate"));
                            String sqlMax = "SELECT count(workcode) as workcode from tbl_news_dataentry  WHERE workcode like ?  and datetime like ?  ";
                            //                            String sql1 = "SELECT a.userid,a.name,count(b.userid) as count from createuser a inner join  tbl_new_member b on a.userid=b.userid WHERE a.userid ="+newid+"  group by b.datetime";
                            System.out.println("sqlsss:-" + sqlMax);
                            PreparedStatement stmMax = dh.prepareStatement(sqlMax);
                            stmMax.setString(1, "%G%");
                            stmMax.setString(2, "%" + rsWorkcode.getString("maxdate") + "%");
                            ResultSet rsMax = stmMax.executeQuery();
//if (rsMax.next()) {
//                                                System.out.println("workcode count:-" + rsMax.getString("workcode"));
//}
                            String sql2 = "select * from (SELECT UPPER(LEFT(workcode, 1)) AS first_char,COUNT(1) as count,CAST(datetime as date) as maxdate FROM tbl_news_dataentry WHERE workcode like ? Group by CAST(datetime as date)  order by CAST(datetime as date) desc limit 7 )var1 order by maxdate asc";
                            System.out.println("sqlsss:-" + sql2);
                            PreparedStatement stm2 = dh.prepareStatement(sql2);
                            stm2.setString(1, "%G%");
                            ResultSet rs2 = stm2.executeQuery();

                    %>

                    <a href="#" style="color:#000">
                        <div class="col-md-3">
                            <div class="card profile-card">
                                <div class="profile-body">
                                    <div class="content-area m-t-30">
                                         <span class="material-icons gr-icon">
                                                home_work
                                            </span>
                                            <h4>GOVERNMENT <br> RESOLUTION</h4>
                                    </div>
                                </div>
                                <%                                    StringBuffer c = new StringBuffer();
                                    StringBuffer d = new StringBuffer();
                                    StringBuffer e = new StringBuffer();
                                    StringBuffer g = new StringBuffer();
                                    StringBuffer p = new StringBuffer();
                                    while (rs2.next()) {
                                        c.append(rs2.getString("count") + ",");

//                                        if (rs2.getString("first_char").equals("D")) {
//                                            d.append(rs2.getString("count") + ",");
//                                        }
//                                        if (rs2.getString("first_char").equals("E")) {
//                                            e.append(rs2.getString("count") + ",");
//                                        }
//                                        if (rs2.getString("first_char").equals("G")) {
//                                            g.append(rs2.getString("count") + ",");
//                                        }
//                                        if (rs2.getString("first_char").equals("P")) {
//                                            p.append(rs2.getString("count") + ",");
//                                        }
                                    }
//                                    String cc=c.toString();
//String aa[]=cc;
//                                     ArrayUtils.reverse(aa);

//                                    System.out.println("c:-" + c);
//                                    System.out.println("d:-" + d);
//                                    System.out.println("e:-" + e);
//                                    System.out.println("g:-" + g);
//                                    System.out.println("p:-" + p);
%>


                               <div class="sparkline" style=" background-color:#5cc1a5; padding:5px;" data-type="line" data-spot-Radius="4" data-highlight-Spot-Color="rgb(233, 30, 99)" data-highlight-Line-Color="#000" data-min-Spot-Color="rgb(255,255,255)" data-max-Spot-Color="rgb(255,255,255)" data-spot-Color="" data-offset="90" data-width="100%" data-height="92px" data-line-Width="2" data-line-Color="rgba(255,255,255,0.7)" data-fill-Color="rgba(0, 188, 212, 0)"> <%=c.substring(0, c.length() - 1)%> </div>
  <div class="profile-footer">
                                    <ul>
                                        <% if (rsMax.next()) {
                                                System.out.println("workcode count:-" + rsMax.getString("workcode"));
                                        %>
                                        <li> <span>LAST COUNT</span> <span class="badge bg-green"> <%=rsMax.getString("workcode")%></span> </li>
                                            <% }%>
                                        <li> <span>LAST DATE</span> <span class="badge bg-green"><%=rsWorkcode.getString("maxdate")%></span> </li>
                                        <li> <span>TOTAL COUNT</span> <span class="badge bg-orange"><%=rsWorkcode.getString("count")%></span> </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <%}%>
                    </a>

                    <div class="col-xs-12 col-sm-12 col-md-8 col-lg-9">
                        <div class="card">

                            <div class="body" style="height: 442px; border-bottom: 4px solid #000; overflow-x: auto">
                                <div class="header text-center">
                                    <h2> RECENT UPLOADS GOVERNMENT RESOLUTION</h2>
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
                                                    String sqlSelects = "SELECT subject,dept,sourcedate FROM tbl_news_dataentry where workcode like ? order by iddataentry DESC limit 0,5 ";
                                                    System.out.println("sqlSelect-" + sqlSelects);
                                                    PreparedStatement stmSelects = dh.prepareStatement(sqlSelects);
                                                    stmSelects.setString(1, "%G%");
                                                    ResultSet rsSelects = stmSelects.executeQuery();
                                                    String ssssss = null;

                                                    while (rsSelects.next()) {
//                                                        System.out.println("rsSelect.getString():-" + rsSelects.getString("imagepath"));
                                                %>
                                                <tr>
                                                   
                                                    <td><h4> <%=rsSelects.getString("subject")%>   </h4>
                                                        <p class="m-t-15 m-b-30"><%=rsSelects.getString("dept")%> </p>
                                                        <span class="badge bg-black"><%=rsSelects.getString("sourcedate")%> </span></td>
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
                </div>
            </div>
            <div class="col-md-12"> 
                <!-- Unordered List -->
                <div class="row clearfix">
                    <%  String newid = null, name = null, datetime = null, nameList = null, pic = null, color = null;
                                int count = 0, maxDateCount = 0, countTotalUser = 0, lastDayTotal = 0;

                                while (rsCreative.next()) {
                                    System.out.println("test");
                                    newid = rsCreative.getString(1);
                                    name = rsCreative.getString(2);
                                    count = rsCreative.getInt(3);
                                    datetime = rsCreative.getString(4);
                                    color = rsCreative.getString("color");

                                    String spliDate[] = datetime.split(" ");

                                    pic = rsCreative.getString("pic");

                                    System.out.println("test");
                                    String sql1 = "SELECT count(userid) as userid,max(datetime) from tbl_news_dataentry  WHERE userid =" + newid + "  and datetime like '%" + spliDate[0] + "%'  group by userid";
                                    //                            String sql1 = "SELECT a.userid,a.name,count(b.userid) as count from createuser a inner join  tbl_new_member b on a.userid=b.userid WHERE a.userid ="+newid+"  group by b.datetime";
                                    System.out.println("sqlsss:-" + sql1);
                                    PreparedStatement stm1 = dh.prepareStatement(sql1);
                                    //                            stm1.setString(1, newid);
                                    ResultSet rs1 = stm1.executeQuery();


                            %>
                    <div class="col-md-3">
                        <div class="card profile-card">
                            
                            <div class="profile-header" style="background-color: #<%=color%>;">&nbsp;</div>
                            <div class="profile-body">
                                <div class="image-area"> 
                                    <%if(pic!=null){%>
                                    <img src="<%=pic%>" alt="Profile Image"/> 
                                <%}else{%>
                                <img src="images/user.png" alt="Profile Image"/> 
                                
                                    <%}%>
                                </div>
                                <!--<div class="bg-green blink"></div>-->
                                <div class="content-area">
                                    <h3><%=name%></h3>
                                    <p>Government Resolution Media Executive</p>
                                    <% String maxdate = null, finaldate[] = null;
                                        DateTimeUTC date = new DateTimeUTC();
                                        String currentDate = date.getCurrentDate();
                                        while (rs1.next()) {
                                            //                                                    out.println(rs1.getString(4));
                                            maxdate = rs1.getString(2);
                                            finaldate = maxdate.split(" ");
                                            maxDateCount = rs1.getInt(1);
                                            lastDayTotal = lastDayTotal + rs1.getInt(1);
                                            //                                                    System.out.println("id:-" + rs1.getString(1));
                                            //                                                    System.out.println("name:-" + rs1.getString(2));
                                            System.out.println("count:-" + rs1.getInt(1));%>
                                    <p>Last form filled on : <%=finaldate[0]%></p>
                                    <%if (currentDate.equals(finaldate[0])) { %>
                                    <div class="blink bg-green"></div>
                                    <%} else {%>
                                    <div class="blink bg-red"></div>

                                    <%}%>
                                                                        <!--<br><span style="color:#FFF !important;font-size: 40px !important"><%//=maxDateCount%></span>-->
                                    <%}
                                        if (stm1 != null) {
                                            stm1.close();
                                        }
                                        if (rs1 != null) {
                                            rs1.close();
                                        }
                                    %>

                                </div>
                            </div>
                            <div class="profile-footer">
                                <ul>
                                    <li> <span>Last Count</span> <span class="badge bg-green"><%=maxDateCount%></span> </li>
                                    <li> <span>Total Count</span> <span class="badge bg-orange"><%=count%></span> </li>
                                    <!--<li> <span>Average</span> <span class="badge bg-blue">21</span> </li>-->
                                </ul>
                            </div>
                           
                        </div>
                    </div>
                                     <%}%>

                </div>
            </div>

            <% }

                if (session.getAttribute("role").equals("5") || session.getAttribute("role").equals("1")) { %>
            <!--<div class="row clearfix">-->
            <%--<div class="col-lg-8 col-md-8 col-sm-12 col-xs-12">
                <div class="card">
                    <div class="body" style="max-height: 56vh;overflow: auto;">
                        <div class="header text-center" >
                            <h2> </h2>
                            <div class="row" >
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
                        </div>
                        <div class="content" style="max-height: auto;overflow: auto;">
                            <div class="table-responsive">
                                <div id="sentimentgraph">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>--%>
            <% } %>
            <!-- #END# Unordered List -->
        </div>
    </section>


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

    <!-- Jquery CountTo Plugin Js --> 
    <script src="plugins/jquery-countto/jquery.countTo.js"></script> 

    <!-- Morris Plugin Js --> 
    <script src="plugins/raphael/raphael.min.js"></script> 
    <script src="plugins/morrisjs/morris.js"></script> 

    <!-- Flot Charts Plugin Js --> 
    <script src="plugins/flot-charts/jquery.flot.js"></script> 

    <!-- Sparkline Chart Plugin Js --> 
    <script src="plugins/jquery-sparkline/jquery.sparkline.js"></script> 
    <!-- Custom Js --> 
    <script src="js/admin.js"></script> 
    <script src="js/pages/forms/form-validation.js"></script> 
    <script src="js/pages/forms/form-wizard.js"></script> 
    <!--<script src="js/pages/forms/basic-form-elements.js"></script>--> 
    <!--<script src="js/pages/forms/advanced-form-elements.js"></script>--> 

    <script src="js/pages/index.js"></script> 
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
                            $.getJSON("jsonfile_1.jsp?description=" + document.getElementById("generaltag").value, {
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
    </script>
    <%java.text.DateFormat df = new java.text.SimpleDateFormat("dd/MM/yyyy");%>
    <script>
        <%--    Highcharts.setOptions({
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
        --%>
    </script>
</body>
</html>
<%
    } else {
        response.sendRedirect("login.jsp");
    }


%>
