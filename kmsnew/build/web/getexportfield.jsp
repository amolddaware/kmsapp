<%-- 
    Document   : gettags
    Created on : Dec 8, 217, 12:28:2 PM
    Author     : Amol
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.LinkedHashSet"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% if (session != null && session.getAttribute("username") != null && session.getAttribute("role").equals("5")) {
        String username = session.getAttribute("username").toString();
        String userid = session.getAttribute("userid").toString();
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1..
        response.setDateHeader("Expires", 0);
        response.addHeader("X-Frame-Options", "DENY");
        String selectUserid = "";
        Connection dh = null;
        String logintime = "";
        ConnectionDB conn = new ConnectionDB();
        dh = conn.getConnection();
        PreparedStatement pstmtTag = null;
        ResultSet rsTag = null;
//        String table = "tbl_graphics_dataentry";
        String criticality = null, sentiment = null, importance = null, ffulldate = null, tfulldate = null;
        StringBuffer str = new StringBuffer();
//        int number=;
        if (request.getParameter("criticality") != null) {
            criticality = request.getParameter("criticality");
        } else {
            criticality = null;
        }
        if (request.getParameter("sentiment") != null) {
            sentiment = request.getParameter("sentiment");
        } else {
            sentiment = null;
        }
        if (request.getParameter("importance") != null) {
            importance = request.getParameter("importance");
        } else {
            importance = null;
        }
        System.out.println("criticality:-" + criticality);
        System.out.println("sentiment-" + sentiment);
        System.out.println("importance-" + importance);
