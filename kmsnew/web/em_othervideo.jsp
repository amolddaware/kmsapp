<%-- 
    Document   : imgtest
    Created on : 23 Dec, 2020, 8:22:24 PM
    Author     : Fluidscapes
--%>

<%@page import="java.sql.Connection"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%ResourceBundle rb = ResourceBundle.getBundle("msg");%>

<%
//    if (session != null && session.getAttribute("username") != null) {

//    String role = session.getAttribute("role").toString();
    if (session != null && session.getAttribute("username") != null && session.getAttribute("role").equals("3")) {
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
<html>
    <head>
        <!--<title>ts</title>-->
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
        <!--<link rel="stylesheet" href="css/dropzone.css"/>-->
    </head>
    <body class="theme-blue">
        <jsp:include page="em_header.jsp"></jsp:include>
        <jsp:include page="em_left.jsp"></jsp:include>
            <!--<div class=" container-scroller">-->
            <!--Navbar-->


            <section class="content">
                <div class="col-md-12"> 
                    <!-- Unordered List -->
                    <div class="row clearfix">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="card">
                                <div class="header">
                                    <h2>ADD OTHER SOURCE VIDEO INFORMATION</h2>
                                    <ul class="header-dropdown m-r--5">
                                        <!--                                        <li class="dropdown"> <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="material-icons">more_vert</i> </a>
                                                                                                                                <ul class="dropdown-menu pull-right">
                                                                                                                                    <li><a href="javascript:void(0);">Action</a></li>
                                                                                                                                    <li><a href="javascript:void(0);">Another action</a></li>
                                                                                                                                    <li><a href="javascript:void(0);">Something else here</a></li>
                                                                                                                                </ul>
                                                                                </li>-->
                                    </ul>
                                </div>

                                <div class="body clearfix">
                                    <div class="col-md-10 col-lg-offset-1 well">
                                        <!-- Nav tabs -->
                                        <!--                                        <ul class="nav nav-tabs tab-nav-right" role="tablist">
                                                                                    <li role="presentation" id="informationClass" class="active"><a href="#information" data-toggle="tab">INFORMATION</a></li>
                                                                                    <li role="presentation" id="tagClass"><a href="#tag" data-toggle="tab" onclick="this.disabled=true;">TAG</a></li>
                                                                                </ul>-->
                                        <!-- Tab panes -->
                                        <div class="tab-content">
                                            <div role="tabpanel" class="tab-pane fade in active" id="information">
                                                <!--<b>INFORMATION Content</b>-->
                                                <section>
                                                    <div>
                                                        <form action="<%=request.getContextPath()%>/emaddothervideo.do" method="post" class="dropzone" id="my-awesome-dropzone" enctype="multipart/form-data">
                                                        <!--<input type="hidden"  id="textInput" name="getUpload" >-->
                                                        <%--<input id="token" name="token" type="hidden" value="<%=token%>" />--%>
                                                        <div class="form-group">
                                                            <label for="channel" class="col-sm-3 control-label">Channel Name</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <select  class="form-control " name="channel" id="channel" onchange="errorBlank('errChannel')"  required>
                                                                        <option value="-1">-Select Channel -</option>
                                                                        <%Connection dh = null;
                                                                            PreparedStatement stmSelect = null;
                                                                            ResultSet rsSelect = null;
                                                                            try {
                                                                                ConnectionDB conn = new ConnectionDB();
                                                                                dh = conn.getConnection();

                                                                                String sqlSelect = "SELECT * FROM tbl_television_master order by telename ";
                                                                                System.out.println("sqlSelect-" + sqlSelect);
                                                                                stmSelect = dh.prepareStatement(sqlSelect);
                                                                                rsSelect = stmSelect.executeQuery();
                                                                                while (rsSelect.next()) {
                                                                        %>
                                                                        <option value="<%=rsSelect.getString(2)%>"><%=rsSelect.getString(2)%></option>
                                                                        <%
                                                                                }
                                                                            } catch (Exception e) {
                                                                                System.out.println("error in television :" + e.getMessage());
                                                                            } finally {
                                                                                if (stmSelect != null) {
                                                                                    stmSelect.close();
                                                                                }
                                                                                if (rsSelect != null) {
                                                                                    rsSelect.close();
                                                                                }
                                                                               
                                                                            }
                                                                        %>
                                                                    </select>   
                                                                    <span id="errChannel" class="text-danger"></span>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="Program" class="col-sm-3 control-label">Title (English) </label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" id="subjectTag">
                                                                    <input type="text" class="form-control" name="subject" autocomplete="off" oninput="errorBlank('errSubject')" id="subject"  placeholder="Enter  Title" required>
                                                                    <span id="errSubject" class="text-danger"></span>
                                                                    <!--<input type="text" class="form-control" id="Program" name="Program" placeholder="Title / Name of Program" required>-->
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="title" class="col-sm-3 control-label">Title (Marathi)</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <input type="text" class="form-control" id="titlemarathi" name="titlemarathi" placeholder="Title (Marathi)" oninput="errorBlank('errMarathiTitle')"  >
                                                                    <!--<textarea class="form-control" id="description" name="description" autocomplete="off" oninput="errorBlank('errDescription')" placeholder="Enter Description " rows="3" required></textarea>-->
                                                                    <span class="text-danger" id="errMarathiTitle"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="Details" class="col-sm-3 control-label">Details / Topic / Information of Program</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <textarea type="text" class="form-control" id="description" name="description" oninput="errorBlank('errDescription')" placeholder="Details / Topic / Information of Program" rows="3" required></textarea>
                                                                    <!--<textarea class="form-control" id="description" name="description" autocomplete="off" oninput="errorBlank('errDescription')" placeholder="Enter Description " rows="3" required></textarea>-->
                                                                    <span id="errDescription" class="text-danger"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <!--<div class="form-group">
                                                            <label for="Criticality" class="col-sm-3 control-label">Criticality</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <select  class="form-control " name="criticality" id="criticality" onchange="errorBlank('errCriticality')"  required>
                                                                        <option value="">-Select Criticality-</option>
                                                                        <option value="High">High</option>
                                                                        <option value="Low">Low</option>
                                                                        <option value="Medium">Medium</option>
                                                                    </select>   
                                                                    <span id="errCriticality" class="text-danger"></span>
                                                                </div>
                                                            </div>
                                                        </div>-->
                                                        <div class="form-group">
                                                            <label for="sourcedate" class="col-sm-3 control-label"> Source Date</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" >
                                                                    <!--<div class="col-lg-9 form-control"  style="display: none;" >-->
                                                                    <input type="text" id="date-start"  name="sourcedate"  class="form-control" oninput="errorBlank('errSourcedate')"  placeholder="Source Date" autocomplete="off" />
                                                                </div>
                                                                <span id="errSourcedate" class="text-danger" style="display: none"></span>


                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="Sentiment" class="col-sm-3 control-label">Sentiment</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <select  class="form-control " name="sentiment" id="sentiment" onchange="errorBlank('errSentiment')"  required>
                                                                        <option value="">-Select Sentiment-</option>
                                                                        <%
                                                                            PreparedStatement stmSentiment = null;
                                                                            ResultSet rsSentiment = null;
//                                                                            Connection dh = null;
//                                                                            ResultSet rs = null;
//                                                                            ConnectionDB conn = new ConnectionDB();
//                                                                            dh = conn.getConnection();
                                                                           
                                                                            try {
                                                                                String sqlSentiment = "SELECT * FROM tbl_sentiment_details ";
                                                                                System.out.println("sqlSelect-" + sqlSentiment);
                                                                                stmSentiment = dh.prepareStatement(sqlSentiment);
                                                                                rsSentiment = stmSentiment.executeQuery();
                                                                                while (rsSentiment.next()) {
                                                                        %>
                                                                        <option value="<%=rsSentiment.getString(2)%>"><%=rsSentiment.getString(2)%></option>
                                                                        <%
                                                                                }
                                                                            } catch (Exception e) {
                                                                                e.printStackTrace();
                                                                            } finally {
                                                                                if (stmSentiment != null) {
                                                                                    stmSentiment.close();
                                                                                }

                                                                                if (rsSentiment != null) {
                                                                                    rsSentiment.close();
                                                                                }
 if (dh != null) {
                                                                                    dh.close();
                                                                                }
                                                                            }

                                                                        %>  </select>  
                                                                    <span id="errSentiment" class="text-danger"></span>

                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="Additional" class="col-sm-3 control-label"> Tags</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" id="newTag">
                                                                    <!--<div class="col-lg-9 form-control"  style="display: none;" >-->
                                                                    <input type="text" id="tags" name="tags"  class="form-control" oninput="errorBlank('errTag')"  placeholder="Tags" autocomplete="off" oninput="errBlank('errTag')" />
                                                                </div>
                                                                <span id="errTag" class="text-danger" style="display: none"></span>


                                                                <div id="divAa" style="font-size: 14px;border:1px solid #c8cbce;display: none" class="text-white"></div>
                                                                <!--<input type="hidden" class="txt" name="additional" id="additional" >-->
                                                                <!--<input type="text" class="form-control" id="Additional" name="Additional" placeholder="Additional Tags" required>-->
                                                                <!--</div>-->
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <div class="col-md-9 col-sm-offset-3">
                                                                <!--                                                                  <div action="/" id="frmFileUpload" class="dropzone" method="post" enctype="multipart/form-data">
                                                                                         
                                                                                                                                                                                            <div  class="dropzone" >
                                                                                                                                                                                                <div class="dz-message">
                                                                                                                                                                                                    <div id="dragandrophandler" class="drag-icon-cph"> <i class="material-icons">touch_app</i> </div>
                                                                                                                                                                                                    <h3>Drop files here or click to upload.</h3>
                                                                                                                                                                                                    <em>(This is just a demo dropzone. Selected files are <strong>not</strong> actually uploaded.)</em> </div>
                                                                                                                                                                                                <div class="fallback">
                                                                                                                                                                                                    <input name="file" type="file" multiple />
                                                                                                                                                                                                </div>
                                                                                                                                                                                            </div>-->
                                                                <div id="frmFileUpload" class="dropzone" onchange="errorBlank('errDragnDrop')" enctype="multipart/form-data">
                                                                    <div class="dropzone-previews"  ></div>
                                                                    <div class="dz-message">
                                                                        <div class="drag-icon-cph"> <i class="material-icons">touch_app</i> </div>
                                                                        <h3>Drop files here or click to upload.</h3>
                                                                        <em>(This is just a demo dropzone. Selected files are <strong>not</strong> actually uploaded.)</em> </div>
                                                                    <div class="fallback">
                                                                        <input name="file" id="uploadFiles" type="file" onchange="errorBlank('errDragnDrop')" multiple />
                                                                    </div>
                                                                    <span id="errDragnDrop" class="text-danger"></span>

                                                                </div>
                                                                <!--
                                                                                                                                                                                            </div>-->
                                                                <!--                                                                <div class="dragandrophandler1" >
                                                                                                                                    <div class="dropzone-previews"  ></div>
                                                                
                                                                                                                                    <div class="fallback">
                                                                                                                                        <input name="file" type="file" id="fileName" multiple/>
                                                                                                                                    </div>
                                                                
                                                                                                                                    <span id="errDragnDrop" class="text-danger"></span>
                                                                                                                                </div>-->

                                                                <br/>
                                                                <div class="form-group">
                                                                    <div id="status1"></div>
                                                                    <input type="hidden" oninput="errorBlank('errDragnDrop')" onblur="errorBlank('errDragnDrop')" id="uploadstatus">
<!--                                                                    <input type="hidden" id="tempvideo" name="tempvideo">
                                                                    <input type="hidden" id="newFilename" name="newFilename">-->
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-sm-12 text-right">
                                                                <button type="submit" id="submit-all" class="btn btn-primary btn-xs"   >SAVE</button>
                                                                <!--<button type="submit" class="btn btn-primary btn-xs" id="submit-all" data-toggle="modal" data-target="#defaultModal" onclick="return saveData()" id="btnSaveVideo"  disabled="true">SAVE</button>-->
                                                            </div>
                                                        </div>

                                                    </form>
                                                    <!--<button type="submit" id="submit-all" class="btn btn-primary btn-xs">Upload the file</button>-->

                                                </div>
                                            </section>
                                        </div>

                                    </div>
                                    <!--                                        <div id="wizard_horizontal">
                                                                                
                                                                                <h2>Information</h2>
                                                                                
                                                                            <h2>Tag</h2>
                                                                            
                                                                        </div>-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- #END# Unordered List --> 
            </div>
           
            <%--
<div class="modal  bodyBackground" id="myModel1" tabindex="-1" role="dialog" style="display: none">
<div class="modal-dialog m-t-125" role="document">
<div class="modal-content">
<div class="modal-header">
<h4 class="modal-title text-center" id="defaultModalLabel">Workcode Entry</h4>
</div>
<div class="modal-body text-center">
<!--<div id="sameEntryExist" class="text-danger"></div>-->
<%
String workcode = "";
if (request.getParameter("workcode") != null) {
workcode = request.getParameter("workcode");
//                                                                            out.println(request.getParameter("workcode"));
}%>

                            <p class="text-success semi-bold" style="font-size:18px">Generated Video Reference Number  is:-<%=workcode%> </p>

                            <!--<iframe width="560" height="315" src="https://www.youtube.com/embed/u3xKgwKUQLc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>-->
                        </div>
                        <div class="modal-footer">
                            <!--<a >TAG</a>-->
                            <a href="em_videoadd.jsp"> <button type="button" class="btn btn-link waves-effect"  data-dismiss="#myModel1" onclick="closeDiv1()">CLOSE</button></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal  m-t-125" id="myModelTag" tabindex="-1" role="dialog" style="display: none">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title text-center" id="defaultModalLabel">Tags Entry</h4>
                        </div>
                        <div class="modal-body text-center">
                            <p class="text-success semi-bold" style="font-size:18px">Thank you! All stages record has been saved successfully. Want to save another record please click on Continue.</p>

                            <!--<iframe width="560" height="315" src="https://www.youtube.com/embed/u3xKgwKUQLc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>-->
                        </div>
                        <div class="modal-footer">
                            <!--<a >TAG</a>-->
                            <a href="newsinformation_dataentry_1.jsp"><button type="button" class="btn btn-link waves-effect"  data-dismiss="#myModel1" onclick="closeDiv1()">CLOSE</button></a>
                        </div>
                    </div>
                </div>
            </div>
            <div id="displayAvailable" class="modal  bodyBackground" style="display:none">
                <!-- Modal content -->
                <div class="modal-dialog m-t-125" role="document">

                    <div class="modal-content ">
                        <div class="modal-header">
                            <h4 class="modal-title text-center" id="defaultModalLabel">Same Entry</h4>
                        </div>
                        <div class="modal-body text-center">
                            <!--<div id=""></div>-->
                            <p class="text-danger semi-bold" id="showExist" style="font-size:18px"><%
                                //                                                               String message="";
                                //                                                                if(request.getAttribute("filename")!=null){
                                //                                                                   message=request.getAttribute("filename").toString();
                                //                                                                System.out.println("The:-"+message +" file already exist. Please choose another file.");    
                                //                                                                }
                                //                                                                out.println(message);
                                %> </p>
                        </div>
                        <div class="modal-footer">
                            <a href="em_videoadd.jsp"> <button class="btn btn-primary" onclick="closeFileExistDiv()">Close</button></a>
                        </div>
                    </div>
                </div>
            </div>
            <div id="displayFileFormat" class="modal bodyBackground" style="display: none">
                <!-- Modal content -->
                <div class="modal-dialog m-t-125" role="document">

                    <div class="modal-content"><div class="modal-header">
                            <h4 class="modal-title text-center" id="defaultModalLabel">File Entry</h4>
                        </div>
                        <div class="modal-body text-center">

                            <!--<div id=""></div>-->
                            <p class="text-success semi-bold" id="demotext" style="font-size:18px"> File format not match. Please dragndrop .mp4 file </p>
                        </div>
                        <div class="modal-footer">

                            <a href="em_videoadd.jsp">     <button class="btn btn-primary" onclick="closeFileDiv()">Close</button></a>
                        </div>
                    </div>
                </div>
            </div>--%>
   <div id="saveRecord" class="modal bodyBackground" style="display: none">
                <!-- Modal content -->
                <div class="modal-dialog m-t-125" role="document">

                    <div class="modal-content"><div class="modal-header">
                            <!--<h4 class="modal-title text-center" id="defaultModalLabel">File Entr</h4>-->
                        </div>
                        <div class="modal-body text-center">

                            <!--<div id=""></div>-->
                            <p class="text-success semi-bold" id="demotext" style="font-size:18px"> Record saved successfully</p>
                        </div>
                        <div class="modal-footer">

                            <a href="em_othervideo.jsp">     <button class="btn btn-primary" onclick="closeFileDiv()">Close</button></a>
                        </div>
                    </div>
                </div>
            </div>


        </section>
        <!--<input type="text" name="status" id="textInput">-->
        <!--<form>-->
        <input type="hidden" id="fd">





        <!-- Jquery Core Js --> 
        <!--<script src="plugins/jquery/jquery.min.js"></script>--> 
        <script src="js/jquery-1.12.4.js"></script>
        <!--<script src="plugins/jquery/jquery.min.js"></script>-->
        <script src="js/jquery-ui.js"></script>
        <!-- Bootstrap Core Js --> 

        <!--<script src="plugins/jquery/jquery.min.js"></script>--> 

        <!-- Bootstrap Core Js --> 
        <script src="plugins/bootstrap/js/bootstrap.js"></script> 

        <!-- Select Plugin Js --> 
        <script src="plugins/bootstrap-select/js/bootstrap-select.js"></script> 

        <!-- Slimscroll Plugin Js --> 
        <script src="plugins/jquery-slimscroll/jquery.slimscroll.js"></script> 

        <!-- Bootstrap Colorpicker Js --> 
        <script src="plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script> 

        <!-- Dropzone Plugin Js --> 
        <script src="js/dropzone.js"></script> 
        <!--<script src="plugins/dropzone/dropzone.js"></script>--> 

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

        <!-- Custom Js --> 
        <script src="js/admin.js"></script> 
        <script src="js/pages/forms/form-validation.js"></script> 
        <script src="js/pages/forms/form-wizard.js"></script> 
        <!--<script src="js/pages/forms/basic-form-elements.js"></script>--> 
        <!--<script src="js/pages/forms/advanced-form-elements.js"></script>--> 

        <!--Demo Js-->  
        <script src="js/demo.js"></script>
        <script type="text/javascript">
                                                                        $(function () { // DOM ready

                                                                            // ::: TAGS BOX

                                                                            $("#newTag input").on({
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
                                                                                    if (/(13|32)/.test(ev.which))
                                                                                        $(this).focusout();
                                                                                    return false;
                                                                                }
                                                                            });
                                                                            $('#newTag').on('click', 'span,button', function () {
                                                                                if (confirm("Remove " + $(this).text() + "?"))
                                                                                    $(this).remove();
                                                                            });
                                                                        });
