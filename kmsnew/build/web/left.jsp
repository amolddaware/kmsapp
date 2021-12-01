<%-- 
    Document   : left
    Created on : Nov 15, 2017, 11:33:42 PM
    Author     : Amol
--%>
<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%ResourceBundle rb = ResourceBundle.getBundle("msg");
//    String role = session.getAttribute("role").toString();
    if (session != null && session.getAttribute("username") != null && session.getAttribute("role").equals("1")) {
        String username = session.getAttribute("username").toString();
        String userid = session.getAttribute("userid").toString();
%>
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
                    <% } else if (session.getAttribute("role").equals("1")) { %>
                    <span>(Admin)</span>
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
                <li class="active">
                    <a href="home.jsp">
                        <i class="material-icons">grid_on</i>
                        <span>Dashboard</span>
                    </a>
                </li> 
                <li >
                    <a href="createuser.jsp">
                        <i class="material-icons">person</i>
                        <span>Create User</span>
                    </a>
                </li> 
                <li>
                    <a  href="javascript:void(0);" class="menu-toggle">
                        <i class="material-icons">description</i>
                        <span>Report</span>
                    </a>
                    <ul class="ml-menu">
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
                    </ul>
                </li>
                <%--
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

                --%>
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
<%} else {
        response.sendRedirect("login.jsp");
    }%>