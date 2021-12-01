<%-- 
    Document   : home
    Created on : Nov 15, 2017, 11:30:13 PM
    Author     : Amol
--%>

<<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.ArrayList"%>
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
// if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("1")||session.getAttribute("role").equals("3")||session.getAttribute("role").equals("4"))) {

//    String role = session.getAttribute("role").toString();
    if (session != null && session.getAttribute("username") != null && session.getAttribute("role").equals("1")) {
        String username = session.getAttribute("username").toString();
        String userid = session.getAttribute("userid").toString();
        String token = session.getAttribute("csrfToken").toString();
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setDateHeader("Expires", 0);
        response.addHeader("X-Frame-Options", "DENY");

        int timeout = session.getMaxInactiveInterval();
//                System.out.println("timeout:-"+timeout);
        response.setHeader("refresh", timeout + ";URL=logout.jsp");%>﻿<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <title>Dashboard</title>
        <!-- Favicon-->
        <link rel="icon" href="images/favicon.ico" type="image/x-icon">

        <!-- Google Fonts -->
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

        <!-- Bootstrap DatePicker Css -->
        <link href="plugins/bootstrap-datepicker/css/bootstrap-datepicker.css" rel="stylesheet" />

        <!-- Morris Chart Css-->
        <link href="plugins/morrisjs/morris.css" rel="stylesheet" />
        <!-- Custom Css -->
        <link href="css/style.css" rel="stylesheet">

        <!-- AdminBSB Themes. You can choose a theme from css/themes instead of get all themes -->
        <link href="css/themes/all-themes.css" rel="stylesheet" />
        <style>
            #chartdiv {
                width: 100%;
                height: 500px;
            }
            #chartdiv2 {
                width:100%; height: 500px;border:3px solid rgba(90, 127, 201, 0.79);border-radius: 10px;

            }
            #chartdivelectronic {
                width: 100%;
                height: 500px;
                border:3px solid rgba(90, 127, 201, 0.79);border-radius: 10px;
            }
            #chartdivcreative {
                width: 100%;
                height: 500px;
                border:3px solid rgba(90, 127, 201, 0.79);border-radius: 10px;
            }
            #chartdivdigital {
                width: 100%;
                height: 500px;
                border:3px solid rgba(90, 127, 201, 0.79);border-radius: 10px;
            }
            #chartdivgr {
                width: 100%;
                height: 500px;
                border:3px solid rgba(90, 127, 201, 0.79);border-radius: 10px;
            }
            #highchart{
                width:100%; min-height: 500px; height: 100%; margin: 0 auto;border:3px solid rgba(90, 127, 201, 0.79);border-radius: 10px;

            }
        </style>    </head>

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
        <jsp:include page="header.jsp"></jsp:include>
        <jsp:include page="left.jsp"></jsp:include>
            <!-- SIDEBAR ENDS -->

            <section class="content" style="overflow: hidden">
                <div class="container-fluid">
                    <div class="block-header">
                        <!--<h2>DASHBOARD</h2>-->
                    </div>

                    <!-- Widgets -->
                    <div class="row clearfix">
                    <%
                        int totalCount = 0;
                        List<String> map = new ArrayList<>();
                        Connection dh = null;
                        ConnectionDB conn = new ConnectionDB();
                        dh = conn.getConnection();
                        // try{ 
                        int numberOfEntry = 0, countDays = 0;

                        String newid = null, name = null, datetime = null, nameList = null, pic = null, color = null;
                        int count = 0, maxDateCount = 0, countTotalUser = 0, lastDayTotal = 0;
                        StringBuffer str = new StringBuffer();

                        String sqlBarchart = "SELECT a.userid,a.name,count(b.userid) as count,max(b.datetime),a.pic as pic from createuser a inner join  tbl_news_dataentry b on a.userid=b.userid WHERE a.userid <> ? and a.role=? group by a.userid ";
//                        System.out.println("sqlBarchart:-" + sqlBarchart);
                        PreparedStatement stmBarchart = dh.prepareStatement(sqlBarchart);
                        stmBarchart.setString(1, "1");
                        stmBarchart.setString(2, "4");
                        ResultSet rsBarchart = stmBarchart.executeQuery();

                        String sqlElectronic = "SELECT a.userid,a.name,count(b.userid) as count,max(b.datetime),a.pic as pic from createuser a inner join  tbl_news_dataentry b on a.userid=b.userid WHERE a.userid <> ? and a.role=? group by a.userid ";
//                        System.out.println("sqlElectronic-" + sqlElectronic);
                        PreparedStatement stmElectronic = dh.prepareStatement(sqlElectronic);
                        stmElectronic.setString(1, "1");
                        stmElectronic.setString(2, "3");
                        ResultSet rsElectronic = stmElectronic.executeQuery();

                        String sqlCreative = "SELECT a.userid,a.name,count(b.userid) as count,max(b.datetime),a.pic as pic from createuser a inner join  tbl_news_dataentry b on a.userid=b.userid WHERE a.userid <> ? and a.role=? group by a.userid ";
//                        System.out.println("sqlElectronic-" + sqlCreative);
                        PreparedStatement stmCreative = dh.prepareStatement(sqlCreative);
                        stmCreative.setString(1, "1");
                        stmCreative.setString(2, "2");
                        ResultSet rsCreative = stmCreative.executeQuery();

                        String sqlDigital = "SELECT a.userid,a.name,count(b.userid) as count,max(b.datetime),a.pic as pic from createuser a inner join  tbl_news_dataentry b on a.userid=b.userid WHERE a.userid <> ? and a.role=? group by a.userid ";
//                        System.out.println("sqlDigital-" + sqlDigital);
                        PreparedStatement stmDigital = dh.prepareStatement(sqlDigital);
                        stmDigital.setString(1, "1");
                        stmDigital.setString(2, "6");
                        ResultSet rsDigital = stmDigital.executeQuery();

                        String sqlGR = "SELECT a.userid,a.name,count(b.userid) as count,max(b.datetime),a.pic as pic from createuser a inner join  tbl_news_dataentry b on a.userid=b.userid WHERE a.userid <> ? and a.role=? group by a.userid ";
//                        System.out.println("sqlGR-" + sqlGR);
                        PreparedStatement stmGR = dh.prepareStatement(sqlGR);
                        stmGR.setString(1, "1");
                        stmGR.setString(2, "7");
                        ResultSet rsGR = stmGR.executeQuery();

                        /*Barchart result ends here**/
 /*Total barcharat*/
