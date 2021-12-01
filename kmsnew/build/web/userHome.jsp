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
<jsp:forward page="user_homepage.jsp"></jsp:forward>
<%ResourceBundle rb = ResourceBundle.getBundle("msg"); %>
<%
 if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("2")||session.getAttribute("role").equals("3")||session.getAttribute("role").equals("4"))) {

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
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title><%=rb.getString("title")%></title>
        <!--<link rel="stylesheet" href="css/font-awesome.min.css" />-->
        <!--<link rel="stylesheet" href="node_modules/font-awesome/css/font-awesome.min.css" />-->
        <!--<link rel="stylesheet" href="node_modules/perfect-scrollbar/dist/css/perfect-scrollbar.min.css" />-->

        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/extra.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery.perfect-scrollbar/0.8.1/css/perfect-scrollbar.min.css" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
        <link rel="shortcut icon" href="images/Maharastra1.jpg" />
        <!--<link rel="stylesheet" type="text/css" href="jquery.autocomplete.css" />-->
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
        <!--<script src="jquery.autocomplete.js"></script>-->  
        <link rel="stylesheet" type="text/css" href="css/style_1.css" />
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script src="js/jquery.autocomplete.js"></script>
<script>
jQuery(function(){
$("#generaltag").autocomplete("list.jsp");
});
</script>
        <!--<script src="js/hoverable-collapse.js"></script>-->
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
            function showData() {
                var xmlhttp;
                var subject = document.getElementById("generaltag").value;
                if (subject != "") {
                    if (window.XMLHttpRequest)
                    {// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp = new XMLHttpRequest();
                    } else
                    {// code for IE6, IE5
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    var urls = "fetchdata_new.jsp?generaltag=" + subject;
//                alert(urls);
                    xmlhttp.onreadystatechange = function ()
                    {
                        if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                        {
                            var resp = xmlhttp.responseText;
//                        alert(resp);

                            document.getElementById("fetchData").innerHTML = resp;
//            document.getElementById("id_disease_type").value="-1";

//                        selectVillage();
//            diseaseType();
                        }
                    };
//    xmlhttp.open("GET", urls, true);
                    xmlhttp.open("POST", urls, true);
                    xmlhttp.send();
                } else {

                    document.getElementById("errGeneral").innerHTML = "Please enter the value";
                    document.getElementById("generaltag").focus();
                    return false;
//                alert("Please enter data");
                }
            }
            function errBlank(err) {
                document.getElementById(err).innerHTML = '';
            }
            function closeVdoFile() {
                document.getElementById("displayVdoFile").style.display = "none";
                var video = document.getElementById("videoContainer");

                video.pause();
                video.currentTime = 0;


            }
            function displayVdoFiles(file) {

                var xhttp = new XMLHttpRequest();
//alert("hi");
                var urls = "videogrid_homepage_1.jsp?searchresult=" + file;
                xhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        document.getElementById("displayVdoFile").style.display = "block";

                        document.getElementById("vdofile").innerHTML = this.responseText;
                    }
                };
                xhttp.open("GET", urls, true);
                xhttp.send();
            }
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
                width: 30%;
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
            .sbico-c {
                background: transparent;
                border: 0;
                float: right;
                height: 44px;
                line-height: 44px;
                margin-top: -1px;
                outline: 0;
                padding-right: 16px;
                position: relative;
                top: -1px;
            }


            .divSearch{
            border-radius: 2px;
            -webkit-box-shadow: inset 0 2px 2px rgba(0,0,0,0.075); box-shadow: inset 0 2px 2px rgba(0,0,0,0.075);-webkit-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
          
            }

            .z1asCe, .qa__svg-icon {
                display: inline-block;
                fill: currentColor;
                height: 24px;
                line-height: 24px;
                position: relative;
                width: 24px;
            }.sbico {
                display: inline-block;
                height: 24px;
                width: 24px;
                cursor: pointer;
                vertical-align: middle;
                color: #4285f4;
            }
