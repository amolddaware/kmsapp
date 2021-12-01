<%-- 
    Document   : createuser
    Created on : Nov 16, 2017, 12:20:29 AM
    Author     : Amol
--%>
<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%ResourceBundle rb = ResourceBundle.getBundle("msg");
//    String role = session.getAttribute("role").toString();
    if (session != null && session.getAttribute("username") != null && session.getAttribute("role").equals("1")) {
        String username = session.getAttribute("username").toString();
        String userid = session.getAttribute("userid").toString();
        String token = session.getAttribute("csrfToken").toString();
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setDateHeader("Expires", 0);
        response.addHeader("X-Frame-Options", "DENY");

        int timeout = session.getMaxInactiveInterval();
//                System.out.println("timeout:-"+timeout);
        response.setHeader("refresh", timeout + ";URL=logout.jsp");
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title><%=rb.getString("title")%></title>
        <!--        <link rel="stylesheet" href="node_modules/font-awesome/css/font-awesome.min.css" />
                <link rel="stylesheet" href="node_modules/perfect-scrollbar/dist/css/perfect-scrollbar.min.css" />-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery.perfect-scrollbar/0.8.1/css/perfect-scrollbar.min.css" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>

        <link rel="stylesheet" href="css/style.css" />
        <link rel="shortcut icon" href="images/Maharastra1.jpg" />
    </head>

    <body>
        <div class=" container-scroller">
            <!--Navbar-->
            <jsp:include page="header.jsp"></jsp:include>
                <!--End navbar-->
                <div class="container-fluid">
                    <div class="row row-offcanvas row-offcanvas-right">
                    <jsp:include page="left.jsp"></jsp:include>
                        <!-- SIDEBAR ENDS -->
                        <div class="content-wrapper">
                            <h5 class="text-primary mb-4">Add General Tag <label class="offset-2 text-success  semi-bold" style="font-size:0.9rem"> <%if (request.getParameter("success") != null) {
                                    out.println("Record saved Successfully");
                                }%></label></h5>
                        <div class="row mb-2">
                            <div class="col-lg-12">
                                <div class="card">
                                    <div class="card-block">
                                        <!--<h5 class="card-title mb-4">Basic form elements</h5>-->
                                        <form class="forms-sample" action="<%=request.getContextPath()%>/addgeneraltag.do" method="post">
                                            <div class="col-sm-12 offset-2">
                                                <div class=" form-group">
                                                    <input type="hidden" name="token" value="<%=token%>">
                                                    <!--<label for="exampleInputEmail1">Name</label>-->
                                                    <input type="text" class="form-control p-input" id="tag" name="tag" aria-describedby="tag" placeholder="Add General Tag" required>
                                                    <!--<small id="emailHelp" class="form-text text-muted text-success"><span class="fa fa-info mt-1"></span>&nbsp;</small>-->
                                                </div>
                                            </div>
                                            <!--                                                <div class="col-sm-12 offset-2">
                                                                                                <div class="form-group">
                                                                                                    <label for="exampleInputEmail1">Email address</label>
                                                                                                    <input type="text" class="form-control p-input" id="subDepartment" aria-describedby="SubDepartment" placeholder="Add Sub Department">
                                                                                                    <small id="emailHelp" class="form-text text-muted text-success"><span class="fa fa-info mt-1"></span>&nbsp; We'll never share your email with anyone else.</small>
                                                                                                </div>
                                                                                            </div>-->
                                            <div class="col-sm-12 offset-2">
                                                <div class="form-group text-md-center">
                                                    <button type="submit" class="btn btn-primary">ADD</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <jsp:include page="footer.jsp"></jsp:include>
                    </div>
                </div>

            </div>


        </body>

    </html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>