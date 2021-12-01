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
//    String jsessionid = "";
//    Cookie[] cookies = request.getCookies();
//    if (cookies != null) {
//        for (Cookie cookie : cookies) {
//            if (cookie.getName().equals("JSESSIONID")) {
////                System.out.println("JSESSIONIDLoginpage=" + cookie.getValue());
//                jsessionid = request.getSession().toString();
//                break;
//            }
//        }
//    }

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
//                                            if(request.getParameter("fail")!=null){
//                                                fail="Incorrect Username or Password !!";
//                                            }
//    
//    request.setAttribute("jession", jsessionid);
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title><%=rb.getString("title")%></title>
          <link rel="icon" href="images/favicon.ico" type="image/x-icon">

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

        <script>(function (global) {

                if (typeof (global) === "undefined")
                {
                    throw new Error("window is undefined");
                }

                var _hash = "!";
                var noBackPlease = function () {
                    global.location.href += "#";

                    // making sure we have the fruit available for juice....
                    // 50 milliseconds for just once do not cost much (^__^)
                    global.setTimeout(function () {
                        global.location.href += "!";
                    }, 50);
                };

                // Earlier we had setInerval here....
                global.onhashchange = function () {
                    if (global.location.hash !== _hash) {
                        global.location.hash = _hash;
                    }
                };

                global.onload = function () {

                    noBackPlease();

                    // disables backspace on page except on input fields and textarea..
                    document.body.onkeydown = function (e) {
                        var elm = e.target.nodeName.toLowerCase();
                        if (e.which === 8 && (elm !== 'input' && elm !== 'textarea')) {
                            e.preventDefault();
                        }
                        // stopping event bubbling up the DOM tree..
                        e.stopPropagation();
                    };

                };

            })(window);</script>
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
        <!--<style>.chk{cursor: pointer;}</style>-->
        <!--</head>-->

    </head>

    <body class="fp-page">
        <div class="fp-box m-t-200">
            <div class="card">
                <div class="body">
                    <div class="logo">
                        <a href="javascript:void(0);"><img class="img-responsive" src="images/logo.png"></a>
                    </div>
                    <!--<form id="forgot_password" method="POST">-->
                        <div class="msg">
                            YOU HAVE BEEN
                            LOGGED OUT SUCCESSFULLY
                        </div>
<!--                        <div class="input-group">
                            <span class="input-group-addon">
                                <i class="material-icons">email</i>
                            </span>
                            <div class="form-line">
                                <input type="email" class="form-control" name="email" placeholder="Email" required autofocus>
                            </div>
                        </div>-->

<a href="login.jsp"> <button class="btn btn-block btn-lg bg-black waves-effect" >LOGIN</button></a>

<!--                        <div class="row m-t-20 m-b--5 align-center">
                            <a href="index.html">Sign In!</a>
                        </div>-->
                    <!--</form>-->
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
        <script src="js/pages/examples/forgot-password.js"></script>
    </body>

</html>