//else{
//        criticality=null;
//        }
        if (!criticality.isEmpty() && !sentiment.isEmpty() && !importance.isEmpty()) {
            str.append(" and criticality='" + criticality + "'" + " and sentiment='" + sentiment + "'" + " and importance='" + importance + "'");
        } else if (!criticality.isEmpty() && sentiment.isEmpty() && importance.isEmpty()) {
            str.append(" and criticality='" + criticality + "'");
        } else if (criticality.isEmpty() && !sentiment.isEmpty() && !importance.isEmpty()) {
            str.append(" and sentiment='" + sentiment + "'" + " and importance='" + importance + "'");
        } else if (!criticality.isEmpty() && !sentiment.isEmpty() && importance.isEmpty()) {
            str.append(" and criticality='" + criticality + "' " + " and sentiment='" + sentiment + "'");
        } else if (criticality.isEmpty() && !sentiment.isEmpty() && importance.isEmpty()) {
            str.append(" and sentiment='" + sentiment + "'");
        } else if (!criticality.isEmpty() && sentiment.isEmpty() && !importance.isEmpty()) {
            str.append(" and criticality='" + criticality + "'" + " and importance='" + importance + "'");
        } else if (criticality.isEmpty() && sentiment.isEmpty() && !importance.isEmpty()) {
            str.append(" and importance='" + importance + "'");
        } else {
            str.append("");
        }
        System.out.println("str:-" + str);
        try {
            String fromDate = null, toDate = null;
            String dateQuery = null;
            //    fromDate = "3/9/219";
            //    toDate = "2/1/219";
            if (request.getParameter("ffulldate") != "" && request.getParameter("tfulldate") != "") {
                fromDate = request.getParameter("ffulldate");
                toDate = request.getParameter("tfulldate");

                //           dateQuery="and (sourcedate BETWEEN '"+fromDate+"' AND '"+toDate+"')";
            } else {
                dateQuery = "";
            }

//            String fdate[] = fromDate.split("/");
//            String fdd = fdate[0];
//            String fmm = fdate[1];
//            String fyy = fdate[2];
//            //                String ffulldate = fromDate +" ::";
//            ffulldate = fyy + "-" + fmm + "-" + fdd;
//            //                String ffulldate = fyy + "-" + fmm + "-" + fdd +" ::";
//            String tdate[] = toDate.split("/");
//            String tdd = tdate[0];
//            String tmm = tdate[1];
//            String tyy = tdate[2];
//            //                String tfulldate = toDate+" ::";;/
//            tfulldate = tyy + "-" + tmm + "-" + tdd;
//            //                String tfulldate = tyy + "-" + tmm + "-" + tdd+" 23:59:59";
//
//            System.out.println("tfulldate:-" + tfulldate);
//            System.out.println("ffulldate:-" + ffulldate);
            String sql = "SELECT * FROM tbl_news_dataentry WHERE  str_to_date(sourcedate,'%d/%m/%Y') >=? and str_to_date(sourcedate,'%d/%m/%Y') <=?  and workcode like '%N%' " + str + " order by sourcedate";
            System.out.println("sqldate:-" + sql);
            PreparedStatement stm = dh.prepareStatement(sql);
            stm.setString(1, fromDate);
            stm.setString(2, toDate);
            //            stm.setString(3, "N");
            int count = 0;
            ResultSet rs = stm.executeQuery();

%>
<style>
    table th {
        background-color: rgb(0, 160, 227)
    }
</style>
<!--<table id="" class="table table-striped table-bordered " style="width:100%">-->
<table id="exportData" class="table table-bordered table-striped table-hover dataTable js-exportable" style="width:100%">

    <thead>
    <th colspan="11" class="text-center" >
        <img src="images/channel/kmslogo.jpg" style="width: 100%">
    </th>
    <tr>
        <th style="width: 3% !important">Sr.No</th>
        <th style="width: 5% !important">Date</th>
        <th style="width: 10% !important">Channel Name</th>
        <th style="width: 20% !important">News Heading</th>
        <!--<th>NEWS LINK</th>-->
        <th style="width: 20% !important">News Description</th>
        <th style="width: 5% !important">News/Video</th>
        <th style="width: 5% !important">Timestamp</th>
        <th style="width: 5% !important">Criticality</th>
        <th style="width: 5% !important">Sentiment</th>
        <th style="width: 5% !important">Importance </th>

        <!--<th>Delete</th>-->
    </tr>
</thead>
<tbody>
    <%        int number = 0;
        while (rs.next()) {
            number++;
//String chname=rs.getString("chname").
%>
    <tr>
        <td style="width:3%"><%=number%></td>
        <td style="width:5%"><%=rs.getString("sourcedate")%></td>
        <td style="width:10%">
            
            <%if (rs.getString("vdopath") != null) {%>
            <img src="images/vchannel/<%=rs.getString("chname")%>.jpeg" width="100" height="80">
            <%} else {%>
            <img src="images/channel/<%=rs.getString("chname")%>.jpeg" width="100" height="80">

            <%}%>
        </td>
        <td style="width: 20%"><%=rs.getString("subject")%></td>
        
        <td style="width: 20%">
            <%if (rs.getString("description") != null) {%>
            <%=rs.getString("description")%><%} else {%>
            -<%}%></td>
        <td style="width:5%">
            <%if (rs.getString("vdopath") != null) {
                    out.println("Video");
            %>

            <%} else {
                out.println("News");%>
            <%}%></td>
        <td style="width:5%">
            <%if (rs.getString("vdopath") != null) {
                    String full = rs.getString("startdatetime").substring(8);
                    String hh = full.substring(0, 2);
                    String mm = full.substring(2, 4);
                    System.out.println("hh:-" + hh);
                    System.out.println("mm:-" + mm);
                    SimpleDateFormat parseFormat = new SimpleDateFormat("HH:mm");
                    SimpleDateFormat displayFormat = new SimpleDateFormat("hh:mm a");
//                    SimpleDateFormat parseFormat = new SimpleDateFormat("hh:mm a");
                    Date date = parseFormat.parse(hh + ":" + mm);
                    System.out.println(parseFormat.format(date) + " = " + displayFormat.format(date));

            %>
            <%=displayFormat.format(date)%><%} else {%>
            <%=rs.getString("timestamp")%><%}%>

        </td>
        <td style="width:5%">
            <%if (rs.getString("criticality") != null) {%>
            <%=rs.getString("criticality")%><%} else {%>
            -<%}%></td>
        <td style="width:5%">
            <%if (rs.getString("sentiment") != null) {%>
            <%=rs.getString("sentiment")%><%} else {%>
            -<%}%></td>
        <td style="width:5%">
            <%if (rs.getString("importance") != null) {%>
            <%=rs.getString("importance")%><%} else {%>
            -<%}%></td>
    </tr>
    <%}
//        if (number == ) {
    %>
    <!--<tr><td>-->
    <%
//                out.println("No record found");%>
    <!--</td></tr>-->
    <% // }%>
</tbody>

</table>
<%
//                subject = rsTag.getString("subject");
//                    fullString = subject ;
//                    fulltext = rsTag.getString("subject") + " " + rsTag.getString("description") + " " + rsTag.getString("summary");
//                    fulldata = fullString + " " + fulltext;
        } catch (Exception e) {
            System.out.println("Excecption in select data try catch block:-" + e.getMessage());
        } finally {
            // pstmtDist.close();
            // rsDist.close();

        }
    } else {
        response.sendRedirect("login.jsp");
    }
%>