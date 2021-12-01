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
    if (session != null && session.getAttribute("username") != null) {

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

            function closeFileDiv() {
                document.getElementById("displayFileFormat").style.display = "none";

            }

            function errorBlank(err) {
                document.getElementById(err).innerHTML = "";
            }
        </script>

    </head>

    <body class="theme-blue">
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
                                    <h2>ADD NEWS INFORMATION</h2>
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
                                                        <form class="form-horizontal m-t-50" action="<%=request.getContextPath()%>/addtextnews.do"  id="uploadform" method="post" accept-charset="UTF-8">
                                                        <!--<input type="hidden"  id="textInput" name="getUpload" >-->
                                                        <input id="token" name="token" type="hidden" value="<%=token%>" />

                                                        <div class="form-group">
                                                            <label for="channel" class="col-sm-3 control-label">Channel Name</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <select  class="form-control " name="channel" id="channel" onchange="errorBlank('errChannel')"  required>
                                                                        <option value="-1">-Select Channel -</option>
                                                                        <%
                                                                            PreparedStatement stmSelect = null;
                                                                            ResultSet rsSelect = null;
                                                                            Connection  dh = null;
//                                                                            ResultSet rs = null;
                                                                            ConnectionDB conn = new ConnectionDB();
                                                                            dh = conn.getConnection();
                                                                           
                                                                            try {
                                                                                String sqlSelect = "SELECT * FROM tbl_television_master order by telename ";
                                                                                System.out.println("sqlSelect-" + sqlSelect);
                                                                                stmSelect = ConnectionDB.getDBConnection().prepareStatement(sqlSelect);
                                                                                rsSelect = stmSelect.executeQuery();
                                                                                while (rsSelect.next()) {
                                                                        %>
                                                                        <option value="<%=rsSelect.getString(2)%>"><%=rsSelect.getString(2)%></option>
                                                                        <%
                                                                                }
                                                                            } catch (Exception e) {
                                                                                System.err.println("exception in television channel list:- " + e.getMessage());
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
                                                                    <input type="text" class="form-control" name="subject"  autocomplete="off" oninput="errorBlank('errSubject')" id="subject"  placeholder="Enter  Title (English)" required>
                                                                    <span id="errSubject" class="text-danger"></span>

                                                                    <!--<input type="text" class="form-control" id="Program" name="Program" placeholder="Title / Name of Program" required>-->
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="Program" class="col-sm-3 control-label">Title (Marathi) </label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" id="subjectTag">
                                                                    <input type="text" class="form-control" name="titlemarathi"  autocomplete="off" oninput="errorBlank('errTitlemarathi')" id="titlemarathi"  placeholder="Enter  Title (Marathi)" required>
                                                                    <span id="errTitlemarathi" class="text-danger"></span>

                                                                    <!--<input type="text" class="form-control" id="Program" name="Program" placeholder="Title / Name of Program" required>-->
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="Details" class="col-sm-3 control-label">Details / Topic / Information of Program</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <textarea type="text" class="form-control" id="description" name="description" placeholder="Details / Topic / Information of Program" oninput="errorBlank('errDescription')" rows="3" required></textarea>
                                                                    <!--<textarea class="form-control" id="description" name="description" autocomplete="off" oninput="errorBlank('errDescription')" placeholder="Enter Description " rows="3" required></textarea>-->
                                                                    <span id="errDescription" class="text-danger"></span>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="sourcedate" class="col-sm-3 control-label">Source Date </label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" >
                                                                    <input type="text" class="form-control" name="sourcedate" autocomplete="off" oninput="errorBlank('errsourcedate')" id="date-start2"  placeholder="Enter Sourcedate" required>
                                                                    <span id="errsourcedate" class="text-danger"></span>
                                                                    <!--<input type="text" class="form-control" id="Program" name="Program" placeholder="Title / Name of Program" required>-->
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="timestamp" class="col-sm-3 control-label">Timestamp</label>
                                                            <div class="col-sm-9">
                                                                <div class="">
                                                                    <div class="col-sm-4 ">
                                                                        <select  class="form-control " name="hour" id="hour" onchange="errorBlank('errHour')"  required>
                                                                            <option value="-1">-Select Hour-</option>
                                                                            <option value="01">1</option>
                                                                            <option value="02">2</option>
                                                                            <option value="03">3</option>
                                                                            <option value="04">4</option>
                                                                            <option value="05">5</option>
                                                                            <option value="06">6</option>
                                                                            <option value="07">7</option>
                                                                            <option value="08">8</option>
                                                                            <option value="09">9</option>
                                                                            <option value="10">10</option>
                                                                            <option value="11">11</option>
                                                                            <option value="12">12</option>

                                                                        </select>   
                                                                        <span id="errHour" class="text-danger"></span>

                                                                    </div>
                                                                    <div class="col-sm-4">
                                                                        <select  class="form-control " name="minute" id="minute" onchange="errorBlank('errMinute')" required>
                                                                            <option value="-1">-Select Minute-</option>
                                                                            <option value="00">0</option>
                                                                            <option value="01">1</option>
                                                                            <option value="02">2</option>
                                                                            <option value="03">3</option>
                                                                            <option value="04">4</option>
                                                                            <option value="05">5</option>
                                                                            <option value="06">6</option>
                                                                            <option value="07">7</option>
                                                                            <option value="08">8</option>
                                                                            <option value="09">9</option>
                                                                            <option value="10">10</option>
                                                                            <option value="11">11</option>
                                                                            <option value="12">12</option>
                                                                            <option value="13">13</option>
                                                                            <option value="14">14</option>
                                                                            <option value="15">15</option>
                                                                            <option value="16">16</option>
                                                                            <option value="17">17</option>
                                                                            <option value="18">18</option>
                                                                            <option value="19">19</option>
                                                                            <option value="20">20</option>
                                                                            <option value="21">21</option>
                                                                            <option value="22">22</option>
                                                                            <option value="23">23</option>
                                                                            <option value="24">24</option>
                                                                            <option value="25">25</option>
                                                                            <option value="26">26</option>
                                                                            <option value="27">27</option>
                                                                            <option value="28">28</option>
                                                                            <option value="29">29</option>
                                                                            <option value="30">30</option>
                                                                            <option value="31">31</option>
                                                                            <option value="32">32</option>
                                                                            <option value="33">33</option>
                                                                            <option value="34">34</option>
                                                                            <option value="35">35</option>
                                                                            <option value="36">36</option>
                                                                            <option value="37">37</option>
                                                                            <option value="38">38</option>
                                                                            <option value="39">39</option>
                                                                            <option value="40">40</option>
                                                                            <option value="41">41</option>
                                                                            <option value="42">42</option>
                                                                            <option value="43">43</option>
                                                                            <option value="44">44</option>
                                                                            <option value="45">45</option>
                                                                            <option value="46">46</option>
                                                                            <option value="47">47</option>
                                                                            <option value="48">48</option>
                                                                            <option value="49">49</option>
                                                                            <option value="50">50</option>
                                                                            <option value="51">51</option>
                                                                            <option value="52">52</option>
                                                                            <option value="53">53</option>
                                                                            <option value="54">54</option>
                                                                            <option value="55">55</option>
                                                                            <option value="56">56</option>
                                                                            <option value="57">57</option>
                                                                            <option value="58">58</option>
                                                                            <option value="59">59</option>
                                                                        </select>  

                                                                        <span id="errMinute" class="text-danger"></span>
                                                                    </div>
                                                                    <div class="col-sm-4">
                                                                        <select  class="form-control " name="ampm" id="ampm" onchange="errorBlank('errAmpm')"  required>
                                                                            <option value="AM">AM</option>
                                                                            <option value="PM">PM</option>
                                                                        </select>

                                                                        <span id="errAmpm" class="text-danger"></span>
                                                                    </div>
                                                                    <!--<input type="text" class="form-control" name="timestamp" id="timestamp" autocomplete="off" oninput="errorBlank('errtimestamp')" aria-describedby="timestamp" placeholder="Enter Timestamp" required>-->

                                                                    <!--<input type="text" class="form-control" id="Summary" name="Summary" placeholder="Summary" required>-->
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="Sentiment" class="col-sm-3 control-label">Sentiment</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <select  class="form-control " name="sentiment" id="sentiment" onchange="errorBlank('errSentiment')" required>
                                                                        <option value="-1">-Select Sentiment-</option>
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

                                                                        %> </select>  

                                                                    <span id="errSentiment" class="text-danger"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="Links" class="col-sm-3 control-label">Add Links</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <input type="text" class="form-control" name="link" id="link" autocomplete="off" oninput="errorBlank('errLink')"  aria-describedby="link" placeholder="Add links here">

                                                                    <span id="errLink" class="text-danger"></span>
                                                                    <!--<input type="text" class="form-control" id="Links" name="Links" placeholder="Add Links" required>-->
                                                                </div> <small class="text-success">Add links with <code>,</code> comma</small> </div>

                                                        </div>
                                                        <div class="form-group">
                                                            <label for="additional" class="col-sm-3 control-label"> Tags</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line " id="newTag">
                                                                    <input type="text" class="form-control" name="additional" oninput="errorBlank('errTag')" id="additional" autocomplete="off"  aria-describedby="additional" placeholder="Add Tags here">

                                                                    <!--<input type="text" class="form-control" id="Links" name="Links" placeholder="Add Links" required>-->
                                                                </div>
                                                                <span id="errTag" class="text-danger"></span>

                                                                <div id="divAa" style="font-size: 14px;border:1px solid #c8cbce;display: none" class="text-white"></div>
                                                                <!--<input type="hidden" class="txt" name="additional" id="additional" >-->

                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-sm-12 text-right">
                                                                <button class="btn btn-danger" data-toggle="modal" data-target="#defaultModal" onclick="return saveNewsData()" id="btnSaveVideo"  >SAVE</button>
                                                            </div>
                                                        </div>
                                                        <!--modal-->
                                                        <!--                                                    <div class="modal fade m-t-125" id="defaultModal" tabindex="-1" role="dialog">
                                                                                                                <div class="modal-dialog" role="document">
                                                                                                                    <div class="modal-content">
                                                                                                                        <div class="modal-header">
                                                                                                                        </div>
                                                                                                                        <div class="modal-body text-center"> <h4>Your Video Reference Number is</h4> <br/>
                                                                                                                            <br/>
                                                                                                                            <span class="badge bg-green font-28 p-t-10 p-b-10 p-l-30 p-r-30">N3310</span> </div>
                                                                                                                        <div class="modal-footer">
                                                                                                                            <button type="button" class="btn btn-link waves-effect" data-dismiss="modal">CLOSE</button>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </div>-->

                                                        <!--</div>-->
                                                    </form>
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
            <div class="modal  bodyBackground" id="myModel1" tabindex="-1" role="dialog" style="display: none">
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

                            <p class="text-success semi-bold" style="font-size:18px">Generated Text News Reference Number  is:-<%=workcode%> </p>

                            <!--<iframe width="560" height="315" src="https://www.youtube.com/embed/u3xKgwKUQLc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>-->
                        </div>
                        <div class="modal-footer">
                            <a href="em_newsadd.jsp"> <button type="button" class="btn btn-link waves-effect"  data-dismiss="#myModel1" onclick="closeDiv1()">CLOSE</button></a>   </div>
                    </div>
                </div>
            </div>
        </section>
        <!--<input type="text" name="status" id="textInput">-->
        <!--<form>-->
        <input type="hidden" id="fd">
        <!--<input type="button" onclick="sendFileToServer(fd,status)" value="Submit">-->




        <script>
        </script>
        <!--</form>-->
        <!--                    </div>
                        </div>
        
                    </div>
                </div>
            </div>-->




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
        </script>
        <script type="text/javascript">
            $(document).ready(function () {
                if (window.location.href.indexOf("tags") > -1) {
//alert("test");
                    document.getElementById('myModelTag').style.display = "block";

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
//                alert("tes");
//                var urlParams = new URLSearchParams(window.location.search);
//                var myParam = urlParams.get('available');
//                alert(myParam);
                if (window.location.href.indexOf("available") > -1) {
//alert("jhj");

                    document.getElementById("sameEntry").style.display = "block";
                    document.getElementById("sameEntryExist").innerHTML = "Video file Already exist. Please try another one";
                    var span = document.getElementsByClassName("close")[0];
//                                    span.onclick = function () {
//                                        modal.style.display = "none";
//                                    }
//                                    window.onclick = function (event) {
//                                        if (event.target == modal) {
//                                            modal.style.display = "none";
//                                        }
//                                    }
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
            function closeDiv1() {
//                alert("jsjfgg");
                document.getElementById('myModel1').style.display = "none";
//                document.getElementById('tag').style.display = "block";
//                $("#informationClass").removeClass("active");
//                $("#tagClass").addClass("active");
////                var element = document.getElementById("tag");
////                    element.classList.add("active");
////                                  window.location.href="#tag";
////                                   $("#information").collapse('hide');
//                $("#information").hide();
//                $("#tag").show();
//                alert("dsdshj");
//                document.getElementById("tag").d
//                $('#information').modal('hide');
//                $('#tag').modal('show');
//        href="#tag" data-toggle="tab"
//                window.location.href="#nextTag";
            }
        </script>
        <script>
            $(function () {
                function split(val) {
                    return val.split(/,\s*/);
                }
                function extractLast(term) {
                    return split(term).pop();
                }

                $("#subjectTag input")
                        .autocomplete({
                            source: function (request, response) {
                                $.getJSON("jsonfile_mediaroom.jsp?description=" + document.getElementById("subject").value, {
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
                $("#descritpionTag textarea")
                        .autocomplete({
                            source: function (request, response) {
                                $.getJSON("jsonfile_mediaroom.jsp?description=" + document.getElementById("description").value, {
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
//            $('#sourcedate').bootstrapMaterialDatePicker({weekStart: 0, time: false});
            $('#date-end').bootstrapMaterialDatePicker({weekStart: 0, time: false});
            $('#date-start').bootstrapMaterialDatePicker({weekStart: 0, time: false}).on('change', function (e, date)
            {
                $('#date-end').bootstrapMaterialDatePicker('setMinDate', date);
            });
        </script>
        <script>

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


            $(function () {
                function split(val) {
                    return val.split(/,\s*/);
                }
                function extractLast(term) {
                    return split(term).pop();
                }

                $("#newTag input")
                        .autocomplete({
                            source: function (request, response) {
                                $.getJSON("jsonfile_mediaroom.jsp?description=" + document.getElementById("addTag").value, {
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
//            function submitTagData() {
//
//
//                var a = document.getElementById("divAa").innerHTML;
////                alert(a);
//                document.getElementById("additional").value = a;
////                document.getElementById("submitFormTag").submit();
////                alert(a);
//
//            }
        </script>
        <script>
            function saveNewsData() {

//                var aa = document.getElementById("newFilename").value;
////                alert(aa);
////                var aa = document.getElementsByClassName("filename");
//                var abc;
                var channel = document.getElementById("channel").value;
                var subject = document.getElementById("subject").value;
                var description = document.getElementById("description").value;
                var sentiment = document.getElementById("sentiment").value;
                var titlemarathi = document.getElementById("titlemarathi").value;
//                var uploadstatus = document.getElementById("uploadstatus").value;
//                for (var i = 0; i < aa.length; i++) {
//                    abc += aa[i].textContent + ",\n";
////                    alert(aa[i].textContent);
////            if(abc!=""){       
//                    document.getElementById("textInput").value = abc;
//
//                }

                if (channel == "-1") {
                    document.getElementById("errChannel").innerHTML = "Please Select Channel";
                    document.getElementById("channel").focus();
                    return false;
                }
                if (subject == "") {
                    document.getElementById("errSubject").innerHTML = "Please Enter Title (English)";
                    document.getElementById("subject").focus();
                    return false;
                }
                if (titlemarathi == "") {
                    document.getElementById("errTitlemarathi").innerHTML = "Please Enter Title (Marathi)";
                    document.getElementById("titlemarathi").focus();
                    return false;
                }
                if (description == "") {
                    document.getElementById("errDescription").innerHTML = "Please Enter Description";
                    document.getElementById("description").focus();
                    return false;
                }
                if (document.getElementById("date-start2").value == "") {
//                    document.getElementById("errsourcedate").innerHTML = "Please select Date";
                    document.getElementById("date-start2").focus();
                    return false;
                }
                if (document.getElementById("hour").value == "-1") {
                    document.getElementById("errHour").innerHTML = "Please select Hour";
                    document.getElementById("hour").focus();
                    return false;
                }
                if (document.getElementById("minute").value == "-1") {
                    document.getElementById("errMinute").innerHTML = "Please select Minute";
                    document.getElementById("minute").focus();
                    return false;
                }
                if (document.getElementById("ampm").value == "-1") {
                    document.getElementById("errAmpm").innerHTML = "Please select AM/PM";
                    document.getElementById("ampm").focus();
                    return false;
                }

                if (sentiment == "-1") {
                    document.getElementById("errSentiment").innerHTML = "Please Select Sentiment";
                    document.getElementById("sentiment").focus();
                    return false;
                }
                if (document.getElementById("link").value == "") {
                    document.getElementById("errLink").innerHTML = "Please enter Link";
                    document.getElementById("link").focus();
                    return false;
                }
                if (document.getElementById("additional").value == "" && $('#divAa:empty').length) {
                    document.getElementById("errTag").innerHTML = "Please enter Tags";
                    document.getElementById("additional").focus();
                    return false;
                }
//                if( $('#divAa:empty').length ) {
//                    alert("test");
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

                var a = document.getElementById("divAa").innerHTML;

//                alert(a);
                document.getElementById("additional").value = a;

                document.getElementById("uploadform").submit();

            }
            $('#date-start2').bootstrapMaterialDatePicker({weekStart: 0, time: false});
        </script>
    </script>

</body>
</html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>

