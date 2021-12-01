<%-- 
    Document   : changepassword
    Created on : Nov 22, 2017, 3:17:50 PM
    Author     : Amol
--%>
<%@page import="java.util.ResourceBundle"%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<%ResourceBundle rb = ResourceBundle.getBundle("msg");%>
<%
//    String role = session.getAttribute("role").toString();
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("2") || session.getAttribute("role").equals("3") || session.getAttribute("role").equals("4") || session.getAttribute("role").equals("5"))) {
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
        response.setHeader("refresh", timeout + ";URL=logout.jsp");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%><!DOCTYPE html>

<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title><%=rb.getString("title")%></title>
        <link rel="icon" href="favicon.ico" type="image/x-icon">

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Roboto:400,700&subset=latin,cyrillic-ext" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" type="text/css">

        <!-- Bootstrap Core Css -->
        <link href="plugins/bootstrap/css/bootstrap.css" rel="stylesheet">

        <!-- Waves Effect Css -->
        <link href="plugins/node-waves/waves.css" rel="stylesheet" />

        <!-- Animation Css -->
        <link href="plugins/animate-css/animate.css" rel="stylesheet" />

        <!-- Custom Css -->
        <link href="css/style.css" rel="stylesheet">

    <body class="signup-page">
        <div class="signup-box m-t-200">
            <div class="card">
                <div class="body">
                    <div class="logo">
                        <a href="javascript:void(0);"><img class="img-responsive" src="images/logo.png"></a>
                    </div>
                    <form id="sign_up" name="form_changepass" method="POST" action="<%=request.getContextPath()%>/changepass.do">
                        <input id="token" name="token" type="hidden" value="<%=token%>" />


                        <div class="msg"><b>Change your password</b></div>
                        <div class="input-group">
                            <span class="input-group-addon">
                                <i class="material-icons">person</i>
                            </span>
                            <div class="form-line">
                                <input type="text" class="form-control" id="username" value="<%=username%>" name="username" readonly >
                            </div>
                        </div>
                        <div class="input-group">
                            <span class="input-group-addon">
                                <i class="material-icons">lock</i>
                            </span>
                            <div class="form-line">
                                <input type="password" class="form-control" id="password" name="password" minlength="6"  oninput="errBlank('errPassword')" placeholder="New Password" required>
                            </div>
                            <span class="error" id="errPassword"></span>

                        </div>

                        <div class="input-group">
                            <span class="input-group-addon">
                                <i class="material-icons">lock</i>
                            </span>
                            <div class="form-line">
                                <input type="password" class="form-control" id="cpassword" name="cpassword" minlength="6" oninput="errBlank('errCpassword')" placeholder="Confirm Password" required>
                                <!---->
                            </div><span class="error" id="errCpassword" ></span>
                        </div>

                        <input class="btn btn-block btn-lg bg-black waves-effect" type="submit" onclick="return CheckPassword();" value="UPDATE">

                        <div class="m-t-25 m-b--5 align-center">
                            <a href="login_1.jsp">You want to login?</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Jquery Core Js -->
        <script src="plugins/jquery/jquery.min.js"></script>

        <!-- Bootstrap Core Js -->
        <script src="plugins/bootstrap/js/bootstrap.js"></script>

        <!-- Waves Effect Plugin Js -->
        <script src="plugins/node-waves/waves.js"></script>

        <!-- Validation Plugin Js -->
        <script src="plugins/jquery-validation/jquery.validate.js"></script>

        <!-- Custom Js -->
        <script src="js/admin.js"></script>
        <script src="js/pages/examples/sign-up.js"></script>
        <script>
                            function errBlank(err) {
                                document.getElementById(err).innerHTML = "";
                            }
                            function CheckPassword() {

                                var password = document.getElementById("password").value;
                                var cpassword = document.getElementById("cpassword").value;

                                var decimal = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{6,15}$/;

                                if (password == "")

                                {
//    alert(password);
                                    document.getElementById("errPassword").innerHTML = "Please enter password";
                                    document.getElementById("password").focus();
                                    return false;
                                }
                                if (password.match(decimal)) {
//                                    return true;
                                } else
                                {
                                    document.getElementById("errPassword").innerHTML = "6 to 15 characters which contain at least one lowercase letter, one uppercase letter, one numeric digit, and one special character";
                                    document.getElementById("password-error").innerHTML = "";
                                    document.getElementById("cpassword").focus();
                                    return false;
                                }
                                if (cpassword == "")

                                {
//    alert(password);
                                    document.getElementById("errCpassword").innerHTML = "Please enter confirm  password";
                                    document.getElementById("cpassword").focus();
                                    return false;
                                }
                                if (password!=cpassword) {
//                                    alert("error");
//                                    document.getElementById("cpassword-error").innerHTML = "";
                                   
                                    document.getElementById("errCpassword").innerHTML = "Password not match";
                                     document.getElementById("cpassword").focus();
                                    return false;
                                }
                            }
        </script>

    </body>
</html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>