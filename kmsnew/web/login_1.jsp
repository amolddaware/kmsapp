<%-- 
    Document   : login
    Created on : Nov 15, 2017, 10:26:41 PM
    Author     : Amol
--%>

<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%ResourceBundle rb = ResourceBundle.getBundle("msg");
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

//    RandomStringGenerator random=new RandomStringGenerator();
////    String captcha=random.getRandomCaptchaString(8);
////    
////    String captchaSplit[]=captcha.split("");
////    
////    String fullcaptcha=captchaSplit[0]+" "+captchaSplit[1]+" "+captchaSplit[2]+" "+captchaSplit[3]+" "+captchaSplit[4]+" "+captchaSplit[5]+" "+captchaSplit[6]+" "+captchaSplit[7];
//    
//    String captcha =random.getRandomStringGenerator();
//    System.out.println("captcha:-"+captcha);
//    String captchaSplit[]=captcha.split("");
////    
//    String fullcaptcha=captchaSplit[0]+" "+captchaSplit[1]+" "+captchaSplit[2]+" "+captchaSplit[3]+" "+captchaSplit[4]+" "+captchaSplit[5]+" "+captchaSplit[6]+" "+captchaSplit[7];
//    
//    String fail="";
    if (request.getParameter("fail") != null) {
        fail = "Incorrect Username or Password !!";
    }
