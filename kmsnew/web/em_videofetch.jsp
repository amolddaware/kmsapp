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
<table class="table table-bordered table-striped table-hovers">

    <%
        // ResourceBundle rb = ResourceBundle.getBundle("msg");
        if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("2") || session.getAttribute("role").equals("3") || session.getAttribute("role").equals("4") || session.getAttribute("role").equals("5") || session.getAttribute("role").equals("1"))) {
            String userid = session.getAttribute("userid").toString();
            String no = request.getParameter("getresult");
            String querySearch = request.getParameter("querySearch");

            System.out.println("querySearch:-" + querySearch);
            System.out.println("no-" + no);
            String sssss = null;
            Connection dh = null;
            try {
                ConnectionDB conn = new ConnectionDB();
                dh = conn.getConnectionDB();

                String sql = querySearch + " limit " + no + ",10";
                PreparedStatement stm = dh.prepareStatement(sql);

                System.out.println("qqqq:-" + sql);
                stm.setString(1, userid);
                ResultSet rs = stm.executeQuery();
                String imag1[], vdo[] = null, doc[] = null, audio[] = null;
                while (rs.next()) {
                    //                            if (rs.getString(3) != null) {
                    //                                strImg.append(rs.getString(3));
                    System.out.println("vdopath-" + rs.getString("vdopath"));
                    //                            }
                   
    %>

    <tr>
        <td style="text-align: center;vertical-align: bottom;">
            <%
             String fullpath[] = null;
                    if (rs.getString("vdopath").contains("::")) {
                        fullpath = rs.getString("vdopath").split("::");
                        for (int i = 0; i < fullpath.length; i++) {

                            fullpath[i] = fullpath[i].replace("\\", "/");
%>
            <video id="videoContainer"  width="200" height="100" controls >
                <source src="/kmsvdo/<%=fullpath[i].substring(25)%>" type="video/mp4" >
            </video>
<%  }
}%>
        </td>
        <td><h4> <%=rs.getString("subject")%>   </h4>
            <p class="m-t-15 m-b-30"><%=rs.getString("description")%> </p>
            <span class="badge bg-black"><%=rs.getString("sourcedate")%> </span></td>
    </tr>

    <%--<div class="row"></div>
    <div class="row mt-5" >
        <div class="col-sm-3">
            <video id="videoContainer" class="w-90" height="100" controls >
                <video id="videoContainer"  class="col-sm-3" width="240" height="180" controls >

            <source src="<%=vdo[0].substring(14)%>" type="video/mp4" >
        </video>
    </div>
    <div class="col-sm-6 offset-1" >
        <label style="margin-top:16px"> <%=rs.getString("subject")%>                        </label><br>
        <label> <%=rs.getString("description")%> 
        </label><br>
    </div>
</div>--%>
    <% }
                
            }catch (Exception e) {
                e.printStackTrace();
            }finally {
                if (dh != null) {
                    dh.close();
                }
            }
        }else {
            response.sendRedirect("login.jsp");
        }
    %>
</table>