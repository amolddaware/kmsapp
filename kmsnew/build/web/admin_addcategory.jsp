<%-- 
    Document   : dragndrop1
    Created on : Dec 18, 2017, 8:34:23 PM
    Author     : Amol
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%ResourceBundle rb = ResourceBundle.getBundle("msg");%>

<%
//    String role = session.getAttribute("role").toString();
    if (session != null && session.getAttribute("username") != null && session.getAttribute("role").equals("1")) {
// if (session != null && session.getAttribute("username") != null ) {

        String username = session.getAttribute("username").toString();
        String userid = session.getAttribute("userid").toString();
        String token = session.getAttribute("csrfToken").toString();
//System.out.println(token);
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
        <!--        <link rel="stylesheet" type="text/css" href="jquery.autocomplete.css" />
                <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>-->

        <!--<link rel="stylesheet" href="css/jquery-ui.css" type="text/css" />-->
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/extra.css" />
        <link rel="shortcut icon" href="images/Maharashtra1.jpg" type="image/jpg" />
        <!--        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
                <script src="js/alertify.min.js"></script>
                <link rel="stylesheet" href="css/alertify.core.css" />
                <link rel="stylesheet" href="css/alertify.default.css" id="toggleCSS" />
           <script src="js/jquery.autocomplete.js"></script>-->
        <link href="css/jquery-ui.css" rel="stylesheet">
        <!--<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />-->
        <link href="css/jquery.multiselect.css" rel="stylesheet" />
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <link href="http://cdn.rawgit.com/davidstutz/bootstrap-multiselect/master/dist/css/bootstrap-multiselect.css"  rel="stylesheet" type="text/css" />
        <script src="js/jquery.multiselect.js"></script>

        <!--    <link rel="stylesheet" type="text/css" href="css/ui.dropdownchecklist.css" />
            <link rel="stylesheet" type="text/css" href="css/main.css" />-->
        <!--<script src="js/sweetalert-dev.js"></script>-->
        <!--<script src="javascript.js"></script>-->
        <link rel="stylesheet" type="text/css" href="style.css" />
        <!--<link rel="stylesheet" type="text/css" href="css/sweetalert.css" />-->
        <!--<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>-->
        <!--<link href="http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.min.css"
            rel="stylesheet" type="text/css" />-->
        <!--<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js"></script>-->
        <!--        <link href="http://cdn.rawgit.com/davidstutz/bootstrap-multiselect/master/dist/css/bootstrap-multiselect.css"
                      rel="stylesheet" type="text/css" />
                <script src="http://cdn.rawgit.com/davidstutz/bootstrap-multiselect/master/dist/js/bootstrap-multiselect.js"-->
        <!--type="text/javascript"></script>-->
        <script type="text/javascript">
            $(function () {
                $('#idCategory').multiselect({
                    includeSelectAllOption: true
                });

            });
        </script>
        <script>
            $(function () {
                function split(val) {
                    return val.split(/,\s*/);
                }
                function extractLast(term) {
                    return split(term).pop();
                }

                $("#generalTag input")
                        .autocomplete({
                            source: function (request, response) {
                                $.getJSON("jsonfile_1.jsp?description=" + document.getElementById("generaltag").value, {
                                    term: extractLast(request.term)
                                }, response);
                            },
                            search: function () {
                                // custom minLength
                                var term = extractLast(this.value);
                                //           alert(term);
                                if (term.length < 2) {

                                    return false;
                                }
                            },
                        });
            });
        </script>
                  

        <script>
           
            function closeSkipDiv() {
                document.getElementById("skipDiv").style.display = "none";

            }
            function errBlank(err) {
                document.getElementById(err).innerHTML = "";
            }
            
            
        </script>
        <script type="text/javascript">
            $(document).ready(function () {
                if (window.location.href.indexOf("success") > -1) {

                    var modal = document.getElementById('myModal').style.display = "block";
                    ;

// Get the button that opens the modal
//var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
                    var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 
//btn.onclick = function() {
//    modal.style.display = "block";
//}

// When the user clicks on <span> (x), close the modal
                    span.onclick = function () {
                        modal.style.display = "none";
                    }

// When the user clicks anywhere outside of the modal, close it
                    window.onclick = function (event) {
                        if (event.target == modal) {
                            modal.style.display = "none";
                        }
                    }
//                    alert("your url contains the name franky");
                }
            });
        </script>
        <style>
            .modal {
                display: none; /* Hidden by default */
                position: fixed; /* Stay in place */
                z-index: 1; /* Sit on top */
                padding-top: 100px; /* Location of the box */
                left: 0;
                top: 0;
                width: 100%; /* Full width */
                height: 100%; /* Full height */
                overflow: auto; /* Enable scroll if needed */
                background-color: rgb(0,0,0); /* Fallback color */
                background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
            }

            /* Modal Content */
            .modal-content {
                background-color: #fefefe;
                margin: auto;
                padding: 20px;
                border: 1px solid #888;
                width: 50%;
            }

            /* The Close Button */
            .close {
                color: #aaaaaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .close:hover,
            .close:focus {
                color: #000;
                text-decoration: none;
                cursor: pointer;
            }

        </style>
        <script>
            $(function () {
                function split(val) {
                    return val.split(/,\s*/);
                }
                function extractLast(term) {
                    return split(term).pop();
                }

                $("#rawSubjectTag input")
                        .autocomplete({
                            source: function (request, response) {
                                $.getJSON("jsonfile_mediaroom.jsp?description=" + document.getElementById("subject").value, {
                                    term: extractLast(request.term)
                                }, response);
                            },
                            search: function () {
                                // custom minLength
                                var term = extractLast(this.value);
//           alert(term);
                                if (term.length < 2) {

                                    return false;
                                }
                            },
                        });
                $("#rawEventTag input")
                        .autocomplete({
                            source: function (request, response) {
                                $.getJSON("jsonfile_mediaroom.jsp?description=" + document.getElementById("event").value, {
                                    term: extractLast(request.term)
                                }, response);
                            },
                            search: function () {
                                // custom minLength
                                var term = extractLast(this.value);
//           alert(term);
                                if (term.length < 2) {

                                    return false;
                                }
                            },
                        });
            });
        </script>
    </head>

    <body>
        <div class=" container-scroller">
            <!--Navbar-->
            <%if (!userid.equals("1")) {%>
            <jsp:include page="userHeader.jsp"></jsp:include>
            <%} else {
            %>
            <jsp:include page="header.jsp"></jsp:include>

            <%
    }%>
            <!--End navbar-->
            <div class="container-fluid">
                <div class="row row-offcanvas row-offcanvas-right">
                    <%--<jsp:include page="userLeft.jsp"></jsp:include>--%>
                    <!-- SIDEBAR ENDS -->
                    <div class="content-wrapper">
                        <!--<h5 class="text-primary mb-4 ">News Data Entry</h5>-->
                        <div class="row mb-2">
                            <div class="col-lg-12">
                                <div class="card">
                                    <div class="card-block">
                                        <div class="col-xs-12"> 
                                           <section class="design-process-section col-sm-12" id="process-tab">
                                                <!--<div class="container">-->
                                                <div class="row">
                                                    <div class="col-sm-9 offset-2" >
                                                        <div class="tab-content">
                                                            <div role="tabpanel"  id="upload">
                                                                <!--<div role="tabpanel" class="tab-pane" id="upload">-->
                                                                <div class=" col-sm-12">
                                                                    <h4 class="semi-bold text-center"> Add Category
                                                                    </h4>
                                                                    <br>
                                                                    <form action="<%=request.getContextPath()%>/addcategory.do"  id="uploadform" method="post" accept-charset="UTF-8">

                                                                        <!--<input type="hidden"  id="textInput" name="getUpload" >-->
                                                                        <div class="row mb-2">
                                                                            <!--<div class="col-sm-12">-->
                                                                            <div class="col-lg-3">
                                                                                <input id="token" name="token" type="hidden" value="<%=token%>" />

                                                                                <label for="subject">Category</label>
                                                                            </div>
                                                                            <div class="col-lg-6" id="rawSubjectTag">
                                                                                <input type="text" class="txt" name="category" autocomplete="off" oninput="errorBlank('errSubject')" id="category"  placeholder="Enter category name" required>

                                                                                <!--<small id="emailHelp" class="form-text text-muted text-success"><span class="fa fa-info mt-1"></span>&nbsp;</small>-->
                                                                            </div>
                                                                            <div class="col-lg-3">
                                                                                <span id="errSubject" class="text-danger">&nbsp;</span>

                                                                            </div>
                                                                            <!--</div>-->
                                                                        </div>

                                                                        <div class="col-sm-12">
                                                                            <div class="form-group text-md-center">
                                                                                <!--<a href="newssource.jsp#source?skip" target="_top" onClick="window.location.reload();" class="text-success btn semi-bold" title="Skip to next tab">skip</a>-->
                                                                                <!--<input type="button" class="btn btn-primary" id="btnSelected"  value="Save">-->
                                                                                <input type="submit" class="btn btn-primary" id="btnSelected"  value="Save and Continue">
                                                                                <!--<input type="submit" class="btn btn-primary"   value="Save and Continue">-->
                                                                            </div>
                                                                        </div>

                                                                    </form>

                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="myModal" class="modal" style="display: none">
                                                    <!-- Modal content -->
                                                    <div class="modal-content">
                                                        <div class="row mb-2 text-center">
                                                            <!--<span class="close">&times;</span>-->
                                                            <div class="col-lg-12">
                                                                

                                                                <p class="text-success semi-bold" style="font-size:18px">Category added successfully</p>
                                                                <!--<p></p>-->

                                                            </div>
                                                            <div class="col-lg-12">

                                                                <a href="admin_addcategory.jsp"> <button class="btn btn-primary" onclick="closeDiv()">Close</button></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </section>
                                            <!--<input type="text" id="ajaxData1">-->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--<jsp:include page="userFooter.jsp"></jsp:include>--%>
                </div>
            </div>
        </div>

        <script src="js/script.js" type="text/javascript"></script>
    </body>
</html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>

