
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%
    // ResourceBundle rb = ResourceBundle.getBundle("msg");
        if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("2") || session.getAttribute("role").equals("3") || session.getAttribute("role").equals("7") || session.getAttribute("role").equals("5") || session.getAttribute("role").equals("1"))) {
            String userid = session.getAttribute("userid").toString();
            System.out.println("userid:-"+userid);
            String dept = request.getParameter("dept");
//            String querySearch = request.getParameter("querySearch");

            System.out.println("querySearch:-" + dept);
         
            String sssss = null;
            Connection dh = null;
            try {
                ConnectionDB conn = new ConnectionDB();
                dh = conn.getConnectionDB();

                String sql ="SELECT dept_name FROM tbl_department_master where dept_name_eng=? group by dept_name_eng order by dept_name_eng";
                PreparedStatement stm = dh.prepareStatement(sql);

                System.out.println("qqqq:-" + sql);
                stm.setString(1, dept);
                ResultSet rs = stm.executeQuery();
                String imag1[], vdo[] = null, doc[] = null, audio[] = null;
                if (rs.next()) {
                    out.println(rs.getString(1));
                    //                            if (rs.getString(3) != null) {
                
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
