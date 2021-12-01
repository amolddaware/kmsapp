<%-- 
    Document   : createuser
    Created on : Nov 16, 2017, 12:20:29 AM
    Author     : Amol
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.sql.Connection"%>
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

        <!-- Google Fonts -->
       <link href="css/font/materialicon.css" rel="stylesheet" type="text/css">
        <link href="css/font/googlefont.css" rel="stylesheet" type="text/css">

        <!-- Bootstrap Core Css -->
        <link href="plugins/bootstrap/css/bootstrap.css" rel="stylesheet">

        <!-- Waves Effect Css -->
        <link href="plugins/node-waves/waves.css" rel="stylesheet" />

        <!-- Animation Css -->
        <link href="plugins/animate-css/animate.css" rel="stylesheet" />

        <!-- Bootstrap Material Datetime Picker Css -->
        <link href="plugins/bootstrap-material-datetimepicker/css/bootstrap-material-datetimepicker.css" rel="stylesheet" />

        <!-- Bootstrap DatePicker Css -->
        <link href="plugins/bootstrap-datepicker/css/bootstrap-datepicker.css" rel="stylesheet" />

        <!-- Dropzone Css -->
        <!--<link href="plugins/dropzone/dropzone.css" rel="stylesheet"/>-->

        <!-- Bootstrap Select Css -->
        <link href="plugins/bootstrap-select/css/bootstrap-select.css" rel="stylesheet" />

        <!-- Custom Css -->
        <link href="css/style.css" rel="stylesheet" />

        <link href="css/jquery-ui.css" rel="stylesheet">
        <!-- AdminBSB Themes. You can choose a theme from css/themes instead of get all themes -->
        <link href="css/themes/all-themes.css" rel="stylesheet" />


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
        <!--        <script>
                    $(document).ready(function () {
                        // hash listener
                        $('#id_password').blur(function () {
                            var t = new Date();
                            hash = Sha1.hash($('#id_password').val());
                            $('#hash-time').html(((new Date() - t)) + 'ms');
                            $('#id_password').val(hash);
                        });
        
                        // show source code
                        $.get('//cdn.rawgit.com/chrisveness/crypto/c71aa49/sha1.js', function (data) {
                            var src = data.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;') // replace &, <, >
                            $('#src-code').html(src);
                            prettyPrint();
                        }, 'text');
                    });
                </script>-->
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
    <body class="theme-blue">
        <!--<div class="loader" style="display:none"></div>-->

        <!-- Page Loader -->
        <!--        <div class="page-loader-wrapper">
                    <div class="loader">
                        <div class="preloader">
                            <div class="spinner-layer pl-blue">
                                <div class="circle-clipper left">
                                    <div class="circle"></div>
                                </div>
                                <div class="circle-clipper right">
                                    <div class="circle"></div>
                                </div>
                            </div>
                        </div>
                        <p>Please wait...</p>
                    </div>
                </div>-->
        <!-- #END# Page Loader --> 
        <!-- Overlay For Sidebars -->
        <!--<div class="overlay"></div>-->
        <!-- #END# Overlay For Sidebars --> 
        <!-- Search Bar 	
        <div class="search-bar">
          <div class="search-icon"> <i class="material-icons">search</i> </div>
          <input type="text" placeholder="START TYPING...">
                <input type="text" id="date-start" placeholder="FROM DATE...">
                <input type="text" id="date-end" placeholder="TO DATE...">
          <div class="close-search"> <i class="material-icons">close</i> </div>
        </div>
        <!-- #END# Search Bar --> 
        <!-- Top Bar -->

        <jsp:include page="userHeader1.jsp"></jsp:include>
        <jsp:include page="left.jsp"></jsp:include>
            <section class="content">
                <div class="col-md-12"> 
                    <!-- Unordered List -->
                    <div class="row clearfix">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="card">
                                <div class="header">
                                    <h2>ADD NEW USER</h2>
                                    <ul class="header-dropdown m-r--5">
                                        <li class="dropdown"> <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="material-icons">more_vert</i> </a>
                                            <ul class="dropdown-menu pull-right">
                                                <li><a href="javascript:void(0);">Action</a></li>
                                                <li><a href="javascript:void(0);">Another action</a></li>
                                                <li><a href="javascript:void(0);">Something else here</a></li>
                                            </ul>
                                        </li>
                                    </ul>
                                </div>

                                <div class="body clearfix">
                                    <div class="col-md-10 col-lg-offset-1 well">
                                        <!-- Nav tabs -->
                                        <ul class="nav nav-tabs tab-nav-right" role="tablist">
                                            <li role="presentation" id="informationClass" class="active"><a href="#information" data-toggle="tab">INFORMATION</a></li>
                                            <!--<li role="presentation" id="tagClass"><a href="#tag" data-toggle="tab" onclick="this.disabled = true;">TAG</a></li>-->
                                        </ul>
                                        <!-- Tab panes -->
                                        <div class="tab-content">
                                            <div role="tabpanel" class="tab-pane fade in active" id="information">
                                                <!--<b>INFORMATION Content</b>-->
                                                <section>
                                                    <div>
                                                        <form class="form-horizontal m-t-50" action="<%=request.getContextPath()%>/createuser.do"  id="uploadform" method="post" accept-charset="UTF-8">
                                                        <input id="token" name="token" type="hidden" value="<%=token%>" />

                                                        <div class="form-group">
                                                            <label for="name" class="col-sm-3 control-label">Name  </label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" >
                                                                    <input type="text" class="form-control" name="name" autocomplete="off" id="name"  placeholder="Enter Name" required>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="emailid" class="col-sm-3 control-label">Email Id  </label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" >
                                                                    <input type="email" class="form-control" name="emailid" autocomplete="off" id="emailid"  placeholder="Enter Email Id" required>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="mobile" class="col-sm-3 control-label">Mobile No  </label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" >
                                                                    <input type="text" class="form-control" name="mobile" autocomplete="off" id="mobile" maxlength="10"  placeholder="Enter Mobile No" required>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="role" class="col-sm-3 control-label">Role  </label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" >
                                                                    <select  class="form-control" name="role" >
                                                                        <option value="-1">-Select Role-</option>
                                                                        <%   String selectRole = "";
                                                                            Connection dh = null;
                                                                            ConnectionDB conn = new ConnectionDB();
                                                                            dh = conn.getConnection();
                                                                            PreparedStatement pstmtRole = null;
                                                                            ResultSet rsRole = null;
                                                                            try {

                                                                                selectRole = "select * from role_master";
                                                                                //                                                                    System.out.println("selectdist:-" + dist);
                                                                                pstmtRole = dh.prepareStatement(selectRole);
                                                                                //                                                                                                pstmtDist.setString(1, dist);
                                                                                //                                        pstmtTal.setString(2, tal);
                                                                                rsRole = pstmtRole.executeQuery();
                                                                                while (rsRole.next()) {
                                                                                    //                                                                        System.out.println(rsDist.getString(1) + "==" + rsDist.getString(2));
                                                                                    out.println(" <option value=" + rsRole.getString(1) + ">" + rsRole.getString(2) + " </option>");
                                                                        %>


                                                                        <%}
                                                                            } catch (Exception e) {
                                                                                e.printStackTrace();
                                                                                System.out.println("Exception in Role master try catch block:-" + e.getMessage());

                                                                            } finally {
                                                                                if (pstmtRole != null) {
                                                                                    pstmtRole.close();
                                                                                }
                                                                                if (rsRole != null) {
                                                                                    rsRole.close();
                                                                                }
                                                                                if (dh != null) {
                                                                                    dh.close();
                                                                                }
                                                                            }
                                                                        %>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-sm-12 text-right">
                                                                <button type="submit" class="btn btn-danger" data-toggle="modal" data-target="#defaultModal" onclick="saveData()" id="btnSaveVideo"  >CREATE</button>
                                                            </div>
                                                        </div>

                                                    </form>
                                                </div>
                                            </section>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div class="modal  m-t-125" id="myModel1" tabindex="-1" role="dialog" style="display: none">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <!--<h4 class="modal-title text-center" id="defaultModalLabel">User Creation</h4>-->
                    </div>
                    <div class="modal-body text-center">
                        <!--<div id="sameEntryExist" class="text-danger"></div>-->
                      
                        <p class="text-success semi-bold" style="font-size:18px">User Created Successfully </p>

                        <!--<iframe width="560" height="315" src="https://www.youtube.com/embed/u3xKgwKUQLc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>-->
                    </div>
                    <div class="modal-footer">
                        <!--<a >TAG</a>-->
                        <a href="createuser.jsp"> <button type="button" class="btn btn-link waves-effect"  data-dismiss="#myModel1" onclick="closeDiv1()">CLOSE</button></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Jquery Core Js --> 
        <!--<script src="plugins/jquery/jquery.min.js"></script>--> 
        <script src="js/jquery-1.12.4.js"></script>
        <!--<script src="plugins/jquery/jquery.min.js"></script>-->
        <script src="js/jquery-ui.js"></script>
        <!-- Bootstrap Core Js --> 
        <script src="plugins/bootstrap/js/bootstrap.js"></script> 

        <!--Select Plugin Js-->  
        <!--<script src="plugins/bootstrap-select/js/bootstrap-select.js"></script>--> 

        <!--Slimscroll Plugin Js-->  
        <script src="plugins/jquery-slimscroll/jquery.slimscroll.js"></script> 

        <!--Bootstrap Colorpicker Js-->  
        <script src="plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script> 

        <!-- Dropzone Plugin Js --> 
        <script src="plugins/dropzone/dropzone.js"></script> 

        <!-- Jquery Validation Plugin Css --> 
        <!----> 
        <!--<script>$.noConflict(true)</script>-->

        <!--<script src="plugins/jquery-validation/jquery.validate.js"></script>-->

        <!-- JQuery Steps Plugin Js --> 
        <!--<script src="plugins/jquery-steps/jquery.steps.js"></script>--> 

        <!-- Waves Effect Plugin Js --> 
        <script src="plugins/node-waves/waves.js"></script> 

        <!--Autosize Plugin Js--> 
        <script src="plugins/autosize/autosize.js"></script>

        <!--Moment Plugin Js--> 
        <script src="plugins/momentjs/moment.js"></script>

        <!--Bootstrap Material Datetime Picker Plugin Js--> 
        <script src="plugins/bootstrap-material-datetimepicker/js/bootstrap-material-datetimepicker.js"></script>

        <!--Bootstrap Datepicker Plugin Js--> 
        <script src="plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>

        <!-- Custom Js -->
<!--        <script src="js/admin.js"></script> 
        <script src="js/pages/forms/form-validation.js"></script> 
        <script src="js/pages/forms/form-wizard.js"></script> -->
        <!--<script src="js/pages/forms/basic-form-elements.js"></script>--> 
        <!--<script src="js/pages/forms/advanced-form-elements.js"></script>--> 

        <!--Demo Js-->  
        <script src="js/demo.js"></script>
        <script>
                                $(document).ready(function () {
                                    if (window.location.href.indexOf("success") > -1) {
//alert("test");
                                        document.getElementById('myModel1').style.display = "block";

                                        var span = document.getElementsByClassName("close")[0];
//                    span.onclick = function () {
//                        modal.style.display = "none";
//                    };
//                    window.onclick = function (event) {
//                        if (event.target == modal) {
//                            modal.style.display = "none";
//                        }
//                    };
                                    }
                                });
        </script>
    </body>
</html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>