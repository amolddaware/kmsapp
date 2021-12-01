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
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("2") || session.getAttribute("role").equals("3") || session.getAttribute("role").equals("7") || session.getAttribute("role").equals("5"))) {

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

        <link rel="icon" href="images/favicon.ico" type="image/x-icon">

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

    </head>

    <body class="theme-blue">


        <% if (session.getAttribute("role").equals("5")) {%>
        <jsp:include page="userHeader1.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <%} else if (session.getAttribute("role").equals("7")) {%>
        <jsp:include page="gr_header.jsp"></jsp:include>
        <jsp:include page="gr_left.jsp"></jsp:include>
        <%}%>    <!--<div class=" container-scroller">-->
        <!--Navbar-->


        <section class="content">
            <div class="col-md-12"> 
                <!-- Unordered List -->
                <div class="row clearfix">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="card">
                            <div class="header">
                                <h2>EDIT INFORMATION</h2>
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
                                    <div id="wizard_horizontal">
                                        <h2>Information (<%=request.getParameter("workcode")%>)</h2>
                                        <section>
                                            <div>
                                                <form class="form-horizontal m-t-50" action="<%=request.getContextPath()%>/updategr.do"  id="uploadform" method="post" accept-charset="UTF-8" enctype="multipart/form-data">
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
                                                        <label for="dept" class="col-sm-3 control-label">Department </label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <select  class="form-control " name="dept" id="dept" onchange="getMarathi(this.value)"  required>

                                                                    <option value="<%=rs.getString("dept")%>"><%=rs.getString("dept")%></option>
                                                                    <%
                                                                        String sqlSelect = "SELECT * FROM tbl_department_master group by dept_name_eng order by dept_name_eng ";
                                                                        System.out.println("sqlSelect-" + sqlSelect);
                                                                        PreparedStatement stmSelect = ConnectionDB.getDBConnection().prepareStatement(sqlSelect);
                                                                        ResultSet rsSelect = stmSelect.executeQuery();
                                                                        while (rsSelect.next()) {
                                                                    %>
                                                                    <option value="<%=rsSelect.getString("dept_name_eng")%>"><%=rsSelect.getString("dept_name_eng")%></option>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </select>   
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="deptmarathi" class="col-sm-3 control-label">Department </label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <input type="text" class="form-control" id="deptmarathi" name="deptmarathi" value="<%=rs.getString("deptmarathi")%>" placeholder="Department (Marathi)" readonly   >

                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="title" class="col-sm-3 control-label">Title (English)</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <input type="text" class="form-control" id="title" name="title" value="<%=rs.getString("subject")%>" placeholder="Title (English)" oninput="errBlank('errTitle')"  >
                                                                <!--<textarea class="form-control" id="description" name="description" autocomplete="off" oninput="errorBlank('errDescription')" placeholder="Enter Description " rows="3" required></textarea>-->
                                                                <span class="text-danger" id="errTitle"></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="titlemarathi" class="col-sm-3 control-label">Title (Marathi)</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <input type="text" class="form-control" id="titlemarathi" name="titlemarathi" value="<%=rs.getString("titlemarathi")%>" placeholder="Title (Marathi)" oninput="errBlank('errTitlemarathi')"  >
                                                                <!--<textarea class="form-control" id="description" name="description" autocomplete="off" oninput="errorBlank('errDescription')" placeholder="Enter Description " rows="3" required></textarea>-->
                                                                <span class="text-danger" id="errTitlemarathi"></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="grcode" class="col-sm-3 control-label">G R Code</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <input type="text" class="form-control" id="grcode" value="<%=rs.getString("grcode")%>" onkeydown="return NumberOnly(event)" onkeypress="return NumberOnly(event)" onkeyup="return NumberOnly(event)" name="grcode" placeholder="GR Code" oninput="errBlank('errGrcode')"  >
                                                                <!--<textarea class="form-control" id="description" name="description" autocomplete="off" oninput="errorBlank('errDescription')" placeholder="Enter Description " rows="3" required></textarea>-->
                                                                <span class="text-danger" id="errGrcode"></span>
                                                            </div>
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

                                                        %>

                                                        <div class="col-xs-6 col-md-4" >
                                                            <span class="img_close" onclick="showPDFFunction('<%=rs.getString("docpath")%>')"><i class="material-icons">
                                                                    clear
                                                                </i></span>
                                                            <span class="thumbnail">
                                                                <img src="images/pdf.jpg" style="height: 200px"  class="img-responsive">
                                                            </span>

                                                            <!--<img  src="" class="img-responsive" style="height: 180px" id="image_" ">-->

                                                        </div>   <%
                                                        } else {
                                                        %>
                                                        <div class="col-md-4">
                                                            <div class="avatar-upload" for="imageUpload">
                                                                <div class="avatar-edit">
                                                                    <input type="hidden" name="uploadImage" value="<%=rs.getString("docpath")%>">

                                                                </div>
                                                                <div class="avatar-edit">
                                                                    <input type="file" id="imageUpload" name="uploadImage" onchange="readURL(this)" accept=".pdf,.PDF" >


                                                                </div>
                                                                <label for="imageUpload" class="labelImage">
                                                                    <div class="avatar-preview" >
                                                                        <div id="imagePreview" style="background-image: url('images/add_img.jpg');"> </div>
                                                                        <img src="#" id="pdffile" style="display: none">

                                                                    </div>
                                                                </label>     
                                                            </div>
                                                        </div>

                                                        <%}%>
                                                    </div> 
                                                    <%}%>
                                                    <div class="form-group">

                                                        <div class="col-sm-12 text-right">
                                                            <button type="submit" class="btn btn-danger "  id="btnSaveVideo"  >UPDATE</button>
                                                            <!--                                                            <button type="submit" class="btn btn-danger " data-toggle="modal" data-target="#defaultModal" onclick="saveEditData()" id="btnSaveVideo"  >UPDATE</button>-->
                                                        </div>
                                                    </div>
                                                    <!--modal-->
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
                                                                    <a href="gr_edit.jsp?workcode=<%=request.getParameter("workcode")%>"  > <button type="button" class="btn btn-danger" data-dismiss="modal">close</button></a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

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
            <div class="modal  bodyBackground" id="myModel1" tabindex="-1" role="dialog" style="display: none">
                <div class="modal-dialog m-t-125" role="document">
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
        <script src="js/pages/forms/form-validation.js"></script> 
        <!--<script src="js/pages/forms/form-wizard.js"></script>--> 
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
                                $(document).ready(function () {
//                $(function () {
                                    function split(val) {
                                        return val.split(/,\s*/);
                                    }
                                    function extractLast(term) {
                                        return split(term).pop();
                                    }

                                    $("#generaltag")
//                $("#generalTag1 input")
                                            .autocomplete({
                                                source: function (request, response) {
//                                alert("tee");
                                                    $.getJSON("jsonfile_1.jsp?description=" + document.getElementById("generaltag").value, {
                                                        term: extractLast(request.term)
                                                    }, response);
                                                },
                                                search: function () {
                                                    // custom minLength
                                                    var term = extractLast(this.value);
//                                           alert(term);
                                                    if (term.length < 2) {

                                                        return false;
                                                    }
                                                },
                                            });
                                });
