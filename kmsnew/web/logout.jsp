<%-- 
    Document   : login
    Created on : Nov 15, 2017, 10:26:41 PM
    Author     : Amol
--%>

<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:forward page="logout_1.jsp"></jsp:forward>
<%ResourceBundle rb = ResourceBundle.getBundle("msg");
    response.addHeader("X-Frame-Options", "DENY");
    if (session == null && session.getAttribute("username") == null) {
        response.sendRedirect("logout.jsp");
    }

%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title><%=rb.getString("title")%></title>               
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery.perfect-scrollbar/0.8.1/css/perfect-scrollbar.min.css" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>

        <link rel="stylesheet" href="css/style.css" />
        <link rel="shortcut icon" href="images/favicon.png" />
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
    </head>

    <body>
        <div class="container-scroller">
            <div class="container-fluid">
                <div class="row">
                    <div class="content-wrapper full-page-wrapper  align-items-center">
                        <div class="card col-lg-10 offset-lg-1">
                            <!--<div class="card-block">-->
                            <h3 class="card-title text-primary text-center mb-5 mt-4 text-success">
                                <i > You have been logout successfully. Please <a href="login.jsp" style="text-decoration: underline">login</a> to Continue your account.</i>
                                <!--<i class="fa fa-user" style="font-size:100px;color:lightblue;text-shadow:2px 2px 4px #000000;"></i>-->
                            </h3>

                            <!--</div>-->
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="node_modules/jquery/dist/jquery.min.js"></script>
        <script src="node_modules/tether/dist/js/tether.min.js"></script>
        <script src="node_modules/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="node_modules/perfect-scrollbar/dist/js/perfect-scrollbar.jquery.min.js"></script>
        <script src="js/misc.js"></script>
    </body>

</html>