<%-- 
    Document   : header
    Created on : Nov 15, 2017, 11:36:31 PM
    Author     : Amol
--%>

<%
    request.setCharacterEncoding("UTF-8");
//    String role = session.getAttribute("role").toString();
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("2")  || session.getAttribute("role").equals("6") || session.getAttribute("role").equals("5") || session.getAttribute("role").equals("1"))) {

//    if (session != null && session.getAttribute("username") != null && session.getAttribute("role").equals("3")) {
        String username = session.getAttribute("username").toString();
        String userid = session.getAttribute("userid").toString();
        String token = session.getAttribute("csrfToken").toString();
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setDateHeader("Expires", 0);
        response.addHeader("X-Frame-Options", "DENY");
//System.out.println("session.getAttribute:-"+session.getAttribute("role").equals("5"));
        int timeout = session.getMaxInactiveInterval();
//                System.out.println("timeout:-"+timeout);
        response.setHeader("refresh", timeout + ";URL=logout.jsp");
%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar">
    <div class="container-fluid">
        <div class="navbar-header">
            <a href="javascript:void(0);" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse" aria-expanded="false"></a>
            <a href="javascript:void(0);" class="bars"></a>

            <a class="navbar-brand" href="#"><img class="img-responsive" width="120px" src="images/logo.png"></a>
        </div>
        <%--<div class="collapse navbar-collapse" id="navbar-collapse">
            <form action="dm_search.jsp" id="myForm" method="get">
                <ul class="nav navbar-nav navbar-right">
                    <%String result = null;
                        if (session.getAttribute("role").equals("2")) {
                            result = "G";
                        } else if (session.getAttribute("role").equals("3")) {
                            result = "N";
                        } else if (session.getAttribute("role").equals("4")) {
                            result = "P";
                        }
                    %>
                    <input type="hidden" name="searchresult" id="searchresult" value="<%=result%>">
                    <!-- Call Search -->
                    <li><a class="search_input" id="generalTag1">
                            <% if (request.getParameter("generaltagdigital") != null) {
//                            System.out.println("tests:-" + request.getParameter("generaltagdigital"));
//                                    String s = null;
//                                    String generaltagdigital = request.getParameter("generaltagdigital");
////        s.getBytes("UTF-8");
//
//                                    s = new String(generaltagdigital.getBytes("ISO-8859-1"), "UTF-8");

                            %>
                            <input class="form-control"  type="text" name="generaltagdigital" value="<%=request.getParameter("generaltagdigital")%>" id="generaltagdigital" autocomplete="off"  oninput="errBlank('errGeneral')" placeholder="Enter Keyword">

                            <%
                            } else {
                                //                        System.out.println("testsadadadasd:-");
                            %>
                            <input class="form-control"  type="text" name="generaltagdigital" id="generaltagdigital" autocomplete="off"  oninput="errBlank('errGeneral')" placeholder="START TYPING...">
                            <%}%>
                            <!--<input type="text" class="form-control" id="generaltagdigital" name="generaltagdigital" placeholder="START TYPING...">-->

                        </a>
                        <span id="errGeneral" class="text-danger col-lg-offset-2"> </span></li>
                    <li><a class="search_input">
                            <% if (request.getParameter("fromDate") != null) {
//                            System.out.println("tests:-" + request.getParameter("generaltagdigital"));

                            %>
                            <input type="text" id="date-start" name="fromDate" value="<%=request.getParameter("fromDate")%>" class="form-control" placeholder="FROM DATE...">
                            <%} else {%>
                            <input type="text" id="date-start" name="fromDate" class="form-control" placeholder="FROM DATE...">
                            <%}%>
                        </a></li>
                    <li><a class="search_input">
                            <% if (request.getParameter("toDate") != null) {
//                            System.out.println("tests:-" + request.getParameter("generaltagdigital"));

                            %>
                            <input type="text" id="date-end" name="toDate" value="<%=request.getParameter("toDate")%>" class="form-control" placeholder="TO DATE...">
                            <%} else {%>
                            <input type="text" id="date-end" name="toDate" class="form-control" placeholder="TO DATE...">
                            <%}%></a></li>
                    <!--<input type="text" id="date-end" name="toDate" class="form-control" placeholder="TO DATE..."></a></li>-->
                    <li style="padding: 35px 7px 2px 7px;"><button type="submit"  class="btn btn-dark p-15" data-close="true" style=" padding: 8px 12px;
                                                                   border-radius: 3px;   background: #1f1f1f;
                                                                   color: #fff;" onclick=" return valHeader()"><i class="material-icons">search</i></button></li>
                    <!-- #END# Call Search -->
                </ul>

            </form>
        </div>--%>
    </div>
    <script>
        function valHeader() {
            var general = document.getElementById("generaltagdigital").value;
//    alert(general);
            if (general == "") {
//        alert("error");
                document.getElementById("errGeneral").innerHTML = "Please enter keyword";
                document.getElementById("generaltagdigital").focus();
                return false;

            }
//    var general=document.getElementById("").value;

        }
//function errBlank(err){
//    document.getElementById(err).innerHTML="";
//}
    </script>
</nav>
<%} else {
        response.sendRedirect("login.jsp");
    }%>