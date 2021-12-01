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
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("3") || session.getAttribute("role").equals("5") || session.getAttribute("role").equals("2") || session.getAttribute("role").equals("1") || session.getAttribute("role").equals("4") || session.getAttribute("role").equals("6") || session.getAttribute("role").equals("7"))) {
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
                <div class="email"> <% if (session.getAttribute("role").equals("5")) { %>
                    <span>(Approver)</span>
                    <% } else if (session.getAttribute("role").equals("3")) { %>
                    <span>(Media Room User)</span>
                    <% } else if (session.getAttribute("role").equals("2")) { %>
                    <span>(Creative Team User)</span>
                    <% } else if (session.getAttribute("role").equals("4")) { %>
                    <span>(Print Media User)</span>
                    <% } else if (session.getAttribute("role").equals("6")) { %>
                    <span>(Digital Media User)</span>

                    <% } else if (session.getAttribute("role").equals("7")) { %>
                    <span>(GR Upload User)</span>
                    <% } %>
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
                    <% if (session.getAttribute("role").equals("1")) { %>

                <li class="active">
                    <a href="home.jsp">
                        <i class="material-icons">grid_on</i>
                        <span>Dashboard</span>
                    </a>
                </li> 
                <li>
                    <a href="admin_allinone.jsp">
                        <i class="material-icons">dashboard</i>
                        <span>All In One </span>
                    </a>
                </li>
                <li>
                    <a href="em_approver_export.jsp?searchresult=N">
                        <i class="material-icons">live_tv</i>
                        <span>Electronic Media</span>
                    </a>
                </li>
                <li>
                    <a href="dm_approver_export.jsp?searchresult=D">
                        <i class="material-icons">phonelink</i>
                        <span>Digital Media </span>
                    </a>
                </li>
                <li>
                    <a href="gr_approver_export.jsp?searchresult=G">
                        <i class="material-icons">home_work</i>
                        <span>Government Resolution</span>
                    </a>
                </li>

                <li>
                    <a href="pr_approver_export.jsp?searchresult=P">
                        <i class="material-icons">local_printshop</i>
                        <span>Print Media</span>
                    </a>
                </li>

                <li>
                    <a href="cr_approver_export.jsp?searchresult=C">
                        <i class="material-icons">wb_incandescent</i>
                        <span>Creative Media</span>
                    </a>
                </li>
                <%} else if (session.getAttribute("role").equals("6")) {
                %>
                <li class="active">
                    <a href="user_home_digital.jsp">
                        <i class="material-icons">grid_on</i>
                        <span>Dashboard</span>
                    </a>
                </li> 
                <%} else if (session.getAttribute("role").equals("7")) {
                %>
                <li class="active">
                    <a href="user_home_gr.jsp">
                        <i class="material-icons">grid_on</i>
                        <span>Dashboard</span>
                    </a>
                </li> 

                <%} else {
                %>
                <li class="active">
                    <a href="user_homepage.jsp">
                        <i class="material-icons">grid_on</i>
                        <span>Dashboard</span>
                    </a>
                </li> 
                <%}
                    if (session.getAttribute("role").equals("2")) { %>
                <li>
                    <a  href="javascript:void(0);" class="menu-toggle">
                        <i class="material-icons">visibility</i>
                        <span>Creative Information</span>
                    </a>
                    <ul class="ml-menu">
                        <li>
                            <a href="cr_add.jsp">
                                <i class="material-icons">add_circle_outline</i>
                                <span>Add Information</span>
                            </a>
                        </li>
                        <li>
                            <a href="cr_view.jsp?searchresult=C">
                                <i class="material-icons">mode_edit</i>
                                <span>Edit Information</span>
                            </a>
                        </li>

                    </ul>

                </li>

                <%}
                    if (session.getAttribute("role").equals("4")) { %>
                <li>
                    <a  href="javascript:void(0);" class="menu-toggle">
                        <i class="material-icons">add_circle_outline</i>
                        <span>Print Media Information</span>
                    </a>
                    <ul class="ml-menu">
                        <li>
                            <a href="printmedia_dataentry.jsp">
                                <i class="material-icons">add_circle_outline</i>
                                <span>Add Information</span>
                            </a>
                        </li>
                        <li>
                            <a href="dataentry_edit_printmedia_list.jsp?searchresult=P">
                                <i class="material-icons">mode_edit</i>
                                <span>Edit Information</span>
                            </a>
                        </li>

                    </ul>

                </li>
                <li>
                    <a  href="javascript:void(0);" class="menu-toggle">
                        <i class="material-icons">add_circle_outline</i>
                        <span>Web Media Information</span>
                    </a>
                    <ul class="ml-menu">
                        <li>
                            <a href="webmedia_dataentry.jsp">
                                <i class="material-icons">add_circle_outline</i>
                                <span>Add Information</span>
                            </a>
                        </li>
                        <li>
                            <a href="dataentry_edit_printmedia.jsp?searchresult=P">
                                <i class="material-icons">mode_edit</i>
                                <span>Edit Information</span>
                            </a>
                        </li>

                    </ul>

                </li>
                <!--                <li>
                                    <a href="dataentry_edit_printmedia.jsp?searchresult=P">
                                        <i class="material-icons">mode_edit</i>
                                        <span>Edit Information</span>
                                    </a>
                                </li>-->
                <%} else if (session.getAttribute("role").equals("3")) { %>
                <li>
                    <a href="javascript:void(0);" class="menu-toggle">
                        <i class="material-icons">movie</i>
                        <span>Video Information</span>
                    </a>
                    <ul class="ml-menu">
                        <li>
                            <a href="em_videoadd.jsp">
                                <i class="material-icons">add_circle_outline</i>
                                <span>Add Information</span>
                            </a>
                        </li>
                        <li>
                            <a href="em_videoview.jsp?searchresult=N">
                                <i class="material-icons">create</i>
                                <span>Edit Information</span>
                            </a>
                        </li>

                    </ul>
                </li>
                <li>
                    <a href="javascript:void(0);" class="menu-toggle">
                        <i class="material-icons">speaker_notes</i>
                        <span>News Information</span>
                    </a>
                    <ul class="ml-menu">
                        <li>
                            <a href="em_newsadd.jsp">
                                <i class="material-icons">add_circle_outline</i>
                                <span>Add Information</span>
                            </a>
                        </li>
                        <li>
                            <a href="em_newsview.jsp?searchresult=MN">
                                <i class="material-icons">create</i>
                                <span>Edit Information</span>
                            </a>
                        </li>

                    </ul>
                </li>

                <%} else if (session.getAttribute("role").equals("6")) { %>
                <li>
                    <a href="javascript:void(0);" class="menu-toggle">
                        <i class="material-icons">movie</i>
                        <span>Twitter Post Information</span>
                    </a>
                    <ul class="ml-menu">
                        <li>
                            <a href="dm_add.jsp">
                                <i class="material-icons">add_circle_outline</i>
                                <span>Add Information</span>
                            </a>
                        </li>
                        <li>
                            <a href="dm_view.jsp?searchresult=D">
                                <i class="material-icons">create</i>
                                <span>Edit Information</span>
                            </a>
                        </li>

                    </ul>
                </li>

                <%} else if (session.getAttribute("role").equals("7")) { %>
                <li>
                    <a href="javascript:void(0);" class="menu-toggle">
                        <i class="material-icons">file_copy</i>
                        <span>GR Information</span>
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
                                <i class="material-icons">create</i>
                                <span>Edit Information</span>
                            </a>
                        </li>

                    </ul>
                </li>


                <%} else if (session.getAttribute("role").equals("5")) { %>
                <li>
                    <a href="admin_allinone.jsp">
                        <i class="material-icons">dashboard</i>
                        <span>All In One </span>
                    </a>
                </li>
                <li>
                    <a href="javascript:void(0);" class="menu-toggle">
                        <i class="material-icons">perm_media</i>
                        <span>Electronic Media </span>
                    </a>
                    <ul class="ml-menu">
                        <li>
                            <a href="em_videonewsview.jsp?searchresult=N">
                                <i class="material-icons">mode_edit</i>
                                <span>Edit Information</span>
                            </a>
                        </li>
                        <li>
                            <a href="em_approver_export.jsp?searchresult=N">
                                <i class="material-icons">save</i>
                                <span>Export Data</span>
                            </a>
                        </li>
                        <li>
                            <a href="dataentry_approver_reviewapprove.jsp?searchresult=N">
                                <i class="material-icons">local_offer</i>
                                <span>Review / Approve Tag</span>
                            </a>
                        </li>
                    </ul>

                </li>
                <li>
                    <a href="javascript:void(0);" class="menu-toggle">
                        <i class="material-icons">assignment</i>
                        <i class="material-icons">language</i>
                        <span>Print and Web Media</span>
                    </a>
                    <ul class="ml-menu">
                        <li>
                            <a href="pr_view.jsp?searchresult=P" >
                                <i class="material-icons">assignment</i>
                                <span>Print Media Dataentry List</span>
                            </a>

                        </li>
                        <li>
                            <a href="pr_webview.jsp?searchresult=PW">
                                <i class="material-icons">language</i>
                                <span>Web Media Dataentry List</span>
                            </a>
                        </li>
                        <li>
                            <a href="pr_approver_export.jsp?searchresult=P">
                                <i class="material-icons">save</i>
                                <span>Export Data</span>
                            </a>
                        </li>

                        <li>
                            <a href="pr_approver_reviewapprove.jsp?searchresult=P">
                                <i class="material-icons">local_offer</i>
                                <span>Review / Approve Tag</span>
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
                    <a href="javascript:void(0);" class="menu-toggle">
                        <i class="material-icons">movie</i>
                        <span>Digital Media</span>
                    </a>
                    <ul class="ml-menu">
                        <!--                        <li>
                                                    <a href="dm_add.jsp">
                                                        <i class="material-icons">add_circle_outline</i>
                                                        <span>Add Information</span>
                                                    </a>
                                                </li>-->
                        <li>
                            <a href="dm_view.jsp?searchresult=D">
                                <i class="material-icons">assignment</i>
                                <span>Twitter Post Information</span>
                            </a>
                        </li>
                        <li>
                            <a href="dm_approver_export.jsp?searchresult=D">
                                <i class="material-icons">save</i>
                                <span>Export Data</span>
                            </a>
                        </li>

                    </ul>
                </li>
                <li>
                    <a href="javascript:void(0);" class="menu-toggle">
                        <i class="material-icons">receipt</i>
                        <span>GR</span>
                    </a>
                    <ul class="ml-menu">
                        <!--                        <li>
                                                    <a href="dm_add.jsp">
                                                        <i class="material-icons">add_circle_outline</i>
                                                        <span>Add Information</span>
                                                    </a>
                                                </li>-->
                        <li>
                            <a href="gr_view.jsp?searchresult=G">
                                <i class="material-icons">assignment</i>
                                <span>GR Information</span>
                            </a>
                        </li>
                        <li>
                            <a href="gr_approver_export.jsp?searchresult=G">
                                <i class="material-icons">save</i>
                                <span>Export Data</span>
                            </a>
                        </li>

                    </ul>
                </li>
                <li>
                    <a  href="javascript:void(0);" class="menu-toggle">
                        <i class="material-icons">visibility</i>
                        <span>Creative Information</span>
                    </a>
                    <ul class="ml-menu">
                        <li>
                            <a href="cr_view.jsp?searchresult=C">
                                <i class="material-icons">mode_edit</i>
                                <span>View Information</span>
                            </a>
                        </li>
                        <li>
                            <a href="cr_approver_export.jsp?searchresult=C">
                                <i class="material-icons">save</i>
                                <span>Export Data</span>
                            </a>
                        </li>

                    </ul>

                </li>

                <%}%>
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