//                        String sqlTotal = "";
//                        String sqlTotal = "SELECT UPPER(LEFT(workcode, 1)) AS first_char,COUNT(1) as count,CAST(datetime as date) as maxdate FROM kmsdb1.tbl_news_dataentry where workcode is not null  Group by CAST(datetime as date),UPPER(LEFT(workcode, 1))  order by CAST(datetime as date) desc limit 7 ";
//                            String sql2 = "SELECT count(workcode) as workcode from tbl_news_dataentry  WHERE workcode like '%"+rs.getString("first_char")+"%'  and datetime like '%" + rs.getString("maxdate") + "%'  ";
                        //                            String sql1 = "SELECT a.userid,a.name,count(b.userid) as count from createuser a inner join  tbl_new_member b on a.userid=b.userid WHERE a.userid ="+newid+"  group by b.datetime";
//                        System.out.println("sqlTotal-" + sqlTotal);
                        PreparedStatement stmC = dh.prepareStatement("SELECT * from cdegp_view ");
                        //                            stm1.setString(1, newid);
                        ResultSet rsC = stmC.executeQuery();

                        StringBuffer totalMonth = new StringBuffer();
                        StringBuffer totalMonthCount = new StringBuffer();
                        Set set = new HashSet();

                        StringBuffer month = new StringBuffer();
                        StringBuffer creative = new StringBuffer();
                        StringBuffer digital = new StringBuffer();
                        StringBuffer electronic = new StringBuffer();
                        StringBuffer gr = new StringBuffer();
                        StringBuffer print = new StringBuffer();
                        while (rsC.next()) {

                            month.append("'" + rsC.getString("month") + "',");
                            creative.append(rsC.getString("creative") + ",");
                            digital.append(rsC.getString("digital") + ",");
                            electronic.append(rsC.getString("electronic") + ",");
                            gr.append(rsC.getString("gr") + ",");
                            print.append(rsC.getString("print") + ",");

//                            totalMonth.append(rsTotal.getString("MONTH"));
                        }

//                        System.out.println("Month:-" + month);
//                        System.out.println("creative:-" + creative);
//                        System.out.println("digital:-" + digital);
//                        System.out.println("electronic:-" + electronic);
//                        System.out.println("gr:-" + gr);
//                        System.out.println("print:-" + print);
//                            
//                        System.out.println("totalDate:-" + set);
//                            System.out.println("totalDateCount:-"+totalDateCount);
                        /*end*/
                        String sql = "SELECT  UPPER(LEFT(workcode, 1)) AS first_char,COUNT(*) as count,max(CAST(datetime as date)) as maxdate FROM tbl_news_dataentry where workcode is not null GROUP BY UPPER(LEFT(workcode, 1)) ORDER BY first_char ASC";
