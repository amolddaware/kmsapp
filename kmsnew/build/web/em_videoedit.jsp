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
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("2") || session.getAttribute("role").equals("3") || session.getAttribute("role").equals("5"))) {

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



    </head>

    <body class="theme-blue">

        <% if (session.getAttribute("role").equals("5")) {%>
        <jsp:include page="userHeader1.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <%} else if (session.getAttribute("role").equals("3")) {%>
        <jsp:include page="em_header.jsp"></jsp:include>
        <jsp:include page="em_left.jsp"></jsp:include>
        <%}%>             <!--<div class=" container-scroller">-->
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
                                    <!--<li class="dropdown"> <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="material-icons">more_vert</i> </a>-->
                                    <!--                                            <ul class="dropdown-menu pull-right">
                                                                                    <li><a href="javascript:void(0);">Action</a></li>
                                                                                    <li><a href="javascript:void(0);">Another action</a></li>
                                                                                    <li><a href="javascript:void(0);">Something else here</a></li>
                                                                                </ul>-->
                                    <!--</li>-->
                                </ul>
                            </div>
                            <div class="body clearfix">
                                <div class="col-md-10 col-lg-offset-1 well">
                                    <div id="wizard_horizontal">
                                        <h2>Information (<%=request.getParameter("workcode")%>)</h2>
                                        <section>
                                            <div>
                                                <form class="form-horizontal m-t-50" action="<%=request.getContextPath()%>/newsinfoupdate.do"  id="uploadform" method="post" accept-charset="UTF-8" enctype="multipart/form-data">
                                                    <%Connection dh = null;
                                                        ConnectionDB connectionDB = new ConnectionDB();
                                                        dh = connectionDB.getConnection();
                                                        String subject = "", description = "", date = "";
//                                                        System.out.println("workcode:-" + request.getParameter("workcode"));
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
                                                        <label for="channel" class="col-sm-3 control-label">Channel Name</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <select  class="form-control " name="channel" id="channel" onclick="onchangeChannel();" onchange="onchangeChannel();errorBlank('errChannel')"  required>
                                                                    <option value="<%=rs.getString("chname")%>"><%=rs.getString("chname")%></option>
                                                                    <%
                                                                        PreparedStatement stmSelect = null;
                                                                        ResultSet rsSelect = null;
                                                                        try {

                                                                            String sqlSelect = "SELECT * FROM tbl_television_master order by telename ";
//                                                                            System.out.println("sqlSelect-" + sqlSelect);
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
//                                                                                if (dh != null) {
//                                                                                    dh.close();
//                                                                                }
                                                                        }
                                                                    %>
                                                                </select>   
                                                                <span id="errChannel" class="text-danger"></span>
                                                            </div>
                                                        </div>
                                                    </div>


                                                    <div class="form-group">
                                                        <label for="Program" class="col-sm-3 control-label">Title (English)</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <input type="text" class="form-control" name="subject" value="<%=rs.getString("subject")%>" autocomplete="off" oninput="errorBlank('errSubject')" id="subject"  placeholder="Enter  Title (English)" required>

                                                                <!--<input type="text" class="form-control" id="Program" name="Program" placeholder="Title / Name of Program" required>-->
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="Program" class="col-sm-3 control-label">Title (Marathi)</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <input type="text" class="form-control" name="titlemarathi" value="<%=rs.getString("titlemarathi")%>" autocomplete="off" oninput="errorBlank('errTitlemarathi')" id="titlemarathi"  placeholder="Enter  Title (Marathi)" required>

                                                                <!--<input type="text" class="form-control" id="Program" name="Program" placeholder="Title / Name of Program" required>-->
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="Details" class="col-sm-3 control-label">Details / Topic / Information of Program</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <!--<textarea type="text" class="form-control" id="Details" name="Details" placeholder="Details / Topic / Information of Program" required></textarea>-->
                                                                <textarea class="form-control" id="description" name="description" autocomplete="off" oninput="errorBlank('errDescription')" placeholder="Enter Description " rows="3" required><%=rs.getString("description")%></textarea>

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="Sentiment" class="col-sm-3 control-label">Sentiment</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <select  class="form-control " name="sentiment" id="sentiment" onclick="onchangeSentiment()" onchange="onchangeSentiment()">
                                                                    <%
                                                                        String sentiment = "";
                                                                        if (rs.getString("sentiment") != null) {
                                                                            sentiment = rs.getString("sentiment");
                                                                            out.println("<option value='" + sentiment + "'>" + sentiment + "</option>");
                                                                    %>
                                                                    <%
                                                                    } else {%>

                                                                    <%
//                                                                            criticality = "";
                                                                        }
                                                                    %>

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
//                                                                                if (dh != null) {
//                                                                                    dh.close();
//                                                                                }
                                                                            }

                                                                        %>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="sourcedate" class="col-sm-3 control-label"> Source Date</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line" >
                                                                <!--<div class="col-lg-9 form-control"  style="display: none;" >-->
                                                                <input type="text" id="date-start"  name="sourcedate"  class="form-control" value="<%=rs.getString("sourcedate")%>" oninput="errorBlank('errSourcedate')"  placeholder="Source Date" autocomplete="off" />
                                                            </div>
                                                            <span id="errSourcedate" class="text-danger" style="display: none"></span>


                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="additional" class="col-sm-3 control-label">Tags</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line" id="newTag">
                                                                <input type="text" class="form-control"  value="<%=rs.getString("additionaltag")%>"  id="additional1" autocomplete="off"  aria-describedby="additional" >
                                                                <input type="text" class="form-control" name="tags" id="tags" autocomplete="off"  aria-describedby="additional" placeholder="Add Tags here">

                                                                <!--<input type="text" class="form-control" id="Links" name="Links" placeholder="Add Links" required>-->
                                                            </div>
                                                            <div id="divAa" style="font-size: 14px;border:1px solid #c8cbce;display: none" class="text-white"></div>
                                                            <!--<input type="hidden" class="txt" name="additional" id="additional" >-->

                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <!--<label for="video" class="col-sm-3 control-label">Uploaded Video /Image</label>-->
                                                        <div class="col-md-4">
                                                            <div class="avatar-upload" for="imageUpload">

                                                                <div class="avatar-edit">
                                                                    <input type="file" id="imageUpload" name="uploadImage" accept=".jpeg,.jpg,.png,.gif,.JPEG,.JPG,.PNG,.GIF,.mp4,.mov" multiple>


                                                                </div>
                                                                <label for="imageUpload" class="labelImage">
                                                                    <div class="avatar-preview" >
                                                                        <div id="imagePreview" style="background-image: url('images/add_img.jpg');"> </div>
                                                                    </div>
                                                                </label>     
                                                            </div>
                                                        </div>

                                                        <!--<div class="col-sm-9">-->
                                                        <!--<div class="form-line" >-->
                                                        <%-- <%String fullpath[] = null;
                                                            if (rs.getString("vdopath").contains("::")) {
                                                                fullpath = rs.getString("vdopath").split("::");
                                                                for (int i = 0; i < fullpath.length; i++) {

                                                                    fullpath[i] = fullpath[i].replace("\\", "/");
                                                        %>
                                                        <div class="col-xs-6 col-md-4" id="divVideo_<%=i%>">
                                                            <span class="img_close" onclick="showVideoFunction('<%=fullpath[i]%>', document.getElementById('divVideo_<%=i%>'), 'V')"><i class="material-icons">
                                                                    clear
                                                                </i>
                                                            </span>
                                                            <span class="thumbnail">
                                                                <video id="videoContainer" style="width:100%" height="193" controls >
                                                                    <source src="/kmsvdo/<%=fullpath[i].substring(25)%>" type="video/mp4" >
                                                                </video> 
                                                            </span>

                                                            <!--<img  src="" class="img-responsive" style="height: 180px" id="image_" ">-->

                                                        </div>


                                                        <%}
                                                        } else {%>
                                                        <div class="col-xs-6 col-md-4">

                                                            <span class="thumbnail">
                                                                <video id="videoContainer"  width="400" height="200" controls >
                                                                    <source src="/kmsvdo/<%=rs.getString("vdopath").substring(25)%>" type="video/mp4" >
                                                                </video> 
                                                            </span>
                                                        </div>
                                                        <%}%>
                                                        
                                                        --%>
                                                     <%--   <%
                                                            String fullpath1[] = null;
                                                            //
                                                            if (!rs.getString("graphicspath").isEmpty()) {
                                                                //                                                                String path = rs.getString("grpahicspath");
                                                                ////                                                        String fullpath=path.substring(19);
                                                                //                                                                String replaceString = path.replace("\\", "/");
                                                                //                                                                fullpath = "/kmsvdo/vdo/" + replaceString.substring(14);
                                                                //                                                                System.out.println("fullpath:-" + fullpath);
                                                                //
                                                                //                                                                String whiteSpace = fullpath.replace(" ", "%20");

                                                                fullpath1 = rs.getString("graphicspath").split("::");
                                                                for (int i = 0; i < fullpath1.length; i++) {
                                                                    fullpath1[i] = fullpath1[i].replace("\\", "/");
                                                        %>

                                                        <div class="col-xs-6 col-md-4" id="divImage_<%=i%>">
                                                            <span class="img_close" onclick="showVideoFunction('<%=fullpath1[i]%>', document.getElementById('divImage_<%=i%>'), 'I')"><i class="material-icons">
                                                                    clear
                                                                </i></span>
                                                            <span class="thumbnail">
                                                                <img src="/kmsvdo/<%=fullpath1[i].substring(25).replace(" ", "%20")%>" style="height: 200px"  class="img-responsive">
                                                            </span>

                                                            <!--<img  src="" class="img-responsive" style="height: 180px" id="image_" ">-->

                                                        </div>
                                                        <%}
                                                            }%>--%>
                                                        <!--</div>-->
                                                        <!--</div>-->
                                                    </div>

                                                    <%}%>
                                                    <div class="form-group">
                                                        <div class="col-sm-12 text-right">
                                                            <button type="submit" class="btn btn-danger " data-toggle="modal" data-target="#defaultModal" onclick="updateSubmitBtnInfo()" id="btnSaveVideo"  >UPDATE</button>
                                                            <!--                                                            <button type="submit" class="btn btn-danger " data-toggle="modal" data-target="#defaultModal" onclick="saveEditData()" id="btnSaveVideo"  >UPDATE</button>-->
                                                        </div>
                                                    </div>
                                                    <!--modal-->
                                                    <div class="modal bodyBackground " id="myModal" tabindex="-1" role="dialog">
                                                        <div class="modal-dialog m-t-125" role="document">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                </div>
                                                                <div class="modal-body text-center"> <h4 id="editSuccess"></h4> <br/>
                                                                    <br/>
                                                                    <span class="badge bg-green font-28 p-t-10 p-b-10 p-l-30 p-r-30"><%=request.getParameter("workcode")%></span> </div>
                                                                <div class="modal-footer">
                                                                    <a href="em_videoedit.jsp?workcode=<%=request.getParameter("workcode")%>&fromSourceDate=<%=request.getParameter("fromSourceDate")%>&toSourceDate=<%=request.getParameter("toSourceDate")%>"><button type="button" class="btn btn-link waves-effect" data-dismiss="modal">CLOSE</button></a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <div class="modal bodyBackground" id="myModel1" tabindex="-1" role="dialog" style="display: none">
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

                                                            <p class="text-success semi-bold" style="font-size:18px">Updated Video Reference Number  is:-<%=workcode%> </p>

                                                            <!--<iframe width="560" height="315" src="https://www.youtube.com/embed/u3xKgwKUQLc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>-->
                                                        </div>
                                                        <div class="modal-footer">
                                                            <!--<a >TAG</a>-->
                                                            <button type="button" class="btn btn-link waves-effect"  data-dismiss="#myModel1" onclick="goBack()">CLOSE</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div id="myModalVideo" class="modal bodyBackground" role="dialog">
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
                                                            <span id="removeVideoDiv" style="display: none"></span>
                                                        </div>
                                                        <div class="modal-footer " style="text-align: center">
                                                            <button type="button" class="btn btn-success" onclick="removeImage()" data-dismiss="modal">Yes</button>
                                                            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeImageDiv()">No</button>
                                                        </div>
                                                    </div>
                                                </div>
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
                                                                function showVideoFunction(val, imageid, type) {

//                                                                    alert(val + " " + imageid.id + " " + type);
                                                                    var image_x = imageid.id;
                                                                    document.getElementById("myModalVideo").style.display = "block";
                                                                    document.getElementById("removeImageid").innerHTML = val;
                                                                    document.getElementById("removeImageDiv").innerHTML = image_x;
                                                                    document.getElementById("removeVideoDiv").innerHTML = type;

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
                                                                    var removeVideoDiv = document.getElementById("removeVideoDiv").textContent;
//            alert(removeImageDiv);
                                                                    var urls = "removevideo.do?removeImageid=" + removeImageid + "&type=" + removeVideoDiv;
//                    alert(urls);
                                                                    xhttp.onreadystatechange = function () {
                                                                        if (this.readyState == 4 && this.status == 200) {
//                        alert(this.responseText);
                                                                            var mresp = this.responseText;
//alert(mresp);
                                                                            if (mresp.includes('success')) {
                                                                                document.getElementById(removeImageDiv).style.display = 'none';
                                                                                document.getElementById("myModalVideo").style.display = 'none';
                                                                            } else {
                                                                                alert(mresp);
                                                                            }
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
                                                                function closeDiv1() {
                                                                    document.getElementById('myModel1').style.display = "none";
                                                                }
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
        </script>
        <script>
//            $(document).ready(function () {
//                if (window.location.href.indexOf("success") > -1) {
////alert("test");
//                    document.getElementById('myModel1').style.display = "block";
//
//                    var span = document.getElementsByClassName("close")[0];
////                    span.onclick = function () {
////                        modal.style.display = "none";
////                    };
////                    window.onclick = function (event) {
////                        if (event.target == modal) {
////                            modal.style.display = "none";
////                        }
////                    };
//                }
//            });
            $('#date-end').bootstrapMaterialDatePicker({weekStart: 0, time: false});
            $('#date-start').bootstrapMaterialDatePicker({weekStart: 0, time: false}).on('change', function (e, date)
            {
                $('#date-end').bootstrapMaterialDatePicker('setMinDate', date);
            });
            function updateSubmitBtnInfo() {
                var a = document.getElementById("divAa").innerHTML;

//                                    alert(a);
                var ab = document.getElementById("additional1").value;
//                                    alert(ab + " "+a);
                document.getElementById("tags").value = ab + " " + a;
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
            function removeTag(tag, id) {
//                alert(tag);
                document.getElementById("tags").value = "";
                return false;
            }
            $(function () { // DOM ready

                // ::: TAGS BOX

                $("#tags").on({
                    focusout: function () {
                        var txt = this.value.replace(/[^a-z0-9_\+\-\.\#\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]/ig, ''); // allowed characters

//                                            var txt = this.value.replace(/[^a-z0-9_\+\-\.\#]/ig, ''); // allowed characters
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
            function goBack() {
                window.history.back();
            }
        </script>
        <script>
            $(document).ready(function () {
                if (window.location.href.indexOf("success") > -1) {

                    var modal = document.getElementById('myModal').style.display = "block";
   //                    var mytext = getUrlVars()["workcode"];
   //                                        alert(mytext);
                    //                    document.getElementById("mobile").value = mytext;
                    document.getElementById("editSuccess").innerHTML = "Record  updated successfully";
                    //                    window.location.href = "thanks.html";
                    var span = document.getElementsByClassName("close")[0];
                    span.onclick = function () {
                        modal.style.display = "none";
                    }
                    window.onclick = function (event) {
                        if (event.target == modal) {
                            modal.style.display = "none";
                        }
                    }
                }
            });

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
            function onchangeChannel() {
                var optionValues = [];
                $('#channel option').each(function () {
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
//                var aa = document.getElementsByClassName("filename");
//                var abc;
//                for (var i = 0; i < aa.length; i++) {
//                    abc += aa[i].textContent + ",\n";
//                    document.getElementById("textInput").value = abc;
//                }
                document.getElementById("uploadform").submit();

            }

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
        </script>

    </body>
</html>
<% } else {
        response.sendRedirect("login.jsp");
    }%>

