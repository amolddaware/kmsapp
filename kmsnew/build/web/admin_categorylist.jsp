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
<%--<jsp:forward page="dashboard.jsp"></jsp:forward>--%>
<%ResourceBundle rb = ResourceBundle.getBundle("msg"); %>
<%
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("1"))) {

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
        <!--<link rel="stylesheet" href="css/styledropdown.css" />-->
        <link rel="stylesheet" href="css/style.css" />
        <!--<link rel="stylesheet" href="css/extra.css" />-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery.perfect-scrollbar/0.8.1/css/perfect-scrollbar.min.css" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
        <link rel="shortcut icon" href="images/Maharastra1.jpg" />

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap.min.css">
        <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>-->
        <!--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>-->
        <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
        <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap.min.js"></script>
        <!--<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>-->
        <!--<script src="js/jquery-1.11.2.js"></script>-->
        <script>
            $(document).ready(function () {
                $('#example').DataTable();
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
            //jQuery(function(){
            //$("#generaltag").autocomplete("list.jsp");
            //});
        </script>
        <script type="text/javascript">

            function openPage(pageName, elmnt, color) {
                //alert(pageName);
                var i, tabcontent, tablinks;
                tabcontent = document.getElementsByClassName("tabcontentData");
                for (i = 0; i < tabcontent.length; i++) {
                    tabcontent[i].style.display = "none";
                }
                tablinks = document.getElementsByClassName("tablink");
                for (i = 0; i < tablinks.length; i++) {
                    tablinks[i].style.borderBottom = "";
                }
                document.getElementById(pageName).style.display = "block";
                elmnt.style.borderBottom = "2px solid  " + color;

            }
            // Get the element with id="defaultOpen" and click on it
            document.getElementById("defaultOpen").click();
        </script>
        <script>
            function showData() {
//                alert("test");
                var xmlhttp;
                var subject = document.getElementById("generaltag").value;
                var fromDate = document.getElementById("fromDate").value;
                var toDate = document.getElementById("toDate").value;
// var checkboxes = document.getElementsByName("chkkms");
//  var checkboxesChecked = [];
                var checkedBoxes;
                var array = [];
                $('input[type="checkbox"]:checked').each(function () {
                    array.push($(this).val());
                });
                if (subject != "") {
                    if (window.XMLHttpRequest)
                    {// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp = new XMLHttpRequest();
                    } else
                    {// code for IE6, IE5
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
//                    var urls = "grid_all_data.jsp?generaltag=" + subject + "&fromdate=" + fromDate + "&todate=" + toDate;
//                    var urls = "fetchdata_new_1.jsp?generaltag=" + subject;
//                alert(urls);
                    xmlhttp.onreadystatechange = function ()
                    {
                        if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                        {
                            var resp = xmlhttp.responseText;
//                        alert(resp);

                            document.getElementById("fetchData").innerHTML = resp;

                            document.getElementById("generaltag1").value = subject;
                            document.getElementById("fromDate1").value = fromDate;
                            document.getElementById("toDate1").value = toDate;

//                        selectVillage();
//            diseaseType();
                        }
                    };
//    xmlhttp.open("GET", urls, true);
                    xmlhttp.open("POST", "grid_category_all_data.jsp?generaltag=" + subject + "&fromdate=" + fromDate + "&todate=" + toDate + "&searchresult=" + array.join(','), true);
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
            function closeDeleteDiv() {
                document.getElementById("displayDeleteFile").style.display = "none";
            }
//            function closeDeleteDivConfirm() {
//                window.location.href="admin_dataentry_edit.jsp";
//                
////                document.getElementById("deleteFileConfirm").style.display = "none";
//                            }
            function showDeleteWorkcode(file) {
                document.getElementById("displayDeleteFile").style.display = "block";
//                alert(file);
                document.getElementById("idDeleteWorkcode").value = file;
                document.getElementById("deleteWorkcode").innerHTML = file;
            }
            function deleteWorkcode() {
//
                var workcode = document.getElementById("idDeleteWorkcode").value;
                var xhttp = new XMLHttpRequest();
//alert("hi");
                var urls = "deletecategory.do?workcode=" + workcode;
                xhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        document.getElementById("deleteFileConfirm").style.display = "block";
                        document.getElementById("displayDeleteFile").style.display = "none";

//                        document.getElementById("vdofile").innerHTML = this.responseText;
                    }
                };
                xhttp.open("POST", urls, true);
                xhttp.send();
            }
        </script>

        <script>
            function showAllGraphicsData() {
                alert("tredteas:-");
//                var x = document.getElementsByName("chkkms");

//  var coffee = document.forms[0];
                var txt = "";
                var i;
                for (i = 0; i < x.length; i++) {
                    if (x[i].checked) {
                        txt = txt + x[i].value + " ";
                    }
                }
                alert("txt:-" + );
//  document.getElementById("order").value = "You ordered a coffee with: " + txt;
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


    </head>

    <body>
        <!--<div id="txtAge" style="display:none">Age is something</div>-->
        <div class=" container-scroller">
            <!--Navbar-->
            <jsp:include page="header.jsp"></jsp:include>

                <!--End navbar-->
                <div class="container-fluid" style="background-color:#f2f7f8">
                    <div class="row row-offcanvas row-offcanvas-right">
                    <%--<jsp:include page="userLeft.jsp"></jsp:include>--%>
                    <!-- SIDEBAR ENDS -->
                    <%String getData = null, searchQuery = null, room = null, link = null;

                        String sql = "SELECT * FROM tbl_category_master  ";
                        //String sql = "Select subject,graphicspath,vdopath,docpath,audiopath  WHERE MATCH (subject, description, summary,general,teletag,districttag,talukatag,villagetag,additionaltag)  AGAINST ('" + subject + "' )";
                        //            String sql = "Select subject,graphicspath,vdopath,docpath,audiopath from tbl_news_dataentry where workcode =?";
                        System.out.println("sql:-" + sql);
                        PreparedStatement stm = ConnectionDB.getDBConnection().prepareStatement(sql);
                        //            stm.setString(1, s);
                        ResultSet rs = stm.executeQuery();
                        int number = 0;
                    %>

                    <div class="content-wrapper " >
                        <!--<div class="container">-->
                        <table id="example" class="table table-striped table-bordered" style="width:100%">
                            <thead>
                            <th colspan="9" class="text-center">
                            <h4><b>Category List</b></h4>
                            </th>
                            <tr>
                                <th>Sr.No</th>
                                <th>Category name</th>
                                <th>Edit </th>
                                <th>Delete </th>
                            </tr>
                            </thead>
                            <tbody>
                                <%
                                    while (rs.next()) {
                                        number++;

                                %>
                                <tr>
                                    <td><%=number%></td>
                                    <td><%=rs.getString("category_name")%></td>

                                    <td class="text-center" ><a href="admin_categoryedit.jsp?num=<%=rs.getString("idtbl_category_master")%>" title="Click Here" style="cursor: pointer" ><i class="fa fa-edit text-success"></i></a></td>
                                    <td class="text-center" ><a onclick="showDeleteWorkcode('<%=rs.getString("idtbl_category_master")%>')" title="Click Here" style="cursor: pointer"  ><i class="fa fa-remove text-danger"></i></a></td>

                                    <%--<td class="text-center" ><a href="deleteentry.do?workcode=<%=rs.getString("workcode")%>" title="Click Here"  ><i class="fa fa-remove text-danger"></i></a></td>--%>
                                </tr>
                                <%}%>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <th>Sr.No</th>
                                    <th>Category name</th>
                                    <th>Edit </th>
                                    <th>Delete </th>
                                </tr>
                            </tfoot>
                        </table>
                        <!--</div>-->

                    </div>
                    <div id="displayDeleteFile" class="modal" style="display: none">
                        <!-- Modal content -->
                        <div class="modal-content">
                            <div class="row mb-2 text-center">
                                <!--<span class="close">&times;</span>-->

                                <div class="col-lg-12">
                                    <p class="text-danger semi-bold" style="font-size:18px">Do you want delete ? </p>
                                    <input type="hidden" name="deleteWorkcode" id="idDeleteWorkcode">
                                    <!--<p class="text-success semi-bold" id="demotext" style="font-size:18px"> File format not match. Please dragndrop .mp4 file </p>-->
                                </div>
                                <div class="col-lg-12">
                                    <button class="btn btn-primary" onclick="deleteWorkcode()">Delete</button></a>
                                    <button class="btn btn-danger" onclick="closeDeleteDiv()">cancel</button></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="deleteFileConfirm" class="modal" style="display: none">
                        <!-- Modal content -->
                        <div class="modal-content">
                            <div class="row mb-2 text-center">
                                <!--<span class="close">&times;</span>-->

                                <div class="col-lg-12">
                                    <p class="text-success semi-bold" style="font-size:18px">Record deleted successfully!</p>
                                    <!--<p class="text-success semi-bold" id="demotext" style="font-size:18px"> File format not match. Please dragndrop .mp4 file </p>-->
                                </div>
                                <div class="col-lg-12">
                                    <!--<button class="btn btn-primary" onclick="////deleteWorkcode()">Delete</button></a>-->
                                    <a href="admin_categorylist.jsp"> <button class="btn btn-primary">Close</button></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <!--</div>-->
            <!--<script src="js/jquery-ui.js"></script>-->
            <!--<script src="js/jquery-ui.js" type="text/javascript"></script>-->
            <!--Load SCRIPT.JS which will create datepicker for input field-->  
            <script src="js/script.js" type="text/javascript"></script>
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
            <script type="text/javascript">

                function DropDown(el) {
                    this.dd = el;
                    this.placeholder = this.dd.children('span');
                    this.opts = this.dd.find('ul.dropdown > li');
                    this.val = '';
                    this.index = -1;
                    this.initEvents();
                }
                DropDown.prototype = {
                    initEvents: function () {
                        var obj = this;

                        obj.dd.on('click', function (event) {
                            $(this).toggleClass('active');
                            return false;
                        });

                        obj.opts.on('click', function () {
                            var opt = $(this);
                            obj.val = opt.text();
                            obj.index = opt.index();
                            obj.placeholder.text(obj.val);
                        });
                    },
                    getValue: function () {
                        return this.val;
                    },
                    getIndex: function () {
                        return this.index;
                    }
                }

                $(function () {

                    var dd = new DropDown($('#dd'));

                    $(document).click(function () {
                        // all dropdowns
                        $('.wrapper-dropdown-3').removeClass('active');
                    });

                });

            </script>
            <!--<script src="js/jquery.multiselect.js"></script>-->

            <!--<script src="https://code.jquery.com/jquery-1.12.4.js"></script>-->
            <!--<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>-->
            <!--             <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
                    <script src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap.min.js"></script>-->

    </body>
</html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>