//    
    request.setAttribute("jession", jsessionid);
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="UTF-8">
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <title><%=rb.getString("title")%></title>

        <!-- Favicon-->
        <link rel="icon" href="images/favicon.ico" type="image/x-icon">

        <!-- Google Fonts -->
        <link href="css/font/materialicon.css" rel="stylesheet" type="text/css">
        <link href="css/font/googlefont.css" rel="stylesheet" type="text/css">

        <!-- Bootstrap Core Css -->
        <link href="plugins/bootstrap/css/bootstrap.css" rel="stylesheet">

        <!-- Waves Effect Css -->
        <link href="plugins/node-waves/waves.css" rel="stylesheet" />

        <!-- Animation Css -->
        <link href="plugins/animate-css/animate.css" rel="stylesheet" />

        <!-- Custom Css -->
        <link href="css/style.css" rel="stylesheet">
        <script>
            $(document).ready(function () {

                /* Get browser */
                $.browser.chrome = /chrome/.test(navigator.userAgent.toLowerCase());

                /* Detect Chrome */
                if ($.browser.chrome) {
                    /* Do something for Chrome at this point */
                    alert("You are using Chrome!");

                    /* Finally, if it is Chrome then jQuery thinks it's 
                     Safari so we have to tell it isn't */
                    $.browser.safari = false;
                }

                /* Detect Safari */
                if ($.browser.safari) {
                    /* Do something for Safari */
                    alert("You are using Safari!");
                }

            });
        </script>
        <style>.chk{cursor: pointer;}</style>
    </head>

    <body class="login-page">

        <!--Login window-->                       

        <div class="login-box m-t-200">

            <div class="card">
                <div class="body">
                    <div class="logo">
                        <a href="javascript:void(0);"><img class="img-responsive" src="images/logo.png"></a>
                    </div>
                    <form id="sign_in"  action="<%=request.getContextPath()%>/login.do" method="post" >
                        <input type="hidden" name="fullVersion" id="fullVersion">
                        <input type="hidden" name="browserName" id="browserName">

                        <input type="hidden" name="csrfPreventionSalt" value="<c:out value='${csrfPreventionSalt}'/>"/>

                        <div class="msg">Sign In to start your session</div>
                        <div class="input-group">
                            <span class="input-group-addon">
                                <i class="material-icons">person</i>
                            </span>
                            <div class="form-line">
                                <input type="text" class="form-control" name="username" placeholder="Username" oninput="errBlank('errUsername')" required autofocus>
                            </div>
                            <span class="error" id="errUsername"></span>

                            <!--<span ></span>-->
                        </div>
                        <div class="input-group">
                            <span class="input-group-addon">
                                <i class="material-icons">lock</i>
                            </span>
                            <div class="form-line">
                                <input type="password" class="form-control" name="password" placeholder="Password" oninput="errBlank('errPassword')" required>
                            </div><span class="error" id="errPassword"></span>

                        </div>

                        <div class="input-group">
                            <!--<div class="form-group m-1 p-0">-->
                            <div id="html_element" class="m-0 p-0 captcha d-flex justify-content-center" ></div>
                            <span class='error' id="errCaptcha"></span>
                            <!--</div>-->
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <input class="btn btn-lg btn-block bg-black waves-effect" type="submit" onclick="return checkValidation()" value="SIGN IN">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="modal bodyBackground" id="myModel1" tabindex="-1" role="dialog" style="display: none">
            <div class="modal-dialog  m-t-125" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title text-center" id="defaultModalLabel">Login Entry</h4>
                    </div>
                    <div class="modal-body text-center">
                        <!--<div id="sameEntryExist" class="text-danger"></div>-->


                        <p class="text-success semi-bold" style="font-size:18px" id="loggedinentry"> </p>

                        <!--<iframe width="560" height="315" src="https://www.youtube.com/embed/u3xKgwKUQLc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>-->
                    </div>
                    <div class="modal-footer">
                        <!--<a >TAG</a>-->
                        <a href="login_1.jsp"> <button type="button" class="btn btn-link waves-effect"  data-dismiss="#myModel1" >CLOSE</button></a>
                    </div>
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
        <script src="js/pages/examples/sign-in.js"></script>
        <script type="text/javascript" src="https://www.google.com/recaptcha/api.js?render=explicit"></script>

        <script type="text/javascript">
                                    //<![CDATA[
            /*window.onload = function () {
                var onloadCallback = function () {
                    grecaptcha.render('html_element', {
////                        'sitekey': '6LcxFK8UAAAAAGH58Fh3lRFaPpMFkP84P5MPTmwQ'
                        'sitekey': '6LdTuuQUAAAAAJxR0qpIi49694zBJY3alIp5nYFW'
                    });
                };
                onloadCallback();
                $('form').on('submit', function (e) {
                    if (grecaptcha.getResponse() == "") {
                        e.preventDefault();
                        document.getElementById("errCaptcha").innerHTML = "Please select captcha";
                        document.getElementById("html_element").focus();
                        return false;
                    }
                });
            }
            */
                                    function errBlank(err) {
                                        document.getElementById(err).innerHTML = "";
                                    }
                                    function checkValidation() {

                                        var username = document.getElementById("username").value;
                                        var password = document.getElementById("password").value;

//                var decimal = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{6,15}$/;

                                        if (username == "")

                                        {
//                    alert(password);
                                            document.getElementById("errUsername").innerHTML = "Please enter username";
                                            document.getElementById("username").focus();
                                            return false;
                                        }
                                        if (password == "")

                                        {
//                    alert(password);
                                            document.getElementById("errPassword").innerHTML = "Please enter password";
                                            document.getElementById("password").focus();
                                            return false;
                                        }
//                                if (password != cpassword) {
//                                    alert("error");
//                                    document.getElementById("cpassword-error").innerHTML = "Password not match";
//                                    document.getElementById("cpassword").focus();
//                                    return false;
//                                }
                                    }
                                    $(document).ready(function () {
                                    if (window.location.href.indexOf("fail") > - 1) {
//alert("test");
                                    document.getElementById('myModel1').style.display = "block";
                                            document.getElementById("loggedinentry").innerHTML = "Incorrect username and password";
                                            var span = document.getElementsByClassName("close")[0];
//                    span.onclick = function () {
//                        modal.style.display = "none";
//                    };
//                    window.onclick = function (event) {
//                        if (event.target == modal) {
//                            modal.style.display = "none";
//                        }
//                    };
                                    }});
                                    //]]></script>

        <!--<script src="node_modules/jquery/dist/jquery.min.js"></script>-->
        <!--<script src="node_modules/tether/dist/js/tether.min.js"></script>-->
        <!--<script src="node_modules/bootstrap/dist/js/bootstrap.min.js"></script>-->
        <!--<script src="node_modules/perfect-scrollbar/dist/js/perfect-scrollbar.jquery.min.js"></script>-->
        <!--<script src="js/misc.js"></script>-->
    </body>

</html>