.txtSearch{
                width:80%;display: block;font-size:0.8rem;border-radius: 3px;padding: 2px 6px;line-height: 1.428571429;color: #000;vertical-align: middle;background-color: #fff;margin-top: 7px;border: none;
            }
            .txtSearch:enabled {
                width:100%;display: block;border-radius: 3px;padding: 6px 6px;line-height: 1.428571429;color: #000;vertical-align: middle;background-color: #fff;margin-top: 7px;
            }
        </style>
    </head>

    <body>
        <div class=" container-scroller">
            <!--Navbar-->
            <jsp:include page="userHeader.jsp"></jsp:include>
                <!--End navbar-->
                <div class="container-fluid">
                    <div class="row row-offcanvas row-offcanvas-right">
                    <jsp:include page="userLeft.jsp"></jsp:include>
                        <!-- SIDEBAR ENDS -->


                        <div class="content-wrapper ">
                            <div class="row-mb-4 text-center">
                                <div class=" row mb-2">
                                    <div class="col-sm-2"></div>
                                    <!--<form class="form-inline mt-2 mt-md-0 hidden-md-down text-center">-->
                                    <div class="col-sm-8">
                                        <div class="row mb-2 ">
                                            <div class="col-sm-8 divSearch bg-white ">
                                                <input class="txtSearch "  type="text" name="generaltag" id="generaltag"  oninput="errBlank('errGeneral')" placeholder="Enter Keyword">

                                            </div>
                                            <div class="col-sm-1 bg-white divSearch ">

                                                <!--<button type="button"  class="fa-search chk">Fetch Record</button>-->
                                                <!--< type="button" onclick="showData()" class="fa-search chk"></button>-->
                                                <button class="sbico-c" value="Search" aria-label="" onclick="showData()" type="submit"><span class="sbico z1asCe MZy1Rb offset-5"><svg focusable="false" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M15.5 14h-.79l-.28-.27A6.471 6.471 0 0 0 16 9.5 6.5 6.5 0 1 0 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"></path></svg></span></button>
                                            </div>
                                        </div>
                                    </div>
                                    <!--<input class="form-control mr-sm-2 search" type="text" name="subject" placeholder="Search">-->
                                    <!--                                        <script>
                                                                                $("#subject").autocomplete("getData.jsp");
                                                                            </script>-->
                                    <div class="col-sm-2">
                                    </div>
                                <%--<div class="col-sm-6">
                                <%   String selectUserid = "";
                                    Connection dh = null;
                                    String logintime = "";
                                    ConnectionDB conn = new ConnectionDB();
                                    dh = conn.getConnection();
                                    PreparedStatement pstmtLogin = null;
                                    ResultSet rsLogin = null;
                                    try {

//                                                selectUserid = "select max(datetime) from loginhistory where userid=?";
                                            selectUserid = "SELECT datetime FROM loginhistory where userid=? ORDER BY datetime DESC LIMIT 1,1;";
                                            //                                                                    System.out.println("selectdist:-" + dist);
                                            pstmtLogin = dh.prepareStatement(selectUserid);
                                            pstmtLogin.setString(1, userid);
                                            //                                                                                                pstmtDist.setString(1, dist);
                                            //                                        pstmtTal.setString(2, tal);
                                            rsLogin = pstmtLogin.executeQuery();
                                            if (rsLogin.next()) {
                                                logintime = rsLogin.getString(1);
//                                                                        System.out.println(rsDist.getString(1) + "==" + rsDist.getString(2));
                                                //                                                out.println(" <option value=" + rsDist.getString(1) + ">" + rsDist.getString(2) + " </option>");
                                    %>


                                    <%}
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                            System.out.println("Exception in district try catch block:-" + e.getMessage());

                                        } finally {
                                            // pstmtDist.close();
                                            // rsDist.close();

                                        }
                                    %>
                                    <span class="text-primary">Last login time:-<%=logintime%></span>
                                </div>
                                <!--</form>-->            
                            </div>
                            <div class="col-lg-3"> <span class="text-danger" id="errGeneral"></span>

                            </div>--%>
                            </div>
                            <div class="row mb-2" >
                                <div class="col-lg-12">
                                    <div class="card">
                                        <div class="card-block">
                                            <!--<h5 class="card-title mb-4">System Users</h5>-->
                                            <div class="table-responsive">
                                                <div id="fetchData" > </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%--<jsp:include page="footer.jsp"></jsp:include>--%>
                        </div>
                    </div>
                </div>
                <div id="displayVdoFile" class="modal" style="display: none">
                    <!-- Modal content -->
                    <div class="modal-content">
                        <div class="row mb-2 text-center">
                            <!--<span class="close">&times;</span>-->
                            <div class="col-lg-12">

                                <div id="vdofile"></div>
                                <!--<p class="text-success semi-bold" id="demotext" style="font-size:18px"> File format not match. Please dragndrop .mp4 file </p>-->
                            </div>
                            <div class="col-lg-12">
                                <button class="btn btn-primary" onclick="closeVdoFile()">Close</button></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--</div>-->

    </body>
</html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>