<%-- 
    Document   : get_results
    Created on : 9 Oct, 2019, 6:28:03 PM
    Author     : Fluidscapes
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("4") || session.getAttribute("role").equals("5"))) {
        String username = session.getAttribute("username").toString();
        String userid = session.getAttribute("userid").toString();
        String token = session.getAttribute("csrfToken").toString();
//System.out.println(token);
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setDateHeader("Expires", 0);
        response.addHeader("X-Frame-Options", "DENY");

        int timeout = session.getMaxInactiveInterval();
//                System.out.println("timeout:-"+timeout);
        response.setHeader("refresh", timeout + ";URL=logout.jsp");

        String val = null;
        PreparedStatement stm = null, stm1 = null, stm2 = null;
        ResultSet rs = null, rs1 = null, rs2 = null;
        Connection dh = null;
        try {
            ConnectionDB conn = new ConnectionDB();
            dh = conn.getConnectionDB();
            if (request.getParameter("language") != null) {

                val = request.getParameter("language");

                try {

                    String sql = "select * from tbl_newspaper_master where id_language=? order by npname";
                    stm = dh.prepareStatement(sql);
                    stm.setString(1, val);
                    System.out.println("npnamesql:-" + sql);
                    rs = stm.executeQuery();
                    out.println("<option value='-1'>Select Newspaper</option>");
                    while (rs.next()) {
%>
<option value="<%=rs.getString(1)%>"><%=rs.getString(3)%></option>
<%
//                 out.println(rs.getString(3));
            System.out.println(rs.getString(3));
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (stm != null) {
            stm.close();
        }
        if (rs != null) {
            rs.close();
        }
    }
} else if (request.getParameter("newspaper") != null) {

    val = request.getParameter("newspaper");
//    Connection dh = null;
    try {
//        ConnectionDB conn = new ConnectionDB();
//        dh = conn.getConnectionDB();
        String sql = "select * from tbl_np_editionmaster where idnewspaper=? order by edition";
        stm1 = dh.prepareStatement(sql);

        stm1.setString(1, val);
        rs1 = stm1.executeQuery();
        out.println("<option value='-1'>Select Edition</option>");
        while (rs1.next()) {
%>
<option value="<%=rs1.getString(1)%>"><%=rs1.getString(3)%></option>
<%
//                 out.println(rs.getString(3));
//                 System.out.println(rs.getString(3));
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (stm1 != null) {
            stm1.close();
        }
        if (rs1 != null) {
            rs1.close();
        }
    }
} else if (request.getParameter("edition") != null) {

    val = request.getParameter("edition");
//    Connection dh = null;
    try {
//        ConnectionDB conn = new ConnectionDB();
//        dh = conn.getConnectionDB();
        String sql = "select * from tbl_np_subedition_master where id_edition=? order by subedition";
        stm2 = dh.prepareStatement(sql);
        stm2.setString(1, val);
        rs2 = stm2.executeQuery();
        out.println("<option value='-1'>Select Sub Edition</option>");
        while (rs2.next()) {
%>
<option value="<%=rs2.getString(1)%>"><%=rs2.getString(3)%></option>
<%
//                 out.println(rs.getString(3));
//                 System.out.println(rs.getString(3));
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (stm2 != null) {
                        stm2.close();
                    }
                    if (rs2 != null) {
                        rs2.close();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (dh != null) {
                dh.close();
            }
        }
    } else {
        response.sendRedirect("login.jsp");
    }
%>