//        });
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

                                function updateSubmitBtnInfo() {
                                    var a = document.getElementById("divAa").innerHTML;

//                                    alert(a);
                                    var ab = document.getElementById("additional1").value;
//                                    alert(ab + " "+a);
                                    document.getElementById("additional").value = ab + " " + a;


                                    document.getElementById("uploadform").submit();

                                }
                                function NumberOnly(evt)
                                {
                                    evt = (evt) ? evt : window.event;
                                    var charCode = (evt.which) ? evt.which : evt.keyCode;
                                    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                                        return false;
                                    }
                                    return true;
                                }
                                function  getMarathi(val) {
                                    var xmlhttp;
//               
                                    if (window.XMLHttpRequest)
                                    {// code for IE7+, Firefox, Chrome, Opera, Safari
                                        xmlhttp = new XMLHttpRequest();
                                    } else
                                    {// code for IE6, IE5
                                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                                    }
                                    var urls = "gr_getmarathidept.jsp?dept=" + val;


                                    xmlhttp.onreadystatechange = function ()
                                    {
                                        if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                                        {
                                            var resp = xmlhttp.responseText;
//                         alert(resp);
                                            document.getElementById("deptmarathi").value = resp.trim();

                                        }
                                    };
                                    xmlhttp.open("POST", urls, true);
                                    xmlhttp.send();

                                }
        </script>
        <script>
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        $('#pdffile')
                                .attr('src', 'images/pdf.jpg')
//                        .attr('src',e.target.result)
                                .width(218)
                                .height(198);
                        document.getElementById("pdffile").style.display = "block";
                        document.getElementById("imagePreview").style.display = "none";
                    };

                    reader.readAsDataURL(input.files[0]);
                }
            }
            function showPDFFunction(val) {
                document.getElementById("myModal1").style.display = "block";
                document.getElementById("removeImageid").innerHTML = val;
                document.getElementById("doyouremove").innerHTML = " Do you want to remove ?";
                document.getElementById("removeImageDiv").innerHTML = val;
            }
            function removePDF()
            {
                var xhttp = new XMLHttpRequest();
                var removeImageid = document.getElementById("removeImageid").textContent;
//                alert(removeImageid);
//                var removeImageDiv = document.getElementById("removeImageDiv").textContent;
                var urls = "removepdf.do?removepdfid=" + removeImageid;
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
            $('#date-start').bootstrapMaterialDatePicker({weekStart: 0, time: false});
//            $('#date-end').bootstrapMaterialDatePicker({weekStart: 0, time: false});
//            $('#date-start').bootstrapMaterialDatePicker({weekStart: 0, time: false}).on('change', function (e, date)
//            {
//                $('#date-end').bootstrapMaterialDatePicker('setMinDate', date);
//            });
        </script>

    </body>
</html>
<% } else {
        response.sendRedirect("login.jsp");
    }%>

