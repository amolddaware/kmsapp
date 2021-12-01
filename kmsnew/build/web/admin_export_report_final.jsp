<%-- 
    Document   : login
    Created on : Nov 15, 2017, 10:26:41 PM
    Author     : Amol
--%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.ListIterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ResourceBundle rb = ResourceBundle.getBundle("msg");
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("1") || session.getAttribute("role").equals("5"))) {

// if (session != null && session.getAttribute("username") != null && session.getAttribute("role").equals("3")) {
        String username = session.getAttribute("username").toString();
        String userid = session.getAttribute("userid").toString();
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setDateHeader("Expires", 0);
        response.addHeader("X-Frame-Options", "DENY");
        
            request.setCharacterEncoding("UTF-8");
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

//    String fail="";
        if (request.getParameter("fail") != null) {
            fail = "Incorrect Username or Password !!";
        }
//    
        request.setAttribute("jession", jsessionid);
%>
<!DOCTYPE html>
<html lang=en>
    <head>
        <meta charset=utf-8>
        <meta name=viewport content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>All Media Report</title>
        <link rel=icon href=images/favicon.ico type=image/x-icon>
        <link href=css/font/materialicon.css rel=stylesheet type=text/css>
        <link href=css/font/googlefont.css rel=stylesheet type=text/css>
        <link href=plugins/bootstrap/css/bootstrap.css rel=stylesheet>
        <link href=plugins/node-waves/waves.css rel=stylesheet />
        <link href=plugins/animate-css/animate.css rel=stylesheet />
        <link href=plugins/bootstrap-material-datetimepicker/css/bootstrap-material-datetimepicker.css rel=stylesheet />
        <link href=plugins/jquery-datatable/skin/bootstrap/css/dataTables.bootstrap.css rel=stylesheet>
        <link href=css/style.css rel=stylesheet>
        <link href=css/themes/all-themes.css rel="stylesheet"/>
        <link href=css/print.css rel="stylesheet"/>
        <link href=css/jquery-ui.css rel=stylesheet>

    </head>
    <body class=theme-blue>

        <% if (session.getAttribute("role").equals("1")) {%>
        <jsp:include page="header.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <%} else if (session.getAttribute("role").equals("5")) {%>
        <jsp:include page="userHeader1.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <% }%>     <%
            String table = "";
            Connection dh = null;
            String imag[];
            ConnectionDB conn = new ConnectionDB();
            dh = conn.getConnection();
            PreparedStatement stm = null;
            ResultSet rs = null;
            //            String s = "Narendra modi";
            //            String s = request.getParameter("generaltagprint");
            try {
                //            String s = null;

                //            String generaltag = request.getParameter("generaltagprint");
                //        s.getBytes("UTF-8");
                //            s = new String(generaltag.getBytes("ISO-8859-1"), "UTF-8");
                //                StringBuilder str = new StringBuilder();
                //
                String fromDate = null, toDate = null;
                String dateQuery = null;
                Set<String> hash_Set = new HashSet<String>();
                String serchQuery = null;
                try {
        %>
        <section class=content style="overflow: hidden">
            <div class=col-md-12  m-t-100>
                <div class="container">
                    <div class="row">
                        <div class="col-sm-8 col-sm-offset-2">
                            <input class="btn btn-dark noprint" type="button" value="Print" onclick="javascript:printDiv('printablediv')" />
                            <!--<input class="btn bg-black pull-right" type=button value="PrintData" onclick="getPDF()" /><br><br>-->

                            <div id="printablediv">
                                <%
                                    String fromdate = null;
                                    StringBuffer query = new StringBuffer();
                                    StringBuffer querySearch = new StringBuffer();
//                                     String dateQuery = null;
//System.out.println("test");
                                    String generaltag = null;
                                    if (request.getParameter("generaltag").isEmpty() && (request.getParameter("fromdate").isEmpty() && request.getParameter("todate").isEmpty()) && !request.getParameter("sentiment").isEmpty()) {
//                                        dateQuery = "and (sourcedate BETWEEN '" + request.getParameter("fromdate") + "' AND '" + request.getParameter("todate") + "') ";

                                        querySearch.append(request.getParameter("sentiment") + "::");
                                        query.append("sentiment=" + "'" + request.getParameter("sentiment") + "'");

                                    }
                                    if (request.getParameter("generaltag").isEmpty() && (!request.getParameter("fromdate").isEmpty() && !request.getParameter("todate").isEmpty()) && !request.getParameter("sentiment").isEmpty()) {
                                        dateQuery = " and (sourcedate BETWEEN '" + request.getParameter("fromdate") + "' AND '" + request.getParameter("todate") + "') ";

                                        querySearch.append(request.getParameter("sentiment") + "::" + request.getParameter("fromdate") + " to " + request.getParameter("todate"));
                                        query.append("sentiment='" + request.getParameter("sentiment") + "'" + dateQuery + "  ");

                                    }
                                    if (!request.getParameter("generaltag").isEmpty() && (!request.getParameter("fromdate").isEmpty() && !request.getParameter("todate").isEmpty()) && !request.getParameter("sentiment").isEmpty()) {
                                        generaltag = request.getParameter("generaltag");
                                        dateQuery = "and (sourcedate BETWEEN '" + request.getParameter("fromdate") + "' AND '" + request.getParameter("todate") + "') ";

                                        querySearch.append(generaltag + "::" + request.getParameter("sentiment") + "::" + request.getParameter("fromdate") + " to " + request.getParameter("todate"));
                                        query.append("MATCH (subject,titlemarathi,chname,additionaltag,sentiment,approvedtag,dm_source,dept,sector,name_of_program,place_of_program,district,npname,edition,location,brand) AGAINST ('" + generaltag + "') " + dateQuery + " and sentiment= '" + request.getParameter("sentiment") + "' ");

                                    }
                                    if (!request.getParameter("generaltag").isEmpty() && (request.getParameter("fromdate").isEmpty() && request.getParameter("todate").isEmpty()) && !request.getParameter("sentiment").isEmpty()) {
                                        generaltag = request.getParameter("generaltag");

                                        querySearch.append(generaltag + "::" + request.getParameter("sentiment"));
                                        query.append("MATCH (subject,titlemarathi,chname,additionaltag,sentiment,approvedtag,dm_source,dept,sector,name_of_program,place_of_program,district,npname,edition,location,brand) AGAINST ('" + generaltag + "') and sentiment='" + request.getParameter("sentiment") + "' ");

                                    }
                                    if (!request.getParameter("generaltag").isEmpty() && (!request.getParameter("fromdate").isEmpty() && !request.getParameter("todate").isEmpty()) && request.getParameter("sentiment").isEmpty()) {
                                        generaltag = request.getParameter("generaltag");
                                        dateQuery = "and (sourcedate BETWEEN '" + request.getParameter("fromdate") + "' AND '" + request.getParameter("todate") + "') ";

                                        querySearch.append(generaltag + "::" + request.getParameter("fromdate") + " to " + request.getParameter("todate"));
                                        query.append("MATCH (subject,titlemarathi,chname,additionaltag,sentiment,approvedtag,dm_source,dept,sector,name_of_program,place_of_program,district,npname,edition,location,brand) AGAINST ('" + generaltag + "') " + dateQuery + "  ");

                                    }
                                    if (!request.getParameter("generaltag").isEmpty() && (request.getParameter("fromdate").isEmpty() && request.getParameter("todate").isEmpty()) && request.getParameter("sentiment").isEmpty()) {
                                        generaltag = request.getParameter("generaltag");
//                                        dateQuery = "and (sourcedate BETWEEN '" + request.getParameter("fromdate") + "' AND '" + request.getParameter("todate") + "') ";

                                        querySearch.append(generaltag + "::");
                                        query.append("MATCH (subject,titlemarathi,chname,additionaltag,sentiment,approvedtag,dm_source,dept,sector,name_of_program,place_of_program,district,npname,edition,location,brand) AGAINST ('" + generaltag + "')   ");

                                    }
                                    if (request.getParameter("generaltag").isEmpty() && (!request.getParameter("fromdate").isEmpty() && !request.getParameter("todate").isEmpty()) && request.getParameter("sentiment").isEmpty()) {
//                                        fromdate = request.getParameter("fromdate");
                                        query.append(" (sourcedate BETWEEN '" + request.getParameter("fromdate") + "' AND '" + request.getParameter("todate") + "') ");
//                        dateQuery = " (sourcedate BETWEEN '" + request.getParameter("fromdate") + "' AND '" + request.getParameter("todate") + "') ";
                                        //                        dateQuery = "and (datetime BETWEEN '" + ffulldate + "' AND '" + tfulldate + "')";
                                        querySearch.append(request.getParameter("fromdate") + " to " + request.getParameter("todate"));

                                    } else {
                                        dateQuery = "";
                                    }
//                                    System.out.println("querySearch:-" + request.getParameter("generaltag"));
//                                    System.out.println("fromdate:-" + request.getParameter("fromdate"));
//                                    System.out.println("todate:-" + request.getParameter("todate"));
//                                    System.out.println("querySearch:-" + querySearch);
//                                    System.out.println("brandquerry:-" + query);
                                    String sql = "SELECT * FROM tbl_news_dataentry where " + query + " and workcode is not null ORDER BY CASE WHEN workcode LIKE '%D%' THEN 1	WHEN workcode LIKE 'P'  THEN 2     WHEN workcode LIKE '%E%' THEN 3    WHEN workcode LIKE '%C%' THEN 4    WHEN workcode LIKE '%G%' THEN 5 WHEN workcode LIKE '%W%' THEN 6    ELSE 7 END ";
                                    //                String sql = "SELECT * FROM tbl_news_dataentry WHERE " + query + " and workcode like ? and workcode not like ? limit 0,10";
//                                    System.out.println("sql11111:-" + sql);
                                    stm = dh.prepareStatement(sql);
                                    //                    stm.setString(1, "%P%");
//                                    stm.setString(1, "%P%");
                                    rs = stm.executeQuery();

                                    String npname = null, tempNpname = null;
                                    int flag = 0;
                                    int flag1 = 0;
                                    int count = 0;
                                    List<String> lstNpname = new ArrayList();
                                    List<String> lstBrand = new ArrayList();


                                %>
                                <div class="col-sm-12 padding-0">
                                    <div class="col-sm-offset-3 col-sm-6 text-center cover_data text-capitalize">
                                        <h1>KMS REPORT</h1>
                                        <hr class="hr_dashed">
                                        <h2 class="text-capitalize">All Media</h2>
                                        <hr class="hr_dashed">
                                        <h3>Search By:                                                

                                            <%                                                String qq[] = querySearch.toString().split("::");
                                                for (int i = 0; i < qq.length; i++) {
                                            %>
                                            <span class="badge badge-pill badge-primary"><%=qq[i]%></span>
                                            <%}%>
                                        </h3>
                                    </div>
                                    <img class="img-responsive" src="images/cover_bg.svg"> 
                                </div>

                                <div class="col-sm-12 padding-0">
                                    <div class="body-main inner">
                                        <div class="row">

                                            <div class="col-sm-12">

                                                <h2 class="text-capitalize text-center">INDEX</h2>
                                                <!--<h3 class="text-center"><span id="dtFirst"></span> to <span id="dtLast"></span></h3>-->
                                                <hr class="dotted">
                                                <div class="row">
                                                    <h3 style="color: #009fe2;" class="text-center">Keywords Used to Generate Report<br><br>

                                                        <%                                                String qq1[] = querySearch.toString().split("::");
                                                            for (int i = 0; i < qq1.length; i++) {
                                                        %>
                                                        <span class="label bg-black"><%=qq1[i]%></span>
                                                        <%}%>
                                                        <!--<span class="label bg-black"> Devendra Fadnavis</span>-->
                                                    </h3><br>

                                                    <div class="col-sm-12">
                                                        <div class="card bg-light">
                                                            <div class="card-body">
                                                                <table class="table table-responsive d-sm-table margin-0">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td id="dmTeam"><strong><span id="dmNum">  </span> Digital Media</strong><span class="pull-right"><strong><span style="text-decoration: underline;color: blue;" id="dmFirst"></span>-<span style="text-decoration: underline;color: blue;"  id="dmLast"></span></strong></span></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td id="prTeam"><strong><span id="prNum">  </span> Print Media</strong><span class="pull-right"><strong><span style="text-decoration: underline;color: blue;" id="prFirst"></span>-<span style="text-decoration: underline;color: blue;" id="prLast"></span></strong></span></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td id="emTeam"><strong><span id="emNum">  </span> Electronic Media</strong><span class="pull-right"><strong><span style="text-decoration: underline;color: blue;" id="emFirst"></span>-<span style="text-decoration: underline;color: blue;"  id="emLast"></span></strong></span> </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td id="crTeam"><strong><span id="crNum">  </span> Creative Team</strong><span class="pull-right"><strong><span style="text-decoration: underline;color: blue;" id="crFirst"></span>-<span style="text-decoration: underline;color: blue;" id="crLast"></span></strong></span></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td id="grTeam"><strong><span id="grNum">  </span> Government Resolution</strong><span class="pull-right"><strong><span style="text-decoration: underline;color: blue;" id="grFirst"></span>-<span style="text-decoration: underline;color: blue;"  id="grLast"></span></strong></span></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td id="wbTeam"><strong><span id="wbNum">  </span> Web Media</strong><span class="pull-right"><strong><span style="text-decoration: underline;color: blue;" id="wbFirst"></span>-<span style="text-decoration: underline;color: blue;"  id="wbLast"></span></strong></span></td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <%
                                    String workcode = null, code = null;
                                    while (rs.next()) {
                                        count++;
//                                out.println(count);

                                        workcode = rs.getString("workcode").substring(0, 1);

                                %>
                                <div class="dttm" style="display:none"><span><%=rs.getString("datetime")%></span></div>
                                        <%
                                            //            Char char=workcode.toCharArray();
                                            switch (workcode) {
                                                case "E":
                                                    //                                        System.out.println("N");
                                                    //if (rs.getString("workcode").contains("N")) {
                                        %>
                                <div class="col-sm-12 padding-0">
                                    <div class="body-main inner ">
                                        <div class="row">
                                            <div class="col-sm-8">
                                                <h4 class="eleName" style="color: #009fe2;"><strong>Electronic Media Report</strong></h4>
                                                <!--                                                <p>
                                                                                                    <strong>From: 2017-04-24</strong><br>
                                                                                                    <strong>To: 2020-04-24</strong></p>-->
                                            </div>
                                            <div class="col-sm-4"> 
                                                <img class="img-responsive pull-right" width="70" alt="" src="images/logo_f.png" /> </div>

                                            <div class="col-sm-12">
                                                <hr class="dotted">
                                                <div class="row">
                                                    <div class="col-sm-4 m-b-15"> 

                                                        <!--<img class="img-responsive" alt="" src="images/card-img.png" />--> 
                                                        <%if (rs.getString("startdatetime") != null && !rs.getString("workcode").contains("EN")) {%>
                                                        <img class="npnameImg img-responsive" src="images/vchannel/<%=rs.getString("chname")%>.png" alt="<%=rs.getString("chname")%>" width="200">
                                                        <%} else {%>
                                                        <img class="npnameImg img-responsive" src="images/webportal/<%=rs.getString("chname")%>.jpg" alt="<%=rs.getString("chname")%>" width="200">

                                                        <%}%>                                          </div>
                                                    <div class="col-sm-8 text-right">

                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-12">
                                                        <div class="card bg-light m-b-15">
                                                            <div class="card-body">
                                                                <div class="row">
    <%--                                                                              <%
                                                                        if (rs.getString("graphicspath") != null) {
                                                                            String image[] = rs.getString("graphicspath").split("::");
                                                                            for (int i = 0; i < image.length; i++) {
                                                                    %> <div class="col-md-4 col-sm-4">
                                                                        <img src="<%=image[i].substring(25).replace(" ", "%20")%>"   class="img-responsive" id="imageContainer"  width="200" height="100"  ></div>

                                                                    <%}
                                                                        } else {
                                                                        }%>
--%>
                                                                    <div class="col-md-9 col-sm-9 m-t-10">
                                                                        <h3 class="npnameH3">


                                                                        </h3>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="card bg-light">
                                                            <div class="card-body">
                                                                <table class="table table-responsive d-md-table mb-0">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td style="width:30%"><strong>Title (English)</strong></td>
                                                                            <td style="width:70%"><% if (rs.getString("subject") != null) {%><%=rs.getString("subject")%> <% } %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Title (Marathi)</strong></td>
                                                                            <td><% if (rs.getString("titlemarathi") != null) {%><%=rs.getString("titlemarathi")%><%}%> </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Channel Name</strong></td>
                                                                            <td><%=rs.getString("chname")%>  </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Description</strong></td>
                                                                            <td> <% if (rs.getString("description") != null) {%> <%=rs.getString("description")%><% } %>  </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Sentiment</strong></td>
                                                                            <td><% if (rs.getString("sentiment") != null) {%> <%=rs.getString("sentiment")%><% }%>  </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Date</strong></td>
                                                                            <td> <%=rs.getString("sourcedate")%> </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--                                                    <div class="col-sm-12">
                                                                                                            <hr class="dotted">
                                                    
                                                                                                        </div>-->

                                                </div>
                                                <div class="emCount">
                                                    <span class="pull-right  "><%=count%></span>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <% break;
                                    case "P":
//                                    if (rs.getString("workcode").contains("P")) { 
                                %>

                                <div class="col-sm-12 padding-0">
                                    <div class="body-main inner ">
                                        <div class="row">
                                            <div class="col-sm-8">
                                                <h4 class="priName" style="color: #009fe2;"><strong> Print Media Report</strong></h4>
                                                <!--                                                <p>
                                                                                                    <strong>From: 2017-04-24</strong><br>
                                                                                                    <strong>To: 2020-04-24</strong></p>-->
                                            </div>
                                            <div class="col-sm-4"> 
                                                <img class="img-responsive pull-right" width="70" alt="" src="images/logo_f.png" /> 
                                            </div>

                                            <div class="col-sm-12">
                                                <hr class="dotted">
                                                <div class="row">
                                                    <div class="col-sm-4 m-b-15"> 

                                                        <!--<img class="img-responsive" alt="" src="images/card-img.png" />--> 
                                                        <%if (rs.getString("npname") != null) {%>
                                                        <img class="npnameImg img-responsive" src="images/epaper/<%=rs.getString("npname")%>.png" alt="<%=rs.getString("npname")%>" width="200">
                                                        <%} else {%>
                                                        <img class="npnameImg img-responsive" src="images/epaper/<%=rs.getString("npname")%>.png" alt="<%=rs.getString("npname")%>" width="200">

                                                        <%}%>
                                                    </div>
                                                    <div class="col-sm-8 text-right">
                                                        <%--
                                                        <%if (!fromdate.isEmpty()) {%>
                                                        <p class="npnameH3">
                                                            <strong>From: <%=fromdate%></strong><br>
                                                            <strong>To: <%=todate%></strong>
                                                        </p>
                                                        <%}%>--%>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-12">
                                                        <div class="card bg-light m-b-15">
                                                            <div class="card-body">
                                                                <div class="row">

                                                                    <%
                                                                        if (!rs.getString("graphicspath").isEmpty()) {
                                                                            String image[] = rs.getString("graphicspath").split("::");
                                                                            for (int i = 0; i < image.length; i++) {
                                                                    %> <div class="col-md-4 col-sm-4">
                                                                        <img src="/kmsvdo/<%=image[i].substring(25).replace(" ", "%20")%>"   class="img-responsive" id="imageContainer"  width="200" height="100"  ></div>

                                                                    <%}
                                                                    } else {%>

                                                                    <%}%>
                                                                    <!--                                                                       <div class="col-sm-4"> <img class="img-responsive" alt="" src="images/bg.jpg" /> </div>
                                                                                                  <div class="col-sm-4"> <img class="img-responsive" alt="" src="images/bg.jpg" /> </div>
                                                                                                  <div class="col-sm-4"> <img class="img-responsive" alt="" src="images/bg.jpg" /> </div>-->

                                                                    <div class="col-md-9 col-sm-9 m-t-10">
                                                                        <h3 class="npnameH3">


                                                                        </h3>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="card bg-light">
                                                            <div class="card-body">
                                                                <table class="table table-responsive d-md-table mb-0">
                                                                    <tbody>


                                                                        <tr>
                                                                            <td style="width:30%"><strong>Brand</strong></td>
                                                                            <td style="width:70%"><% if (rs.getString("brand") != null) {%><%=rs.getString("brand")%> <% } %></td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td><strong>Location</strong></td>
                                                                            <td><% if (rs.getString("location") != null) {%><%=rs.getString("location")%><%}%> </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Language</strong></td>
                                                                            <td><% if (rs.getString("language") != null) {%><%=rs.getString("language")%><%}%> 
                                                                            </td>
                                                                        </tr>


                                                                        <tr>
                                                                            <td><strong>Edition</strong></td>
                                                                            <td><% if (rs.getString("edition") != null) {%><%=rs.getString("edition")%><%}%>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Sub Edition</strong></td>
                                                                            <td> <% if (rs.getString("subedition") != null) {%> <%=rs.getString("subedition")%><% } %>  </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Title (English) </strong></td>
                                                                            <td><% if (rs.getString("subject") != null) {%> <%=rs.getString("subject")%><% }%>  </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Title (Marathi)</strong></td>
                                                                            <td><% if (rs.getString("titlemarathi") != null) {%> <%=rs.getString("titlemarathi")%><% }%>  </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Date</strong></td>
                                                                            <td> <%=rs.getString("sourcedate")%> </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--                                                    <div class="col-sm-12">
                                                                                                            <hr class="dotted">
                                                    
                                                                                                        </div>-->

                                                </div>
                                                <div class="prCount">
                                                    <span class="pull-right"><%=count%></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <% break;
                                    case "W":
//                                    if (rs.getString("workcode").contains("P")) { 
                                %>

                                <div class="col-sm-12 padding-0">
                                    <div class="body-main inner ">
                                        <div class="row">
                                            <div class="col-sm-8">
                                                <h4 class="priName" style="color: #009fe2;"><strong> Web Media Report</strong></h4>
                                                <!--                                                <p>
                                                                                                    <strong>From: 2017-04-24</strong><br>
                                                                                                    <strong>To: 2020-04-24</strong></p>-->
                                            </div>
                                            <div class="col-sm-4"> 
                                                <img class="img-responsive pull-right" width="70" alt="" src="images/logo_f.png" /> 
                                            </div>

                                            <div class="col-sm-12">
                                                <hr class="dotted">
                                                <div class="row">
                                                    <div class="col-sm-4 m-b-15"> 

                                                        <!--<img class="img-responsive" alt="" src="images/card-img.png" />--> 
                                                        <%if (rs.getString("npname") != null) {%>
                                                        <img class="npnameImg img-responsive" src="images/epaper/<%=rs.getString("npname")%>.png" alt="<%=rs.getString("npname")%>" width="200">
                                                        <%} else {%>
                                                        <img class="npnameImg img-responsive" src="images/epaper/<%=rs.getString("npname")%>.png" alt="<%=rs.getString("npname")%>" width="200">

                                                        <%}%>
                                                    </div>
                                                    <div class="col-sm-8 text-right">
                                                        <%--
                                                        <%if (!fromdate.isEmpty()) {%>
                                                        <p class="npnameH3">
                                                            <strong>From: <%=fromdate%></strong><br>
                                                            <strong>To: <%=todate%></strong>
                                                        </p>
                                                        <%}%>--%>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-12">
                                                        <div class="card bg-light m-b-15">
                                                            <div class="card-body">
                                                                <div class="row">

                                                                    <!--                                                                       <div class="col-sm-4"> <img class="img-responsive" alt="" src="images/bg.jpg" /> </div>
                                                                                                  <div class="col-sm-4"> <img class="img-responsive" alt="" src="images/bg.jpg" /> </div>
                                                                                                  <div class="col-sm-4"> <img class="img-responsive" alt="" src="images/bg.jpg" /> </div>-->

                                                                    <div class="col-md-9 col-sm-9 m-t-10">
                                                                        <h3 class="npnameH3">

                                                                            <%=rs.getString("npname")%>
                                                                        </h3>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="card bg-light">
                                                            <div class="card-body">
                                                                <table class="table table-responsive d-md-table mb-0">
                                                                    <tbody>

                                                                        <tr>
                                                                            <td style="width:30%"><strong>WebLink</strong></td>
                                                                            <td style="width:70%"><% if (rs.getString("link") != null) {%>
                                                                                <a href="<%=rs.getString("link")%>" target="_blank"><%=rs.getString("link")%> </a>

                                                                                <% } %></td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td><strong>District</strong></td>
                                                                            <td><% if (rs.getString("district") != null) {%><%=rs.getString("district")%><%}%> </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Language</strong></td>
                                                                            <td><% if (rs.getString("language") != null) {%><%=rs.getString("language")%><%}%> 
                                                                            </td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td><strong>Title (English) </strong></td>
                                                                            <td><% if (rs.getString("subject") != null) {%> <%=rs.getString("subject")%><% }%>  </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Title (Marathi)</strong></td>
                                                                            <td><% if (rs.getString("titlemarathi") != null) {%> <%=rs.getString("titlemarathi")%><% }%>  </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Date</strong></td>
                                                                            <td> <%=rs.getString("sourcedate")%> </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--                                                    <div class="col-sm-12">
                                                                                                            <hr class="dotted">
                                                    
                                                                                                        </div>-->

                                                </div>
                                                <div class="wbCount">
                                                    <span class="pull-right"><%=count%></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <% break;
                                    case "D":
//                                    if (rs.getString("workcode").contains("D")) {  
                                %>
                                <div class="col-sm-12 padding-0">
                                    <div class="body-main inner ">
                                        <div class="row">
                                            <div class="col-sm-8">
                                                <h4 class="digName" style="color: #009fe2;"><strong>Digital Media Report</strong></h4>
                                                <!--                                                <p>
                                                                                                    <strong>From: 2017-04-24</strong><br>
                                                                                                    <strong>To: 2020-04-24</strong></p>-->
                                            </div>
                                            <div class="col-sm-4"> 
                                                <img class="img-responsive pull-right" width="70" alt="" src="images/logo_f.png" /> </div>

                                            <div class="col-sm-12">
                                                <hr class="dotted">
                                                <div class="row">
                                                    <div class="col-md-12 m-b-15"> 

                                                        <!--<img class="img-responsive" alt="" src="images/card-img.png" />--> 
                                                        <h5> <% if (rs.getString("subject") != null) {%><%=rs.getString("subject")%> <% } %> </h5>
                                                    </div>

                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-12">
                                                        <div class="card bg-light">
                                                            <div class="card-body">
                                                                <table class="table table-responsive d-md-table mb-0">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td style="width:30%"><strong>Source</strong></td>
                                                                            <td style="width:70%"><% if (rs.getString("dm_source") != null) {%><%=rs.getString("dm_source")%> <% } %></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Post</strong></td>
                                                                            <td><% if (rs.getString("description") != null) {%><%=rs.getString("description")%><%}%> </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>URL</strong></td>
                                                                            <td><a href="<%=rs.getString("link")%>" target="_blank" ><%=rs.getString("link")%></a>   </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Count</strong></td>
                                                                            <td> <% if (rs.getString("total_engagement") != null) {%> <%=rs.getString("total_engagement")%><% }%>  </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Date</strong></td>
                                                                            <td> <%=rs.getString("sourcedate")%> </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--                                                    <div class="col-sm-12">
                                                                                                            <hr class="dotted">
                                                    
                                                                                                        </div>-->

                                                </div>
                                                <div class="dmCount">
                                                    <span class="pull-right "><%=count%></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <% break;
                                    case "G":
                                        //  if (rs.getString("workcode").contains("G")) { 
                                %>
                                <div class="col-sm-12 padding-0">
                                    <div class="body-main inner ">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="row">
                                                    <div class="col-sm-8">
                                                        <h4 class="grName" style="color: #009fe2;"><strong>Government Resolution Report</strong></h4>
                                                        <!--                                                        <p><strong>From: 2017-04-24</strong><br>
                                                                                                                    <strong>To: 2020-04-24</strong></p>-->
                                                    </div>
                                                    <div class="col-sm-4 text-right clearfix"> 
                                                        <img class="img-responsive pull-right" width="70px" alt="" src="images/logo_f.png" />
                                                    </div>
                                                </div>
                                                <hr class="dotted">
                                            </div>
                                            <div class="col-sm-12">
                                                <div class="row">
                                                    <div class="col-sm-12 m-b-15">
                                                        <div class="row">
                                                            <div class="col-sm-10">
                                                                <h5> <%=rs.getString("subject")%></h5>
                                                            </div>
                                                            <div class="col-sm-2 text-right">
                                                                <a class="showPDF"  data-toggle="collapse" href="#collapseExample_<%=count%>" role="button" aria-expanded="false" aria-controls="collapseExample">
                                                                    <img class="img-fluid" width="40px" src="images/pdf_icon.png"/>
                                                                </a>

                                                            </div>
                                                            <div class="col-sm-12">
                                                                <div class="collapse" id="collapseExample_<%=count%>">
                                                                    <div class="card card-body">
                                                                        <iframe src="<%=rs.getString("docpath")%>" width="100%" height="500px">
                                                                        </iframe>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-12">
                                                        <div class="card bg-light">
                                                            <div class="card-body">
                                                                <table class="table table-responsive d-sm-table mb-0">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td><strong>Date</strong></td>
                                                                            <td><%=rs.getString("sourcedate")%></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Title Marathi</strong></td>
                                                                            <td><%=rs.getString("titlemarathi")%></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Department</strong></td>
                                                                            <td><%=rs.getString("dept")%></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Department(Marathi)</strong></td>
                                                                            <td><%=rs.getString("deptmarathi")%></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>GR Code</strong></td>
                                                                            <td><%=rs.getString("grcode")%></td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="grCount">
                                                    <span class="pull-right"><%=count%></span>

                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <% break;
                                    case "C":
//                                    if (rs.getString("workcode").contains("C")) { 
                                %>
                                <div class="col-sm-12 padding-0">
                                    <div class="body-main inner ">
                                        <div class="row">
                                            <div class="col-sm-8">
                                                <h4 class="crName" style="color: #009fe2;"><strong>Creative Team Report</strong></h4>
                                                <!--                                                <p>
                                                                                                    <strong>From: 2017-04-24</strong><br>
                                                                                                    <strong>To: 2020-04-24</strong></p>-->
                                            </div>
                                            <div class="col-sm-4"> 
                                                <img class="img-responsive pull-right" width="70" alt="" src="images/logo_f.png" /> </div>

                                            <div class="col-sm-12">
                                                <hr class="dotted">
                                                <div class="row">
                                                    <div class="col-md-12 m-b-15"> 

                                                        <!--<img class="img-responsive" alt="" src="images/card-img.png" />--> 
                                                        <h5>  <% if (rs.getString("subject") != null) {%><%=rs.getString("subject")%> <% } %> </h5>
                                                    </div>

                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-12">
                                                        <div class="card bg-light m-b-15">
                                                            <div class="card-body">
                                                                <div class="row">

                                                                    <%
                                                                        if (!rs.getString("graphicspath").isEmpty()) {
                                                                            String image[] = rs.getString("graphicspath").split("::");
                                                                            for (int i = 0; i < image.length; i++) {

                                                                    %> <div class="col-md-4 col-sm-4">
                                                                        <img src="/kmsvdo/<%=image[i].substring(25).replace(" ", "%20")%>"   class="img-responsive" id="imageContainer"  width="200" height="100"  ></div>

                                                                    <%}
                                                                        }%>
                                                                  

                                                                    <div class="col-md-9 col-sm-9 m-t-10">
                                                                        <h3 class="npnameH3">


                                                                        </h3>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="card bg-light">
                                                            <div class="card-body">
                                                                <table class="table table-responsive d-md-table mb-0">
                                                                    <tbody>

                                                                        <tr>
                                                                            <td><strong>Description</strong></td>
                                                                            <td><% if (rs.getString("description") != null) {%><%=rs.getString("description")%><%}%> </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Sector</strong></td>
                                                                            <td><%=rs.getString("sector")%>   </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Name of Program</strong></td>
                                                                            <td> <% if (rs.getString("name_of_program") != null) {%> <%=rs.getString("name_of_program")%><% }%>  </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Place of Program</strong></td>
                                                                            <td> <% if (rs.getString("place_of_program") != null) {%> <%=rs.getString("place_of_program")%><% }%>  </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Date</strong></td>
                                                                            <td> <%=rs.getString("sourcedate")%> </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--                                                    <div class="col-sm-12">
                                                                                                            <hr class="dotted">
                                                    
                                                                                                        </div>-->

                                                </div>
                                                <div class="crCount">
                                                    <span class="pull-right"><%=count%></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <%
                                            break;

                                        default:
                                            System.out.println("test");
                                    }
//} 
                                %>

                                <% }

                                    if (count == 0) {
                                        out.println("<span class='text-danger '><b>Record not found</b></span>");
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <%      } catch (Exception e) {
                    System.out.println("error in innerexport:-" + e.getMessage());
                }
            } catch (Exception e) {
                System.out.println("error in outerexport:-" + e.getMessage());
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
        <script src=js/jquery.min.js></script>
        <script src=js/jspdf.min.js></script>
        <script src=js/jquery-1.12.4.js></script>
        <script src=js/jquery-ui.js></script>
        <script src=plugins/bootstrap/js/bootstrap.js></script>
        <script src=plugins/bootstrap-select/js/bootstrap-select.js></script>
        <script src=plugins/jquery-slimscroll/jquery.slimscroll.js></script>
        <script src=plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.js></script>
        <script src=plugins/jquery-validation/jquery.validate.js></script>
        <!--<script src=plugins/jquery-steps/jquery.steps.js></script>-->
        <script src=plugins/autosize/autosize.js></script>
        <script src=plugins/momentjs/moment.js></script>
        <script src=plugins/node-waves/waves.js ></script>
        <script src=plugins/bootstrap-material-datetimepicker/js/bootstrap-material-datetimepicker.js></script>
        <script src=plugins/bootstrap-datepicker/js/bootstrap-datepicker.js></script>
        <script src=js/demo.js></script>
        <script src=js/admin.js></script>
        <script>

                                var seen = {};
                                $("#date-end1").bootstrapMaterialDatePicker({weekStart: 0, time: false});
                                $("#date-start1").bootstrapMaterialDatePicker({weekStart: 0, time: false}).on("change", function (b, a) {
                                    $("#date-end1").bootstrapMaterialDatePicker("setMinDate", a)
                                });
                                $("#date-end").bootstrapMaterialDatePicker({weekStart: 0, time: false});
                                $("#date-start").bootstrapMaterialDatePicker({weekStart: 0, time: false}).on("change", function (b, a) {
                                    $("#date-end").bootstrapMaterialDatePicker("setMinDate", a)
                                });

        </script>
        <script>
            //electronic media//       
            var f = "-";
            var ff = "-";
            var l = "-";
            var ll = "-";
//            var i = 0;
            $(".emCount").each(function () {
                f = $(this).children("span:first-child").text();//this is first span of this line
//                 l = $(this).children("span:last-child").text();//this is last span of this line
                $(this).attr("id", 'em-' + f);
                ff = $(".emCount span").first().text();//this is last span of this line
                ll = $(".emCount span").last().text();//this is last span of this line
            });
//            alert(ll);
            if (ll == "-") {
                document.getElementById("emTeam").style.display = "none";
//                alert("no record");
            } else if (ll != "-") {
                document.getElementById("emTeam").style.display = "block";
//                alert("record");
            }
            var mydivEm = document.getElementById("emFirst");
            var aTagEm = document.createElement('a');
            aTagEm.setAttribute('href', "#em-" + ff);
            aTagEm.innerText = ff;
            mydivEm.appendChild(aTagEm);
            var mydivEml = document.getElementById("emLast");
            var aTagEml = document.createElement('a');
            aTagEml.setAttribute('href', "#em-" + ll);
            aTagEml.innerText = ll;
            mydivEml.appendChild(aTagEml);
            //web media//       
            var w = "-";
            var wf = "-";
            var wl = "-";
            var wll = "-";
//            var i = 0;
            $(".wbCount").each(function () {
                w = $(this).children("span:first-child").text();//this is first span of this line
//                 l = $(this).children("span:last-child").text();//this is last span of this line
                $(this).attr("id", 'wb-' + w);
                wf = $(".wbCount span").first().text();//this is last span of this line
                wll = $(".wbCount span").last().text();//this is last span of this line
            });
//            alert(wll);
            if (wll == "-") {
                document.getElementById("wbTeam").style.display = "none";
//                alert("no record");
            } else if (wll != "-") {
                document.getElementById("wbTeam").style.display = "block";
//                alert("record");
            }
            var mydivWb = document.getElementById("wbFirst");
            var aTagWb = document.createElement('a');
            aTagWb.setAttribute('href', "#wb-" + wf);
            aTagWb.innerText = wf;
            mydivWb.appendChild(aTagWb);
            var mydivWbl = document.getElementById("wbLast");
            var aTagWbl = document.createElement('a');
            aTagWbl.setAttribute('href', "#wb-" + wll);
            aTagWbl.innerText = wll;
            mydivWbl.appendChild(aTagWbl);

            //Print media//       
            var pf = "-";
            var pff = "-";
            var pl = "-";
            var pll = "-";
//            var i = 0;
            $(".prCount").each(function () {
                pf = $(this).children("span:first-child").text();//this is first span of this line
//                 l = $(this).children("span:last-child").text();//this is last span of this line
                $(this).attr("id", 'pr-' + pf);
                pff = $(".prCount span").first().text();//this is last span of this line
                pll = $(".prCount span").last().text();//this is last span of this line
            });
            if (pll == "-") {
                document.getElementById("prTeam").style.display = "none";
//                alert("no record");
            } else if (pll != "-") {
                document.getElementById("prTeam").style.display = "block";
//                alert("no record");
            }
            var mydivPr = document.getElementById("prFirst");
            var aTagPr = document.createElement('a');
            aTagPr.setAttribute('href', "#pr-" + pff);
            aTagPr.innerText = pff;
            mydivPr.appendChild(aTagPr);
            var mydivPrl = document.getElementById("prLast");
            var aTagPrl = document.createElement('a');
            aTagPrl.setAttribute('href', "#pr-" + pll);
            aTagPrl.innerText = pll;
            mydivPrl.appendChild(aTagPrl);

            //Digital media//       
            var df = "-";
            var dff = "-";
            var dl = "-";
            var dll = "-";
//            var i = 0;
            $(".dmCount").each(function () {
                df = $(this).children("span:first-child").text();//this is first span of this line
//                 l = $(this).children("span:last-child").text();//this is last span of this line
                $(this).attr("id", 'dm-' + df);
                dff = $(".dmCount span").first().text();//this is last span of this line
                dll = $(".dmCount span").last().text();//this is last span of this line
            });
            if (dll == "-") {
                document.getElementById("dmTeam").style.display = "none";
//                alert("no record");
            } else if (dll != "-") {
                document.getElementById("dmTeam").style.display = "block";
//                alert("no record");
            }
            var mydivDm = document.getElementById("dmFirst");
            var aTagDm = document.createElement('a');
            aTagDm.setAttribute('href', "#dm-" + dff);
            aTagDm.innerText = dff;
            mydivDm.appendChild(aTagDm);
            var mydivDml = document.getElementById("dmLast");
            var aTagDml = document.createElement('a');
            aTagDml.setAttribute('href', "#dm-" + dll);
            aTagDml.innerText = dll;
            mydivDml.appendChild(aTagDml);


            //Creative media//       
            var cf = "-";
            var cff = "-";
            var cl = "-";
            var cll = "-";
//            var i = 0;
            $(".crCount").each(function () {
                cf = $(this).children("span:first-child").text();//this is first span of this line
//                 l = $(this).children("span:last-child").text();//this is last span of this line
                $(this).attr("id", 'cr-' + cf);
                cff = $(".crCount span").first().text();//this is last span of this line
                cll = $(".crCount span").last().text();//this is last span of this line
            });
            if (cll == "-") {
                document.getElementById("crTeam").style.display = "none";
//                alert("no record");
            } else if (cll != "-") {
                document.getElementById("crTeam").style.display = "block";
//                alert("no record");
            }
//            alert(cll);
            var mydivCr = document.getElementById("crFirst");
            var aTagCr = document.createElement('a');
            aTagCr.setAttribute('href', "#cr-" + cff);
            aTagCr.innerText = cff;
            mydivCr.appendChild(aTagCr);
            var mydivCrl = document.getElementById("crLast");
            var aTagCrl = document.createElement('a');
            aTagCrl.setAttribute('href', "#cr-" + cll);
            aTagCrl.innerText = cll;
            mydivCrl.appendChild(aTagCrl);

            //GR media//       
            var gf = "-";
            var gff = "-";
            var gl = "-";
            var gll = "-";
//            var i = 0;
            $(".grCount").each(function () {
                gf = $(this).children("span:first-child").text();//this is first span of this line
//                 l = $(this).children("span:last-child").text();//this is last span of this line
                $(this).attr("id", 'gr-' + gf);
                gff = $(".grCount span").first().text();//this is last span of this line
                gll = $(".grCount span").last().text();//this is last span of this line
            });
            if (gll == "-") {
                document.getElementById("grTeam").style.display = "none";
//                alert("no record");
            } else
            if (gll != "-") {
                document.getElementById("grTeam").style.display = "block";
//                alert("no record");
            }
            var mydivGr = document.getElementById("grFirst");
            var aTagGr = document.createElement('a');
            aTagGr.setAttribute('href', "#gr-" + gff);
            aTagGr.innerText = gff;
            mydivGr.appendChild(aTagGr);
            var mydivGrl = document.getElementById("grLast");
            var aTagGrl = document.createElement('a');
            aTagGrl.setAttribute('href', "#gr-" + gll);
            aTagGrl.innerText = gll;
            mydivGrl.appendChild(aTagGrl);


            if (pll != "-" && dll != "-" && ll != "-" && cll != "-" && gll != "-" && wll != "-") {
                document.getElementById("wbNum").innerHTML = "6.";
                document.getElementById("grNum").innerHTML = "5.";
                document.getElementById("crNum").innerHTML = "4.";
                document.getElementById("emNum").innerHTML = "3.";
                document.getElementById("prNum").innerHTML = "2.";
                document.getElementById("dmNum").innerHTML = "1.";
            }
            if (pll != "-" && dll != "-" && ll == "-" && cll == "-" && gll == "-" && wll != "-") {
//    document.getElementById("grNum").innerHTML="5.";
//    document.getElementById("crNum").innerHTML="4.";
//    document.getElementById("emNum").innerHTML="3.";
                document.getElementById("prNum").innerHTML = "2.";
                document.getElementById("dmNum").innerHTML = "1.";
            }
            if (pll != "-" && dll != "-" && ll == "-" && cll == "-" && gll == "-" && wll == "-") {
//    document.getElementById("grNum").innerHTML="5.";
//    document.getElementById("crNum").innerHTML="4.";
                document.getElementById("wbNum").innerHTML = "3.";
                document.getElementById("prNum").innerHTML = "2.";
                document.getElementById("dmNum").innerHTML = "1.";
            }
            if (pll != "-" && dll != "-" && ll != "-" && cll == "-" && gll == "-" && wll != "-") {
//    document.getElementById("grNum").innerHTML="5.";
//    document.getElementById("crNum").innerHTML="4.";
                document.getElementById("emNum").innerHTML = "3.";
                document.getElementById("prNum").innerHTML = "2.";
                document.getElementById("dmNum").innerHTML = "1.";
            }
            if (pll != "-" && dll != "-" && ll != "-" && cll == "-" && gll == "-" && wll == "-") {
//    document.getElementById("grNum").innerHTML="5.";
                document.getElementById("wbNum").innerHTML = "4.";
                document.getElementById("emNum").innerHTML = "3.";
                document.getElementById("prNum").innerHTML = "2.";
                document.getElementById("dmNum").innerHTML = "1.";
            }
            if (pll != "-" && dll != "-" && ll != "-" && cll != "-" && gll == "-" && wll != "-") {
//    document.getElementById("grNum").innerHTML="5.";
                document.getElementById("crNum").innerHTML = "4.";
                document.getElementById("emNum").innerHTML = "3.";
                document.getElementById("prNum").innerHTML = "2.";
                document.getElementById("dmNum").innerHTML = "1.";
            }
            if (pll != "-" && dll != "-" && ll != "-" && cll != "-" && gll == "-" && wll == "-") {
                document.getElementById("wbNum").innerHTML = "5.";
                document.getElementById("crNum").innerHTML = "4.";
                document.getElementById("emNum").innerHTML = "3.";
                document.getElementById("prNum").innerHTML = "2.";
                document.getElementById("dmNum").innerHTML = "1.";
            }
            if (pll == "-" && dll != "-" && ll != "-" && cll == "-" && gll == "-" && wll != "-") {
//    document.getElementById("grNum").innerHTML="5.";
//    document.getElementById("crNum").innerHTML="4.";
                document.getElementById("emNum").innerHTML = "2.";
//    document.getElementById("prNum").innerHTML="2.";
                document.getElementById("dmNum").innerHTML = "1.";
            }
            if (pll == "-" && dll != "-" && ll != "-" && cll == "-" && gll == "-" && wll == "-") {
//    document.getElementById("grNum").innerHTML="5.";
                document.getElementById("wbNum").innerHTML = "3.";
                document.getElementById("emNum").innerHTML = "2.";
//    document.getElementById("prNum").innerHTML="2.";
                document.getElementById("dmNum").innerHTML = "1.";
            }
            if (pll == "-" && dll != "-" && ll != "-" && cll != "-" && gll == "-" && wll != "-") {
//    document.getElementById("grNum").innerHTML="5.";
                document.getElementById("crNum").innerHTML = "3.";
                document.getElementById("emNum").innerHTML = "2.";
//    document.getElementById("prNum").innerHTML="2.";
                document.getElementById("dmNum").innerHTML = "1.";
            }
            if (pll == "-" && dll != "-" && ll != "-" && cll != "-" && gll == "-" && wll == "-") {
//    document.getElementById("grNum").innerHTML="5.";
                document.getElementById("crNum").innerHTML = "3.";
                document.getElementById("emNum").innerHTML = "2.";
                document.getElementById("wbNum").innerHTML = "4.";
                document.getElementById("dmNum").innerHTML = "1.";
            }
            if (pll == "-" && dll != "-" && ll != "-" && cll != "-" && gll != "-" && wll != "-") {
                document.getElementById("grNum").innerHTML = "4.";
                document.getElementById("crNum").innerHTML = "3.";
                document.getElementById("emNum").innerHTML = "2.";
//    document.getElementById("prNum").innerHTML="2.";
                document.getElementById("dmNum").innerHTML = "1.";
            }
            if (pll == "-" && dll != "-" && ll != "-" && cll != "-" && gll != "-" && wll == "-") {
                document.getElementById("grNum").innerHTML = "4.";
                document.getElementById("crNum").innerHTML = "3.";
                document.getElementById("emNum").innerHTML = "2.";
                document.getElementById("wbNum").innerHTML = "5.";
                document.getElementById("dmNum").innerHTML = "1.";
            }
            if (pll != "-" && dll == "-" && ll != "-" && cll != "-" && gll != "-" && wll != "-") {
                document.getElementById("grNum").innerHTML = "4.";
                document.getElementById("crNum").innerHTML = "3.";
                document.getElementById("emNum").innerHTML = "2.";
                document.getElementById("prNum").innerHTML = "1.";
//    document.getElementById("dmNum").innerHTML="1.";
            }
            if (pll != "-" && dll == "-" && ll != "-" && cll != "-" && gll != "-" && wll == "-") {
                document.getElementById("grNum").innerHTML = "4.";
                document.getElementById("crNum").innerHTML = "3.";
                document.getElementById("emNum").innerHTML = "2.";
                document.getElementById("prNum").innerHTML = "1.";
                document.getElementById("wbNum").innerHTML = "5.";
            }
            if (pll != "-" && dll == "-" && ll == "-" && cll != "-" && gll != "-" && wll != "-") {
                document.getElementById("grNum").innerHTML = "3.";
                document.getElementById("crNum").innerHTML = "2.";
//    document.getElementById("emNum").innerHTML="2.";
                document.getElementById("prNum").innerHTML = "1.";
//    document.getElementById("dmNum").innerHTML="1.";
            }
            if (pll != "-" && dll == "-" && ll == "-" && cll != "-" && gll != "-" && wll == "-") {
                document.getElementById("grNum").innerHTML = "3.";
                document.getElementById("crNum").innerHTML = "2.";
                document.getElementById("wbNum").innerHTML = "4.";
                document.getElementById("prNum").innerHTML = "1.";
//    document.getElementById("dmNum").innerHTML="1.";
            }
            if (pll != "-" && dll == "-" && ll == "-" && cll == "-" && gll != "-" && wll != "-") {
                document.getElementById("grNum").innerHTML = "2.";
//    document.getElementById("crNum").innerHTML="2.";
//    document.getElementById("emNum").innerHTML="2.";
                document.getElementById("prNum").innerHTML = "1.";
//    document.getElementById("dmNum").innerHTML="1.";
            }
            if (pll != "-" && dll == "-" && ll == "-" && cll == "-" && gll != "-" && wll == "-") {
                document.getElementById("grNum").innerHTML = "2.";
                document.getElementById("wbNum").innerHTML = "3.";
//    document.getElementById("emNum").innerHTML="2.";
                document.getElementById("prNum").innerHTML = "1.";
//    document.getElementById("dmNum").innerHTML="1.";
            }
            if (pll == "-" && dll == "-" && ll != "-" && cll != "-" && gll != "-" && wll != "-") {
//    document.getElementById("grNum").innerHTML="2.";
                document.getElementById("crNum").innerHTML = "2.";
                document.getElementById("emNum").innerHTML = "1.";
//    document.getElementById("prNum").innerHTML="1.";
//    document.getElementById("dmNum").innerHTML="1.";
            }
            if (pll == "-" && dll == "-" && ll != "-" && cll != "-" && gll != "-" && wll == "-") {
                document.getElementById("wbNum").innerHTML = "3.";
                document.getElementById("crNum").innerHTML = "2.";
                document.getElementById("emNum").innerHTML = "1.";
//    document.getElementById("prNum").innerHTML="1.";
//    document.getElementById("dmNum").innerHTML="1.";
            }
            if (pll != "-" && dll == "-" && ll == "-" && cll == "-" && gll == "-" && wll == "-") {
                document.getElementById("prNum").innerHTML = "1.";
            }
            if (pll == "-" && dl1 != "-" && ll == "-" && cll == "-" && gll == "-" && wll == "-") {
                document.getElementById("dmNum").innerHTML = "1.";
            }
            if (pll == "-" && dl1 == "-" && ll != "-" && cll == "-" && gll == "-" && wll == "-") {
                document.getElementById("emNum").innerHTML = "1.";
            }
            if (pll == "-" && dl1 == "-" && ll == "-" && cll != "-" && gll == "-" && wll == "-") {
                document.getElementById("crNum").innerHTML = "1.";
            }
            if (pll == "-" && dl1 == "-" && ll == "-" && cll == "-" && gll != "-" && wll == "-") {
                document.getElementById("grNum").innerHTML = "1.";
            }
            if (pll == "-" && dl1 == "-" && ll == "-" && cll == "-" && gll == "-" && wll != "-") {
                document.getElementById("wbNum").innerHTML = "1.";
            }
            var dtf;
            var dtll;
            var dtff;

            $(".dttm").each(function () {
//                dtf = $(this).children("span:first-child").text();//this is first span of this line
//                 l = $(this).children("span:last-child").text();//this is last span of this line
//                $(this).attr("id", 'gr-' + gf);
                dtff = $(".dttm span").first().text();//this is last span of this line
                dtll = $(".dttm span").last().text();//this is last span of this line
            });
//            alert(dtff+" "+dtll);
            document.getElementById("dtFirst").innerHTML = dtff;
            document.getElementById("dtLast").innerHTML = dtll;

            function printDiv(a) {
                var b = document.getElementById(a).innerHTML;
                var c = document.body.innerHTML;
                document.body.innerHTML = "<html><head><title></title></head><body>" + b + "</body>";
                window.print();
                document.body.innerHTML = c
            }</script>
        <script>$(document).ready(function () {
                $(".card-about-me .body ul li .content :nth-child(odd)").addClass("bg-black");
                $(".card-about-me .body ul li .content :nth-child(even)").addClass("bg-blue")
            });
        </script>
        <script>
            function showFilterDiv() {
                var b = new XMLHttpRequest();
                //                    var d = document.getElementById("edition").value;
                var a = "pr_approver_export_filter_show.jsp";
                b.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        document.getElementById("collapseOne_1").innerHTML = this.responseText;
                    }
                };
                b.open("GET", a, true);
                b.send();
            }
        </script>
        <script>
            function printData() {
                var margin = {
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0
                };
                var doc = new jsPDF();
                var elementHTML = $('#printablediv').html();
                var specialElementHandlers = {
                    '#elementH': function (element, renderer) {
                        return true;
                    }
                };
                doc.fromHTML(elementHTML, 0, 0, {
                    'width': 100,
                    'elementHandlers': specialElementHandlers
                }, function (dispose) {
                    // dispose: object with X, Y of the last line add to the PDF
                    //          this allow the insertion of new lines after html
                    // pdf.save('Test.pdf');

                    if (navigator.msSaveBlob) {
                        var string = doc.output('datauristring');
                    } else {
                        var string = doc.output('bloburi');
                    }

                    $('.previewIFRAME').attr('src', string);
                });



// Save the PDF
//                doc.save('sample-document.pdf');
            }
        </script>
    </body>
</html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>
