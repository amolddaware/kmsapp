<%-- 
    Document   : login
    Created on : Nov 15, 2017, 10:26:41 PM
    Author     : Amol
--%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page autoFlush="true" buffer="2094kb"%>
<%--<%@ taglib uri="http://htmlcompressor.googlecode.com/taglib/compressor" prefix="compress" %>--%>
<%--<%@/taglib uri="http://htmlcompressor.googlecode.com/taglib/compressor" prefix="compress" %>--%>


<%
    ResourceBundle rb = ResourceBundle.getBundle("msg");
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("1") || session.getAttribute("role").equals("5"))) {

// if (session != null && session.getAttribute("username") != null && session.getAttribute("role").equals("3")) {
        String username = session.getAttribute("username").toString();
        String userid = session.getAttribute("userid").toString();
        response.addHeader("X-Frame-Options", "DENY");
//    if (session != null && session.getAttribute("username") != null) {
//        response.sendRedirect("workcontrol");
//    }
        String fail = "";
//    if (request.getParameter("fail") != null) {
//        fail = "Please enter correct Captcha";
//    }
        String jsessionid = "";
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("JSESSIONID")) {
//                System.out.println("JSESSIONIDLoginpage=" + cookie.getValue());
                    jsessionid = request.getSession().toString();
                    break;
                }
            }
        }

//    String fail="";
        if (request.getParameter("fail") != null) {
            fail = "Incorrect Username or Password !!";
        }
//    
        request.setAttribute("jession", jsessionid);