//                        System.out.println("sql:-" + sql);
                        PreparedStatement stm = dh.prepareStatement(sql);
                        //            stm.setString(1, s);
                        ResultSet rs = stm.executeQuery();

                        String fullList = null;
                       String ta=null;
                        while (rs.next()) {
//                            System.out.println("workcode:-" + rs.getString("first_char"));

                            String sql1 = "SELECT count(workcode) as workcode from tbl_news_dataentry  WHERE workcode like '%" + rs.getString("first_char") + "%'  and datetime like '%" + rs.getString("maxdate") + "%'  ";
                            //                            String sql1 = "SELECT a.userid,a.name,count(b.userid) as count from createuser a inner join  tbl_new_member b on a.userid=b.userid WHERE a.userid ="+newid+"  group by b.datetime";
//                            System.out.println("sqlsss:-" + sql1);
                            PreparedStatement stm1 = dh.prepareStatement(sql1);
                            //                            stm1.setString(1, newid);
                            ResultSet rs1 = stm1.executeQuery();

                            String sql2 = "select * from (SELECT UPPER(LEFT(workcode, 1)) AS first_char,COUNT(1) as count,CAST(datetime as date) as maxdate FROM tbl_news_dataentry WHERE workcode like '%" + rs.getString("first_char") + "%' Group by CAST(datetime as date)  order by CAST(datetime as date) desc limit 7 )var1 order by maxdate asc";
//                            String sql2 = "SELECT UPPER(LEFT(workcode, 1)) AS first_char,COUNT(1) as count,CAST(datetime as date) as maxdate FROM kmsdb1.tbl_news_dataentry WHERE workcode like '%" + rs.getString("first_char") + "%' Group by CAST(datetime as date)  order by datetime desc limit 7 ";
//                            String sql2 = "SELECT count(workcode) as workcode from tbl_news_dataentry  WHERE workcode like '%"+rs.getString("first_char")+"%'  and datetime like '%" + rs.getString("maxdate") + "%'  ";
                            //                            String sql1 = "SELECT a.userid,a.name,count(b.userid) as count from createuser a inner join  tbl_new_member b on a.userid=b.userid WHERE a.userid ="+newid+"  group by b.datetime";
//                            System.out.println("sqlsss:-" + sql2);
                            PreparedStatement stm2 = dh.prepareStatement(sql2);
                            //                            stm1.setString(1, newid);
                            ResultSet rs2 = stm2.executeQuery();

                    %>
                    <a href="#" style="color:#000">
                        <div class="col-md-20">
                            <div class="card profile-card">
                                <div class="profile-body">
                                    <div class="content-area m-t-30">
                                        <%if (rs.getString("first_char").equals("C")) {%>
                                        <a href="admin_cr_home.jsp" target="_self"> 
                                            <span class="material-icons creative-icon">
                                                wb_incandescent
                                            </span>
                                            <h4>CREATIVE <br> MEDIA</h4></a>
                                                <% } %>
                                                <%if (rs.getString("first_char").equals("D")) {%>
                                        <a href="admin_dm_home.jsp" target="_self"> 
                                            <span class="material-icons digital-icon">
                                                phonelink
                                            </span>
                                            <h4>DIGITAL <br> MEDIA</h4></a>
                                                <% } %>
                                                <%if (rs.getString("first_char").equals("E")) {%>
                                        <a href="admin_em_home.jsp" target="_self"> 
                                            <span class="material-icons electronic-icon">
                                                live_tv
                                            </span>
                                            <h4>ELECTRONIC <br> MEDIA</h4></a>
                                                <% } %>
                                                <%if (rs.getString("first_char").equals("G")) {%>
                                        <a href="admin_gr_home.jsp" target="_self"> 
                                            <span class="material-icons gr-icon">
                                                home_work
                                            </span>
                                            <h4>GOVERNMENT <br> RESOLUTION</h4>
                                        </a><% } %>
                                        <%if (rs.getString("first_char").equals("P")) {%>
                                        <a href="admin_pr_home.jsp" target="_self"> 
                                            <span class="material-icons print-icon">
                                                local_printshop
                                            </span>
                                            <h4> PRINT <br> MEDIA</h4></a>
                                                <% ta="av"; } %>
                                    </div>
                                </div>
                                <%
                                    StringBuffer c = new StringBuffer();
                                    StringBuffer d = new StringBuffer();
                                    StringBuffer e = new StringBuffer();
                                    StringBuffer g = new StringBuffer();
                                    StringBuffer p = new StringBuffer();
                                    while (rs2.next()) {
                                        if (rs2.getString("first_char").equals("C")) {
                                            c.append(rs2.getString("count") + ",");
                                        }
                                        if (rs2.getString("first_char").equals("D")) {
                                            d.append(rs2.getString("count") + ",");
                                        }
                                        if (rs2.getString("first_char").equals("E")) {
                                            e.append(rs2.getString("count") + ",");
                                        }
                                        if (rs2.getString("first_char").equals("G")) {
                                            g.append(rs2.getString("count") + ",");
                                        }
                                        if (rs2.getString("first_char").equals("P")) {
                                            p.append(rs2.getString("count") + ",");
                                        }

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

                                <%if (rs.getString("first_char").equals("C")) {%>

                                <div class="sparkline" style="background-color: #f8d90f; padding:5px;" data-type="line" data-spot-Radius="4" data-highlight-Spot-Color="rgb(233, 30, 99)" data-highlight-Line-Color="#000" data-min-Spot-Color="rgb(255,255,255)" data-max-Spot-Color="rgb(255,255,255)" data-spot-Color="" data-offset="90" data-width="100%" data-height="92px" data-line-Width="2" data-line-Color="rgba(255,255,255,0.7)" data-fill-Color="rgba(0, 188, 212, 0)"> <%=c.substring(0, c.length() - 1)%></div>
                                <%}%>
                                <%if (rs.getString("first_char").equals("D")) {%>

                                <div class="sparkline" style="background-color:#aacd5a; padding:5px;" data-type="line" data-spot-Radius="4" data-highlight-Spot-Color="rgb(233, 30, 99)" data-highlight-Line-Color="#000"
                                     data-min-Spot-Color="rgb(255,255,255)" data-max-Spot-Color="rgb(255,255,255)" data-spot-Color=""
                                     data-offset="90" data-width="100%" data-height="92px" data-line-Width="2" data-line-Color="rgba(255,255,255,0.7)"
                                     data-fill-Color="rgba(0, 188, 212, 0)"> <%=d.substring(0, d.length() - 1)%></div>
                                <%}%>
                                <%if (rs.getString("first_char").equals("E")) {%>
                                <div class="sparkline" style="background-color:#83c77f; padding:5px;" data-type="line" data-spot-Radius="4" data-highlight-Spot-Color="rgb(233, 30, 99)" data-highlight-Line-Color="#000"
                                     data-min-Spot-Color="rgb(255,255,255)" data-max-Spot-Color="rgb(255,255,255)" data-spot-Color=""
                                     data-offset="90" data-width="100%" data-height="92px" data-line-Width="2" data-line-Color="rgba(255,255,255,0.7)"
                                     data-fill-Color="rgba(0, 188, 212, 0)"> <%=e.substring(0, e.length() - 1)%> </div>

                                <%}%>
                                <%if (rs.getString("first_char").equals("G")) {%>
                                <div class="sparkline" style=" background-color:#5cc1a5; padding:5px;" data-type="line" data-spot-Radius="4" data-highlight-Spot-Color="rgb(233, 30, 99)" data-highlight-Line-Color="#000" data-min-Spot-Color="rgb(255,255,255)" data-max-Spot-Color="rgb(255,255,255)" data-spot-Color="" data-offset="90" data-width="100%" data-height="92px" data-line-Width="2" data-line-Color="rgba(255,255,255,0.7)" data-fill-Color="rgba(0, 188, 212, 0)"> <%=g.substring(0, g.length() - 1)%> </div>

                                <%}%>
                                <%if (rs.getString("first_char").equals("P")) {%>
                                <div class="sparkline" style="background-color:#35bbca; padding:5px;" data-type="line" data-spot-Radius="4" data-highlight-Spot-Color="rgb(233, 30, 99)" data-highlight-Line-Color="#000" data-min-Spot-Color="rgb(255,255,255)" data-max-Spot-Color="rgb(255,255,255)" data-spot-Color="" data-offset="90" data-width="100%" data-height="92px" data-line-Width="2" data-line-Color="rgba(255,255,255,0.7)" data-fill-Color="rgba(0, 188, 212, 0)"> <%=p.substring(0, p.length() - 1)%></div>

                                <% }
                                %>
                                <div class="profile-footer">
                                    <ul>
                                        <% while (rs1.next()) {
//                                                System.out.println("workcode count:-" + rs1.getString("workcode"));
                                        %>


                                        <li> <span>LAST COUNT</span> <span class="badge bg-green"> <%=rs1.getString("workcode")%></span> </li>
                                            <% } %>

                                        <%if (rs.getString("first_char").equals("C")) {%>
                                        <li> <span>LAST DATE</span> <span class="badge bg-green"><%=rs.getString("maxdate")%></span> </li>
                                        <li> <span>TOTAL COUNT</span> <span class="badge bg-orange"><%=rs.getString("count")%></span> </li>
                                            <%}%>
                                            <%if (rs.getString("first_char").equals("D")) {%>
                                        <li> <span>LAST DATE</span> <span class="badge bg-green"><%=rs.getString("maxdate")%></span> </li>
                                        <li> <span>TOTAL COUNT</span> <span class="badge bg-orange"><%=rs.getString("count")%></span> </li>
                                            <%}%>
                                            <%if (rs.getString("first_char").equals("E")) {%>
                                        <li> <span>LAST DATE</span> <span class="badge bg-green"><%=rs.getString("maxdate")%></span> </li>
                                        <li> <span>TOTAL COUNT</span> <span class="badge bg-orange"><%=rs.getString("count")%></span> </li>
                                            <%}%>
                                            <%if (rs.getString("first_char").equals("G")) {%>
                                        <li> <span>LAST DATE</span> <span class="badge bg-green"><%=rs.getString("maxdate")%></span> </li>
                                        <li> <span>TOTAL COUNT</span> <span class="badge bg-orange"><%=rs.getString("count")%></span> </li>
                                            <%}%>
                                            <%if (rs.getString("first_char").equals("P")) {%>
                                        <li> <span>LAST DATE</span> <span class="badge bg-green"><%=rs.getString("maxdate")%></span> </li>
                                        <li> <span>TOTAL COUNT</span> <span class="badge bg-orange"><%=rs.getString("count")%></span> </li>
                                            <%}%>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </a>
                       <%-- 
                         <%if (!rs.getString("first_char").equals("C") && rs.getString("first_char").equals("P")) {%>
                                       
                          <a href="#" style="color:#000">
                        <div class="col-md-20">
                            <div class="card profile-card">
                                <div class="profile-body">
                                    <div class="content-area m-t-30">
                                        <span class="material-icons electronic-icon">
                                            live_tv
                                        </span>
                                        <h4> CREATIVE <br> MEDIA</h4>
                                    </div>
                                </div>
                                <div class="sparkline" style=" background-color:#5cc1a5; padding:5px;" data-type="line" data-spot-Radius="4" data-highlight-Spot-Color="rgb(233, 30, 99)" data-highlight-Line-Color="#000" data-min-Spot-Color="rgb(255,255,255)" data-max-Spot-Color="rgb(255,255,255)" data-spot-Color="" data-offset="90" data-width="100%" data-height="92px" data-line-Width="2" data-line-Color="rgba(255,255,255,0.7)" data-fill-Color="rgba(0, 188, 212, 0)"> 0 </div>
                                 <div class="profile-footer">
                                    <ul>
                                        <li> <span>LAST COUNT</span> <span class="badge bg-green">0</span> </li>
                                        <li> <span>LAST DATE</span> <span class="badge bg-green">0</span> </li>
                                        <li> <span>TOTAL COUNT</span> <span class="badge bg-orange">0</span> </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </a>

                        <% }%>--%>
                                    
                    <% } %>
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="padding: 0px 10px 0px 0px !important">
                        <div class="card">
                            <div class="header">
                                <h2>TOTAL UPLOADS</h2>
                                <!--<ul class="header-dropdown m-r--5">
                                  <li class="dropdown"> <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="material-icons">more_vert</i> </a>
                                    <ul class="dropdown-menu pull-right">
                                      <li><a href="javascript:void(0);">Action</a></li>
                                      <li><a href="javascript:void(0);">Another action</a></li>
                                      <li><a href="javascript:void(0);">Something else here</a></li>
                                    </ul>
                                  </li>
                                </ul>-->
                            </div>
                            <div class="body">
                                <div id="highchart"></div>
                                <!--<div id="chartdiv"></div>-->
                                <!--<div id="chartdiv"></div>-->
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="padding: 0px 10px 0px 0px !important"u>
                        <div class="card">
                            <div class="header">
                                <h2>USER'S INFOS</h2>
                                <!-- <ul class="header-dropdown m-r--5">
                                   <li class="dropdown"> <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="material-icons">more_vert</i> </a>
                                     <ul class="dropdown-menu pull-right">
                                       <li><a href="javascript:void(0);">Action</a></li>
                                       <li><a href="javascript:void(0);">Another action</a></li>
                                       <li><a href="javascript:void(0);">Something else here</a></li>
                                     </ul>
                                   </li>
                                 </ul>-->
                            </div>
                            <div class="body">
                                <!-- Nav tabs -->
                                <ul class="nav nav-tabs" role="tablist">
                                    <li role="presentation" class="active">
                                        <a href="#home_with_icon_title" data-toggle="tab">
                                            <span class="material-icons">local_printshop</span> PRINT
                                        </a>
                                    </li>
                                    <li role="presentation">
                                        <a href="#profile_with_icon_title" data-toggle="tab">
                                            <span class="material-icons">phonelink</span> DIGITAL
                                        </a>
                                    </li>
                                    <li role="presentation">
                                        <a href="#messages_with_icon_title" data-toggle="tab">
                                            <span class="material-icons">wb_incandescent</span> CREATIVE
                                        </a>
                                    </li>
                                    <li role="presentation">
                                        <a href="#settings_with_icon_title" data-toggle="tab">
                                            <span class="material-icons">live_tv</span> ELECTRONIC
                                        </a>
                                    </li>
                                    <li role="presentation">
                                        <a href="#gr_with_icon_title" data-toggle="tab">
                                            <span class="material-icons">home_work</span> GOVERNMENT RESOLUTION
                                        </a>
                                    </li>
                                </ul>

                                <!-- Tab panes -->
                                <div class="tab-content">
                                    <div role="tabpanel" class="tab-pane fade in active" id="home_with_icon_title">
                                        <div id="chartdiv2"></div>
                                    </div>
                                    <div role="tabpanel" class="tab-pane fade" id="profile_with_icon_title">

                                        <!--<b>Digital</b>-->

                                        <div id="chartdivdigital"></div>

                                    </div>
                                    <div role="tabpanel" class="tab-pane fade" id="messages_with_icon_title">
                                        <!--<b>Creative </b>-->
                                        <div id="chartdivcreative"></div>
                                        <!--                                        <p>
                                                                                    Lorem ipsum dolor sit amet, ut duo atqui exerci dicunt, ius impedit mediocritatem an. Pri ut tation electram moderatius.
                                                                                    Per te suavitate democritum. Duis nemore probatus ne quo, ad liber essent aliquid
                                                                                    pro. Et eos nusquam accumsan, vide mentitum fabellas ne est, eu munere gubergren
                                                                                    sadipscing mel.
                                                                                </p>-->
                                    </div>
                                    <div role="tabpanel" class="tab-pane fade" id="settings_with_icon_title">
                                        <div id="chartdivelectronic"></div>
                                    </div>
                                    <div role="tabpanel" class="tab-pane fade" id="gr_with_icon_title">
                                        <div id="chartdivgr"></div>
                                        <!--<P>Government Resolution</P>-->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>


        <!-- Jquery Core Js --> 
        <script src="plugins/jquery/jquery.min.js"></script> 

        <!-- Bootstrap Core Js --> 
        <script src="plugins/bootstrap/js/bootstrap.js"></script> 

        <!-- Select Plugin Js --> 
        <script src="plugins/bootstrap-select/js/bootstrap-select.js"></script> 

        <!-- Slimscroll Plugin Js --> 
        <script src="plugins/jquery-slimscroll/jquery.slimscroll.js"></script> 

        <!-- Waves Effect Plugin Js --> 
        <script src="plugins/node-waves/waves.js"></script> 

        <!-- Jquery CountTo Plugin Js --> 
        <script src="plugins/jquery-countto/jquery.countTo.js"></script> 

        <!-- Morris Plugin Js --> 
        <script src="plugins/raphael/raphael.min.js"></script> 
        <script src="plugins/morrisjs/morris.js"></script> 

        <!-- Flot Charts Plugin Js --> 
        <script src="plugins/flot-charts/jquery.flot.js"></script> 

        <!-- Sparkline Chart Plugin Js --> 
        <script src="plugins/jquery-sparkline/jquery.sparkline.js"></script> 

        <!--am chart--> 
        <script src="plugins/amcharts4/core.js"></script> 
        <script src="plugins/amcharts4/charts.js"></script> 
        <script src="plugins/amcharts4/animated.js"></script> 

        <!-- highchart--> 
        <script src="https://code.highcharts.com/highcharts.js"></script> 
        <script src="https://code.highcharts.com/modules/exporting.js"></script> 
        <script src="https://code.highcharts.com/modules/export-data.js"></script> 
        <script src="https://code.highcharts.com/modules/accessibility.js"></script> 

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
        <script src="js/pages/index.js"></script> 
        <script src="js/pages/forms/basic-form-elements.js"></script>

        <!-- Demo Js --> 
        <!--<script src="js/demo.js"></script>--> 
        <!--highchart-->
        <script>
            $('#date-end').bootstrapMaterialDatePicker({weekStart: 0, time: false});
            $('#date-start').bootstrapMaterialDatePicker({weekStart: 0, time: false}).on('change', function (e, date)
            {
            $('#date-end').bootstrapMaterialDatePicker('setMinDate', date);
            });
        </script>

        <%java.text.DateFormat df = new java.text.SimpleDateFormat("dd/MM/yyyy");%>
        <script>

            Highcharts.setOptions({
            colors: ['#F8D90F', '#AACD5A', '#83C77F', '#5CC1A5', '#35BBCA']
            });
            Highcharts.chart('highchart', {
            chart: {
            type: 'column'
            },
                    title: {
                    text: 'All Media Statistics',
                            style: {
                            fontSize: '16px',
                                    fontFamily: 'Verdana',
                                    fontWeight: 600
                            }
                    },
                    subtitle: {
                    text: '<b>Till  <%= df.format(new java.util.Date())%> </b>',
                            x: - 20
                    },
                    xAxis: {
                    categories: [<%=month%>],
                            gridLineColor: 'transparent',
                            gridTextColor: '#ffffff',
                            lineColor: 'transparent',
                            tickColor: 'transparent',
                            showEmpty: false,
                    },
                    yAxis: {
                    min: 0,
                            title: {
                            text: 'Total uploads'
                            },
                            gridLineColor: '#ffffff',
                            gridLineWidth: 0,
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
                    },
                    legend: {
                    style: {
                    fontSize: '12px',
                            fontFamily: 'Verdana',
                            fontWeight: 600
                    }
//                    align: 'right',
//                            x: - 10,
//                            verticalAlign: 'bottom',
//                            y: 25,
//                            floating: true,
//                            backgroundColor:
//                            Highcharts.defaultOptions.legend.backgroundColor || 'white',
//                            borderColor: '#CCC',
//                            borderWidth: 1,
//                            shadow: false
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
                    series: [{
                    name: 'Print',
                            data: [<%=print%>]
                    }, {
                    name: 'Digital',
                            data: [<%=digital%>]
                    }, {
                    name: 'Creative',
                            data: [<%=creative%>]
                    }, {
                    name: 'Electronic',
                            data: [<%=electronic%>]
                    }, {
                    name: 'GR',
                            data: [<%=gr%>]
                    }, ]
            });
        </script>

        <script>

            //user info
            am4core.ready(function () {

            // Themes begin
            am4core.useTheme(am4themes_animated);
            // Themes end

            /**
             * Chart design taken from Samsung health app
             */

            var chart = am4core.create("chartdiv2", am4charts.XYChart);
            chart.hiddenState.properties.opacity = 0; // this creates initial fade-in

            chart.paddingBottom = 30;
            chart.data = [
            <%
                String dateTimeLine = null;
                while (rsBarchart.next()) {

//                            newid = rs.getString(1);
                    name = rsBarchart.getString(2);
                    count = rsBarchart.getInt(3);
//                    dateTimeLine = rs.getString(4);
                    pic = rsBarchart.getString("pic");
//                    System.out.println("name:-" + name);
//                    System.out.println("count:-" + count);
//                    System.out.println("pic:-" + pic);
            %>
            {
            "name": "<%=name%>",
                    "steps": <%=count%>,
                    "href": "<%=pic%>"
            },
            <%}

                if (stmBarchart != null) {
                    stmBarchart.close();
                }
                if (rsBarchart != null) {
                    rsBarchart.close();
                }

            %>
            ];
            var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
            categoryAxis.dataFields.category = "name";
            categoryAxis.renderer.grid.template.strokeOpacity = 0;
            categoryAxis.renderer.minGridDistance = 60;
            categoryAxis.renderer.labels.template.dy = 35;
            categoryAxis.renderer.tooltip.dy = 35;
            var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
            valueAxis.renderer.inside = true;
            valueAxis.renderer.labels.template.fillOpacity = 0.3;
            valueAxis.renderer.grid.template.strokeOpacity = 0;
            valueAxis.min = 0;
            valueAxis.cursorTooltipEnabled = false;
            valueAxis.renderer.baseGrid.strokeOpacity = 0;
            var series = chart.series.push(new am4charts.ColumnSeries);
            series.dataFields.valueY = "steps";
            series.dataFields.categoryX = "name";
            series.tooltipText = "{valueY.value}";
            series.tooltip.pointerOrientation = "vertical";
            series.tooltip.dy = - 6;
            series.columnsContainer.zIndex = 100;
            var columnTemplate = series.columns.template;
categoryAxis.renderer.cellStartLocation = 0.5;
columnTemplate.width = am4core.percent(40);           
                  // columnTemplate.maxWidth = 66;
            columnTemplate.column.cornerRadius(50, 50, 10, 10);
            columnTemplate.strokeOpacity = 0;
            series.heatRules.push({target: columnTemplate, property: "fill", dataField: "valueY", min: am4core.color("#e5dc36"), max: am4core.color("#5faa46")});
            series.mainContainer.mask = undefined;
            var cursor = new am4charts.XYCursor();
            chart.cursor = cursor;
            cursor.lineX.disabled = true;
            cursor.lineY.disabled = true;
            cursor.behavior = "none";
            var bullet = columnTemplate.createChild(am4charts.CircleBullet);
            bullet.circle.radius = 20;
            bullet.valign = "bottom";
            bullet.align = "center";
            bullet.isMeasured = true;
            bullet.mouseEnabled = false;
            bullet.verticalCenter = "bottom";
            bullet.interactionsEnabled = false;
            var hoverState = bullet.states.create("hover");
            var outlineCircle = bullet.createChild(am4core.Circle);
            outlineCircle.adapter.add("radius", function (radius, target) {
            var circleBullet = target.parent;
            return circleBullet.circle.pixelRadius + 5;
            })

                    var image = bullet.createChild(am4core.Image);
            image.width = 60;
            image.height = 60;
            image.horizontalCenter = "middle";
            image.verticalCenter = "middle";
            image.propertyFields.href = "href";
            image.adapter.add("mask", function (mask, target) {
            var circleBullet = target.parent;
            return circleBullet.circle;
            })

                    var previousBullet;
            chart.cursor.events.on("cursorpositionchanged", function (event) {
            var dataItem = series.tooltipDataItem;
            if (dataItem.column) {
            var bullet = dataItem.column.children.getIndex(1);
            if (previousBullet && previousBullet != bullet) {
            previousBullet.isHover = false;
            }

            if (previousBullet != bullet) {

            var hs = bullet.states.getKey("hover");
            hs.properties.dy = - bullet.parent.pixelHeight + 30;
            bullet.isHover = true;
            previousBullet = bullet;
            }
            }
            })

            });
            //
            // end am4core.ready()
            //user info Electronic
            am4core.ready(function () {

            // Themes begin
            am4core.useTheme(am4themes_animated);
            // Themes end

            /**
             * Chart design taken from Samsung health app
             */

            var chart = am4core.create("chartdivelectronic", am4charts.XYChart);
            chart.hiddenState.properties.opacity = 0; // this creates initial fade-in

            chart.paddingBottom = 30;
            chart.data = [
            <%//                String dateTimeLine = null;
                while (rsElectronic.next()) {

//                            newid = rs.getString(1);
                    name = rsElectronic.getString(2);
                    count = rsElectronic.getInt(3);
//                    dateTimeLine = rs.getString(4);
                    pic = rsElectronic.getString("pic");
//                    System.out.println("name:-" + name);
//                    System.out.println("count:-" + count);
//                    System.out.println("pic:-" + pic);
            %>
            {
            "name": "<%=name%>",
                    "steps": <%=count%>,
                    "href": "<%=pic%>"
            },
            <%}

                if (stmElectronic != null) {
                    stmElectronic.close();
                }
                if (rsElectronic != null) {
                    rsElectronic.close();
                }

            %>
            ];
            var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
            categoryAxis.dataFields.category = "name";
            categoryAxis.renderer.grid.template.strokeOpacity = 0;
            categoryAxis.renderer.minGridDistance = 10;
            categoryAxis.renderer.labels.template.dy = 35;
            categoryAxis.renderer.tooltip.dy = 35;
            var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
            valueAxis.renderer.inside = true;
            valueAxis.renderer.labels.template.fillOpacity = 0.3;
            valueAxis.renderer.grid.template.strokeOpacity = 0;
            valueAxis.min = 0;
            valueAxis.cursorTooltipEnabled = false;
            valueAxis.renderer.baseGrid.strokeOpacity = 0;
            var series = chart.series.push(new am4charts.ColumnSeries);
            series.dataFields.valueY = "steps";
            series.dataFields.categoryX = "name";
            series.tooltipText = "{valueY.value}";
            series.tooltip.pointerOrientation = "vertical";
            series.tooltip.dy = - 6;
            series.columnsContainer.zIndex = 100;
            var columnTemplate = series.columns.template;
            columnTemplate.width = am4core.percent(20);
            columnTemplate.maxWidth = 66;
            columnTemplate.column.cornerRadius(60, 60, 10, 10);
            columnTemplate.strokeOpacity = 0;
            series.heatRules.push({target: columnTemplate, property: "fill", dataField: "valueY", min: am4core.color("#e5dc36"), max: am4core.color("#5faa46")});
            series.mainContainer.mask = undefined;
            var cursor = new am4charts.XYCursor();
            chart.cursor = cursor;
            cursor.lineX.disabled = true;
            cursor.lineY.disabled = true;
            cursor.behavior = "none";
            var bullet = columnTemplate.createChild(am4charts.CircleBullet);
            bullet.circle.radius = 20;
            bullet.valign = "bottom";
            bullet.align = "center";
            bullet.isMeasured = true;
            bullet.mouseEnabled = false;
            bullet.verticalCenter = "bottom";
            bullet.interactionsEnabled = false;
            var hoverState = bullet.states.create("hover");
            var outlineCircle = bullet.createChild(am4core.Circle);
            outlineCircle.adapter.add("radius", function (radius, target) {
            var circleBullet = target.parent;
            return circleBullet.circle.pixelRadius + 5;
            })

                    var image = bullet.createChild(am4core.Image);
            image.width = 60;
            image.height = 60;
            image.horizontalCenter = "middle";
            image.verticalCenter = "middle";
            image.propertyFields.href = "href";
            image.adapter.add("mask", function (mask, target) {
            var circleBullet = target.parent;
            return circleBullet.circle;
            })

                    var previousBullet;
            chart.cursor.events.on("cursorpositionchanged", function (event) {
            var dataItem = series.tooltipDataItem;
            if (dataItem.column) {
            var bullet = dataItem.column.children.getIndex(1);
            if (previousBullet && previousBullet != bullet) {
            previousBullet.isHover = false;
            }

            if (previousBullet != bullet) {

            var hs = bullet.states.getKey("hover");
            hs.properties.dy = - bullet.parent.pixelHeight + 30;
            bullet.isHover = true;
            previousBullet = bullet;
            }
            }
            })

            }); // end am4core.ready()
//            am4core.ready(function () {
//            am4core.ready(function () {
            am4core.ready(function () {

            // Themes begin
            am4core.useTheme(am4themes_animated);
            // Themes end

            /**
             * Chart design taken from Samsung health app
             */

            var chart = am4core.create("chartdivgr", am4charts.XYChart);
            chart.hiddenState.properties.opacity = 0; // this creates initial fade-in

            chart.paddingBottom = 30;
            chart.data = [
            <%//                String dateTimeLine = null;
                while (rsGR.next()) {

//                            newid = rs.getString(1);
                    name = rsGR.getString(2);
                    count = rsGR.getInt(3);
//                    dateTimeLine = rs.getString(4);
                    pic = rsGR.getString("pic");
//                    System.out.println("name:-" + name);
//                    System.out.println("count:-" + count);
//                    System.out.println("pic:-" + pic);
            %>
            {
            "name": "<%=name%>",
                    "steps": <%=count%>,
                    "href": "<%=pic%>"
            },
            <%}

                if (stmGR != null) {
                    stmGR.close();
                }
                if (rsGR != null) {
                    rsGR.close();
                }

            %>
            ];
            var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
            categoryAxis.dataFields.category = "name";
            categoryAxis.renderer.grid.template.strokeOpacity = 0;
            categoryAxis.renderer.minGridDistance = 10;
            categoryAxis.renderer.labels.template.dy = 35;
            categoryAxis.renderer.tooltip.dy = 35;
            var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
            valueAxis.renderer.inside = true;
            valueAxis.renderer.labels.template.fillOpacity = 0.3;
            valueAxis.renderer.grid.template.strokeOpacity = 0;
            valueAxis.min = 0;
            valueAxis.cursorTooltipEnabled = false;
            valueAxis.renderer.baseGrid.strokeOpacity = 0;
            var series = chart.series.push(new am4charts.ColumnSeries);
            series.dataFields.valueY = "steps";
            series.dataFields.categoryX = "name";
            series.tooltipText = "{valueY.value}";
            series.tooltip.pointerOrientation = "vertical";
            series.tooltip.dy = - 6;
            series.columnsContainer.zIndex = 100;
            var columnTemplate = series.columns.template;
            columnTemplate.width = am4core.percent(20);
            columnTemplate.maxWidth = 66;
            columnTemplate.column.cornerRadius(60, 60, 10, 10);
            columnTemplate.strokeOpacity = 0;
            series.heatRules.push({target: columnTemplate, property: "fill", dataField: "valueY", min: am4core.color("#e5dc36"), max: am4core.color("#5faa46")});
            series.mainContainer.mask = undefined;
            var cursor = new am4charts.XYCursor();
            chart.cursor = cursor;
            cursor.lineX.disabled = true;
            cursor.lineY.disabled = true;
            cursor.behavior = "none";
            var bullet = columnTemplate.createChild(am4charts.CircleBullet);
            bullet.circle.radius = 20;
            bullet.valign = "bottom";
            bullet.align = "center";
            bullet.isMeasured = true;
            bullet.mouseEnabled = false;
            bullet.verticalCenter = "bottom";
            bullet.interactionsEnabled = false;
            var hoverState = bullet.states.create("hover");
            var outlineCircle = bullet.createChild(am4core.Circle);
            outlineCircle.adapter.add("radius", function (radius, target) {
            var circleBullet = target.parent;
            return circleBullet.circle.pixelRadius + 5;
            })

                    var image = bullet.createChild(am4core.Image);
            image.width = 60;
            image.height = 60;
            image.horizontalCenter = "middle";
            image.verticalCenter = "middle";
            image.propertyFields.href = "href";
            image.adapter.add("mask", function (mask, target) {
            var circleBullet = target.parent;
            return circleBullet.circle;
            })

                    var previousBullet;
            chart.cursor.events.on("cursorpositionchanged", function (event) {
            var dataItem = series.tooltipDataItem;
            if (dataItem.column) {
            var bullet = dataItem.column.children.getIndex(1);
            if (previousBullet && previousBullet != bullet) {
            previousBullet.isHover = false;
            }

            if (previousBullet != bullet) {

            var hs = bullet.states.getKey("hover");
            hs.properties.dy = - bullet.parent.pixelHeight + 30;
            bullet.isHover = true;
            previousBullet = bullet;
            }
            }
            })

            }); // end am4core.ready()
            am4core.ready(function () {

            // Themes begin
            am4core.useTheme(am4themes_animated);
            // Themes end

            /**
             * Chart design taken from Samsung health app
             */

            var chart = am4core.create("chartdivdigital", am4charts.XYChart);
            chart.hiddenState.properties.opacity = 0; // this creates initial fade-in

            chart.paddingBottom = 30;
            chart.data = [
            <%//                String dateTimeLine = null;
                while (rsDigital.next()) {

//                            newid = rs.getString(1);
                    name = rsDigital.getString(2);
                    count = rsDigital.getInt(3);
//                    dateTimeLine = rs.getString(4);
                    pic = rsDigital.getString("pic");
//                    System.out.println("name:-" + name);
//                    System.out.println("count:-" + count);
//                    System.out.println("pic:-" + pic);
            %>
            {
            "name": "<%=name%>",
                    "steps": <%=count%>,
                    "href": "<%=pic%>"
            },
            <%}

                if (stmDigital != null) {
                    stmDigital.close();
                }
                if (rsDigital != null) {
                    rsDigital.close();
                }

            %>
            ];
            var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
            categoryAxis.dataFields.category = "name";
            categoryAxis.renderer.grid.template.strokeOpacity = 0;
            categoryAxis.renderer.minGridDistance = 10;
            categoryAxis.renderer.labels.template.dy = 35;
            categoryAxis.renderer.tooltip.dy = 35;
            var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
            valueAxis.renderer.inside = true;
            valueAxis.renderer.labels.template.fillOpacity = 0.3;
            valueAxis.renderer.grid.template.strokeOpacity = 0;
            valueAxis.min = 0;
            valueAxis.cursorTooltipEnabled = false;
            valueAxis.renderer.baseGrid.strokeOpacity = 0;
            var series = chart.series.push(new am4charts.ColumnSeries);
            series.dataFields.valueY = "steps";
            series.dataFields.categoryX = "name";
            series.tooltipText = "{valueY.value}";
            series.tooltip.pointerOrientation = "vertical";
            series.tooltip.dy = - 6;
            series.columnsContainer.zIndex = 100;
            var columnTemplate = series.columns.template;
            columnTemplate.width = am4core.percent(20);
            columnTemplate.maxWidth = 66;
            columnTemplate.column.cornerRadius(60, 60, 10, 10);
            columnTemplate.strokeOpacity = 0;
            series.heatRules.push({target: columnTemplate, property: "fill", dataField: "valueY", min: am4core.color("#e5dc36"), max: am4core.color("#5faa46")});
            series.mainContainer.mask = undefined;
            var cursor = new am4charts.XYCursor();
            chart.cursor = cursor;
            cursor.lineX.disabled = true;
            cursor.lineY.disabled = true;
            cursor.behavior = "none";
            var bullet = columnTemplate.createChild(am4charts.CircleBullet);
            bullet.circle.radius = 20;
            bullet.valign = "bottom";
            bullet.align = "center";
            bullet.isMeasured = true;
            bullet.mouseEnabled = false;
            bullet.verticalCenter = "bottom";
            bullet.interactionsEnabled = false;
            var hoverState = bullet.states.create("hover");
            var outlineCircle = bullet.createChild(am4core.Circle);
            outlineCircle.adapter.add("radius", function (radius, target) {
            var circleBullet = target.parent;
            return circleBullet.circle.pixelRadius + 5;
            })

                    var image = bullet.createChild(am4core.Image);
            image.width = 60;
            image.height = 60;
            image.horizontalCenter = "middle";
            image.verticalCenter = "middle";
            image.propertyFields.href = "href";
            image.adapter.add("mask", function (mask, target) {
            var circleBullet = target.parent;
            return circleBullet.circle;
            })

                    var previousBullet;
            chart.cursor.events.on("cursorpositionchanged", function (event) {
            var dataItem = series.tooltipDataItem;
            if (dataItem.column) {
            var bullet = dataItem.column.children.getIndex(1);
            if (previousBullet && previousBullet != bullet) {
            previousBullet.isHover = false;
            }

            if (previousBullet != bullet) {

            var hs = bullet.states.getKey("hover");
            hs.properties.dy = - bullet.parent.pixelHeight + 30;
            bullet.isHover = true;
            previousBullet = bullet;
            }
            }
            })

            }); // end am4core.ready()

            am4core.ready(function () {

            // Themes begin
            am4core.useTheme(am4themes_animated);
            // Themes end

            /**
             * Chart design taken from Samsung health app
             */

            var chart = am4core.create("chartdivcreative", am4charts.XYChart);
            chart.hiddenState.properties.opacity = 0; // this creates initial fade-in

            chart.paddingBottom = 30;
            chart.data = [
            <%//                String dateTimeLine = null;
                while (rsCreative.next()) {

//                            newid = rs.getString(1);
                    name = rsCreative.getString(2);
                    count = rsCreative.getInt(3);
//                    dateTimeLine = rs.getString(4);
                    pic = rsCreative.getString("pic");
//                    System.out.println("name:-" + name);
//                    System.out.println("count:-" + count);
//                    System.out.println("pic:-" + pic);
            %>
            {
            "name": "<%=name%>",
                    "steps": <%=count%>,
                    "href": "<%=pic%>"
            },
            <%}

                if (stmCreative != null) {
                    stmCreative.close();
                }
                if (rsCreative != null) {
                    rsCreative.close();
                }

            %>
            ];
            var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
            categoryAxis.dataFields.category = "name";
            categoryAxis.renderer.grid.template.strokeOpacity = 0;
            categoryAxis.renderer.minGridDistance = 10;
            categoryAxis.renderer.labels.template.dy = 35;
            categoryAxis.renderer.tooltip.dy = 35;
            var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
            valueAxis.renderer.inside = true;
            valueAxis.renderer.labels.template.fillOpacity = 0.3;
            valueAxis.renderer.grid.template.strokeOpacity = 0;
            valueAxis.min = 0;
            valueAxis.cursorTooltipEnabled = false;
            valueAxis.renderer.baseGrid.strokeOpacity = 0;
            var series = chart.series.push(new am4charts.ColumnSeries);
            series.dataFields.valueY = "steps";
            series.dataFields.categoryX = "name";
            series.tooltipText = "{valueY.value}";
            series.tooltip.pointerOrientation = "vertical";
            series.tooltip.dy = - 6;
            series.columnsContainer.zIndex = 100;
            var columnTemplate = series.columns.template;
            columnTemplate.width = am4core.percent(20);
            columnTemplate.maxWidth = 66;
            columnTemplate.column.cornerRadius(60, 60, 10, 10);
            columnTemplate.strokeOpacity = 0;
            series.heatRules.push({target: columnTemplate, property: "fill", dataField: "valueY", min: am4core.color("#e5dc36"), max: am4core.color("#5faa46")});
            series.mainContainer.mask = undefined;
            var cursor = new am4charts.XYCursor();
            chart.cursor = cursor;
            cursor.lineX.disabled = true;
            cursor.lineY.disabled = true;
            cursor.behavior = "none";
            var bullet = columnTemplate.createChild(am4charts.CircleBullet);
            bullet.circle.radius = 20;
            bullet.valign = "bottom";
            bullet.align = "center";
            bullet.isMeasured = true;
            bullet.mouseEnabled = false;
            bullet.verticalCenter = "bottom";
            bullet.interactionsEnabled = false;
            var hoverState = bullet.states.create("hover");
            var outlineCircle = bullet.createChild(am4core.Circle);
            outlineCircle.adapter.add("radius", function (radius, target) {
            var circleBullet = target.parent;
            return circleBullet.circle.pixelRadius + 5;
            })

                    var image = bullet.createChild(am4core.Image);
            image.width = 60;
            image.height = 60;
            image.horizontalCenter = "middle";
            image.verticalCenter = "middle";
            image.propertyFields.href = "href";
            image.adapter.add("mask", function (mask, target) {
            var circleBullet = target.parent;
            return circleBullet.circle;
            })

                    var previousBullet;
            chart.cursor.events.on("cursorpositionchanged", function (event) {
            var dataItem = series.tooltipDataItem;
            if (dataItem.column) {
            var bullet = dataItem.column.children.getIndex(1);
            if (previousBullet && previousBullet != bullet) {
            previousBullet.isHover = false;
            }

            if (previousBullet != bullet) {

            var hs = bullet.states.getKey("hover");
            hs.properties.dy = - bullet.parent.pixelHeight + 30;
            bullet.isHover = true;
            previousBullet = bullet;
            }
            }
            })

            }); // end am4core.ready()

        </script>


    </body>
</html>

<%} else {
        response.sendRedirect("login.jsp");
    }%>