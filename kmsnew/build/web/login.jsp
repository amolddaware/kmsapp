<%-- 
    Document   : login
    Created on : Nov 15, 2017, 10:26:41 PM
    Author     : Amol
--%>

<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:forward page="login_1.jsp"></jsp:forward>
    
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
            
                                            if(request.getParameter("fail")!=null){
                                                fail="Incorrect Username or Password !!";
                                            }
//    
    request.setAttribute("jession", jsessionid);
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
        <link rel="shortcut icon" href="images/logo_2.png" />
        <!--          <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
                  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>-->



        <script>
//            var nVer = navigator.appVersion;
//            var nAgt = navigator.userAgent;
//            var browserName = navigator.appName;
//            var fullVersion = '' + parseFloat(navigator.appVersion);
//            var majorVersion = parseInt(navigator.appVersion, 10);
//            var nameOffset, verOffset, ix;
//
//// In Opera 15+, the true version is after "OPR/" 
//            if ((verOffset = nAgt.indexOf("OPR/")) != -1) {
//                browserName = "Opera";
//                fullVersion = nAgt.substring(verOffset + 4);
//            }
//// In older Opera, the true version is after "Opera" or after "Version"
//            else if ((verOffset = nAgt.indexOf("Opera")) != -1) {
//                browserName = "Opera";
//                fullVersion = nAgt.substring(verOffset + 6);
//                if ((verOffset = nAgt.indexOf("Version")) != -1)
//                    fullVersion = nAgt.substring(verOffset + 8);
//            }
//// In MSIE, the true version is after "MSIE" in userAgent
//            else if ((verOffset = nAgt.indexOf("MSIE")) != -1) {
//                browserName = "Microsoft Internet Explorer";
//                fullVersion = nAgt.substring(verOffset + 5);
//            }
//// In Chrome, the true version is after "Chrome" 
//            else if ((verOffset = nAgt.indexOf("Chrome")) != -1) {
//                browserName = "Chrome";
//                fullVersion = nAgt.substring(verOffset + 7);
//            }
//// In Safari, the true version is after "Safari" or after "Version" 
//            else if ((verOffset = nAgt.indexOf("Safari")) != -1) {
//                browserName = "Safari";
//                fullVersion = nAgt.substring(verOffset + 7);
//                if ((verOffset = nAgt.indexOf("Version")) != -1)
//                    fullVersion = nAgt.substring(verOffset + 8);
//            }
//// In Firefox, the true version is after "Firefox" 
//            else if ((verOffset = nAgt.indexOf("Firefox")) != -1) {
//                browserName = "Firefox";
//                fullVersion = nAgt.substring(verOffset + 8);
//            }
//// In most other browsers, "name/version" is at the end of userAgent 
//            else if ((nameOffset = nAgt.lastIndexOf(' ') + 1) <
//                    (verOffset = nAgt.lastIndexOf('/')))
//            {
//                browserName = nAgt.substring(nameOffset, verOffset);
//                fullVersion = nAgt.substring(verOffset + 1);
//                if (browserName.toLowerCase() == browserName.toUpperCase()) {
//                    browserName = navigator.appName;
//                }
//            }
//// trim the fullVersion string at semicolon/space if present
//            if ((ix = fullVersion.indexOf(";")) != -1)
//                fullVersion = fullVersion.substring(0, ix);
//            if ((ix = fullVersion.indexOf(" ")) != -1)
//                fullVersion = fullVersion.substring(0, ix);
//
//            majorVersion = parseInt('' + fullVersion, 10);
//            if (isNaN(majorVersion)) {
//                fullVersion = '' + parseFloat(navigator.appVersion);
//                majorVersion = parseInt(navigator.appVersion, 10);
//            }
//
//            document.getElementById("browserName").value = browserName;
//            document.getElementById("fullVersion").value = fullVersion;
//            alert(browserName);
//document.getElementById("browserName").value=browserName;
//document.write(''
// +'Browser name  = '+browserName+'<br>'
// +'Full version  = '+fullVersion+'<br>'
// +'Major version = '+majorVersion+'<br>'
//// +'navigator.appName = '+navigator.appName+'<br>'
//// +'navigator.userAgent = '+navigator.userAgent+'<br>'
//)
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

    <body>
        <div class="container-scroller">
            <div class="container-fluid">
                <div class="row">
                    <div class="content-wrapper full-page-wrapper d-flex align-items-center">
                        <div class="card col-lg-4 offset-lg-4">
                            <div class="card-block">
                                <h3 class="card-title text-primary text-center mb-3 mt-4">
                                    <i class="fa fa-user" style="font-size:100px;color:lightblue;text-shadow:2px 2px 4px #000000;"></i>
                                </h3>
                                <form action="<%=request.getContextPath()%>/login.do" method="post">
                                    <input type="hidden" name="fullVersion" id="fullVersion">
                                    <input type="hidden" name="browserName" id="browserName">

                                    <input type="hidden" name="csrfPreventionSalt" value="<c:out value='${csrfPreventionSalt}'/>"/>
                                    <div class="form-group text-center">
                                        <!--<div class="input-group">-->
                                            <small class="form-text text-muted text-danger"><%=fail%>&nbsp;</small>

                                        <!--</div>-->
                                    </div>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa fa-user"></i></span>
                                            <input type="text" name="username" class="form-control p_input" placeholder="Enter Email Id" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                                            <input type="password" name="password" class="form-control p_input" placeholder="Password" required>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-primary chk">Login</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--<script src="node_modules/jquery/dist/jquery.min.js"></script>-->
        <!--<script src="node_modules/tether/dist/js/tether.min.js"></script>-->
        <!--<script src="node_modules/bootstrap/dist/js/bootstrap.min.js"></script>-->
        <!--<script src="node_modules/perfect-scrollbar/dist/js/perfect-scrollbar.jquery.min.js"></script>-->
        <!--<script src="js/misc.js"></script>-->
    </body>

</html>