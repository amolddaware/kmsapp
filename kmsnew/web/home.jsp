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
<jsp:forward page="adminHomepage.jsp"></jsp:forward>
<%ResourceBundle rb = ResourceBundle.getBundle("msg");
//    String role = session.getAttribute("role").toString();
    if (session != null && session.getAttribute("username") != null && session.getAttribute("role").equals("1")) {
        String username = session.getAttribute("username").toString();
        String userid = session.getAttribute("userid").toString();

%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title><%=rb.getString("title")%></title>
        
        <link rel="icon" href="images/favicon.ico" type="image/x-icon">
        <!--        <link rel="stylesheet" href="node_modules/font-awesome/css/font-awesome.min.css" />
                <link rel="stylesheet" href="node_modules/perfect-scrollbar/dist/css/perfect-scrollbar.min.css" />-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery.perfect-scrollbar/0.8.1/css/perfect-scrollbar.min.css" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
        <link href="css/jquery-ui.css" rel="stylesheet">
        <!--<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />-->
        <link href="css/jquery.multiselect.css" rel="stylesheet" />
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <link href="http://cdn.rawgit.com/davidstutz/bootstrap-multiselect/master/dist/css/bootstrap-multiselect.css"  rel="stylesheet" type="text/css" />
        <script src="js/jquery.multiselect.js"></script>
        <link rel="stylesheet" href="css/style.css" />
        <link rel="shortcut icon" href="images/Maharashtra1.jpg" />
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
        <div class=" container-scroller">
            <!--Navbar-->
            <jsp:include page="header.jsp"></jsp:include>
                <!--End navbar-->
                <div class="container-fluid">
                    <div class="row row-offcanvas row-offcanvas-right">
                    <%--<jsp:include page="left.jsp"></jsp:include>--%>
                    <!-- SIDEBAR ENDS -->


                    <div class="content-wrapper">

                        <div class="row mb-2">
                            <div class="col-lg-12">
                                <div class="card">
                                    <div class="card-block">
                                        <h5 class="card-title mb-4">System Users</h5>
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
                                                        <!--<th>Price</th>-->
                                                        <th></th>
                                                        <th></th>
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
                                                        <td><a href="#" class="btn btn-danger btn-sm">Remove</a></td> 
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
                    <jsp:include page="footer.jsp"></jsp:include>

                    </div>

                </div>
            </div>

            <!--                <script src="node_modules/jquery/dist/jquery.min.js"></script>
                            <script src="node_modules/tether/dist/js/tether.min.js"></script>
                            <script src="node_modules/bootstrap/dist/js/bootstrap.min.js"></script>
                            <script src="node_modules/bootstrap-select/js/bootstrap-select.js"></script>
                            <script src="js/bootstrap-select.js"></script>
                            <script src="node_modules/chart.js/dist/Chart.min.js"></script>
                            <script src="node_modules/perfect-scrollbar/dist/js/perfect-scrollbar.jquery.min.js"></script>
                            <script src="js/off-canvas.js"></script>
                            <script src="js/hoverable-collapse.js"></script>
                            <script src="js/misc.js"></script>-->
        </body>
        <script>
            $(function () {
                $('select[multiple].active.3col').multiselect({
                    columns: 1,
                    placeholder: 'Select Category',
                    search: true,
                    searchOptions: {
                        'default': 'Search Category'
                    },
                    selectAll: true
                });

            });
        </script>
    </html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>