//                                function alphanumeric_only() {
//                                    var splChars = "*|,\":<>[]{}`\';()@&$#% ";
//                                    var filename = document.getElementById("fileName").value; //your fileupload file name\
//                                    alert("ttt:" + filename);
//
//                                    for (var i = 0; i < filename.length; i++) {
//                                        if (splChars.indexOf(filename.charAt(i)) != -1) {
//                                            alert("Illegal characters detected!");
//                                            document.getElementById("fileName").focus();
//                                            return false;
//                                        } else
//                                        {
//                                            return true;
//                                        }
//                                    }
//                                }
                                                                        // The camelized version of the ID of the form element
                                                                        Dropzone.options.myAwesomeDropzone = {
                                                                            // set following configuration
                                                                            autoProcessQueue: false,
                                                                            uploadMultiple: true,
					  				 timeout: 1800000,
                                                                            parallelUploads: 100,
                                                                            maxFiles: 100,
                                                                            maxFilesize: 5120,
                                                                            addRemoveLinks: true,
                                                                            previewsContainer: ".dropzone-previews",
                                                                            dictRemoveFile: "Remove",
                                                                            dictCancelUpload: "Cancel",
                                                                            dictDefaultMessage: "Drop the images you want to upload here",
                                                                            dictFileTooBig: "Image size is too big. Max size: 5120mb.",
                                                                            dictMaxFilesExceeded: "Only 100 images allowed per upload.",
                                                                            acceptedFiles: ".jpeg,.jpg,.png,.gif,.JPEG,.JPG,.PNG,.GIF,.mp4,.mov",
                                                                            renameFile: function (file) {
//                                        string.replace(/[^a-zA-Z0-9]/g,'_');
//                                        var fff = file.name;
//                                        var ffffile = fff.replace(/[\W_]/g, "_");
                                                                                var newName = new Date().getDate() + "-" + (new Date().getMonth() + 1) + "-" + new Date().getFullYear() + "-" + new Date().getTime() + '_' + file.name;
//                                        var newName = new Date().getTime() + '_' + ffffile  ;
                                                                                var test = newName.replace(/(?:\.(?![^.]+$)|[^\w.])+/g, "");
//  newName = newName.replace(/[\W_]/g, "_");
//                                        alert(test);
                                                                                return test;
//                                        return newName;
                                                                            },
                                                                            // The setting up of the dropzone
                                                                            init: function () {
                                                                                var myDropzone = this;
                                                                                // Upload images when submit button is clicked.

                                                                                $("#submit-all").click(function (e) {

//                                        alert(myDropzone.getUploadingFiles().length);
                                                                                    e.preventDefault();
                                                                                    e.stopPropagation();
                                                                                    var abc;
                                                                                    var subject = document.getElementById("subject").value;
                                                                                    var channel = document.getElementById("channel").value;
                                                                                    var titlemarathi = document.getElementById("titlemarathi").value;
                                                                                    var description = document.getElementById("description").value;
                                                                                    var sentiment = document.getElementById("sentiment").value;
                                                                                    var tags = document.getElementById("tags").value;
                                                                                    var sourcedate = document.getElementById("date-start").value;
//                                            var uploadstatus = document.getElementById("uploadstatus").value;

//            if(abc!=""){       

                                                                                    if (channel == "-1") {
                                                                                        document.getElementById("errChannel").innerHTML = "Please select channel";
                                                                                        document.getElementById("channel").focus();
                                                                                        return false;
                                                                                    }
                                                                                    if (subject == "") {
                                                                                        document.getElementById("errSubject").innerHTML = "Please Enter Subject";
                                                                                        document.getElementById("subject").focus();
                                                                                        return false;
                                                                                    }
                                                                                    if (titlemarathi == "") {
                                                                                        document.getElementById("errMarathiTitle").innerHTML = "Please Enter Title Marathi";
                                                                                        document.getElementById("titlemarathi").focus();
                                                                                        return false;
                                                                                    }
                                                                                    if (description == "") {
                                                                                        document.getElementById("errDescription").innerHTML = "Please Enter Description";
                                                                                        document.getElementById("description").focus();
                                                                                        return false;
                                                                                    }
                                                                                    if (sourcedate == "") {

                                                                                        document.getElementById("errSourcedate").innerHTML = "Please select sourcedate";
                                                                                        document.getElementById("date-start").focus();
//        document.getElementById("tags").focus();
                                                                                        return false;
                                                                                    }
                                                                                    if (sentiment == "") {
                                                                                        document.getElementById("errSentiment").innerHTML = "Please Select Sentiment";
                                                                                        document.getElementById("sentiment").focus();
                                                                                        return false;
                                                                                    }
                                                                                    if (tags == "" && $('#divAa:empty').length) {

                                                                                        document.getElementById("errTag").style.display = "block";
                                                                                        document.getElementById("errTag").innerHTML = "Please enter tags";
                                                                                        document.getElementById("tags").focus();
//        document.getElementById("tags").focus();
                                                                                        return false;
                                                                                    }

//                                            alert(myDropzone.getUploadingFiles().length);
                                                                                    if (myDropzone.files.length === 0) {
                                                                                        document.getElementById("errDragnDrop").innerHTML = "Please upload files";
//                                                document.getElementById("uploadFiles").focus();
                                                                                        return false;
                                                                                    } else {
                                                                                        var a = document.getElementById("divAa").innerHTML;
//                alert(a);
                                                                                        document.getElementById("tags").value = a;
                                                                                        myDropzone.processQueue();
                                                                                    }
                                                                                });
                                                                                this.on("addedfile", function () {
                                                                                    if (this.files[1] != null) {
//        this.removeFile(this.files[0]);
//alert("test");
                                                                                        document.getElementById("errDragnDrop").innerHTML = '';
                                                                                    }
                                                                                });
                                                                                // Refresh page when all images are uploaded
                                                                                myDropzone.on("complete", function (file) {
                                                                                    if (myDropzone.getUploadingFiles().length === 0 && myDropzone.getQueuedFiles().length === 0) {
//                                                                                        window.location.reload();
                                                                                        document.getElementById("saveRecord").style.display = "block";
                                                                                    }
                                                                                });
                                                                            }
                                                                        }
                                                                        $('#date-start').bootstrapMaterialDatePicker({weekStart: 0, time: false});
        </script>
    </body>
</html>

<%} else {
        response.sendRedirect("login.jsp");
    }%>
