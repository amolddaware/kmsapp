<%-- 
    Document   : jsonfile
    Created on : Sep 18, 2018, 4:44:31 PM
    Author     : Amol
--%>

<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONArray"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Set<String> al = new HashSet<String>();
// System.out.println("data:-"+request.getParameter("data"));
    try {
        ConnectionDB ds = new ConnectionDB();

        Connection conn = ds.getConnection();
        Statement stmt = conn.createStatement();
        String sql = "select subject from tbl_news_dataentry ";
//      String sql="select subject,districttag,talukatag,villagetag,additionaltag,teletag from tbl_news_dataentry ";
        System.out.println("sql:-" + sql);
        ResultSet rs = stmt.executeQuery(sql);
        while (rs.next()) {
            System.out.println(rs.getString("subject"));
            al.add(rs.getString("subject"));
//       al.add(rs.getString("districttag"));
//       al.add(rs.getString("talukatag"));
//       al.add(rs.getString("villagetag"));
//       al.add(rs.getString("additionaltag"));
//       al.add(rs.getString("teletag"));
        }
        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    JSONArray json = new JSONArray(al);
    response.setContentType("application/json");
    response.getWriter().print(json);

%>