%>
<!DOCTYPE html>
<html lang=en>
    <head>
        <meta charset=utf-8>
        <meta name=viewport content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title><%=rb.getString("title")%></title>
        <link rel="icon" href="images/favicon.ico" type="image/x-icon">
        <link href=css/font/materialicon.css rel=stylesheet type=text/css>
        <link href=css/font/googlefont.css rel=stylesheet type=text/css>
        <link href=plugins/bootstrap/css/bootstrap.css rel=stylesheet>
        <!--<link href=plugins/node-waves/waves.css rel=stylesheet />-->
        <link href=plugins/animate-css/animate.css rel=stylesheet />
        <link href=plugins/bootstrap-material-datetimepicker/css/bootstrap-material-datetimepicker.css rel=stylesheet />
        <link href=plugins/jquery-datatable/skin/bootstrap/css/dataTables.bootstrap.css rel=stylesheet>
        <link href=css/style.css rel=stylesheet>
        <link href=css/themes/all-themes.css rel="stylesheet"/>
        <link href=css/print.css rel="stylesheet"/>
        <link href=css/jquery-ui.css rel=stylesheet>
    </head>
    <body class=theme-blue>
        <compress:html>
           <% if (session.getAttribute("role").equals("1")) {%>
        <jsp:include page="header.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <%} else if (session.getAttribute("role").equals("5")) {%>
        <jsp:include page="userHeader1.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <% }%>  <%
                String table = "";
                request.setCharacterEncoding("UTF-8");
                Connection dh = null;
                String imag[];
                ConnectionDB conn = new ConnectionDB();
                dh = conn.getConnection();
                PreparedStatement stm = null;
                ResultSet rs = null;
                //            String s = "Narendra modi";
                //            String s = request.getParameter("generaltagprint");
                try {
                    //            String s = null;

                    //            String generaltag = request.getParameter("generaltagprint");
                    //        s.getBytes("UTF-8");
                    //            s = new String(generaltag.getBytes("ISO-8859-1"), "UTF-8");
                    //                StringBuilder str = new StringBuilder();
                    //
                    String fromDate = null, toDate = null;
                    String dateQuery = null;

                    String serchQuery = null;
                    try {
            %>
            <section class=content>
                <div class=panel-group id=accordion_1 role=tablist aria-multiselectable=true>
                    <div class="panel panel-primary">
                        <div class=panel-heading role=tab id=headingOne_1>
                            <h4 class=panel-title> <a role=button data-toggle=collapse data-parent=#accordion_1 href=#collapseOne_1 aria-expanded=true aria-controls=collapseOne_1 onclick=""> 

                                    <span class="glyphicon glyphicon-menu-right rotate"></span> Creative Team  Filters </a> 
                            </h4>
                        </div>
                        <div id=collapseOne_1 class="panel-collapse collapse" role=tabpanel aria-labelledby=headingOne_1>
                            <jsp:include page="cr_approver_export_filter_show.jsp"></jsp:include>
                            </div>
                        </div>
                    </div>
                    <div class=col-md-12>
                        <div class="row clearfix">
                            <div id=printablediv>
                                <div class=col-md-12>
                                    <input class="btn bg-black pull-right" type=button value=Print onclick="javascript:printDiv('printablediv')" /><br><br>
                                    <div class="card profile-card"><br>
                                        <div class=header>
                                            <div class="content-area clearfix">
                                                <div class=col-md-12>
                                                    <div class="pull-left text-left">
                                                        <!--<h3>User Keyword Search Report (Print Media User)</h3>-->
                                                    </div>
                                                    <div class=pull-right> <img class="img-responsive text-right" src=images/logo_circle.png> </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id=border>
                                            <div id=blue></div>
                                            <div id=black></div>
                                        </div>
                                        <div class="profile-body profile-footer clearfix">
                                            <div class=row>
                                                <div class=col-md-12><br>
                                                    <div class="panel panel-default panel-post">
                                                    <%                                                    StringBuffer query = new StringBuffer();
                                                        //                                                    System.out.println("request.getParameter(brand):-" + brand);
                                                        //                                                    System.out.println("request.getParameter(location):-" + location);
                                                        //                                                    System.out.println("request.getParameter(title):-" + title);
                                                        //                                                    System.out.println("request.getParameter(nameofprogram):-" + nameofprogram);
                                                        //                                                    System.out.println("request.getParameter(language):-" + request.getParameter("language1"));
                                                        //                                                    System.out.println("request.getParameter(npanme):-" + newspaper1);
                                                        //                                                    System.out.println("request.getParameter(edition):-" + edition1);
                                                        //                                                    System.out.println("request.getParameter(subedition):-" + subedition1);
                                                        //                                                    //-----brand starts here------//

                                                        String sector = request.getParameter("sector");
                                                        String title = request.getParameter("title");
                                                        String nameofprogram = request.getParameter("nameofprogram");
                                                        String placeofprogram= request.getParameter("placeofprogram");
                                                        String tag = request.getParameter("tag");
                                                        String fromdate = request.getParameter("fromdate");
                                                        String todate = request.getParameter("todate");
                                                        //String location=null;
                                                     StringBuffer querySearch = new StringBuffer();
                                                    if (!sector.isEmpty()) {
                                                        querySearch.append(sector + "::");
                                                    }
                                                    if (!title.isEmpty()) {
                                                        querySearch.append(title + "::");
                                                    }
                                                    if (!nameofprogram.isEmpty()) {
                                                        querySearch.append(nameofprogram + "::");
                                                    }
                                                    if (!placeofprogram.isEmpty()) {
                                                        querySearch.append(placeofprogram + "::");
                                                    }
                                                    if (!tag.isEmpty()) {
                                                        querySearch.append(tag+ "::");
                                                    }
                                                    if (!fromdate.isEmpty() && !todate.isEmpty()) {
                                                        querySearch.append(fromdate + " to " + todate);
                                                    }
                                                        
                                                        
                                                        if ((sector.isEmpty()) &&(tag.isEmpty()) && (title.isEmpty()) && (nameofprogram.isEmpty()) && (placeofprogram.isEmpty()) && (!fromdate.isEmpty()) && (!todate.isEmpty())) {
                                                            query.append(" where  (sourcedate BETWEEN '" + fromdate + "' AND '" + todate + "') ");
                                                        }
                                                        if ((!sector.isEmpty()) &&(tag.isEmpty()) && (title.isEmpty()) && (nameofprogram.isEmpty()) && (placeofprogram.isEmpty()) && (!fromdate.isEmpty()) && (!todate.isEmpty())) {
                                                            query.append(" where sector='"+sector+"' and  (sourcedate BETWEEN '" + fromdate + "' AND '" + todate + "') ");
                                                        }
                                                        if ((!sector.isEmpty()) &&(tag.isEmpty()) && (!title.isEmpty()) && (nameofprogram.isEmpty()) && (placeofprogram.isEmpty()) && (!fromdate.isEmpty()) && (!todate.isEmpty())) {
                                                            query.append(" where subject like '%" + title + "%' and sector='"+sector+"' and  (sourcedate BETWEEN '" + fromdate + "' AND '" + todate + "') ");
                                                        }
                                                        if ((!sector.isEmpty()) &&(tag.isEmpty()) && (!title.isEmpty()) && (!nameofprogram.isEmpty()) && (placeofprogram.isEmpty()) && (!fromdate.isEmpty()) && (!todate.isEmpty())) {
                                                            query.append(" where subject like '%" + title + "%' and name_of_program like '%" + nameofprogram + "%' and sector='"+sector+"' and  (sourcedate BETWEEN '" + fromdate + "' AND '" + todate + "') ");
                                                        }
                                                        if ((!sector.isEmpty()) &&(tag.isEmpty()) && (!title.isEmpty()) && (!nameofprogram.isEmpty()) && (!placeofprogram.isEmpty()) && (!fromdate.isEmpty()) && (!todate.isEmpty())) {
                                                            query.append(" where subject like '%" + title + "%' and place_of_program like '%" + placeofprogram + "%'and name_of_program like '%" + nameofprogram + "%' and sector='"+sector+"' and  (sourcedate BETWEEN '" + fromdate + "' AND '" + todate + "') ");
                                                        }
                                                        if ((!sector.isEmpty()) &&(tag.isEmpty()) && (title.isEmpty()) && (!nameofprogram.isEmpty()) && (!placeofprogram.isEmpty()) && (!fromdate.isEmpty()) && (!todate.isEmpty())) {
                                                            query.append(" where  place_of_program like '%" + placeofprogram + "%'and name_of_program like '%" + nameofprogram + "%' and sector='"+sector+"' and  (sourcedate BETWEEN '" + fromdate + "' AND '" + todate + "') ");
                                                        }
                                                        if ((!sector.isEmpty()) &&(tag.isEmpty()) && (title.isEmpty()) && (nameofprogram.isEmpty()) && (!placeofprogram.isEmpty()) && (!fromdate.isEmpty()) && (!todate.isEmpty())) {
                                                            query.append(" where  place_of_program like '%" + placeofprogram + "%' and sector='"+sector+"' and  (sourcedate BETWEEN '" + fromdate + "' AND '" + todate + "') ");
                                                        }
                                                        if ((sector.isEmpty()) &&(tag.isEmpty()) && (title.isEmpty()) && (nameofprogram.isEmpty()) && (!placeofprogram.isEmpty()) && (fromdate.isEmpty()) && (todate.isEmpty())) {
                                                            query.append(" where  place_of_program like '%" + placeofprogram + "%' ");
                                                        }
                                                        if ((sector.isEmpty()) &&(tag.isEmpty()) && (title.isEmpty()) && (nameofprogram.isEmpty()) && (!placeofprogram.isEmpty()) && (!fromdate.isEmpty()) && (!todate.isEmpty())) {
                                                            query.append(" where  place_of_program like '%" + placeofprogram + "%' and (sourcedate BETWEEN '" + fromdate + "' AND '" + todate + "') ");
                                                        }
                                                        if ((!sector.isEmpty()) &&(tag.isEmpty()) && (title.isEmpty()) && (nameofprogram.isEmpty()) && (placeofprogram.isEmpty()) && (fromdate.isEmpty()) && (todate.isEmpty())) {
                                                            query.append(" where sector='"+sector+"'  ");
                                                        }
                                                         if ((!sector.isEmpty()) &&(tag.isEmpty()) && (!title.isEmpty()) && (nameofprogram.isEmpty()) && (placeofprogram.isEmpty()) && (fromdate.isEmpty()) && (todate.isEmpty())) {
                                                            query.append(" where subject like '%" + title + "%' and sector='"+sector+"'");
                                                        }
                                                         if ((!sector.isEmpty()) &&(tag.isEmpty()) && (!title.isEmpty()) && (!nameofprogram.isEmpty()) && (placeofprogram.isEmpty()) && (fromdate.isEmpty()) && (todate.isEmpty())) {
                                                            query.append(" where subject like '%" + title + "%' and name_of_program like '%" + nameofprogram + "%' and sector='"+sector+"'");
                                                        }
                                                         if ((sector.isEmpty()) &&(tag.isEmpty()) && (title.isEmpty()) && (!nameofprogram.isEmpty()) && (placeofprogram.isEmpty()) && (!fromdate.isEmpty()) && (!todate.isEmpty())) {
                                                            query.append(" where name_of_program like '%" + nameofprogram + "%' and  (sourcedate BETWEEN '" + fromdate + "' AND '" + todate + "') ");
                                                        }
                                                         if ((sector.isEmpty()) &&(tag.isEmpty()) && (title.isEmpty()) && (!nameofprogram.isEmpty()) && (placeofprogram.isEmpty()) && (fromdate.isEmpty()) && (todate.isEmpty())) {
                                                            query.append(" where name_of_program like '%" + nameofprogram + "%' ");
                                                        }
                                                         if ((!sector.isEmpty()) &&(tag.isEmpty()) && (!title.isEmpty()) && (!nameofprogram.isEmpty()) && (!placeofprogram.isEmpty()) && (fromdate.isEmpty()) && (todate.isEmpty())) {
                                                            query.append(" where subject like '%" + title + "%' and name_of_program like '%" + nameofprogram + "%' ");
                                                        }
                                                         if ((sector.isEmpty()) &&(tag.isEmpty()) && (title.isEmpty()) && (!nameofprogram.isEmpty()) && (!placeofprogram.isEmpty()) && (fromdate.isEmpty()) && (todate.isEmpty())) {
                                                            query.append(" where  name_of_program like '%" + nameofprogram + "%' and sector='"+sector+"' and place_of_program like '%" + placeofprogram + "%' ");
                                                        }
                                                         if ((sector.isEmpty()) &&(tag.isEmpty()) && (!title.isEmpty()) && (!nameofprogram.isEmpty()) && (!placeofprogram.isEmpty()) && (fromdate.isEmpty()) && (todate.isEmpty())) {
                                                            query.append(" where subject like '%" + title + "%' and name_of_program like '%" + nameofprogram + "%'  and place_of_program like '%" + placeofprogram + "%' ");
                                                        }
                                                         if ((sector.isEmpty()) &&(tag.isEmpty()) && (!title.isEmpty()) && (!nameofprogram.isEmpty()) && (placeofprogram.isEmpty()) && (fromdate.isEmpty()) && (todate.isEmpty())) {
                                                            query.append(" where subject like '%" + title + "%' and name_of_program like '%" + nameofprogram + "%' ");
                                                        }
                                                         if ((sector.isEmpty()) &&(tag.isEmpty()) && (!title.isEmpty()) && (nameofprogram.isEmpty()) && (placeofprogram.isEmpty()) && (fromdate.isEmpty()) && (todate.isEmpty())) {
                                                            query.append(" where subject like '%" + title + "%' ");
                                                        }
                                                         if ((sector.isEmpty())&&(tag.isEmpty()) && (!title.isEmpty()) && (nameofprogram.isEmpty()) && (placeofprogram.isEmpty()) && (!fromdate.isEmpty()) && (!todate.isEmpty())) {
                                                            query.append(" where subject like '%" + title + "%' and  (sourcedate BETWEEN '" + fromdate + "' AND '" + todate + "')  ");
                                                        }
                                                         if ((sector.isEmpty()) &&(!tag.isEmpty()) && (title.isEmpty()) && (nameofprogram.isEmpty()) && (placeofprogram.isEmpty()) && (!fromdate.isEmpty()) && (!todate.isEmpty())) {
                                                            query.append(" where additionaltag like '%" + tag + "%'  and  (sourcedate BETWEEN '" + fromdate + "' AND '" + todate + "')  ");
                                                        }
                                                         if ((sector.isEmpty()) &&(!tag.isEmpty()) && (title.isEmpty()) && (nameofprogram.isEmpty()) && (placeofprogram.isEmpty()) && (fromdate.isEmpty()) && (todate.isEmpty())) {
                                                            query.append(" where additionaltag like '%" + tag + "%' ");
                                                        }
                                                        if (query != null) {

                                                    %>
                                                    <jsp:forward page="cr_approver_export_report_final.jsp">
                                                           <jsp:param name="querySearch" value="<%=querySearch%>" /> 
                                                    <jsp:param name="query" value="<%=query%>" /> 
                                                    <jsp:param name="fromdate" value="<%=fromdate%>" /> 
                                                
                                                        <jsp:param name="query" value="<%=query%>" /> 
                                                    </jsp:forward>
                                                    <%                                                    }

                                                    %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <%      } catch (Exception e) {
                        System.out.println("error in innerexport:-" + e.getMessage());
                    }
                } catch (Exception e) {
                    System.out.println("error in outerexport:-" + e.getMessage());
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
            <script src=js/jquery-1.12.4.js></script>
            <script src=js/jquery-ui.js></script>
            <script src=plugins/bootstrap/js/bootstrap.js></script>
            <script src=plugins/bootstrap-select/js/bootstrap-select.js></script>
            <script src=plugins/jquery-slimscroll/jquery.slimscroll.js></script>
            <script src=plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.js></script>
            <script src=plugins/jquery-validation/jquery.validate.js></script>
            <!--<script src=plugins/jquery-steps/jquery.steps.js></script>-->
            <script src=plugins/autosize/autosize.js></script>
            <script src=plugins/momentjs/moment.js></script>
            <script src=plugins/bootstrap-material-datetimepicker/js/bootstrap-material-datetimepicker.js></script>
            <script src=plugins/bootstrap-datepicker/js/bootstrap-datepicker.js></script>
            <script src=js/demo.js></script>
            <script src=js/admin.js></script>

            <script>
                  $('#date-end').bootstrapMaterialDatePicker({weekStart: 0, time: false});
                                    $('#date-start').bootstrapMaterialDatePicker({weekStart: 0, time: false}).on('change', function (e, date)
                                    {
                                        $('#date-end').bootstrapMaterialDatePicker('setMinDate', date);
                                    });
                                    $('#date-end1').bootstrapMaterialDatePicker({weekStart: 0, time: false});
                                    $('#date-start1').bootstrapMaterialDatePicker({weekStart: 0, time: false}).on('change', function (e, date)
                                    {
                                        $('#date-end1').bootstrapMaterialDatePicker('setMinDate', date);
                                    });
            </script>
        </compress:html>
    </body>
</html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>