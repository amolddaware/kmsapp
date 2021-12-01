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
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("4"))) {
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
                    <span>(Print Media Executive)</span>
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
                    <a href="pr_home.jsp">
                        <i class="material-icons">grid_on</i>
                        <span>Dashboard</span>
                    </a>
                </li> 
                <li>
                    <a  href="javascript:void(0);" class="menu-toggle">
                        <i class="material-icons">add_circle_outline</i>
                        
                          <%
                            Connection dh = null;
                            String printMedia = null;
                            String webMedia = null;
                            PreparedStatement stm1 = null;
                            ResultSet rs1 = null;
                            ConnectionDB conn = new ConnectionDB();
                            dh = conn.getConnection();
                            try {
                                String sql1 = "SELECT count(workcode) as workcodecount FROM tbl_news_dataentry WHERE workcode like ? and workcode not like ? and userid=?";
//                                System.out.println("sql:-" + sql1);
                                stm1 = dh.prepareStatement(sql1);
                                stm1.setString(1, "%P%");
                                stm1.setString(2, "%PW%");
                                stm1.setString(3, userid);
                                rs1 = stm1.executeQuery();
                                while (rs1.next()) {
                                     System.out.println("rs1.getString(1):-"+rs1.getString(1));
//                                    if(rs1.getString(1).contains("PW")){
                                       
//                                    webMedia=rs1.getString(1);
//                                    }else if(rs1.getString(1).contains("P")){
                                    printMedia = rs1.getString(1);
//                                    }
                                }%>
                        <span>Print Media Information (<%=printMedia%>)</span>
                        <%} catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (stm1 != null) {
                                    stm1.close();
                                }
                                if (rs1 != null) {
                                    rs1.close();
                                }
//                                if (dh != null) {
//                                    dh.close();
//                                }
                            }%>
                    </a>
                       
                    
                    <ul class="ml-menu">
                        <li>
                            <a href="pr_add.jsp">
                                <i class="material-icons">add_circle_outline</i>
                                <span>Add Information</span>
                            </a>
                        </li>
                        <li>
                            <a href="pr_view.jsp?searchresult=P">
                                <i class="material-icons">mode_edit</i>
                                <span>Edit Information</span>
                            </a>
                        </li>
                        <li>
                            <a href="pr_gallery.jsp?searchresult=P">
                                <i class="material-icons">description</i>
                                <span>Paper Cutting</span>
                            </a>
                        </li>

                    </ul>

                </li>
                <li>
                    <a  href="javascript:void(0);" class="menu-toggle">
                        <i class="material-icons">add_circle_outline</i>
                        
                        <% 
                            PreparedStatement pstmt=null;
                            ResultSet rs=null;
                                    
                            try {
                                String sql2 = "SELECT count(workcode) as workcodecount FROM tbl_news_dataentry WHERE  workcode  like ? and userid=?";
//                                System.out.println("sql:-" + sql1);
                                pstmt = dh.prepareStatement(sql2);
                                pstmt.setString(1, "%W%");
                                pstmt.setString(2, userid);
                                rs = pstmt.executeQuery();
                                while (rs.next()) {
                                     System.out.println("rs1.getString(1):-"+rs.getString(1));
//                                    if(rs1.getString(1).contains("PW")){
                                       
//                                    webMedia=rs1.getString(1);
//                                    }else if(rs1.getString(1).contains("P")){
                                    webMedia = rs.getString(1);
//                                    }
                                }%>
                        <span>Web Media Information (<%=webMedia%>)</span>
                        <%} catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (pstmt != null) {
                                    pstmt.close();
                                }
                                if (rs != null) {
                                    rs.close();
                                }
                                if (dh != null) {
                                    dh.close();
                                }
                            }%>
                           </a>
                    <ul class="ml-menu">
                        <li>
                            <a href="pr_webadd.jsp">
                                <i class="material-icons">add_circle_outline</i>
                                <span>Add Information</span>
                            </a>
                        </li>
                        <li>
                            <a href="pr_webview.jsp?searchresult=PW">
                                <i class="material-icons">mode_edit</i>
                                <span>Edit Information</span>
                            </a>
                        </li>

                    </ul>

                </li>
                <div class="watermark"></div>
            </ul>
        </div>
        <!-- #Menu -->
        <!-- Footer -->
        <div class="legal">
            <div class="copyright">
                &copy; 2018 - 2019 <a href="javascript:void(0);">Fluidscapes.in</a>
            </div>
            <div class="version">
                <b>Version: </b> 1.0.5
            </div>
        </div>
        <!-- #Footer -->
    </aside>
    <!-- #END# Left Sidebar -->
</section>
<!--End navbar-->
<%} else {
        response.sendRedirect("login.jsp");
    }%>