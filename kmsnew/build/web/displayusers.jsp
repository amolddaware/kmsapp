<%-- 
    Document   : home
    Created on : Nov 15, 2017, 11:30:13 PM
    Author     : Amol
--%>

<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<jsp:forward page="admin_homepage.jsp"></jsp:forward>--%>
<%ResourceBundle rb = ResourceBundle.getBundle("msg");
//    String role = session.getAttribute("role").toString();
    if (session != null && session.getAttribute("username") != null && session.getAttribute("role").equals("1")) {
        String username = session.getAttribute("username").toString();
        String userid = session.getAttribute("userid").toString();

%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title><%=rb.getString("title")%></title>
        <!-- Required meta tags -->
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

    <body class="theme-blue">


        <jsp:include page="userHeader1.jsp"></jsp:include>
        <jsp:include page="left.jsp"></jsp:include>
            <!--<div class=" container-scroller">-->
            <!--Navbar-->
        <%--<jsp:include page="header.jsp"></jsp:include>--%>
        <!--End navbar-->
        <section class="content">
            <div class="col-md-12"> 
                <!-- Unordered List -->
                <div class="row clearfix">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="card">
                            <div class="header">
                                <h2>Display Users</h2>
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
                                <div class="table-responsive">
                                    <table class="table center-aligned-table">
                                        <thead>
                                            <tr class="text-primary">
                                                <th>Sr.No</th>
                                                <th>Name</th>
                                                <!--<th>Username</th>-->
                                                <th>Email Id</th>
                                                <th>Mobile No</th>
                                                <th>Role</th>
                                                <th>Status</th>
                                                <!--                                                            <th>Price</th>
                                                                                                            <th></th>
                                                                                                            <th></th>-->
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                Connection dh = null;
                                                String logintime = "";
                                                ConnectionDB conn = new ConnectionDB();
                                                dh = conn.getConnection();
                                                int number = 0;
                                                String selectData = "select * from createuser ";
                                                PreparedStatement pstmtData = dh.prepareStatement(selectData);
                                                ResultSet rsData = pstmtData.executeQuery();
                                                while (rsData.next()) {
                                                    number++;
                                                    System.out.println(rsData.getString("role"));
//                                                            if(!rsData.getString("role").equals("1")){}else if (rsData.getString("role").equals("3") || rsData.getString("role").equals("2")){
                                            %>

                                            <tr class="">
                                                <td><%=number%></td>
                                                <td><%=rsData.getString("name")%></td>
                                                <td><%=rsData.getString("emailid")%></td>
                                                <td><%=rsData.getString("mobileno")%></td>
                                                <td>
                                                    <%
                                                        if (rsData.getString("role").equals("1")) {
                                                            out.println("SuperAdmin");
                                                        } else {
                                                            out.println("User");
                                                        }
                                                    %></td>
                                                <td>
                                                        <%
                                                            if (rsData.getString("status").equals("1")) {
                                                        %><label class="badge badge-success"><%
                                                                    out.println("Active");%></label>

                                                    <%} else if (rsData.getString("status").equals("0")) {
                                                    %>
                                                        <label class="badge badge-danger "><%
                                                                    out.println("Inactive");%></label>
                                                        <%
                                                            }
                                                        %></td>
                                                <!--<td><label class="badge badge-success">Active</label></td>-->
                                                <!--<td><a href="#" class="btn btn-primary btn-sm">Reset Password</a></td>-->
                                                <!--<td><a href="#" class="btn btn-danger btn-sm">Remove</a></td>--> 
                                            </tr>
                                            <%}
//    }

                                            %>
                                            <!--                                                <tr class="">
                                                                                                <td>1</td>
                                                                                                <td>Amol</td>
                                                                                                <td>amoldaware@ymail.com</td>
                                                                                                <td>9762483918</td>
                                                                                                <td>User</td>
                                                                                                <td><label class="badge badge-success">Active</label></td>
                                                                                                <td><a href="#" class="btn btn-primary btn-sm">Reset Password</a></td>
                                                                                                <td><a href="#" class="btn btn-danger btn-sm">Remove</a></td> 
                                                                                            </tr>
                                                                                            <tr class="">
                                                                                                <td>2</td>
                                                                                                <td>Prasad</td>
                                                                                                <td>prasad.bhoi@gov.in</td>
                                                                                                <td>9765947239</td>
                                                                                                <td>User</td>
                                                                                                <td><label class="badge badge-danger">Block</label></td>
                                                                                                <td><a href="#" class="btn btn-primary btn-sm">Reset Password</a></td>
                                                                                                <td><a href="#" class="btn btn-danger btn-sm">Remove</a></td> 
                                                                                            </tr>-->

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
                                            
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
</body>

</html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>