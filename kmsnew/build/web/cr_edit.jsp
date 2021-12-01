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
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("2") || session.getAttribute("role").equals("5") || session.getAttribute("role").equals("4"))) {

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

    <head> <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title><%=rb.getString("title")%></title>
        <link rel="icon" href="images/favicon.ico" type="image/x-icon">

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Roboto:400,700&subset=latin,cyrillic-ext" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" type="text/css">

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

        <!-- AdminBSB Themes. You can choose a theme from css/themes instead of get all themes -->
        <link href="css/themes/all-themes.css" rel="stylesheet" />

        <link href="css/jquery-ui.css" rel="stylesheet">
        <style>
            .avatar-upload {
                position: relative;
                /*max-width: 205px;*/
                height: 200px;
            }
            .avatar-upload .avatar-edit {
                position: absolute;
                right: 12px;
                z-index: 1;
                top: 10px;
            }
            .avatar-upload .avatar-edit input {
                display: none;
            }
            .avatar-upload .avatar-edit input + label {

                width: 34px;
                height: 34px;

                /*border-radius: 100%;*/
                background: #FFFFFF;
                border: 1px solid transparent;
                box-shadow: 0px 2px 4px 0px rgba(0, 0, 0, 0.12);
                cursor: pointer;
                font-weight: normal;
                transition: all 0.2s ease-in-out;
            }
            .avatar-upload .avatar-edit input + label:hover {
                background: #f1f1f1;
                border-color: #d6d6d6;
            }
            .avatar-upload .avatar-edit input + label:after {
                content: "\f067";
                font-size: 25px;
                font-family: 'FontAwesome';
                color: #757575;
                position: absolute;
                top: 0px;
                /*left: -110px;*/
                right:7px;
                text-align: center;
                margin: auto;
                cursor: pointer;
            }
            .avatar-upload .avatar-preview {
                width: 100%;
                height: 210px;
                position: relative;
                /*border-radius: 100%;*/
                border: 6px solid #F8F8F8;
                box-shadow: 0px 2px 4px 0px rgba(0, 0, 0, 0.1);
            }
            .avatar-upload .avatar-preview > div {
                width: 100%;
                height: 100%;
                /*border-radius: 100%;*/
                background-size: cover;
                background-repeat: no-repeat;
                background-position: center;
            }
            .labelImage{
                display: inherit !important;
                float: none !important;
            }
        </style>

        <script>
            function updateCreativeData() {
                var a = document.getElementById("divAa").innerHTML;

//                                    alert(a);
                var ab = document.getElementById("additional1").value;
//                                    alert(ab + " "+a);
                document.getElementById("additional").value = ab + " " + a;
                document.getElementById("uploadform").submit();

            }
        </script>

        <script>
            function closeDiv() {
                document.getElementById("myModal").style.display = "none";

            }
            function closeEntryDiv() {
                document.getElementById("sameEntry").style.display = "none";

            }

            function closeFileExistDiv() {
                document.getElementById("displayAvailable").style.display = "none";

            }

            function closeFileDiv() {
                document.getElementById("displayFileFormat").style.display = "none";

            }
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

//                    alert("your url contains the name franky");
                }
            });
        </script>

    </head>

    <body class="theme-blue"> 
        <!--<div class=" container-scroller">-->
        <!--Navbar-->
        <% if (session.getAttribute("role").equals("5")) {%>
        <jsp:include page="userHeader1.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <%} else if (session.getAttribute("role").equals("2")) {%>
        <jsp:include page="cr_header.jsp"></jsp:include>
        <jsp:include page="cr_left.jsp"></jsp:include>
        <%}%>   
        <!--End navbar-->
        <section class="content">
            <div class="col-md-12"> 
                <!-- Unordered List -->
                <div class="row clearfix">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="card">
                            <div class="header">
                                <h2>Creative Team Dataentry reference No : <%=request.getParameter("workcode")%> </h2>
                                <ul class="header-dropdown m-r--5">
                                    <li class="dropdown"> <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">  </a>
                                        <!--                                            <ul class="dropdown-menu pull-right">
                                                                                        <li><a href="javascript:void(0);">Action</a></li>
                                                                                        <li><a href="javascript:void(0);">Another action</a></li>
                                                                                        <li><a href="javascript:void(0);">Something else here</a></li>
                                                                                    </ul>
                                        -->
                                        <button type="button" class="btn btn-link waves-effect"  data-dismiss="#myModel1" onclick="goBack()">BACK</button> 
                                    </li>
                                </ul>
                            </div>

                            <div class="body clearfix">
                                <div class="col-md-10 col-lg-offset-1 well">
                                    <!-- Nav tabs -->
                                    <!--                                        <ul class="nav nav-tabs tab-nav-right" role="tablist">
                                                                                <li role="presentation" id="informationClass" class="active"><a href="#information" data-toggle="tab">INFORMATION</a></li>
                                                                                <li role="presentation" id="tagClass"><a href="#tag" data-toggle="tab" onclick="this.disabled = true;">TAG</a></li>
                                                                            </ul>-->
                                    <!-- Tab panes -->
                                    <div class="tab-content">
                                        <div role="tabpanel" class="tab-pane fade in active" id="information">
                                            <!--<b>INFORMATION Content</b>-->
                                            <section>
                                                <div>
                                                    <form action="<%=request.getContextPath()%>/graphicsupdate.do" class="form-horizontal m-t-50" id="uploadform" method="post" accept-charset="UTF-8" enctype="multipart/form-data">
                                                        <%Connection dh = null;
                                                            ConnectionDB connectionDB = new ConnectionDB();
                                                            dh = connectionDB.getConnection();
                                                            String subject = "", description = "", summary = "", date = "";

                                                            String selectData = "Select * from tbl_news_dataentry where workcode=?";
                                                            PreparedStatement pstmt = dh.prepareStatement(selectData);
                                                            pstmt.setString(1, request.getParameter("workcode"));
                                                            ResultSet rs = pstmt.executeQuery();
                                                            if (rs.next()) {
                                                                System.out.println("workcode:-" + rs.getString("workcode"));

                                                        %>

                                                        <!--<input type="hidden"  id="textInput" name="getUpload" >-->
                                                        <input  id="workcode" name="workcode" type="hidden" value="<%=request.getParameter("workcode")%>" />
                                                        <input id="token" name="token" type="hidden" value="<%=token%>" />
                                                        <input id="admin" name="admin" type="hidden" value="" />


                                                        <div class="form-group">
                                                            <label for="Program" class="col-sm-3 control-label">Title / Name of Program </label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" id="subjectTag">
                                                                    <input type="text" class="form-control" name="subject" value="<%=rs.getString("subject")%>" autocomplete="off" oninput="errorBlank('errSubject')" id="subject"  placeholder="Enter  Title" required>

                                                                    <!--<input type="text" class="form-control" id="Program" name="Program" placeholder="Title / Name of Program" required>-->
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="description" class="col-sm-3 control-label">Details/Topic/Information of program </label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" id="subjectTag">
                                                                    <textarea class="form-control" id="description" name="description" autocomplete="off" oninput="errorBlank('errDescription')" placeholder="Enter Description " rows="3"><%=rs.getString("description")%></textarea>
                                                                    <!--<input type="text" class="form-control" id="Program" name="Program" placeholder="Title / Name of Program" required>-->
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="sector" class="col-sm-3 control-label">Sector </label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" id="sectorTag">
                                                                    <select name="sector" id="sector" class="form-control" onchange="onchangeSector()" onblur="onchangeSector()">
                                                                        <%
                                                                            String sector = "";

                                                                            if (rs.getString("sector") != null) {
                                                                                sector = rs.getString("sector");
                                                                                out.println("<option value='" + sector + "'>" + sector + "</option>");

                                                                            } else {
                                                                                //                                                                                            sector =;
                                                                            }
                                                                            String selectRecord = "select category_name from tbl_category_master";
                                                                            PreparedStatement pstmt1 = ConnectionDB.getDBConnection().prepareStatement(selectRecord);
                                                                            ResultSet rs1 = pstmt1.executeQuery();
                                                                            while (rs1.next()) {
                                                                                out.println("<option value='" + rs1.getString(1) + "'>" + rs1.getString(1) + "</option>");
                                                                            }
                                                                        %>

                                                                    </select>   
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="nameofprogram" class="col-sm-3 control-label">Name Of Program </label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" >
                                                                    <input type="text" class="form-control" name="nameofprogram" id="nameofprogram" value="<%=rs.getString("name_of_program")%>" autocomplete="off" oninput="errorBlank('errNameofprogram')" aria-describedby="tag" placeholder="Enter name of program">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="placeofprogram" class="col-sm-3 control-label">Place Of Program </label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" >
                                                                    <input type="text" class="form-control" name="placeofprogram" id="placeofprogram" value="<%=rs.getString("place_of_program")%>" autocomplete="off" oninput="errorBlank('errPlaceofprogram')" aria-describedby="tag" placeholder="Enter place of program">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="sourcedate" class="col-sm-3 control-label">Source Date </label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" >
                                                                    <input type="text" class="form-control" name="sourcedate"  id="date-start2" autocomplete="off" value="<%=rs.getString("sourcedate")%>"  aria-describedby="link" placeholder="Sourcedate">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="additional" class="col-sm-3 control-label"> Tags</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" id="newTag">
                                                                    <textarea type="text" class="form-control"  id="additional1" autocomplete="off"  aria-describedby="additional" readonly ><%=rs.getString("additionaltag")%></textarea>
                                                                    <input type="text" class="form-control" name="additional" id="additional" autocomplete="off"  aria-describedby="additional" placeholder="Add Tags here">

                                                                    <!--<input type="text" class="form-control" id="Links" name="Links" placeholder="Add Links" required>-->
                                                                </div>
                                                                <div id="divAa" style="font-size: 14px;border:1px solid #c8cbce;display: none" class="text-white"></div>
                                                                <!--<input type="hidden" class="txt" name="additional" id="additional" >-->

                                                            </div>
                                                        </div>

                                                        <div class="row">
                                                            <%
                                                                String fullpath[] = null;
                                                                //
                                                                if (!rs.getString("docpath").isEmpty()) {
                                                                    //                                                                String path = rs.getString("grpahicspath");
                                                                    ////                                                        String fullpath=path.substring(19);
                                                                    //                                                                String replaceString = path.replace("\\", "/");
                                                                    //                                                                fullpath = "/kmsvdo/vdo/" + replaceString.substring(14);
                                                                    //                                                                System.out.println("fullpath:-" + fullpath);
                                                                    //
                                                                    //                                                                String whiteSpace = fullpath.replace(" ", "%20");
                                                                    fullpath = rs.getString("docpath").split("::");
                                                                    for (int i = 0; i < fullpath.length; i++) {
                                                            %>
                                                            <input type="hidden" name="uploadDoc" value="<%=rs.getString("docpath")%>">

                                                            <div class="col-xs-6 col-md-4" >
                                                                <span class="img_close" onclick="showPDFFunction('<%=fullpath[i].substring(34).replace(" ", "%20")%>', 'pdf')"><i class="material-icons">
                                                                        clear
                                                                    </i></span>
                                                                <span class="thumbnail">
                                                                    <img src="images/pdf.jpg" style="height: 200px"  class="img-responsive">
                                                                </span>
                                          
                                                                <!--<img  src="" class="img-responsive" style="height: 180px" id="image_" ">-->

                                                            </div>  
                                                            <%}
                                                                }
                                                                if (!rs.getString("graphicspath").isEmpty()) {
                                                                    //                                                                String path = rs.getString("grpahicspath");
                                                                    ////                                                        String fullpath=path.substring(19);
                                                                    //                                                                String replaceString = path.replace("\\", "/");
                                                                    //                                                                fullpath = "/kmsvdo/vdo/" + replaceString.substring(14);
                                                                    //                                                                System.out.println("fullpath:-" + fullpath);
                                                                    //
                                                                    //                                                                String whiteSpace = fullpath.replace(" ", "%20");
                                                                    fullpath = rs.getString("graphicspath").split("::");
                                                                    for (int i = 0; i < fullpath.length; i++) {
                                                            %>
                                                            <input type="hidden" name="uploadImage" value="<%=rs.getString("graphicspath")%>">

                                                            <div class="col-xs-6 col-md-4" >
                                                                <span class="img_close" onclick="showPDFFunction('<%=fullpath[i].replace(" ", "%20")%>', 'img')"><i class="material-icons">
                                                                        clear
                                                                    </i></span>
                                                                <span class="thumbnail">
                                                                    <img src="/kmsvdo/<%=fullpath[i].substring(25).replace(" ", "%20")%>" style="height: 200px"  class="img-responsive">
                                                                </span>
                                                             
                                                                <!--<img  src="" class="img-responsive" style="height: 180px" id="image_" ">-->

                                                            </div> 
                                                            <%}
                                                                }
                                                                if (!rs.getString("vdopath").isEmpty()) {
                                                                    //                                                                String path = rs.getString("grpahicspath");
                                                                    ////                                                        String fullpath=path.substring(19);
                                                                    //                                                                String replaceString = path.replace("\\", "/");
                                                                    //                                                                fullpath = "/kmsvdo/vdo/" + replaceString.substring(14);
                                                                    //                                                                System.out.println("fullpath:-" + fullpath);
                                                                    //
                                                                    //                                                                String whiteSpace = fullpath.replace(" ", "%20");
                                                                    fullpath = rs.getString("vdopath").split("::");
                                                                    for (int i = 0; i < fullpath.length; i++) {
                                                            %>
                                                            <input type="hidden" name="uploadVdo" value="<%=rs.getString("vdopath")%>">

                                                            <div class="col-xs-6 col-md-4" >
                                                                <span class="img_close" onclick="showPDFFunction('<%=fullpath[i].replace(" ", "%20")%>', 'vdo')"><i class="material-icons">
                                                                        clear
                                                                    </i></span>
                                                                <span class="thumbnail">
                                                                    <video width="190" height="170" controls class="m-t-25">
                                                                        <source src="<%=fullpath[i].substring(25).replace(" ", "%20")%>" type="video/mp4">
                                                                        <!--<source src="movie.ogg" type="video/ogg">-->
                                                                        <!--Your browser does not support the video tag.-->
                                                                    </video>
                                                                    <%--<img src="<%=fullpath[i].substring(34).replace(" ", "%20")%>" style="height: 200px"  class="img-responsive">--%>
                                                                </span>
                                               
                                                                <!--<img  src="" class="img-responsive" style="height: 180px" id="image_" ">-->

                                                            </div> 
                                                            <% }
                                                                } %>
                                                            <div class="col-md-4">
                                                                <div class="avatar-upload" for="imageUpload" style="cursor: pointer">
                                                                    <div class="avatar-edit">

                                                                    </div>
                                                                    <div class="avatar-edit" style="cursor: pointer">
                                                                        <input type="file" id="imageUpload" name="uploadImage" onchange="readURL(this)" accept=".pdf,.PDF,.jpef,.jpg,.png,.gif,.3gp,.mov,.mp4,.MXF" multiple>
                                                                        <!--<input type="file" id="imageUpload" name="uploadImage" onchange="readURL(this)" accept=".pdf,.PDF,.jpef,.jpg,.png,.gif,.3gp,.mov,.mp4,.MXF" multiple>-->


                                                                    </div>
                                                                    <label for="imageUpload" class="labelImage" style="cursor: pointer">
                                                                        <div class="avatar-preview" >
                                                                            <div id="imagePreview" style="background-image: url('images/add_img.jpg');"> </div>
                                                                            <img src="#" id="pdffile" style="display: none"><br>
                                                                            <span id="selectedFiles" class="text-success"></span>

                                                                        </div>
                                                                    </label>     
                                                                </div>
                                                            </div>

                                                        </div>          
                                                        <div class="form-group">
                                                            <div class="col-sm-12 text-right">
                                                                <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#defaultModal" onclick=" updateCreativeData()" id="btnSaveVideo" >UPDATE</button>
                                                            </div>
                                                        </div>
                                                    </form>
                                                    <%}%>
                                                    <div id="myModal1" class="modal bodyBackground" role="dialog">
                                                        <div class="modal-dialog m-t-125">
                                                            <!-- Modal content-->
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <button type="button" class="close" data-dismiss="modal" onclick="closeImageDiv()">&times;</button>
                                                                    <h4 class="modal-title" id="doyouremove"> 
                                                                        <br></h4>
                                                                </div>
                                                                <div class="modal-body">

                                                                    <span id="removeImageid"></span>
                                                                    <span id="removeImageDiv" style="display: none"></span>
                                                                </div>
                                                                <div class="modal-footer " id="footerOpen" style="text-align: center">
                                                                    <button type="button" class="btn btn-success" onclick="removePDF()" data-dismiss="modal">Yes</button>
                                                                    <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeImageDiv()">No</button>
                                                                </div>
                                                                <div class="modal-footer " id="footerClose" style="text-align: center;display: none">
                                                                    <!--<button type="button" class="btn btn-success" onclick="removePDF()" data-dismiss="modal">Yes</button>-->
                                                                    <a href="cr_edit.jsp?workcode=<%=request.getParameter("workcode")%>"  > <button type="button" class="btn btn-danger" data-dismiss="modal">close</button></a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div></div></div>

        </section>

        <div class="modal bodyBackground " id="myModal12" tabindex="-1" role="dialog" style="display:none">
            <div class="modal-dialog m-t-125" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                    </div>
                    <div class="modal-body text-center"> <h4>Your update reference number is</h4> <br/>
                        <br/>
                        <span class="badge bg-green font-28 p-t-10 p-b-10 p-l-30 p-r-30"><%=request.getParameter("workcode")%></span> </div>
                    <div class="modal-footer">
                        <a href="cr_edit.jsp?workcode=<%=request.getParameter("workcode")%>"><button type="button" class="btn btn-link waves-effect" data-dismiss="modal">CLOSE</button></a>
                    </div>
                </div>
            </div>
        </div>  <!-- Jquery Core Js --> 
        <!--<script src="plugins/jquery/jquery.min.js"></script>--> 
        <script src="js/jquery-1.12.4.js"></script>
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
        <script src="plugins/jquery-steps/jquery.steps.js"></script> 

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
        <script src="js/admin.js"></script> 
        <script src="js/pages/forms/form-validation.js"></script> 
        <script src="js/pages/forms/form-wizard.js"></script> 
        <!--<script src="js/pages/forms/basic-form-elements.js"></script>--> 
        <!--<script src="js/pages/forms/advanced-form-elements.js"></script>--> 

        <!--Demo Js-->  
        <script src="js/demo.js"></script>
        <script>
                                                                        $('#date-end').bootstrapMaterialDatePicker({weekStart: 0, time: false});
                                                                        $('#date-start').bootstrapMaterialDatePicker({weekStart: 0, time: false}).on('change', function (e, date)
                                                                        {
                                                                            $('#date-end').bootstrapMaterialDatePicker('setMinDate', date);
                                                                        });
                                                                        $('#date-start2').bootstrapMaterialDatePicker({weekStart: 0, time: false});
        </script>
        <script type="text/javascript">
            $(document).ready(function () {
                if (window.location.href.indexOf("success") > -1) {

                    var modal = document.getElementById('myModal12').style.display = "block";
// Get the <span> element that closes the modal
                    var span = document.getElementsByClassName("close")[0];
// When the user clicks on <span> (x), close the modal
                }
            });
            function removeTag(tag, id) {
//                alert(tag);
                document.getElementById("additional").value = "";
                return false;
            }
            $(function () { // DOM ready

                // ::: TAGS BOX

                $("#newTag input").on({
                    focusout: function () {
                        var txt = this.value.replace(/[^a-z0-9_\+\-\.\#]/ig, ''); // allowed characters
                        if (txt)
                            //                    $("<input type='text' name='stag'">), {text: txt.toLowerCase(), insertBefore: this});
                            $("<span />", {text: txt, insertBefore: this});
                        $("#divAa").append("" + this.value);
                        //                                $('#sourcetag').appendVal(value);
//                        document.getElementById("add").value = this.value;
                        this.value = "";
                    },
                    keyup: function (ev) {
                        // if: comma|enter (delimit more keyCodes with | pipe)
                        if (/(188|13|32)/.test(ev.which))
                            $(this).focusout();
                        return false;
                    }
                });
                $('#newTag').on('click', 'span,button', function () {
                    if (confirm("Remove " + $(this).text() + "?"))
                        $(this).remove();
                });
            });
            $('input#imageUpload').change(function () {
                var files = $(this)[0].files;
                if (files.length > 10) {
                    document.getElementById("selectedFiles").innerHTML = "You have selected " + files.length + " files.";
//                    alert("you can select max 10 files.");
                } else {
                    document.getElementById("selectedFiles").innerHTML = "You have selected " + files.length + " files.";

//                    alert("correct, you have selected less than 10 files");
                }
            });
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        $('#pdffile')
                                .attr('src', 'images/tickfile.png')
//                        .attr('src',e.target.result)
                                .width(218)
                                .height(198);
                        document.getElementById("pdffile").style.display = "block";
                        document.getElementById("imagePreview").style.display = "none";
                    };

                    reader.readAsDataURL(input.files[0]);
                }
            }

            function showPDFFunction(val, type) {
                document.getElementById("myModal1").style.display = "block";
                document.getElementById("removeImageid").innerHTML = val;
                document.getElementById("doyouremove").innerHTML = " Do you want to remove ?";
                document.getElementById("removeImageDiv").innerHTML = type;
            }
            function removePDF()
            {
                var xhttp = new XMLHttpRequest();
                var removeImageid = document.getElementById("removeImageid").textContent;
//                alert(removeImageid);
                var removeImageDiv = document.getElementById("removeImageDiv").textContent;
                var workcode = document.getElementById("workcode").value;
                var urls = "removecr.do?removepdfid=" + removeImageid + "&type=" + removeImageDiv + "&workcode=" + workcode;
//                    alert(urls);
                xhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
//                        alert(this.responseText);
                        document.getElementById("removeImageDiv").style.display = 'none';
                        document.getElementById("doyouremove").innerHTML = 'File removed successfully';
                        document.getElementById("footerOpen").style.display = 'none';
                        document.getElementById("footerClose").style.display = 'block';
                    }
                };
                xhttp.open("POST", urls, true);
                xhttp.send();

            }
            function goBack() {
                window.history.back();
            }
        </script>
    </body>
</html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>

