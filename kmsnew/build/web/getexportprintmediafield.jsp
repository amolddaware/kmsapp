<%-- 
    Document   : gettags
    Created on : Dec 8, 217, 12:28:2 PM
    Author     : Amol
--%>

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
        if (!sentiment.isEmpty() && !importance.isEmpty()) {
            str.append(" and sentiment='" + sentiment + "'" + " and importance='" + importance + "'");
        } else if (!sentiment.isEmpty() && importance.isEmpty()) {
            str.append(" and sentiment='" + sentiment + "'");
        } else if (sentiment.isEmpty() && !importance.isEmpty()) {
            str.append("  and importance='" + importance + "'");
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

            String sql = "SELECT * FROM total_printmedia_dataentry_view WHERE  sourcedate >=? and sourcedate <=?  and workcode like '%P%' " + str + " order by sourcedate";
            System.out.println("sqldate:-" + sql);
            PreparedStatement stm = dh.prepareStatement(sql);
            stm.setString(1, fromDate);
            stm.setString(2, toDate);
            //            stm.setString(3, "N");
            int count = 0;
            ResultSet rs = stm.executeQuery();

%>

<!--<table id="" class="table table-striped table-bordered " style="width:100%">-->
<table id="exportData" class="table table-bordered table-striped table-hover dataTable js-exportable" style="width:100%">

    <thead>
    <th colspan="10" class="text-center">
       <img src="images/channel/kmslogo.jpg" style="width: 100%">
 
    </th>
    <tr>
        <th>Sr.No</th>
        <th>Date</th>
        <th>Title</th>
        <th>Title (Marathi)</th>
        <th>News Paper</th>
        <th>Edition</th>
        <th>Sub Edition</th>
        <th>Sentiment</th>
        <th>Importnance</th>
    </tr>
</thead>
<tbody>
    <%        int number = 0;
        while (rs.next()) {
            number++;

    %>
    <tr>
        <td><%=number%></td>
        <td><%=rs.getString("sourcedate")%></td>
        <td><%=rs.getString("subject")%></td>
        <td><%=rs.getString("titlemarathi")%></td>
        <td><%=rs.getString("npname")%></td>
        <td >
            <%if (rs.getString("edition") != null) {%>
            <%=rs.getString("edition")%><%} else {%>
            -<%}%>

        </td>
        <td>
            <%if (rs.getString("subedition") != null) {%>
            <%=rs.getString("subedition")%><%} else {%>
            -<%}%></td>
        <td><%=rs.getString("sentiment")%></td>
        <td>
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