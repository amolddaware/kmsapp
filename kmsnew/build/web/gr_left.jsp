<%-- 
    Document   : left
    Created on : Nov 15, 2017, 11:33:42 PM
    Author     : Amol
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
//    String role = session.getAttribute("role").toString();
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("7"))) {
        String username = session.getAttribute("username").toString();
        String userid = session.getAttribute("userid").toString();
        String token = session.getAttribute("csrfToken").toString();%>
<!--<script src="js/hoverable-collapse.js"></script>-->
<section>
    <!-- Left Sidebar -->
    <aside id="leftsidebar" class="sidebar">
        <!-- User Info -->
        <div class="user-info">
            <div class="image">
                <img src="images/user.png" width="48" height="48" alt="User" />
            </div>
            <div class="info-container">
                <div class="name" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><%=username%></div>
                <div class="email">
                    <span>(GR Entry Executive)</span>
                </div>
                <div class="btn-group user-helper-dropdown">
                    <i class="material-icons" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">keyboard_arrow_down</i>
                    <ul class="dropdown-menu pull-right">
                        <li><a href="javascript:void(0);"><i class="material-icons">person</i>Profile</a></li>
                        <li><a href="logout.do"><i class="material-icons">input</i>Sign Out</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- #User Info -->
        <!-- Menu -->
        <div class="menu">
            <ul class="list">
                <li class="header">MAIN NAVIGATION</li>

                <li class="active">
                    <a href="gr_home.jsp">
                        <i class="material-icons">grid_on</i>
                        <span>Dashboard</span>
                    </a>
                </li> 
                <li>
                    <a  href="javascript:void(0);" class="menu-toggle">
                        <i class="material-icons">receipt</i>
                        <%
                            Connection dh = null;
                            String digitalMedia = null;
                            PreparedStatement stm1 = null;
                            ResultSet rs1 = null;
                            ConnectionDB conn = new ConnectionDB();
                            dh = conn.getConnection();
                            try {
                                String sql1 = "SELECT count(workcode) as workcode FROM tbl_news_dataentry WHERE workcode like ? and userid=?";
//                                System.out.println("sql:-" + sql1);
                                stm1 = dh.prepareStatement(sql1);
                                stm1.setString(1, "%G%");
                                stm1.setString(2, userid);
                                rs1 = stm1.executeQuery();
                                while (rs1.next()) {
                                    digitalMedia = rs1.getString(1);
                                }%>
                        <span>GR Information (<%=digitalMedia%>)</span>
                        <%} catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (stm1 != null) {
                                    stm1.close();
                                }
                                if (rs1 != null) {
                                    rs1.close();
                                }
                                if (dh != null) {
                                    dh.close();
                                }
                            }%>
                    </a>
                    <ul class="ml-menu">
                        <li>
                            <a href="gr_add.jsp">
                                <i class="material-icons">add_circle_outline</i>
                                <span>Add Information</span>
                            </a>
                        </li>
                        <li>
                            <a href="gr_view.jsp?searchresult=G">
                                <i class="material-icons">visibility</i>
                                <span>View Information</span>
                            </a>
                        </li>

                    </ul>

                </li>


                <div class="watermark"></div>
            </ul>
        </div>
        <!-- #Menu -->
        <!-- Footer -->
        <jsp:include page="footer.jsp"></jsp:include>
            <!-- #Footer -->
        </aside>
        <!-- #END# Left Sidebar -->
    </section>
    <!--End navbar-->
<%} else {
        response.sendRedirect("login.jsp");
    }%>