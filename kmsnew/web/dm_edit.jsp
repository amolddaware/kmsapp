<%-- 
    Document   : dragndrop1
    Created on : Dec 18, 2017, 8:34:23 PM
    Author     : Amol
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%ResourceBundle rb = ResourceBundle.getBundle("msg");%>

<%
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("6") || session.getAttribute("role").equals("3") || session.getAttribute("role").equals("4") || session.getAttribute("role").equals("5"))) {

//    String role = session.getAttribute("role").toString();
//    if (session != null && session.getAttribute("username") != null && session.getAttribute("role").equals("3")) {
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
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title><%=rb.getString("title")%></title>
        <link rel=icon href=images/favicon.ico type=image/x-icon>

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
        <link href="plugins/dropzone/dropzone.css" rel="stylesheet"/>

        <!-- Bootstrap Select Css -->
        <link href="plugins/bootstrap-select/css/bootstrap-select.css" rel="stylesheet" />

        <!-- Custom Css -->
        <link href="css/style.css" rel="stylesheet" />

        <!-- AdminBSB Themes. You can choose a theme from css/themes instead of get all themes -->
        <link href="css/themes/all-themes.css" rel="stylesheet" />

        <link href="css/jquery-ui.css" rel="stylesheet">

    </head>

    <body class="theme-blue">


        <% if (session.getAttribute("role").equals("5")) {%>
        <jsp:include page="userHeader1.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <%} else if (session.getAttribute("role").equals("6")) {%>
        <jsp:include page="dm_header.jsp"></jsp:include>
        <jsp:include page="dm_left.jsp"></jsp:include>
        <%}%>     <!--<div class=" container-scroller">-->
        <!--Navbar-->


        <section class="content">
            <div class="col-md-12"> 
                <!-- Unordered List -->
                <div class="row clearfix">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="card">
                            <div class="header">
                                <h2>DIGITAL MEDIA EDIT INFORMATION (<%=request.getParameter("workcode")%>)</h2>
                                <ul class="header-dropdown m-r--5">
                                    <li class="dropdown"> <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">  </a>
                                        <!--                                            <ul class="dropdown-menu pull-right">
                                                                                        <li><a href="javascript:void(0);">Action</a></li>
                                                                                        <li><a href="javascript:void(0);">Another action</a></li>
                                                                                        <li><a href="javascript:void(0);">Something else here</a></li>
                                                                                    </ul>-->
                                        <button type="button" class="btn btn-link waves-effect"  data-dismiss="#myModel1" onclick="goBack()">BACK</button>   

                                    </li>
                                </ul>
                            </div>
                            <div class="body clearfix">
                                <div class="col-md-10 col-lg-offset-1 well">
                                    <div id="wizard_horizontal">
                                        <%--<h2>Information (<%=request.getParameter("workcode")%>)</h2>--%>
                                        <section>
                                            <div>
                                                <form class="form-horizontal m-t-10" action="<%=request.getContextPath()%>/updatedigitalmedia.do"  id="uploadform" method="post" accept-charset="UTF-8" enctype="multipart/form-data">
                                                    <%Connection dh = null;
                                                        ConnectionDB connectionDB = new ConnectionDB();
                                                        dh = connectionDB.getConnection();
                                                        String subject = "", description = "", date = "";
                                                        System.out.println("workcode:-" + request.getParameter("workcode"));
                                                        String selectData = "Select * from tbl_news_dataentry where workcode=?";
                                                        PreparedStatement pstmt = dh.prepareStatement(selectData);
                                                        pstmt.setString(1, request.getParameter("workcode"));
                                                        ResultSet rs = pstmt.executeQuery();
                                                        if (rs.next()) {

                                                    %>

                                                    <!--<input type="hidden"  id="textInput" name="getUpload" >-->
                                                    <input id="maxid" name="workcode" type="hidden" value="<%=request.getParameter("workcode")%>" />
                                                    <input  name="admin" type="hidden" value="" />
                                                    <input  name="importance" type="hidden" value="" />

                                                    <input id="token" name="token" type="hidden" value="<%=token%>" />
                                                    <div class="form-group">
                                                        <label for="date" class="col-sm-3 control-label">Date</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line" >
                                                                <input type="text" class="form-control" id="date-start" value="<%=rs.getString("sourcedate")%>" onblur="errBlank('errDate')" name="date" placeholder="Date" >
                                                                <span id="errDate" class="text-danger"></span>
                                                            </div>
                                                        </div>
                                                    </div>


                                                    <div class="form-group">
                                                        <label for="source" class="col-sm-3 control-label">Source </label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <input type="text" class="form-control" id="source" value="<%=rs.getString("dm_source")%>" name="source" placeholder="Enter Source" oninput="errBlank('errsource')"  >
                                                                <!--<textarea class="form-control" id="description" name="description" autocomplete="off" oninput="errorBlank('errDescription')" placeholder="Enter Description " rows="3" required></textarea>-->
                                                                <span class="text-danger" id="errsource"></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="topic" class="col-sm-3 control-label">Topic</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <input type="text" class="form-control" id="topic" name="topic" value="<%=rs.getString("subject")%>" placeholder="Topic" oninput="errBlank('errTopic')"  >
                                                                <!--<textarea class="form-control" id="description" name="description" autocomplete="off" oninput="errorBlank('errDescription')" placeholder="Enter Description " rows="3" required></textarea>-->
                                                                <span class="text-danger" id="errTopic"></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="post" class="col-sm-3 control-label">Post/Description</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <%--<input type="text" class="form-control" id="post" name="post" placeholder="Post" value="<%=rs.getString("description")%>" oninput="errBlank('errPost')"  >--%>
                                                                <textarea class="form-control" id="post" name="post" autocomplete="off" oninput="errBlank('errPost')" placeholder="Post" rows="3" required>value="<%=rs.getString("description")%>"</textarea>
                                                                <span class="text-danger" id="errPost"></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="totalengagement" class="col-sm-3 control-label">Total Engagement</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <input type="text" class="form-control" id="totalengagement" onkeydown="return NumberOnly(event)" value="<%=rs.getString("total_engagement")%>" onkeypress="return NumberOnly(event)" onkeyup="return NumberOnly(event)" name="totalengagement" placeholder="Total Engagement" oninput="errBlank('errTotalengagement')"  >
                                                                <!--<textarea class="form-control" id="description" name="description" autocomplete="off" oninput="errorBlank('errDescription')" placeholder="Enter Description " rows="3" required></textarea>-->
                                                                <span class="text-danger" id="errTotalengagement"></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="Sentiment" class="col-sm-3 control-label">Sentiment</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <select  class="form-control " name="sentiment" id="sentiment" onchange="errBlank('errSentiment')" >
                                                                    <%
                                                                        String sentiment = "";
                                                                        if (rs.getString("sentiment") != null) {
                                                                            sentiment = rs.getString("sentiment");
                                                                            out.println("<option value='" + sentiment + "'>" + sentiment + "</option>");
                                                                    %>
                                                                    <%
                                                                    } else {%>

                                                                    <%
                                                                            sentiment = "";
                                                                        }
                                                                    %>

                                                                    <option value="Positive">Positive</option>
                                                                    <option value="Negative">Negative</option>
                                                                    <option value="Neutral">Neutral</option>


                                                                </select>  
                                                                <span class="text-danger" id="errSentiment"></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="link" class="col-sm-3 control-label">Link</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line" >
                                                                <!--<div class="col-lg-9 form-control"  style="display: none;" >-->
                                                                <input type="text" id="link" name="link" value="<%=rs.getString("link")%>"  class="form-control" placeholder="Add Link here" autocomplete="off" oninput="errBlank('errLink')" />
                                                                <span id="errLink" class="text-danger"></span>
                                                            </div>

                                                            <!--<input type="text" class="form-control" id="Additional" name="Additional" placeholder="Additional Tags" required>-->
                                                            <!--</div>-->
                                                        </div>
                                                    </div>
                                                    <%}%>

                                                    <div class="form-group">
                                                        <div class="col-sm-12 text-right">
                                                            <button type="submit" class="btn btn-danger " onclick="return updateSubmitBtnInfo();" id="btnSaveVideo"  >UPDATE</button>
                                                            <!--                                                            <button type="submit" class="btn btn-danger " data-toggle="modal" data-target="#defaultModal" onclick="saveEditData()" id="btnSaveVideo"  >UPDATE</button>-->
                                                        </div>
                                                    </div>
                                                    <!--modal-->
                                                    <div class="modal  m-t-125" id="myModal" tabindex="-1" role="dialog">
                                                        <div class="modal-dialog" role="document">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                </div>
                                                                <div class="modal-body text-center"> <h4 id="editSuccess"></h4> <br/>
                                                                    <br/>
                                                                    <span class="badge bg-green font-28 p-t-10 p-b-10 p-l-30 p-r-30"><%=request.getParameter("workcode")%></span> </div>
                                                                <div class="modal-footer">
                                                                    <a href="dataentry_edit.jsp?searchresult=N"><button type="button" class="btn btn-link waves-effect" data-dismiss="modal">CLOSE</button></a>
                                                                </div>
                                                            </div>
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
            <div class="modal  m-t-125" id="myModel1" tabindex="-1" role="dialog" style="display: none">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title text-center" id="defaultModalLabel">Workcode </h4>
                        </div>
                        <div class="modal-body text-center">
                            <!--<div id="sameEntryExist" class="text-danger"></div>-->
                            <%
                                String workcode = "";
                                if (request.getParameter("workcode") != null) {
                                    workcode = request.getParameter("workcode");
                                    //                                                                            out.println(request.getParameter("workcode"));
                                }%>

                            <p class="text-success semi-bold" style="font-size:18px">Update Reference Number  is:-<%=workcode%> </p>

                            <!--<iframe width="560" height="315" src="https://www.youtube.com/embed/u3xKgwKUQLc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>-->
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-link waves-effect"  data-dismiss="#myModel1" onclick="goBack()">CLOSE</button>   </div>
                    </div>
                </div>
            </div>
        </section>


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

        <script src="plugins/jquery-validation/jquery.validate.js"></script>

        <!-- JQuery Steps Plugin Js --> 
        <!--<script src="plugins/jquery-steps/jquery.steps.js"></script>--> 

        <!-- Waves Effect Plugin Js --> 
        <script src="plugins/node-waves/waves.js"></script> 

        <!--Autosize Plugin Js--> 
        <script src="plugins/autosize/autosize.js"></script>

        <!--Moment Plugin Js--> 
        <script src="plugins/momentjs/moment.js"></script>

        <!--Bootstrap Material Datetime Picker Plugin Js--> 
        <script src="plugins/bootstrap-material-datetimepicker/js/bootstrap-material-datetimepicker_1.js"></script>

        <!--Bootstrap Datepicker Plugin Js--> 
        <script src="plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>

        <!-- Custom Js -->
        <script src="js/admin.js"></script> 
        <!--<script src="js/pages/forms/form-validation.js"></script>--> 
        <!--<script src="js/pages/forms/form-wizard.js"></script>--> 
        <!--<script src="js/pages/forms/basic-form-elements.js"></script>--> 
        <!--<script src="js/pages/forms/advanced-form-elements.js"></script>--> 

        <!--Demo Js-->  
        <script src="js/demo.js"></script>
        <script>             
            $(document).ready(function () {
                 
                                    if (window.location.href.indexOf("success") > -1) {

                                        document.getElementById('myModel1').style.display = "block";

                                        var span = document.getElementsByClassName("close")[0];
                                    }
                                });
                          
                                function updateSubmitBtnInfo() {
                                    var a = document.getElementById("divAa").innerHTML;

//                                    alert(a);
                                    var ab = document.getElementById("additional1").value;
//                                    alert(ab + " "+a);
                                    document.getElementById("additional").value = ab + " " + a;
//                var aa = document.getElementById("newFilename").value;
////                alert(aa);
////                var aa = document.getElementsByClassName("filename");
//                var abc;
//                var subject = document.getElementById("subject").value;
//                var description = document.getElementById("description").value;
//                var sentiment = document.getElementById("sentiment").value;
//                var criticality = document.getElementById("criticality").value;
//                var uploadstatus = document.getElementById("uploadstatus").value;
//                for (var i = 0; i < aa.length; i++) {
//                    abc += aa[i].textContent + ",\n";
////                    alert(aa[i].textContent);
////            if(abc!=""){       
//                    document.getElementById("textInput").value = abc;
//
//                }

//                if (subject == "") {
//                    document.getElementById("errSubject").innerHTML = "Please Enter Subject";
//                    document.getElementById("subject").focus();
//                    return false;
//                }
//                if (description == "") {
//                    document.getElementById("errDescription").innerHTML = "Please Enter Description";
//                    document.getElementById("description").focus();
//                    return false;
//                }
//                if (criticality == "-1") {
//                    document.getElementById("errCriticality").innerHTML = "Please Select Criticality";
//                    document.getElementById("criticality").focus();
//                    return false;
//                }
//                if (sentiment == "-1") {
//                    document.getElementById("errSentiment").innerHTML = "Please Select Sentiment";
//                    document.getElementById("sentiment").focus();
//                    return false;
//                }
//                var node = document.getElementById('filename');
//
////htmlContent = node.innerHTML,
//// htmlContent = "Some <span class="foo">sample</span> text."
//
//var textContent = node.textContent;
//alert(textContent);
//                if (uploadstatus != "test") {
//                    document.getElementById("errDragnDrop").innerHTML = "Please upload files";
//                    document.getElementById("dragndrophandler").focus();
//                    return false;
//                }


                                    document.getElementById("uploadform").submit();

                                }
        </script>
        <script>
    $('#date-start').bootstrapMaterialDatePicker({weekStart: 0, time: false});
         
//            $('#date-end').bootstrapMaterialDatePicker({weekStart: 0, time: false});
//            $('#date-start').bootstrapMaterialDatePicker({weekStart: 0, time: false}).on('change', function (e, date)
//            {
//                $('#date-end').bootstrapMaterialDatePicker('setMinDate', date);
//            });
            function errBlank(err) {
                document.getElementById(err).innerHTML = "";
            }
            function goBack() {
                window.history.back();
            }
        </script>

    </body>
</html>
<% } else {
        response.sendRedirect("login.jsp");
    }%>

