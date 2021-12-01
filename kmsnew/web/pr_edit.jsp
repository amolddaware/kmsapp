<%-- 
    Document   : dragndrop1
    Created on : Dec 18, 2017, 8:34:23 PM
    Author     : Amol
--%>

<%@page import="jcifs.smb.SmbFile"%>
<%@page import="jcifs.smb.NtlmPasswordAuthentication"%>
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
        <link href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css" rel="stylesheet" />
        <link href="css/jquery-ui.css" rel="stylesheet">
        <script src="https://maps.googleapis.com/maps/api/js?libraries=places&key=AIzaSyD-eGqLReBVwTTRNsl7XTWk2NRRV71p4To"></script>
        <!--        <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css'>
                <link rel="stylesheet" href="css/style_dragndrop.css">-->

        <style>


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
        <script>
            var autocomplete;
            function initialize() {
                autocomplete = new google.maps.places.Autocomplete(
                        (document.getElementById('autocomplete')),
                        {types: ['geocode']});
                google.maps.event.addListener(autocomplete, 'place_changed', function () {
                });
            }
        </script>
    </head>

    <body class="theme-blue" onload="initialize()">

        <% if (session.getAttribute("role").equals("5")) {%>
        <jsp:include page="userHeader1.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <%} else if (session.getAttribute("role").equals("4")) {%>
        <jsp:include page="pr_header.jsp"></jsp:include>
        <jsp:include page="pr_left.jsp"></jsp:include>
        <%}%>
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
                                    <div id="wizard_horizontal">
                                        <h2>Information (<%=request.getParameter("workcode")%>)</h2>
                                        <section>
                                            <div>
                                                <form class="form-horizontal m-t-50" action="<%=request.getContextPath()%>/updateprintmediadataentry.do"  id="uploadform" method="post" accept-charset="UTF-8" enctype="multipart/form-data">
                                                    <%

                                                        Connection dh = null;
                                                        ResultSet rs = null;
                                                        PreparedStatement pstmt = null;
                                                        ConnectionDB connectionDB = new ConnectionDB();
                                                        dh = connectionDB.getConnection();
                                                        try {

                                                            String subject = "", description = "", date = "";
                                                            System.out.println("workcode:-" + request.getParameter("workcode"));
                                                            String selectData = "Select language,npname,edition,subedition,subject,sentiment,sourcedate,additionaltag,graphicspath,titlemarathi,location,brand from tbl_news_dataentry where workcode=?";
                                                            pstmt = dh.prepareStatement(selectData);
                                                            pstmt.setString(1, request.getParameter("workcode"));
                                                            rs = pstmt.executeQuery();
                                                            if (rs.next()) {

                                                    %>

                                                    <!--<input type="hidden"  id="textInput" name="getUpload" >-->
                                                    <input id="maxid" name="workcode" type="hidden" value="<%=request.getParameter("workcode")%>" />
                                                    <input  name="admin" type="hidden" value="" />
                                                    <input  name="importance" type="hidden" value="" />

                                                    <input id="token" name="token" type="hidden" value="<%=token%>" />
                                                    <div class="form-group">
                                                        <!--                                                            <div class="form-group">
                                                                                                                        <div class="col-sm-9">
                                                                                                                            <div id="temp" class="form-control" contentEditable="true"></div>
                                                                                                                            <input type="text" class="form-control" id="temp">
                                                                                                                            <input type="hidden" id="idhiddentemp">
                                                                                                                            <div id="temp" class="form-control" contentEditable="true"></div>
                                                                                                                        </div>
                                                                                                                    </div>-->
                                                        <label for="dfnondf" class="col-sm-3 control-label">Brand</label>
                                                        <div class="col-sm-9">
                                                            <!--<div class="form-">-->
                                                            <div class="demo-checkbox pull-left  ">
                                                                <%
                                                                    if (rs.getString("brand") != null) {
                                                                        if (rs.getString("brand").equals("DF")) {
                                                                %>
                                                                <input type="radio" name="dfnondf" value="DF" id="df" onclick="errBlank('errDFNonDF')" class="filled-in chk-col-blue" checked />
                                                                <label for="df">DF</label>
                                                                <%} else {
                                                                %>
                                                                <input type="radio" name="dfnondf" value="DF" id="df" onclick="errBlank('errDFNonDF')" class="filled-in chk-col-blue"  />
                                                                <label for="df">DF</label>

                                                                <%}

                                                                    if (rs.getString("brand").equals("Non DF") && rs.getString("brand") != null) {%>
                                                                <input type="radio" name="dfnondf" value="Non DF" id="nondf" oninput="errBlank('errDFNonDF')" class="filled-in chk-col-blue" checked  />
                                                                <label for="nondf">Non DF</label>
                                                                <%} else {
                                                                %>
                                                                <input type="radio" name="dfnondf" value="Non DF" id="nondf" oninput="errBlank('errDFNonDF')" class="filled-in chk-col-blue"   />
                                                                <label for="nondf">Non DF</label>

                                                                <%}
                                                                } else {%>
                                                                <input type="radio" name="dfnondf" value="DF" id="df" onclick="errBlank('errDFNonDF')" class="filled-in chk-col-blue"  />
                                                                <label for="df">DF</label>


                                                                <input type="radio" name="dfnondf" value="Non DF" id="nondf" oninput="errBlank('errDFNonDF')" class="filled-in chk-col-blue"   />
                                                                <label for="nondf">Non DF</label>


                                                                <%}%>
                                                                <!--</div>-->

                                                            </div>
                                                            <span id="errDFNonDF" class="text-danger"></span>

                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="autocomplete" class="col-sm-3 control-label">Location</label>
                                                        <div class="col-sm-9">
                                                            <div id="locationField">
                                                                <%if (rs.getString("location") != null) {%>

                                                                <input id="autocomplete" placeholder="Location" value="<%=rs.getString("location")%>" oninput="errBlank('errAutocomplete')" class="form-control" name="location" onFocus="geolocate()" type="text"></input>
                                                                <%} else {%>
                                                                <input id="autocomplete" placeholder="Location"  oninput="errBlank('errAutocomplete')" class="form-control" name="location" onFocus="geolocate()" type="text"></input>

                                                                <%}%>
                                                            </div>
                                                            <span id="errAutocomplete" class="text-danger"></span>
                                                        </div>
                                                        <!--<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15094.063092311517!2d72.81608609999999!3d18.9528158!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3be7ce11624bd7f5%3A0x9e69b276b442c51a!2sSir%20H.%20N.%20Reliance%20Foundation%20Hospital%20and%20Research%20Centre!5e0!3m2!1sen!2sin!4v1581604572056!5m2!1sen!2sin" width="600" height="450" frameborder="0" style="border:0;" allowfullscreen=""></iframe>-->
                                                    </div>
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
                                                                    <option value="<%=rs.getString("language")%>"><%=rs.getString("language")%></option>
                                                                    <%
                                                                        String sqlSelect = "SELECT * FROM tbl_language_master ";
                                                                        System.out.println("sqlSelect-" + sqlSelect);
                                                                        PreparedStatement stmSelect = dh.prepareStatement(sqlSelect);
                                                                        ResultSet rsSelect = stmSelect.executeQuery();
                                                                        while (rsSelect.next()) {
                                                                    %>
                                                                    <option value="<%=rsSelect.getString(1)%>"><%=rsSelect.getString(2)%></option>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </select>   
                                                                <input id="language1" name="language1" type="hidden">

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="newspaper" class="col-sm-3 control-label">News Paper</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line" id="idnewspaper">
                                                                <select  class="form-control " name="newspaper" id="newspaper" onchange="selectNewsPaper('np')" required>
                                                                    <option value="<%=rs.getString("npname")%>"><%=rs.getString("npname")%></option>

                                                                    <!--<option value="-1">Select NewsPaper</option>-->
                                                                </select>                                   <!--<input type="text" class="form-control" id="Program" name="Program" placeholder="Title / Name of Program" required>-->
                                                                <input id="newspaper1" name="newspaper1" type="hidden">

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="edition" class="col-sm-3 control-label">Edition</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <select  class="form-control " name="edition" id="edition" onchange="selectNewsPaper('edition')" required>
                                                                    <option value="<%=rs.getString("edition")%>"><%=rs.getString("edition")%></option>

                                                                </select> 
                                                                <input id="edition1" name="edition1" type="hidden"> 
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="subedition" class="col-sm-3 control-label">Sub Edition</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <select  class="form-control " name="subedition" id="subedition"  required>
                                                                    <% if (rs.getString("subedition") != null) {%>
                                                                    <option value="<%=rs.getString("subedition")%>"><%=rs.getString("subedition")%></option>
                                                                    <%} else {%>
                                                                    <option value="-1">Select Subedition</option>
                                                                    <%}%>
                                                                </select>   
                                                                <input id="subedition1" name="subedition1" type="hidden"> 
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="title" class="col-sm-3 control-label">Title (English)</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <input type="text" class="form-control" value="<%=rs.getString("subject")%>" id="title" name="title" placeholder="Title"  required>
                                                                <!--<textarea class="form-control" id="description" name="description" autocomplete="off" oninput="errorBlank('errDescription')" placeholder="Enter Description " rows="3" required></textarea>-->

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="title" class="col-sm-3 control-label">Title (Marathi)</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <input type="text" class="form-control" value="<%=rs.getString("titlemarathi")%>" id="titlemarathi" name="titlemarathi" placeholder="Title Marathi"  required>
                                                                <!--<textarea class="form-control" id="description" name="description" autocomplete="off" oninput="errorBlank('errDescription')" placeholder="Enter Description " rows="3" required></textarea>-->

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="Sentiment" class="col-sm-3 control-label">Sentiment</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <select  class="form-control " name="sentiment" id="sentiment"  required>
                                                                    <option value="<%=rs.getString("sentiment")%>"><%=rs.getString("sentiment")%></option>
                                                                    <%
                                                                        String sqlSentiment = "SELECT * FROM tbl_sentiment_details ";
                                                                        System.out.println("sqlSelect-" + sqlSentiment);
                                                                        PreparedStatement stmSentiment = ConnectionDB.getDBConnection().prepareStatement(sqlSentiment);
                                                                        ResultSet rsSentiment = stmSentiment.executeQuery();
                                                                        while (rsSentiment.next()) {
                                                                    %>
                                                                    <option value="<%=rsSentiment.getString(2)%>"><%=rsSentiment.getString(2)%></option>
                                                                    <%
                                                                        }
                                                                    %>

                                                                </select>  
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="Additional" class="col-sm-3 control-label">Tags</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line" >
                                                                <!--<div class="col-lg-9 form-control"  style="display: none;" >-->

                                                                <textarea id="tags1"    class="form-control" placeholder="Tags" autocomplete="off" ><%=rs.getString("additionaltag")%></textarea>

                                                                <!--<input type="hidden" id="tags1"  value="" class="form-control" placeholder="Tags" autocomplete="off" readonly/>-->

                                                                <div id="newTag">
                                                                    <input type="text" id="tags" name="tags" class="form-control" placeholder="Tags" autocomplete="off" />
                                                                </div>


                                                            </div>
                                                            <div id="divAa" style="font-size: 14px;border:1px solid #c8cbce;display: none" class="text-white"></div>
                                                            <input type="hidden" class="txt" name="additional" id="additional" >

                                                            <!--<input type="text" class="form-control" id="Additional" name="Additional" placeholder="Additional Tags" required>-->
                                                            <!--</div>-->
                                                        </div>
                                                    </div>
                                                    <!--                                                    <div class="form-group">
                                                                                                            <div class="col-sm-9">
                                                    
                                                                                                                <div style="float: left;width:240px;">
                                                                                                                    <div id="dropzone-wrapper">
                                                                                                                        <div id="textbox-wrapper">
                                                                                                                            <div id=textbox></div>
                                                    
                                                                                                                        </div>
                                                                                                                        <div id="dropzone"></div>
                                                                                                                    </div>
                                                                                                                    <div id="errormessages"><span style="display: none;"></span></div>
                                                    
                                                                                                                    <div id="overlay"></div>
                                                                                                                </div>
                                                                                                                <div style="float: left;">
                                                                                                                    <br /><br />
                                                                                                                    <h3>Preview:</h3>
                                                    
                                                                                                                    <div id="output"><ul></ul></div>
                                                                                                                </div>
                                                    
                                                                                                            </div>
                                                                                                        </div>-->


                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="avatar-upload" for="imageUpload">
                                                                <div class="avatar-edit">
                                                                    <input type="hidden" name="uploadImage" value="<%=rs.getString("graphicspath")%>">

                                                                </div>
                                                                <div class="avatar-edit">
                                                                    <input type="file" id="imageUpload" name="uploadImage" accept=".jpeg,.png,.jpg" multiple>


                                                                </div>
                                                                <label for="imageUpload" class="labelImage">
                                                                    <div class="avatar-preview" >
                                                                        <div id="imagePreview" style="background-image: url('images/add_img.jpg');"> </div>
                                                                    </div>
                                                                </label>     
                                                            </div>
                                                        </div>
                                                        <%
                                                            String fullpath[] = null;
                                                            //
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
                                                                    fullpath[i] = fullpath[i].replace("\\", "/");
//                                                                    NtlmPasswordAuthentication auth = new NtlmPasswordAuthentication(null, "kms", "CSF@1234");
//                                                                    SmbFile ss = new SmbFile(fullpath[i], auth);

                                                        %>

                                                        <div class="col-xs-6 col-md-4" id="divImage_<%=i%>">
                                                            <span class="img_close" onclick="showImageFunction('<%=fullpath[i]%>', document.getElementById('divImage_<%=i%>'))"><i class="material-icons">
                                                                    clear
                                                                </i></span>
                                                            <span class="thumbnail">
                                                                <img src="<%="/kmsvdo/" +fullpath[i].substring(25).replace(" ", "%20")%>" style="height: 200px"  class="img-responsive">
                                                            </span>

                                                            <!--<img  src="" class="img-responsive" style="height: 180px" id="image_" ">-->

                                                        </div>
                                                        <!--                                                            <div class="col-xs-6 col-md-3">
                                                                                                                        <a href="javascript:void(0);" class="thumbnail">
                                                                                                                            <img src="http://placehold.it/500x300" class="img-responsive">
                                                                                                                        </a>
                                                                                                                    </div>
                                                                                                                    <div class="col-xs-6 col-md-3">
                                                                                                                        <a href="javascript:void(0);" class="thumbnail">
                                                                                                                            <img src="http://placehold.it/500x300" class="img-responsive">
                                                                                                                        </a>
                                                                                                                    </div>
                                                                                                                    <div class="col-xs-6 col-md-3">
                                                                                                                        <a href="javascript:void(0);" class="thumbnail">
                                                                                                                            <img src="http://placehold.it/500x300" class="img-responsive">
                                                                                                                        </a>
                                                                                                                    </div>-->

                                                        <!--                                                        <div class="col-sm-6">
                                                                                                                    <label for="imageUpload"></label>-->
                                                        <!--                                                        <div class="card col-sm-5 m-r-30 m-l-30" style="border:1px solid #000">
                                                                                                                   </div>-->

                                                        <!--                                                            <a data-toggle="modal" class="col-sm-12" data-target="#myModal" title="Click here to view in full page">
                                                                                                                        <div class="avatar-preview">
                                                                                                                            <div id="imagePreview" style="background-image: url('');"> </div>
                                                                                                                        </div>
                                                                                                                    </a>-->
                                                        <!--</div>-->
                                                        <%    }
                                                            }
                                                        %>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="col-sm-12 text-right">
                                                            <button type="button" class="btn btn-danger "  onclick="saveEditPrintData()"    >UPDATE</button>
                                                            <!--                                                            <button type="submit" class="btn btn-danger " data-toggle="modal" data-target="#defaultModal" onclick="saveEditData()" id="btnSaveVideo"  >UPDATE</button>-->
                                                        </div>
                                                    </div>
                                                    <%
                                                            }
                                                        } catch (Exception e) {
                                                            e.printStackTrace();
                                                        } finally {
                                                            if (pstmt != null) {
                                                                pstmt.close();
                                                            }
                                                            if (rs != null) {
                                                                rs.close();
                                                            }
                                                            if (dh != null) {
                                                                dh.close();
                                                            }
                                                        }

                                                    %>
                                                    <!--modal-->

                                                </form>
                                            </div>

                                    </div>

                                    </section>

                                    <!-- Modal -->
                                    <div id="myModal1" class="modal bodyBackground" role="dialog">
                                        <div class="modal-dialog m-t-125">
                                            <!-- Modal content-->
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" onclick="closeImageDiv()">&times;</button>
                                                    <h4 class="modal-title">  Do you want to remove ?
                                                        <br></h4>
                                                </div>
                                                <div class="modal-body">

                                                    <span id="removeImageid"></span>
                                                    <span id="removeImageDiv" style="display: none"></span>
                                                </div>
                                                <div class="modal-footer " style="text-align: center">
                                                    <button type="button" class="btn btn-success" onclick="removeImage()" data-dismiss="modal">Yes</button>
                                                    <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeImageDiv()">No</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="myModal" class="modal fade" role="dialog">
                                        <div class="modal-dialog">
                                            <!-- Modal content-->
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    <!--<h4 class="modal-title">Modal Header</h4>-->
                                                </div>
                                                <div class="modal-body">
                                                    <img class="img-responsive" src=""/>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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
        </div>
    </section>
    <div class="modal bodyBackground" id="myModal11" tabindex="-1" role="dialog" style="display:none">
        <div class="modal-dialog m-t-125" role="document">
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
                    <a href="pr_viewdatewise.jsp?fromSourceDate=<%=request.getParameter("fromSourceDate")%>&toSourceDate=<%=request.getParameter("toSourceDate")%>"><button type="button" class="btn btn-link waves-effect" data-dismiss="modal">CLOSE</button></a>
                    <!--<a href="pr_view.jsp?searchresult=P"><button type="button" class="btn btn-link waves-effect" data-dismiss="modal">CLOSE</button></a>-->

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
    <!--        <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
            <script src='https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.js'></script>
            <script src='https://cdn.jsdelivr.net/npm/jquery.dragbetter@0.1.4/jquery.dragbetter.min.js'></script>
            <script  src="js/script_dragndrop.js"></script>-->

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
//        });
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

        function closeImageDiv() {
            document.getElementById("myModal1").style.display = "none";
        }
        function showImageFunction(val, imageid) {

//                alert(val + " " + imageid);
            var image_x = imageid.id;
            document.getElementById("myModal1").style.display = "block";
            document.getElementById("removeImageid").innerHTML = val;
            document.getElementById("removeImageDiv").innerHTML = image_x;

//                var image_x = imageid.id;
//                alert(image_x);
//                document.getElementById(image_x).style.display = 'none';
//                image_x.parentNode.removeChild(image_x);
        }
        function removeImage()
        {
//            alert("test");
            var xhttp = new XMLHttpRequest();
            var removeImageid = document.getElementById("removeImageid").textContent;
            var removeImageDiv = document.getElementById("removeImageDiv").textContent;
//            alert(removeImageDiv);
            var urls = "removeimage.do?removeImageid=" + removeImageid;
//                    alert(urls);
            xhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
//                        alert(this.responseText);
                    document.getElementById(removeImageDiv).style.display = 'none';
                    document.getElementById("myModal1").style.display = 'none';
//                            document.getElementById("newspaper").innerHTML = this.responseText;
//                            $('#edition').empty();
//                            $('#edition').append($('<option>', {text: 'Select Edition', value: '-1', selected: true}))
//                            $('#edition').change();
//                            $('#subedition').empty();
//                            $('#subedition').append($('<option>', {text: 'Select Sub Edition', value: '-1', selected: true}))
//                            $('#subedition').change();
                }
            };
            xhttp.open("POST", urls, true);
            xhttp.send();

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
        $("#imageUpload1").change(function () {
            readURL(this);
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
//                        var txt = this.value.replace(/[^a-z0-9_\+\-\.\#]/ig, ''); // allowed characters
                    var txt = this.value.replace(/[^a-z0-9_\+\-\.\#\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]/ig, ''); // allowed characters

                    if (txt)
                        //                    $("<input type='text' name='stag'">), {text: txt.toLowerCase(), insertBefore: this});
                        $("<span />", {text: txt, insertBefore: this});
                    $("#divAa").append(" " + this.value);
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
        function saveEditPrintData() {
//                var aa = document.getElementsByClassName("filename");
//                var abc;
//                for (var i = 0; i < aa.length; i++) {
//                    abc += aa[i].textContent + ",\n";
//                    document.getElementById("textInput").value = abc;
//                }
            var sellanguage = document.getElementById("language");
            var textsellanguage = sellanguage.options[sellanguage.selectedIndex].text;
            document.getElementById("language1").value = textsellanguage;
            var selnewspaper = document.getElementById("newspaper");
            var textnewspaper = selnewspaper.options[selnewspaper.selectedIndex].text;
            document.getElementById("newspaper1").value = textnewspaper;

            var seledition = document.getElementById("edition");
            var textedition = seledition.options[seledition.selectedIndex].text;
            document.getElementById("edition1").value = textedition;

            var selsubedition = document.getElementById("subedition");
            var textsubedition = selsubedition.options[selsubedition.selectedIndex].text;
            document.getElementById("subedition1").value = textsubedition;

            var a = document.getElementById("divAa").innerHTML;

//                alert(a);
//                if (document.getElementById("tags1").value != "") {
            var ab = document.getElementById("tags1").value;
//                alert(" " + ab + " " + a + " ");
            document.getElementById("tags").value = " " + ab + " " + a + " ";
//                } else {
//                    document.getElementById("tags").value = a;
//                    alert(a);

//                }

//                alert(a);
//                document.getElementById("tags").value = a;
            document.getElementById("uploadform").submit();

        }
    </script>


</body>
</html>
<% } else {
        response.sendRedirect("login.jsp");
    }%>

