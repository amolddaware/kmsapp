<%-- 
    Document   : home
    Created on : Nov 15, 2017, 11:30:13 PM
    Author     : Amol
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<jsp:forward page="dashboard.jsp"></jsp:forward>--%>
<%ResourceBundle rb = ResourceBundle.getBundle("msg"); %>
<%
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("5") || session.getAttribute("role").equals("1"))) {

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
    Connection dh = null;
    PreparedStatement stmSelect = null;
    ResultSet rsSelect = null;
    String imag[];
%>
<form action="dm_approver_export_report.jsp" method="post"> 
    <div class="panel-body">

        <div class="row clearfix">

            <div class="col-md-3">

                <div class="form-group ">
                    <!--<label class="labelFilter"  for="location">Location:</label>-->
                    <div class="form-line">
                        <input type="text" class="form-control" id="sourceid" name="source" placeholder="Source">
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <!--<label class="labelFilter"  for="title">Title (English):</label>-->
                    <div class="form-line">
                        <input type="text" class="form-control" name="topic" id="topicid" placeholder="Topic">
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <!--<label class="labelFilter" for="titlemarathi">Title (Marathi):</label>-->
                    <div class="form-line">
                        <input type="text" class="form-control" name="post" id="postid" placeholder="Post">
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <!--<label class="labelFilter" for="titlemarathi">Title (Marathi):</label>-->

                    <div class="col-sm-6">
                        <div class="form-line">
                            <select name="count" id="count" class="form-control">
                                <option value="">Count</option>
                                <option value=">">></option>
                                <option value="<"><</option>
                                <option value="=">=</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-sm-6"><div class="form-line">
                            <input type="text" class="form-control" name="countnum" id="countnumid" placeholder="Number">
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div class="row clearfix">

            <div class="col-md-3">
                <div class="form-group">

                    <!--<label class="labelFilter"  for="sentiment">Sentiment:</label>-->
                    <select class="form-control show-tick form-line" name="sentiment">
                        <option value="">-Sentiment-</option>
                        <%
                              ConnectionDB connectionDB = new ConnectionDB();
                                dh = connectionDB.getConnection();
                             
                            PreparedStatement stmSentiment = null;
                            ResultSet rsSentiment = null;
                            try {
                                String sqlSentiment = "SELECT * FROM tbl_sentiment_details ";
                                System.out.println("sqlSelect-" + sqlSentiment);
                                stmSentiment = dh.prepareStatement(sqlSentiment);
                                rsSentiment = stmSentiment.executeQuery();
                                while (rsSentiment.next()) {
                        %>
                        <option value="<%=rsSentiment.getString(2)%>"><%=rsSentiment.getString(2)%></option>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (stmSentiment != null) {
                                    stmSentiment.close();
                                }

                                if (rsSentiment != null) {
                                    rsSentiment.close();
                                }
                            }

                        %>
                    </select>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <!--<label class="labelFilter"  for="tags">Tags:</label>-->
                    <div class="form-line">
                        <input type="text" class="form-control" name="tags" id="tagsid" placeholder="Tag">
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <!--<label class="labelFilter"  for="fromdate">From Date:</label>-->
                    <input type="text" class="form-control form-line" id="date-start1" name="fromdate" placeholder="From Date">
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <!--<label class="labelFilter"  for="todate">To Date:</label>-->
                    <input type="text" class="form-control form-line"  id="date-end1"  name="todate" placeholder="To Date">
                </div>
            </div>
            
        </div>
        <button type="submit" class="btn bg-black waves-effect waves-light" onclick="submitExport()" style="margin: 0px auto">SEARCH</button>
    </div>
</form>


<%} else {
        response.sendRedirect("login.jsp");
    }%>