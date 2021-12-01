<%-- 
    Document   : home
    Created on : Nov 15, 2017, 11:30:13 PM
    Author     : Amol
--%>

<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<jsp:forward page="dashboard.jsp"></jsp:forward>--%>
<%ResourceBundle rb = ResourceBundle.getBundle("msg"); %>
<%
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("5") || session.getAttribute("role").equals("1") || session.getAttribute("role").equals("4") || session.getAttribute("role").equals("3"))) {

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

<% String getData = null, searchQuery = null, room = null, link = null;
%>

<%             String no = request.getParameter("getresult");
    String querySearch = request.getParameter("querySearch");

    System.out.println("querySearch:-" + querySearch);
    System.out.println("no-" + no);
    String sssss = null;
    Connection dh = null;
    ConnectionDB conn = new ConnectionDB();
    dh = conn.getConnectionDB();
    PreparedStatement stm = null;
    ResultSet rs = null;
    try {

        String sql = querySearch + " limit " + no + ",9";
        stm = dh.prepareStatement(sql);

        System.out.println("qqqq:-" + sql);
//                stm.setString(1, userid);
        stm.setString(1, "%E%");
//        stm.setString(2, "%EN%");
        rs = stm.executeQuery();

        while (rs.next()) {
//                  while()
%>
<!--<div class="row">-->

<div class="col-sm-4" >
    <div class="gal-detail thumb">
        <%
//                                                                        if (rs.getString("vdopath") != null) {
            String fullpath[] = null;
            if (rs.getString("vdopath").contains("::")) {
                fullpath = rs.getString("vdopath").split("::");
                for (int i = 0; i < fullpath.length; i++) {

        %>
        <a href="<%=fullpath[i].substring(25)%>" target="_blank">
            <video id="videoContainer"  width="200" height="100" controls >
                <source src="/kmsvdo/<%=fullpath[i].substring(25).replace('\\', '/')%>" type="video/mp4" height="300"  class="thumb-img" alt="<%=rs.getString("subject")%>" >
            </video>
            <%--<img src="<%=rs.getString("graphicspath").substring(34, rs.getString("graphicspath").length() - 2).replace(" ", "%20")%>" height="300"  class="thumb-img" alt="<%=rs.getString("subject")%>">--%>
        </a>
        <%}
        } else {%>
        <a href="<%=rs.getString("vdopath").substring(25)%>" target="_blank">
            <video id="videoContainer"  width="200" height="100" controls >
                <source src="/kmsvdo/<%=rs.getString("vdopath").substring(25).replace('\\', '/')%>" type="video/mp4" height="300"  class="thumb-img" alt="<%=rs.getString("subject")%>" >
            </video>
            <%--<img src="<%=rs.getString("graphicspath").substring(34, rs.getString("graphicspath").length() - 2).replace(" ", "%20")%>" height="300"  class="thumb-img" alt="<%=rs.getString("subject")%>">--%>
        </a>
        <%}%>

        <%
            if (rs.getString("graphicspath") != null) {
                String image[] = rs.getString("graphicspath").split("::");
                for (int i = 0; i < image.length; i++) {
        %>
        <img src="/kmsvdo/<%=image[i].substring(25).replace(" ", "%20")%>"   height="300"  class="thumb-img" alt="<%=rs.getString("subject")%>" >

        <%}
            } else {
            }%>
        <h4 class="text-center"><%=rs.getString("subject")%></h4>
        <div class="ga-border"></div>
        <p class="text-muted text-center"><small><%=rs.getString("sourcedate")%></small></p>
    </div>
    <!--</div>-->
</div>
<%}
    } catch (ArrayIndexOutOfBoundsException e) {
        e.printStackTrace();

    } catch (Exception e) {
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


<%} else {
        response.sendRedirect("login.jsp");
    }%>