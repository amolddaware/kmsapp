<%-- 
    Document   : dragndrop1
    Created on : Dec 18, 2017, 8:34:23 PM
    Author     : Amol
--%>

<%@page import="java.io.File"%>
<%@page import="java.net.URL"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%ResourceBundle rb = ResourceBundle.getBundle("msg");%>

<%
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("2") || session.getAttribute("role").equals("3") || session.getAttribute("role").equals("4") || session.getAttribute("role").equals("5"))) {

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
            #newTag{

                /*float:left;*/
                /*border:1px solid #ccc;*/
                /*padding:5px;*/
                font-family:Arial;
            }
            #newTag > span{
                cursor: pointer;
                display: block;
                float: left;
                color: #000;
                font-size: 1.5rem;
                /*background: #c8cbce;*/
                padding: 1px 20px 1px 5px; 
                /*padding-top: 4px;*/
                /*padding-right: 25px;*/
                /*padding-left: 5px;*/
                /*                margin: 1px;
                                margin-right: 5px;
                                margin-left: 12px;*/
                /*padding-bottom: 4px;*/
                color: #222;
                margin: 2px 5px;
                /*max-width: 325px;*/
                /*max-height: 17px;*/
                overflow: hidden;
                text-overflow: ellipsis;
                direction: ltr;
                cursor: move;
                border: 1px solid #f29900;
                border-radius: 15px;
            }
            #newTag > span:hover{
                opacity:0.7;
            }
            #newTag > span:after{
                position:absolute;
                content:"×";
                /*border:1px solid;*/
                padding:0px 5px;
                margin-left:3px;
                font-size:16px;

            }
            #newTag > input{
                /*        background:#eee;
                        border:0;
                        margin:4px;
                        padding:7px;
                        width:auto;*/
                border: none;
                width:100%;font-size:14px;border-radius: 3px;padding: 5px 6px;line-height: 1.428571429;color: #000;vertical-align: middle;background-color: #fff;

            }
            .closebtn{
                padding: 1px 6px;
                /*border: 1px solid transparent;*/ 
                pointer-events: none;
                cursor: default;
                cursor: pointer;
                display: block;
                float: left;
                color: #000;
                font-size: 1.5rem;
                background: #fff;
                /* padding: 5px; */
                /*padding-top: 4px;*/
                /*padding-right: 25px;*/
                /*padding-left: 5px;*/
                /*                margin: 1px;
                                margin-right: 5px;
                                margin-left: 12px;*/
                /*padding-bottom: 4px;*/
                color: #222;
                margin: 2px 5px;
                /*max-width: 325px;*/
                /*max-height: 17px;*/
                overflow: hidden;
                text-overflow: ellipsis;
                direction: ltr;
                cursor: move;
                border: 1px solid #f29900;
                border-radius: 10px;
            }
            .txtNew{
                width:60%;font-size:14px;border-radius: 3px;padding: 5px 6px;line-height: 1.428571429;color: #000;vertical-align: middle;background-color: #fff;border: 0.5px solid  #00b8e6 ;-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,0.075); box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);-webkit-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            }
            .txtNew:enabled{
                width:60%;font-size:14px;border-radius: 3px;padding: 5px 6px;line-height: 1.428571429;color: #000;vertical-align: middle;background-color: #fff;border: 0.5px solid  #00b8e6 ;-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,0.075); box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);-webkit-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            }</style>
        <style>

            .avatar-upload {
                position: relative;
                /*max-width: 205px;*/
                height: 460px;
                margin: 50px auto;
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
                display: inline-block;
                width: 34px;
                height: 34px;
                margin-bottom: 0;
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
                content: "\f040";
                font-family: 'FontAwesome';
                color: #757575;
                position: absolute;
                top: 10px;
                left: 0;
                right: 0;
                text-align: center;
                margin: auto;
            }
            .avatar-upload .avatar-preview {
                width: 100%;
                height: 460px;
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
        </style>

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
            function displayFiles() {
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        document.getElementById("displayFileModal").style.display = "block";

                        document.getElementById("demotext").innerHTML = this.responseText;
                    }
                };
                xhttp.open("GET", "displayfiles.jsp", true);
                xhttp.send();
            }
        </script>

    </head>

    <body class="theme-blue">


        <jsp:include page="printmediauserHeader.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>
            <!--<div class=" container-scroller">-->
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
                                        <div id="wizard_horizontal">
                                            <h2>Information (<%=request.getParameter("workcode")%>)</h2>
                                        <section>
                                            <div>
                                                <form class="form-horizontal m-t-50" action="<%=request.getContextPath()%>/updateprintmedia.do"  id="uploadform" method="post" accept-charset="UTF-8" enctype="multipart/form-data">
                                                    <%Connection dh = null;
                                                        ConnectionDB connectionDB = new ConnectionDB();
                                                        dh = connectionDB.getConnection();
                                                        String subject = "", description = "", date = "";
                                                        System.out.println("workcode:-" + request.getParameter("workcode"));
                                                        String selectData = "Select * from total_printmedia_dataentry_view where workcode=?";

                                                        PreparedStatement pstmt = dh.prepareStatement(selectData);
                                                        pstmt.setString(1, request.getParameter("workcode"));
                                                        ResultSet rs = pstmt.executeQuery();
                                                        if (rs.next()) {

                                                    %>

                                                    <!--<input type="hidden"  id="textInput" name="getUpload" >-->
                                                    <input id="maxid" name="workcode" type="hidden" value="<%=request.getParameter("workcode")%>" />
                                                    <input  name="admin" type="hidden" value="" />
                                                    <input  name="importance" type="hidden" value="" />
                                                    <input  name="fromSourceDate" type="hidden" value="<%=request.getParameter("fromSourceDate")%>" />
                                                    <input  name="toSourceDate" type="hidden" value="<%=request.getParameter("toSourceDate")%>" />

                                                    <input id="token" name="token" type="hidden" value="<%=token%>" />

                                                    <div class="form-group">
                                                        <label for="date" class="col-sm-3 control-label">Date</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line" >
                                                                <input type="text" class="form-control" id="date" value="<%=rs.getString("sourcedate")%>" name="date" placeholder="Date" required>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="language" class="col-sm-3 control-label">Language</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <select  class="form-control " name="language" id="language"  onchange="selectNewsPaper('lang')"  required>
                                                                    <option value="<%=rs.getString("id_language")%>"><%=rs.getString("language")%></option>
                                                                    <%
                                                                        String sqlSelect = "SELECT * FROM tbl_language_master ";
//                                                                        System.out.println("sqlSelect-" + sqlSelect);
                                                                        PreparedStatement stmSelect = ConnectionDB.getDBConnection().prepareStatement(sqlSelect);
                                                                        ResultSet rsSelect = stmSelect.executeQuery();
                                                                        while (rsSelect.next()) {
                                                                    %>
                                                                    <option value="<%=rsSelect.getString(1)%>"><%=rsSelect.getString(2)%></option>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </select>   
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="newspaper" class="col-sm-3 control-label">News Paper</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line" id="idnewspaper">
                                                                <select  class="form-control " name="newspaper" id="newspaper" onchange="selectNewsPaper('np')" required>
                                                                    <option value="<%=rs.getString("id_npname")%>"><%=rs.getString("npname")%></option>

                                                                    <!--<option value="-1">Select NewsPaper</option>-->
                                                                </select>                                   <!--<input type="text" class="form-control" id="Program" name="Program" placeholder="Title / Name of Program" required>-->

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="edition" class="col-sm-3 control-label">Edition</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <select  class="form-control " name="edition" id="edition" onchange="selectNewsPaper('edition')" required>
                                                                    <option value="<%=rs.getString("id_edition")%>"><%=rs.getString("edition")%></option>

                                                                </select>   
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="subedition" class="col-sm-3 control-label">Sub Edition</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <select  class="form-control " name="subedition" id="subedition"  required>
                                                                    <% if (rs.getString("subedition") != null) {%>
                                                                    <option value="<%=rs.getString("id_subedition")%>"><%=rs.getString("subedition")%></option>
                                                                    <%} else {%>
                                                                    <option value="-1">Select Subedition</option>
                                                                    <%}%>
                                                                </select>   
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="title" class="col-sm-3 control-label">Title (English)</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <input type="text" class="form-control" value="<%=rs.getString("subject")%>" id="title" name="title" placeholder="Title (English)"  required>
                                                                <!--<textarea class="form-control" id="description" name="description" autocomplete="off" oninput="errorBlank('errDescription')" placeholder="Enter Description " rows="3" required></textarea>-->

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="title" class="col-sm-3 control-label">Title (Marathi)</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <input type="text" class="form-control" value="<%=rs.getString("titlemarathi")%>" id="titlemarathi" name="titlemarathi" placeholder="Title (Marathi)"  required>
                                                                <!--<textarea class="form-control" id="description" name="description" autocomplete="off" oninput="errorBlank('errDescription')" placeholder="Enter Description " rows="3" required></textarea>-->

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="Sentiment" class="col-sm-3 control-label">Sentiment</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <select  class="form-control " name="sentiment" id="sentiment"  required>
                                                                    <option value="<%=rs.getString("id_sentiment")%>"><%=rs.getString("sentiment")%></option>
                                                                    <%
                                                                        String sqlSentiment = "SELECT * FROM tbl_sentiment_details ";
//                                                                        System.out.println("sqlSelect-" + sqlSentiment);
                                                                        PreparedStatement stmSentiment = ConnectionDB.getDBConnection().prepareStatement(sqlSentiment);
                                                                        ResultSet rsSentiment = stmSentiment.executeQuery();
                                                                        while (rsSentiment.next()) {
                                                                    %>
                                                                    <option value="<%=rsSentiment.getString(1)%>"><%=rsSentiment.getString(2)%></option>
                                                                    <%
                                                                        }
                                                                    %>

                                                                </select>  
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="Additional" class="col-sm-3 control-label">Additional Tags</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line" id="newTag">
                                                                <!--<div class="col-lg-9 form-control"  style="display: none;" >-->
                                                                <input type="text" id="tagsold" name="tagsold" value="<%=rs.getString("tags")%>" class="form-control" placeholder="Tags" autocomplete="off" />

                                                                <input type="text" id="tags" name="tags"  class="form-control" placeholder="Tags" autocomplete="off" />
                                                            </div>
                                                            <div id="divAa" style="font-size: 14px;border:1px solid #c8cbce;display: none" class="text-white"></div>
                                                            <input type="hidden" class="txt" name="additional" id="additional" >

                                                            <!--<input type="text" class="form-control" id="Additional" name="Additional" placeholder="Additional Tags" required>-->
                                                            <!--</div>-->
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="importance" class="col-sm-3 control-label">Importance</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <select  class="form-control " name="importance" id="importance"  onclick="errorBlank('errImportance')" onchange="errorBlank('errImportance')" required>

                                                                    <%
                                                                        String importance = "";
                                                                        if (rs.getString("importance") != null) {
                                                                            importance = rs.getString("importance");
                                                                            out.println("<option value='" + importance + "'>" + importance + "</option>");
                                                                    %>
                                                                    <option value="Very Important">Very Important</option>
                                                                    <option value="Important">Important</option>
                                                                    <%
                                                                    } else {%>
                                                                    <%//                                                                                            criticality = "";
                                                                        out.println("<option value='-1'>-Select Importance-</option>");%>
                                                                    <option value="Very Important">Very Important</option>
                                                                    <option value="Important">Important</option>
                                                                    <%
                                                                        }
                                                                    %>

                                                                </select>
                                                                <span id="errImportance" class="text-danger"></span>

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="avatar-upload col-sm-12">
                                                        <div class="avatar-edit">
                                                            <input type="hidden" name="uploadImage" value="<%=rs.getString("imagepath")%>">
                                                            <input type="file" id="imageUpload"  name="upload" accept=".png, .jpg, .jpeg" />
                                                            <label for="imageUpload"></label>
                                                        </div>
                                                        <%
                                                            String fullpath = null;

                                                            if (!rs.getString("imagepath").isEmpty()) {
                                                                String path = rs.getString("imagepath");
//                                                        String fullpath=path.substring(19);
                                                                String replaceString = path.replace("\\", "/");
                                                                fullpath = "/kmsvdo/vdo/" + replaceString.substring(14);
                                                                System.out.println("fullpath:-" + fullpath);

                                                                String whiteSpace = fullpath.replace(" ", "%20");
//System.out.println("fullpath:-" + whiteSpace);


                                                        %>
                                                        <a data-toggle="modal" class="col-sm-12" data-target="#myModal" title="Click here to view in full page">
                                                            <div class="avatar-preview">

                                                                <div id="imagePreview" style="background-image: url(<%=fullpath%>);"> </div>
                                                            </div>
                                                        </a>
                                                        <!-- Modal -->
                                                        <div id="myModal" class="modal fade" role="dialog">
                                                            <div class="modal-dialog">
                                                                <!-- Modal content-->
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                        <!--<h4 class="modal-title">Modal Header</h4>-->
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <img class="img-responsive" src="<%=fullpath%>"/>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%} else {%>
                                                    <a data-toggle="modal" class="col-sm-12" data-target="#myModal" title="Click here to view in full page">
                                                        <div class="avatar-preview">

                                                            <div id="imagePreview" style="background-image: url(<%=fullpath%>);"> </div>
                                                        </div>
                                                    </a>
                                                    <%}%>
                                                    <div class="form-group">
                                                        <div class="col-sm-12 text-right">
                                                            <button type="submit" class="btn btn-danger " data-toggle="modal" data-target="#defaultModal"  id="btnSaveVideo" onclick="return saveEditData()"  >UPDATE</button>
                                                            <!--                                                            <button type="submit" class="btn btn-danger " data-toggle="modal" data-target="#defaultModal" onclick="saveEditData()" id="btnSaveVideo"  >UPDATE</button>-->
                                                        </div>
                                                    </div>
                                                    <%}%>
                                                    <!--modal-->

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
        </section>
        <div class="modal" id="myModal11" tabindex="-1" role="dialog" style="display:none">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                    </div>
                    <div class="modal-body text-center"> 
                        <br/>
                        <span class="badge bg-green font-28 p-t-10 p-b-10 p-l-30 p-r-30"><%=request.getParameter("workcode")%></span> 
                        <br>
                        <h4 id="editSuccess"></h4>
                    </div>
                    <div class="modal-footer">
                         <a href="dataentry_approver_edit_printmedia.jsp?fromSourceDate=<%=request.getParameter("fromSourceDate")%>&toSourceDate=<%=request.getParameter("toSourceDate")%>"><button type="button" class="btn btn-link waves-effect" data-dismiss="modal">CLOSE</button></a>
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
        <script src="plugins/bootstrap-material-datetimepicker/js/bootstrap-material-datetimepicker.js"></script>

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
                                                                                    $.getJSON("jsonfile_printmedia.jsp?description=" + document.getElementById("generaltag").value, {
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
        </script>
        <script>
            $('#date-end').bootstrapMaterialDatePicker({weekStart: 0, time: false});
            $('#date-start').bootstrapMaterialDatePicker({weekStart: 0, time: false}).on('change', function (e, date)
            {
                $('#date-end').bootstrapMaterialDatePicker('setMinDate', date);
            });
        </script>
        <script>
            function errorBlank(err) {
                document.getElementById(err).innerHTML = "";
            }
            function selectNewsPaper(val) {
//alert(val);
                if (val == "lang") {
                    var xhttp = new XMLHttpRequest();
                    var language = document.getElementById("language").value;
                    var urls = "get_newspaper.jsp?language=" + language;
//                    alert(urls);
                    xhttp.onreadystatechange = function () {
                        if (this.readyState == 4 && this.status == 200) {
//                        alert(this.responseText);
                            document.getElementById("newspaper").innerHTML = this.responseText;
                            $('#edition').empty();
                            $('#edition').append($('<option>', {text: 'Select Edition', value: '-1', selected: true}))
                            $('#edition').change();
                            $('#subedition').empty();
                            $('#subedition').append($('<option>', {text: 'Select Sub Edition', value: '-1', selected: true}))
                            $('#subedition').change();
                        }
                    };
                    xhttp.open("GET", urls, true);
                    xhttp.send();
                } else if (val == 'np') {
//                      $('#edition').removeAttr('selected').find('option:first').attr('selected', 'selected');
//                     
                    var xhttp = new XMLHttpRequest();
                    var language = document.getElementById("newspaper").value;
                    var urls = "get_newspaper.jsp?newspaper=" + language;
                    xhttp.onreadystatechange = function () {
                        if (this.readyState == 4 && this.status == 200) {
//                            alert(this.responseText);
                            document.getElementById("edition").innerHTML = this.responseText;
                            $('#subedition').empty();
                            $('#subedition').append($('<option>', {text: 'Select Sub Edition', value: '-1', selected: true}))
                            $('#subedition').change();
                        }
                    };
                    xhttp.open("GET", urls, true);
                    xhttp.send();
                } else if (val == 'edition')
                {
                    var xhttp = new XMLHttpRequest();
                    var language = document.getElementById("edition").value;
                    var urls = "get_newspaper.jsp?edition=" + language;
                    xhttp.onreadystatechange = function () {
                        if (this.readyState == 4 && this.status == 200) {
//                        alert(this.responseText);
                            document.getElementById("subedition").innerHTML = this.responseText;
                        }
                    };
                    xhttp.open("GET", urls, true);
                    xhttp.send();
                }

            }
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#imagePreview').css('background-image', 'url(' + e.target.result + ')');
                        $('#imagePreview').hide();
                        $('#imagePreview').fadeIn(650);
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
            $("#imageUpload").change(function () {
                readURL(this);
            });
            function removeTag(tag, id) {
//                alert(tag);
                document.getElementById("additional").value = "";
                return false;
            }
            $(function () { // DOM ready

                // ::: TAGS BOX

                $("#tags").on({
                    focusout: function () {
                        var txt = this.value.replace(/[^a-z0-9_\+\-\.\#\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]/ig, ''); // allowed characters

//                        var txt = this.value.replace(/[^a-z0-9_\+\-\.\#]/ig, ''); // allowed characters
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
        </script>
        <script>
            $(document).ready(function () {
                if (window.location.href.indexOf("success") > -1) {

                    document.getElementById('myModal11').style.display = "block";
//                    var mytext = getUrlVars()["workcode"];
//                                        alert(mytext);
                    //                    document.getElementById("mobile").value = mytext;
                    document.getElementById("editSuccess").innerHTML = "Record  updated successfully";
                    //                    window.location.href = "thanks.html";
//                    var span = document.getElementsByClassName("close")[0];
//                    span.onclick = function () {
//                        modal.style.display = "none";
//                    }
//                    window.onclick = function (event) {
//                        if (event.target == modal) {
//                            modal.style.display = "none";
//                        }
//                    }
                }
            });


        </script>
        <script>
            function onchangeCriticality() {
                var optionValues = [];
                $('#criticality option').each(function () {
                    if ($.inArray(this.value, optionValues) > -1) {
                        $(this).remove()
                    } else {
                        optionValues.push(this.value);
                    }
                });
            }
            function onchangeSentiment() {
                var optionValues = [];
                $('#sentiment option').each(function () {
                    if ($.inArray(this.value, optionValues) > -1) {
                        $(this).remove()
                    } else {
                        optionValues.push(this.value);
                    }
                });
            }
            function saveEditData() {

//                if(document.getElementById("importance").value="-1"){
//                    
//                    document.getElementById("errImportance").innerHTML="Please select Importance";
//                    document.getElementById("importance").focus();
//                    return false;
//                }
                var a = document.getElementById("divAa").innerHTML;
                var b = document.getElementById("tagsold").value;


//                alert(b + " " + a);
                document.getElementById("tags").value = b + " " + a;
//                var aa = document.getElementsByClassName("filename");
//                var abc;
//                for (var i = 0; i < aa.length; i++) {
//                    abc += aa[i].textContent + ",\n";
//                    document.getElementById("textInput").value = abc;
//                }
                document.getElementById("uploadform").submit();

            }
        </script>


    </body>
</html>
<% } else {
        response.sendRedirect("login.jsp");
    }%>

