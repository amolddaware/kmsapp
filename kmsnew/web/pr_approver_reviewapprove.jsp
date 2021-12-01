<%-- 
    Document   : home
    Created on : Nov 15, 2017, 11:30:13 PM
    Author     : Amol
--%>

<%@page import="java.util.Arrays"%>
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<jsp:forward page="dashboard.jsp"></jsp:forward>--%>
<%ResourceBundle rb = ResourceBundle.getBundle("msg"); %>
<%
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("5"))) {

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
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <title><%=rb.getString("title")%></title>

        <!-- Favicon-->
      <link rel="icon" href="images/favicon.ico" type="image/x-icon">
    <!-- Google Fonts -->
        <link href="css/font/materialicon.css" rel="stylesheet" type="text/css">
        <link href="css/font/googlefont.css" rel="stylesheet" type="text/css">


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

        <!-- AdminBSB Themes. You can choose a theme from css/themes instead of get all themes -->
        <link href="css/themes/all-themes.css" rel="stylesheet" />


        <link href="css/jquery-ui.css" rel="stylesheet">


        <script>
            function savePrintMediaApproverTagData(val, id, workcode) {
//                                alert(val);
                var a = document.getElementById(val).value;
//                                alert(a);
                window.location.href = "<%=request.getContextPath()%>/approvertagupdate.do?tag=" + a + "&id=" + id + "&workcode=" + workcode;
//                var xmlhttp;
//               
//                    if (window.XMLHttpRequest)
//                    {// code for IE7+, Firefox, Chrome, Opera, Safari
//                        xmlhttp = new XMLHttpRequest();
//                    } else
//                    {// code for IE6, IE5
//                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
//                    }
//                    xmlhttp.onreadystatechange = function ()
//                    {
//                        if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
//                        {
//                            var resp = xmlhttp.responseText;
//                            document.getElementById("fetchData").innerHTML = resp;
//                            
//                        }
//                    };
//                    xmlhttp.open("POST", urls, true);
//                    xmlhttp.send();

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
            function displayVdoFilesData(file) {
                var xhttp = new XMLHttpRequest();
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

        <script>
            function showAllGraphicsData() {
                var txt = "";
                var i;
                for (i = 0; i < x.length; i++) {
                    if (x[i].checked) {
                        txt = txt + x[i].value + " ";
                    }
                }
            }
        </script>
        <script>
            function editData(val) {
//                alert(val);
                document.getElementById(val).readOnly = false;
                var a = document.getElementById(val);

                a.classList.remove("txtEditHidden");
                a.className += " txtEdit";
            }
        </script>
        <style>
            .txtEditHidden{
                background: transparent;border: transparent; width:100%;display: block;font-size:1.2rem;border: none;border-radius: 3px;padding: 12px 6px;line-height: 1.428571429;color: green;font-weight: 600;vertical-align: middle;
            }
            .txtEdit{
                width:100%;display: block;font-size:1.2rem;border-radius: 3px;padding: 12px 6px;line-height: 1.428571429;color: #000;vertical-align: middle;background-color: #fff;border: 0.5px solid  #00b8e6 ;-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,0.075); box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);-webkit-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            }
        </style>
    </head>
    <body class="theme-blue">
        <div class="overlay"></div>
        <!-- #END# Overlay For Sidebars --> 
        <!-- Top Bar -->
        <!--        <nav class="navbar">
                    <div class="container-fluid">
                        <div class="navbar-header"> <a href="javascript:void(0);" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse" aria-expanded="false"></a> <a href="javascript:void(0);" class="bars"></a> <a class="navbar-brand" href="index.html"><img class="img-responsive" width="120px" src="images/logo.png"></a> </div>
                        <div class="collapse navbar-collapse" id="navbar-collapse">
                            <ul class="nav navbar-nav navbar-right">
                                 Call Search 
                                <li><a class="search_input">
                                        <input type="text" class="form-control" placeholder="START TYPING...">
                                    </a></li>
                                <li><a class="search_input">
                                        <input type="text" id="date-start" class="form-control" placeholder="FROM DATE...">
                                    </a></li>
                                <li><a class="search_input">
                                        <input type="text" id="date-end" class="form-control" placeholder="TO DATE...">
                                    </a></li>
                                <li><a href="search_list.html" class="js-search" data-close="true"><i class="material-icons">search</i></a></li>
                                 #END# Call Search 
                            </ul>
                        </div>
                    </div>
                </nav>-->

        <jsp:include page="pr_header.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

            <!-- SIDEBAR ENDS -->
        <%
               Connection dh = null;
            String logintime = "";
            ConnectionDB conn = new ConnectionDB();
            dh = conn.getConnection();
            String getData = null, searchQuery = null, room = null, link = null;

            int number = 1;
            String sql1 = "SELECT a.workcode as workcode,a.subject,a.titlemarathi,b.idtbl_temp_tag_master as idtbl_temp_tag_master,b.tag as tag FROM ((tbl_temp_print_tag_master b inner join tbl_news_dataentry a on a.workcode=b.workcode) left join tbl_tag_master c on  b.tag!= c.tag ) where b.workcode like  ?  group by b.tag";
            System.out.println("sql:-" + sql1);
            PreparedStatement stm1 = dh.prepareStatement(sql1);
            stm1.setString(1, "%P%");
            ResultSet rs1 = stm1.executeQuery();
            int number1 = 0;

        %>

        <section class="content">
            <div class="col-md-12"> 
                <!-- Unordered List -->
                <div class="row clearfix">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="card">
                            <div class="header">
                                <h2>Review / Approve Tag Print Media</h2>
<!--                                <ul class="header-dropdown m-r--5">
                                    <li class="dropdown"> <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="material-icons">more_vert</i> </a>
                                        <ul class="dropdown-menu pull-right">
                                            <li><a href="javascript:void(0);">Action</a></li>
                                            <li><a href="javascript:void(0);">Another action</a></li>
                                            <li><a href="javascript:void(0);">Something else here</a></li>
                                        </ul>
                                    </li>
                                </ul>-->
                            </div>
                            <div class="body clearfix">
                                <div class="table-responsive">

                                    <!--<table class="table table-bordered table-striped table-hover dataTable">-->
                                    <table  id="example" class="table table-bordered table-striped table-hover ">
                                    <!--<table  id="example" class="table table-bordered table-striped table-hover dataTable js-exportable">-->

                                        <thead>
                                        <th colspan="8" class="text-center">
                                            <h4><b>Review / Approve Tag</b></h4>
                                        </th>
                                        <tr align="center">
                                            <th class="text-center"  align="center">Sr.No</th>
                                            <th>Dataentry Reference no</th>
                                            <th>Title</th>
                                            <th>Title (Marathi)</th>
                                            <th class="text-center" style="width:100px" align="center">New Tag</th>
                                            <th class="text-center" align="center">Edit</th>
                                            <th class="text-center" align="center">Save</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                            <%    while (rs1.next()) {
                                            %>
                                            <tr>
                                                <td><%=number++%></td>
                                                <td><%=rs1.getString("workcode")%></td>
                                                <td><%=rs1.getString("subject")%></td>
                                                <td><%=rs1.getString("titlemarathi")%></td>
                                                <td >
                                                    <input type="text" class="text-success txtEditHidden"  value="<%=rs1.getString("tag")%>" id="tag<%=rs1.getString("idtbl_temp_tag_master")%>" name="tag[]" readonly="true">
                                                </td>
                                                <td align="center"> <a onclick="editData('tag<%=rs1.getString("idtbl_temp_tag_master")%>')" class="cursorpointer" ><i class="material-icons" style="font-size:20px;color: green;cursor: pointer">edit</i></a> </td>
                                                <td align="center">  <a onclick="savePrintMediaApproverTagData('tag<%=rs1.getString("idtbl_temp_tag_master")%>', '<%=rs1.getString("idtbl_temp_tag_master")%>', '<%=rs1.getString("workcode")%>')" class="cursorpointer" ><i class="material-icons" style="font-size:20px;color:#15B2FE;cursor: pointer ">save</i></td>
                                            </tr>
                                            <%}%>
                                        </tbody> </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- #END# Unordered List --> 
            </div>
        </section>
        <script src="js/jquery-1.12.4.js"></script>
        <!--<script src="plugins/jquery/jquery.min.js"></script>-->
        <script src="js/jquery-ui.js"></script>

        <!-- Bootstrap Core Js --> 
        <script src="plugins/bootstrap/js/bootstrap.js"></script> 

        <!-- Select Plugin Js --> 
        <script src="plugins/bootstrap-select/js/bootstrap-select.js"></script> 

        <!-- Slimscroll Plugin Js --> 
        <script src="plugins/jquery-slimscroll/jquery.slimscroll.js"></script> 

        <!-- Bootstrap Colorpicker Js --> 
        <script src="plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script> 

        <!-- Dropzone Plugin Js --> 
        <script src="plugins/dropzone/dropzone.js"></script> 

        <!-- Jquery Validation Plugin Css --> 
        <script src="plugins/jquery-validation/jquery.validate.js"></script> 

        <!-- JQuery Steps Plugin Js --> 
        <script src="plugins/jquery-steps/jquery.steps.js"></script> 

        <!-- Waves Effect Plugin Js --> 
        <script src="plugins/node-waves/waves.js"></script> 

        <!-- Autosize Plugin Js --> 
        <script src="plugins/autosize/autosize.js"></script> 

        <!-- Moment Plugin Js --> 
        <script src="plugins/momentjs/moment.js"></script> 

        <!-- Bootstrap Material Datetime Picker Plugin Js --> 
        <script src="plugins/bootstrap-material-datetimepicker/js/bootstrap-material-datetimepicker.js"></script>

        <!-- Bootstrap Datepicker Plugin Js --> 
        <script src="plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script> 

        <!-- Jquery DataTable Plugin Js -->
      
        <script src="plugins/jquery-datatable/jquery.dataTables.js"></script>
        <script src="plugins/jquery-datatable/skin/bootstrap/js/dataTables.bootstrap.js"></script>
        <script src="plugins/jquery-datatable/extensions/export/dataTables.buttons.min.js"></script>
        <script src="plugins/jquery-datatable/extensions/export/buttons.flash.min.js"></script>
        <script src="plugins/jquery-datatable/extensions/export/jszip.min.js"></script>
        <script src="plugins/jquery-datatable/extensions/export/pdfmake.min.js"></script>
        <script src="plugins/jquery-datatable/extensions/export/vfs_fonts.js"></script>
        <script src="plugins/jquery-datatable/extensions/export/buttons.html5.min.js"></script> 
        <script src="plugins/jquery-datatable/extensions/export/buttons.print.min.js"></script>
    
  <script>
//      $("#example").dataTable().fnDestroy();
        $('#example').DataTable({
//      bDestroy: true,     
//    searching: false,
            dom: 'Bfrtip',
            buttons: [
                {
                    extend: 'excelHtml5',
                    title: 'Media Monitoring Sheet',
                    orientation: 'landscape',
                    pageSize: 'LEGAL',
                  className: 'btn btn-primary btn-user btn-capsules btn-sm mob-btn btnExcel',
                    //                    background: '#0053ba'
                },
                {
                    extend: 'csvHtml5',
                    title: 'Media Monitoring Sheet',
                    orientation: 'landscape',
                    pageSize: 'LEGAL',
                    className: 'btn btn-success btn-user btn-capsules btn-sm mob-btn btnExcel',
//                }, {
//                    extend: 'pdfHtml5',
//                    title: 'Media Monitoring Sheet',
//                    orientation: 'landscape',
//                    pageSize: 'LEGAL',
//                    className: 'btn btn-danger btn-user btn-capsules btn-sm mob-btn btnExcel',
                }
            ]
        });
//          $('.dataTable').DataTable({
//              paging: false,
//            searching: false,
//            destroy: true
//        }
//        );
        </script>
        <!-- Custom Js -->
        <script src="js/admin.js"></script>
        <script src="js/pages/tables/jquery-datatable.js"></script>
        <script src="js/pages/forms/form-validation.js"></script> 
        <script src="js/pages/forms/form-wizard.js"></script> 
        <!--        <script src="js/pages/forms/basic-form-elements.js"></script> 
                <script src="js/pages/forms/advanced-form-elements.js"></script> -->

        <!-- Demo Js --> 
        <script src="js/demo.js"></script> 
        
    </body>
</html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>