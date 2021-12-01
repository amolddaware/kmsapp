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
<form action="em_approver_export_report.jsp" method="post"> 
    <div class="panel-body">

        <div class="row clearfix">
            <div class="col-md-3">

                <div class="form-group">
                    <div class="form-line">

                        <!--<label class="labelFilter" for="brand">Brand:</label>-->
                        <select  class="form-control " name="channel" id="channel" onchange="errorBlank('errChannel')"  >
                            <option value="">-Select Channel -</option>
                            <%
//                                Connection dh = null;
                                ConnectionDB connectionDB = new ConnectionDB();
                                dh = connectionDB.getConnection();
                                try {
                                    String sqlSelect = "SELECT * FROM tbl_television_master order by telename ";
                                    System.out.println("sqlSelect-" + sqlSelect);
                                    stmSelect = dh.prepareStatement(sqlSelect);
                                    rsSelect = stmSelect.executeQuery();
                                    while (rsSelect.next()) {
                            %>
                            <option value="<%=rsSelect.getString(2)%>"><%=rsSelect.getString(2)%></option>
                            <%
                                    }
                                } catch (Exception e) {
                                    System.err.println("Exception in television try catch :" + e.getMessage());
                                } finally {
                                    if (stmSelect != null) {
                                        stmSelect.close();
                                    }
                                    if (rsSelect != null) {
                                        rsSelect.close();
                                    }
                                }
                            %>
                            <!--</select>-->   
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <!--<label class="labelFilter"  for="title">Title (English):</label>-->
                    <div class="form-line">
                        <input type="text" class="form-control" name="title" id="titleidgr" placeholder="Title (English)">
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <!--<label class="labelFilter" for="titlemarathi">Title (Marathi):</label>-->
                    <div class="form-line">
                        <input type="text" class="form-control" name="titlemarathi" id="titlemarathiidgr" placeholder="Title (Marathi)">
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">

                    <!--<label class="labelFilter"  for="sentiment">Sentiment:</label>-->
                    <select class="form-control show-tick form-line" name="sentiment">
                        <option value="">-Sentiment-</option>
                        <%
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
        </div>
        <div class="row clearfix">

            <div class="col-md-4">
                <div class="form-group">
                    <!--<label class="labelFilter"  for="tags">Tags:</label>-->
                    <div class="form-line">
                        <input type="text" class="form-control" name="tags" id="tagsid" placeholder="Tag">
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                    <!--<label class="labelFilter"  for="fromdate">From Date:</label>-->
                    <input type="text" class="form-control form-line" id="date-start1" name="fromdate" placeholder="From Date">
                </div>
            </div>
            <div class="col-md-4">
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