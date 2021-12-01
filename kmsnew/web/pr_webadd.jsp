<%-- 
    Document   : dragndrop1
    Created on : Dec 18, 2017, 8:34:23 PM
    Author     : Amol
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%ResourceBundle rb = ResourceBundle.getBundle("msg");%>

<%
//    if (session != null && session.getAttribute("username") != null) {

//    String role = session.getAttribute("role").toString();
    if (session != null && session.getAttribute("username") != null && session.getAttribute("role").equals("4")) {
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
        <!-- Required meta tags -->
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
        <!--<link href="plugins/dropzone/dropzone.css" rel="stylesheet"/>-->

        <!-- Bootstrap Select Css -->
        <link href="plugins/bootstrap-select/css/bootstrap-select.css" rel="stylesheet" />

        <!-- Custom Css -->
        <link href="css/style.css" rel="stylesheet" />

        <!-- AdminBSB Themes. You can choose a theme from css/themes instead of get all themes -->
        <link href="css/themes/all-themes.css" rel="stylesheet" />


        <link href="css/jquery-ui.css" rel="stylesheet">
        <!--<link href="http://cdn.rawgit.com/davidstutz/bootstrap-multiselect/master/dist/css/bootstrap-multiselect.css"  rel="stylesheet" type="text/css" />-->
        <!--<script src="js/jquery.multiselect.js"></script>-->

        <script>
            function errorBlank(err) {
                document.getElementById(err).innerHTML = "";
            }
        </script>
        <style >


            .modal-backdrop {
                background-color: rgba(0,0,0,.0001) !important;
            }
        </style>

    </head>

    <body class="theme-blue" id="bodyBack">
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

        <jsp:include page="pr_header.jsp"></jsp:include>
        <jsp:include page="pr_left.jsp"></jsp:include>
            <!--<div class=" container-scroller">-->
            <!--Navbar-->


            <section class="content">
                <div class="col-md-12"> 
                    <!-- Unordered List -->
                    <div class="row clearfix">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="card">
                                <div class="header">
                                    <h2>ADD WEB MEDIA INFORMATION</h2>
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
                                                                                    <li role="presentation" id="tagClass"><a href="#tag" data-toggle="tab" onclick="this.disabled = true;">TAG</a></li>
                                                                                </ul>-->
                                        <!-- Tab panes -->
                                        <div class="tab-content">
                                            <div role="tabpanel" class="tab-pane fade in active" id="information">
                                                <!--<b>INFORMATION Content</b>-->
                                                <section>
                                                    <div>
                                                        <form class="form-horizontal m-t-30" action="<%=request.getContextPath()%>/addprintweb.do"  id="uploadwebform" method="post" accept-charset="UTF-8" >
                                                        <!--<input type="hidden"  id="textInput" name="getUpload" >-->
                                                        <input id="token" name="token" type="hidden" value="<%=token%>" />
                                                        <div class="form-group">
                                                            <label for="date" class="col-sm-3 control-label">Date</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" >
                                                                    <input type="text" class="form-control" id="date" onblur="errBlank('errDate')" name="sourcedate" placeholder="Date" >
                                                                    <span id="errDate" class="text-danger"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="language" class="col-sm-3 control-label">Language</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <select  class="form-control " name="language" id="language" onchange="errBlank('errLanguage')" >
                                                                        <option value="-1">Select Language</option>
                                                                        <%
                                                                            Connection dh = null;
                                                                            ResultSet rs = null;
                                                                            ConnectionDB conn = new ConnectionDB();
                                                                            dh = conn.getConnection();
                                                                            PreparedStatement stmSelect = null;
                                                                            ResultSet rsSelect = null;
                                                                            try {
                                                                                try {
                                                                                    String sqlSelect = "SELECT * FROM tbl_language_master ";
                                                                                    System.out.println("sqlSelect-" + sqlSelect);
                                                                                    stmSelect = dh.prepareStatement(sqlSelect);
                                                                                    rsSelect = stmSelect.executeQuery();
                                                                                    while (rsSelect.next()) {
                                                                        %>
                                                                        <option value="<%=rsSelect.getString(2)%>"><%=rsSelect.getString(2)%></option>
                                                                        <%
                                                                                }
                                                                            } catch (Exception e) {
                                                                                e.printStackTrace();
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
                                                                    <span id="errLanguage" class="text-danger"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="newspaper" class="col-sm-3 control-label">Web portal name</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" id="idnewspaper">
                                                                    <select  class="form-control " name="webmedianame" id="webmedianame" onchange="errBlank('errWebmedianame')" >
                                                                        <option value="-1">-Select Web Media-</option>
                                                                        <%                                                                            PreparedStatement stmSelectWeb = null;
                                                                            ResultSet rsSelectWeb = null;
                                                                            try {
                                                                                String sqlSelectWeb = "SELECT * FROM tbl_webportal_master order by portal_name";
                                                                                System.out.println("sqlSelect-" + sqlSelectWeb);
                                                                                stmSelectWeb = dh.prepareStatement(sqlSelectWeb);
                                                                                rsSelectWeb = stmSelectWeb.executeQuery();
                                                                                while (rsSelectWeb.next()) {
                                                                        %>
                                                                        <option value="<%=rsSelectWeb.getString(2)%>"><%=rsSelectWeb.getString(2)%></option>
                                                                        <%
                                                                                }
                                                                            } catch (Exception e) {
                                                                                e.printStackTrace();
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
                                                                    <span class="text-danger" id="errWebmedianame"></span>
                                                                    <!--<input type="text" class="form-control" id="Program" name="Program" placeholder="Title / Name of Program" required>-->

                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="district" class="col-sm-3 control-label">District</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <select  class="form-control " name="district" id="district" onchange="errBlank('errDistrict')" >
                                                                        <option value="-1">Select District</option>
                                                                        <%                                                                            PreparedStatement stmSelectDistrict = null;
                                                                            ResultSet rsSelectDistrict = null;
                                                                            try {
                                                                                String sqlSelect1 = "SELECT * FROM district ";
                                                                                System.out.println("sqlSelect-" + sqlSelect1);
                                                                                stmSelectDistrict = dh.prepareStatement(sqlSelect1);
                                                                                rsSelectDistrict = stmSelectDistrict.executeQuery();
                                                                                while (rsSelectDistrict.next()) {
                                                                        %>
                                                                        <option value="<%=rsSelectDistrict.getString(2)%>"><%=rsSelectDistrict.getString(2)%></option>
                                                                        <%
                                                                                }
                                                                            } catch (Exception e) {
                                                                                e.printStackTrace();
                                                                            } finally {
                                                                                if (stmSelectDistrict != null) {
                                                                                    stmSelectDistrict.close();
                                                                                }
                                                                                if (rsSelectDistrict != null) {
                                                                                    rsSelectDistrict.close();
                                                                                }
                                                                            }
                                                                        %>
                                                                    </select>   
                                                                    <span class="text-danger" id="errDistrict"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="title" class="col-sm-3 control-label">Title (English)</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <input type="text" class="form-control" id="subject" name="subject" placeholder="Title (English)" oninput="errBlank('errSubject')"  >
                                                                    <!--<textarea class="form-control" id="description" name="description" autocomplete="off" oninput="errorBlank('errDescription')" placeholder="Enter Description " rows="3" required></textarea>-->
                                                                    <span class="text-danger" id="errSubject"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="title" class="col-sm-3 control-label">Title (Marathi)</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <input type="text" class="form-control" id="titlemarathi" name="titlemarathi" placeholder="Title (Marathi)" oninput="errBlank('errMarathiTitle')"  >
                                                                    <!--<textarea class="form-control" id="description" name="description" autocomplete="off" oninput="errorBlank('errDescription')" placeholder="Enter Description " rows="3" required></textarea>-->
                                                                    <span class="text-danger" id="errMarathiTitle"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="Sentiment" class="col-sm-3 control-label">Sentiment</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <select  class="form-control " name="sentiment" id="sentiment" onchange="errBlank('errSentiment')" >
                                                                        <option value="-1">-Select Sentiment-</option>
                                                                        <%
                                                                            PreparedStatement stmSentiment = null;
                                                                            ResultSet rsSentiment = null;
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
                                                                            }

                                                                        %>
                                                                    </select>  
                                                                    <span class="text-danger" id="errSentiment"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="Additional" class="col-sm-3 control-label"> Tags</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" id="newTag">
                                                                    <!--<div class="col-lg-9 form-control"  style="display: none;" >-->
                                                                    <input type="text" id="tags" name="tags"  class="form-control" placeholder="Tags" autocomplete="off" oninput="errBlank('errTag')" />
                                                                </div>   
                                                                <span id="errTag" class="text-danger"></span>

                                                                <div id="divAa" style="font-size: 14px;border:1px solid #c8cbce;display: none" class="text-white"></div>
                                                                <input type="hidden" class="txt" name="additional" id="additional" >
                                                                <!--<input type="text" class="form-control" id="Additional" name="Additional" placeholder="Additional Tags" required>-->
                                                                <!--</div>-->
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="link" class="col-sm-3 control-label">Link</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" >
                                                                    <!--<div class="col-lg-9 form-control"  style="display: none;" >-->
                                                                    <input type="text" id="link" name="link"  class="form-control" placeholder="Link" autocomplete="off" oninput="errBlank('errLink')" />
                                                                    <span id="errLink" class="text-danger"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-sm-12 text-right">
                                                                <button class="btn btn-danger" onclick="return saveSubmitBtnInfo();">SAVE</button>
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
                <% } catch (Exception e) {

                        e.printStackTrace();

                    }
                    if (dh != null) {

                        dh.close();
                    }
                %>
                <!-- #END# Unordered List --> 
            </div>
            <div class="modal  m-t-125" id="sameEntry" tabindex="-1" role="dialog" style="display: none">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title text-center" id="defaultModalLabel">Same Entry</h4>
                        </div>
                        <div class="modal-body text-center">
                            <div id="sameEntryExist" class="text-danger"></div>
                            <!--<iframe width="560" height="315" src="https://www.youtube.com/embed/u3xKgwKUQLc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>-->
                        </div>
                        <div class="modal-footer">
                            <a href="newsinformation_dataentry_1.jsp"> <button type="button" class="btn btn-link waves-effect" data-dismiss="modal">CLOSE</button></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal bodyBackground" id="myModel1" tabindex="-1" role="dialog" style="display: none">
                <div class="modal-dialog m-t-125" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title text-center" id="defaultModalLabel">Workcode Entry</h4>
                        </div>
                        <div class="modal-body text-center">
                            <!--<div id="sameEntryExist" class="text-danger"></div>-->
                            <%                                String workcode = "";
                                if (request.getParameter("workcode") != null) {
                                    workcode = request.getParameter("workcode");
                                    //                                                                            out.println(request.getParameter("workcode"));
                                }%>

                            <p class="text-success semi-bold" style="font-size:18px">Generated Web Media Reference Number  is:-<%=workcode%> </p>

                            <!--<iframe width="560" height="315" src="https://www.youtube.com/embed/u3xKgwKUQLc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>-->
                        </div>
                        <div class="modal-footer">
                            <!--<a >TAG</a>-->
                            <a href="pr_webadd.jsp"> <button type="button" class="btn btn-link waves-effect"  data-dismiss="#myModel1" >CLOSE</button></a>
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
        </section>

        <div id="displayFileFormat" class="modal" style="display: none">
            <!-- Modal content -->
            <div class="modal-content">
                <div class="row mb-2 text-center">
                    <!--<span class="close">&times;</span>-->
                    <div class="col-lg-12">

                        <!--<div id=""></div>-->
                        <p class="text-success semi-bold" id="demotext" style="font-size:18px"> File format not match. Please dragndrop .mp4 file </p>
                    </div>
                    <div class="col-lg-12">
                        <button class="btn btn-primary" onclick="closeFileDiv()">Close</button></a>
                    </div>
                </div>
            </div>
        </div>
        <div id="displayAvailable" class="modal" style="visibility: hidden">
            <!-- Modal content -->
            <div class="modal-content">
                <div class="row mb-2 text-center">
                    <!--<span class="close">&times;</span>-->
                    <div class="col-lg-12">

                        <!--<div id=""></div>-->
                        <p class="text-success semi-bold" id="showExist" style="font-size:18px"><%
                            //                                                               String message="";
                            //                                                                if(request.getAttribute("filename")!=null){
                            //                                                                   message=request.getAttribute("filename").toString();
                            //                                                                System.out.println("The:-"+message +" file already exist. Please choose another file.");    
                            //                                                                }
                            //                                                                out.println(message);
                            %> </p>
                    </div>
                    <div class="col-lg-12">
                        <button class="btn btn-primary" onclick="closeFileExistDiv()">Close</button></a>
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
                            $(function () {
                                function split(val) {
                                    return val.split(/,\s*/);
                                }
                                function extractLast(term) {
                                    return split(term).pop();
                                }

                                $("#generaltag")
                                        .autocomplete({
                                            source: function (request, response) {
                                                $.getJSON("jsonfile_printmedia.jsp?description=" + document.getElementById("generaltag").value, {
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
                                $("#tags")
                                        .autocomplete({
                                            source: function (request, response) {
                                                $.getJSON("jsonfile_mediaroom.jsp?description=" + document.getElementById("tags").value, {
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

        <script type="text/javascript">
            function errBlank(err) {
                document.getElementById(err).innerHTML = "";
            }
            function saveSubmitBtnInfo() {

                if (document.getElementById("date").value == "") {

                    document.getElementById("errDate").innerHTML = "Please select Date";
                    document.getElementById("date").focus();
                    return false;
                }
                if (document.getElementById("language").value == "-1") {

                    document.getElementById("errLanguage").innerHTML = "Please select Language";
                    document.getElementById("language").focus();
                    return false;
                }
                if (document.getElementById("webmedianame").value == "-1") {

                    document.getElementById("errWebmedianame").innerHTML = "Please select Web Media";
                    document.getElementById("webmedianame").focus();
                    return false;
                }
                if (document.getElementById("district").value == "-1") {

                    document.getElementById("errDistrict").innerHTML = "Please select District";
                    document.getElementById("district").focus();
                    return false;
                }
                if (document.getElementById("subject").value == "") {

                    document.getElementById("errSubject").innerHTML = "Please enter Title";
                    document.getElementById("subject").focus();
                    return false;
                }
                if (document.getElementById("titlemarathi").value == "") {

                    document.getElementById("errMarathiTitle").innerHTML = "Please enter Marathi Title";
                    document.getElementById("titlemarathi").focus();
                    return false;
                }
                if (document.getElementById("sentiment").value == "-1") {

                    document.getElementById("errSentiment").innerHTML = "Please select Sentiment";
                    document.getElementById("sentiment").focus();
                    return false;
                }
                if (document.getElementById("link").value == "") {

                    document.getElementById("errLink").innerHTML = "Please enter link";
                    document.getElementById("link").focus();
                    return false;
                }
                if (document.getElementById("tags").value == "" && $('#divAa:empty').length) {

                    document.getElementById("errTag").innerHTML = "Please enter Tag";
                    document.getElementById("tags").focus();
                    return false;
                }

                var a = document.getElementById("divAa").innerHTML;

//                alert(a);
                document.getElementById("tags").value = a;
//                alert(a);
                document.getElementById("uploadwebform").submit();
            }
            function removeTag(tag, id) {
//                alert(tag);
                document.getElementById("additional").value = "";
                return false;
            }
            $(function () { // DOM ready

                // ::: TAGS BOX

                $("#newTag input").on({
                    focusout: function () {
                        var txt = this.value.replace(/[^a-z0-9_\+\-\.\#\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]/ig, ''); // allowed characters
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
            $(document).ready(function () {
                if (window.location.href.indexOf("success") > -1) {
//alert("test");
                    document.getElementById('myModel1').style.display = "block";
//                    document.getElementById('myModel1').style.display = "block";
//                    var element = document.getElementById("myModel1");
//                    element.classList.add("bodyBackground");
//                    var element1 = document.getElementById("myModel1");
//                    element1.classList.add("model");
//                    mystyle

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
                $(window).keydown(function (event) {
                    if (event.keyCode === 13) {
//                        alert("test");
//                        event.preventDefault();
                        return false;
                    }
                });
            });
        </script>
        <script>

        </script>
        <script>
            $('#date').bootstrapMaterialDatePicker({weekStart: 0, time: false});
            $('#date-end').bootstrapMaterialDatePicker({weekStart: 0, time: false});
            $('#date-start').bootstrapMaterialDatePicker({weekStart: 0, time: false}).on('change', function (e, date)
            {
                $('#date-end').bootstrapMaterialDatePicker('setMinDate', date);
            });
        </script>
        <script>

        </script>
    </body>
</html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>

