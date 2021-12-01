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
<% String getData = null, searchQuery = null, room = null, link = null;%>
<form action="cr_approver_export_report.jsp" method="post"> 
    <div class="panel-body">

        <div class="row clearfix">
            <div class="col-md-3">

                <div class="form-group">
                    <div class="form-line">

                        <!--<label class="labelFilter" for="brand">Brand:</label>-->
                        <select  class="form-control " name="sector" id="sector"   >
                            <option value="">-Select Sector-</option>
                            <%
                                Connection dh = null;
                                String imag[];
                                try {
                                    ConnectionDB connectionDB = new ConnectionDB();
                                    dh = connectionDB.getConnection();
                                    String sqlSelect = "select category_name from tbl_category_master ";
                                    System.out.println("sqlSelect-" + sqlSelect);
                                    PreparedStatement stmSelect = dh.prepareStatement(sqlSelect);
                                    ResultSet rsSelect = stmSelect.executeQuery();
                                    while (rsSelect.next()) {
                            %>
                            <option value="<%=rsSelect.getString(1)%>"><%=rsSelect.getString(1)%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-md-3">

                <div class="form-group ">
                    <!--<label class="labelFilter"  for="location">Location:</label>-->
                    <div class="form-line">
                        <input type="text" class="form-control" id="titlecr" name="title" placeholder="Title" >

                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <!--<label class="labelFilter"  for="title">Title (English):</label>-->
                    <div class="form-line">
                        <input type="text" class="form-control" name="nameofprogram" id="nameofprogramcr" placeholder="Name of Program">
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <!--<label class="labelFilter" for="titlemarathi">Title (Marathi):</label>-->
                    <div class="form-line">
                        <input type="text" class="form-control" name="placeofprogram" id="placeofprogramcr" placeholder="Place of Program">
                    </div>
                </div>
            </div>

        </div>
        <div class="row clearfix">


            <div class="col-md-4">
                <div class="form-group">
                    <!--<label class="labelFilter"  for="tags">Tags:</label>-->
                    <div class="form-line">
                        <input type="text" class="form-control" name="tag" id="tagcr"  placeholder="Tag">
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
            <% } catch (Exception e) {

                    e.printStackTrace();
                } finally {
                    if (dh != null) {
                        dh.close();
                    }
                }
            %>
        </div>
        <button type="submit" class="btn bg-black waves-effect waves-light" onclick="submitExport()" style="margin: 0px auto">SEARCH</button>
    </div>
</form>


<%} else {
        response.sendRedirect("login.jsp");
    }%>