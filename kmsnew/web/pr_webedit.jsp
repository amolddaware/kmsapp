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
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("4") || session.getAttribute("role").equals("5"))) {

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


        <!--
                <script>
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
                </script>-->
        <!--        <style>
                    #dragandrophandler
                    {
                        border:2px dotted #0B85A1;
                        width:450px;
                        color:#92AAB0;
                        text-align:left;vertical-align:middle;
                        padding:10px 10px 30px 10px;
                        margin-bottom:10px;
                        font-size:200%;
                    }
                    .progressBar {
                        width: 150px;
                        height: 22px;
                        border: 1px solid #ddd;
                        border-radius: 5px; 
                        overflow: hidden;
                        display:inline-block;
                        margin:0px 10px 5px 5px;
                        vertical-align:top;
                    }
        
                    .progressBar div {
                        height: 100%;
                        color: #fff;
                        text-align: right;
                        line-height: 22px; /* same as #progressBar height if we want text middle aligned */
                        width: 0;
                        background-color: #0ba1b5; border-radius: 3px; 
                    }
                    .statusbar
                    {
                        border-top:1px solid #A9CCD1;
                        min-height:25px;
                        width:695px;
                        padding:10px 10px 0px 10px;
                        vertical-align:top;
                    }
                    .statusbar:nth-child(odd){
                        background:#EBEFF0;
                    }
                    .filename
                    {
                        display:inline-block;
                        vertical-align:top;
                        width:370px;
                    }
                    .filesize
                    {
                        display:inline-block;
                        vertical-align:top;
                        color:#30693D;
                        width:50px;
                        margin-left:5px;
                        margin-right:5px;
                    }
                    .abort{
                        /*                background-color:#A8352F;*/
                        background-color: #FE1A00;
                        border: 1px solid #D83526;
                        -moz-border-radius:4px;
                        -webkit-border-radius:4px;
                        border-radius:4px;
                        display:inline-block;
                        color:#f44336;
                        font-family:arial;font-size:11px;font-weight:normal;
                        padding:2px 15px;
                        cursor:pointer;
                        vertical-align:top;
                        /*                  background-color: #FE1A00;
                            border: 1px solid #D83526;
                                        border-radius: 4px;*/
                        color: #FFF;
                        /*    font-weight: bold;
                            padding: 6px 15px;*/
                        text-decoration: none;
                        text-shadow: 1px 1px 0 rgba(0,0,0,.5);
                        /*box-shadow: inset 0 1px 0 0 rgba(255,255,255,.5);*/
                        background-image: -webkit-linear-gradient(top, rgba(255,255,255,.3), rgba(255,255,255,0));
                        /*cursor: pointer;*/
                        /*width:5px;*/
                    }
                </style>-->
        <script>
            function updateWebMediaCreativeData() {
                var a = document.getElementById("divAa").innerHTML;

//                                    alert(a);
                var ab = document.getElementById("additional1").value;
//                                    alert(ab + " "+a);
                document.getElementById("additional").value = ab + " " + a;
                document.getElementById("uploadwebmediaform").submit();

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

        <%} else if (session.getAttribute("role").equals("4")) {%>
        <jsp:include page="pr_header.jsp"></jsp:include>
        <jsp:include page="pr_left.jsp"></jsp:include>
        <%}%>     <!--End navbar-->
        <section class="content">
            <div class="col-md-12"> 
                <!-- Unordered List -->
                <div class="row clearfix">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="card">
                            <div class="header">
                                <h2>Web Media Dataentry reference No : <%=request.getParameter("workcode")%> </h2>
                                <ul class="header-dropdown m-r--5">
                                    <!--                                    <li class="dropdown"> <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="material-icons">more_vert</i> </a>
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
                                                    <form action="<%=request.getContextPath()%>/updatewebmedia.do" class="form-horizontal m-t-50" id="uploadwebmediaform" method="post" accept-charset="UTF-8">
                                                        <%
                                                            Connection dh = null;
                                                            ConnectionDB connectionDB = new ConnectionDB();
                                                            dh = connectionDB.getConnection();
                                                            PreparedStatement pstmt = null;
                                                            ResultSet rs = null;
                                                            try {
                                                                String subject = "", description = "", summary = "", date = "";

                                                                String selectData = "Select * from tbl_news_dataentry where workcode=?";
                                                                pstmt = dh.prepareStatement(selectData);
                                                                pstmt.setString(1, request.getParameter("workcode"));
                                                                rs = pstmt.executeQuery();
                                                                if (rs.next()) {
                                                                    System.out.println("workcode:-" + rs.getString("workcode"));

                                                        %>

                                                        <!--<input type="hidden"  id="textInput" name="getUpload" >-->
                                                        <input id="maxid" name="workcode" type="hidden" value="<%=request.getParameter("workcode")%>" />
                                                        <input id="token" name="token" type="hidden" value="<%=token%>" />
                                                        <input id="admin" name="admin" type="hidden" value="" />

                                                        <div class="form-group">
                                                            <label for="date" class="col-sm-3 control-label">Date</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" >
                                                                    <input type="text" class="form-control" id="date" value="<%=rs.getString("sourcedate")%>" onblur="errBlank('errDate')" name="sourcedate" placeholder="Date" >
                                                                    <span id="errDate" class="text-danger"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="language" class="col-sm-3 control-label">Language</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <select  class="form-control " name="language" id="language" onchange="errBlank('errLanguage')" >
                                                                        <option value="<%=rs.getString("language")%>"><%=rs.getString("language")%></option>
                                                                        <% PreparedStatement stmSelect = null;
                                                                            ResultSet rsSelect = null;
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
                                                                        <option value="<%=rs.getString("npname")%>"><%=rs.getString("npname")%></option>
                                                                        <%                                                                            PreparedStatement stmSelectWeb = null;
                                                                            ResultSet rsSelectWeb = null;
                                                                            try {
                                                                                String sqlSelectWeb = "SELECT * FROM tbl_newspaper_master ";
                                                                                System.out.println("sqlSelect-" + sqlSelectWeb);
                                                                                stmSelectWeb = dh.prepareStatement(sqlSelectWeb);
                                                                                rsSelectWeb = stmSelectWeb.executeQuery();
                                                                                while (rsSelectWeb.next()) {
                                                                        %>
                                                                        <option value="<%=rsSelectWeb.getString(3)%>"><%=rsSelectWeb.getString(3)%></option>
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
                                                                        <option value="<%=rs.getString("district")%>"><%=rs.getString("district")%></option>
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
                                                                    <input type="text" class="form-control" id="subject" name="subject" placeholder="Title (English)" value="<%=rs.getString("subject")%>" oninput="errBlank('errSubject')"  >
                                                                    <!--<textarea class="form-control" id="description" name="description" autocomplete="off" oninput="errorBlank('errDescription')" placeholder="Enter Description " rows="3" required></textarea>-->
                                                                    <span class="text-danger" id="errSubject"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="title" class="col-sm-3 control-label">Title (Marathi)</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <input type="text" class="form-control" id="titlemarathi" name="titlemarathi" value="<%=rs.getString("titlemarathi")%>" placeholder="Title (Marathi)" oninput="errBlank('errMarathiTitle')"  >
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
                                                                        <option value="-<%=rs.getString("sentiment")%>"><%=rs.getString("sentiment")%></option>
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
                                                            <label for="link" class="col-sm-3 control-label">Link</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" >
                                                                    <!--<div class="col-lg-9 form-control"  style="display: none;" >-->
                                                                    <input type="text" id="link" name="link"  class="form-control" value="<%=rs.getString("link")%>" placeholder="Link" autocomplete="off" oninput="errBlank('errLink')" />
                                                                    <span id="errLink" class="text-danger"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="additional" class="col-sm-3 control-label">Additional Tags</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" id="newTag">
                                                                    <textarea type="text" class="form-control"  id="additional1" autocomplete="off"  aria-describedby="additional" readonly ><%=rs.getString("additionaltag")%></textarea>
                                                                    <input type="text" class="form-control" name="tags" id="additional" autocomplete="off"  aria-describedby="additional" placeholder="Add Tags here">

                                                                    <!--<input type="text" class="form-control" id="Links" name="Links" placeholder="Add Links" required>-->
                                                                </div>
                                                                <div id="divAa" style="font-size: 14px;border:1px solid #c8cbce;display: none" class="text-white"></div>
                                                                <!--<input type="hidden" class="txt" name="additional" id="additional" >-->

                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-sm-12 text-right">
                                                                <button class="btn btn-danger" onclick="updateWebMediaCreativeData()" id="btnSaveVideo" >UPDATE</button>
                                                            </div>
                                                        </div>
                                                    </form>
                                                    <%}
                                                        } catch (Exception e) {
                                                            e.printStackTrace();
                                                        } finally {
                                                            if (dh != null) {
                                                                dh.close();
                                                            }
                                                        }%>

                                                </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div></div></div>

        </section>

        <div class="modal bodyBackground" id="myModal12" tabindex="-1" role="dialog" style="display:none">
            <div class="modal-dialog  m-t-125" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                    </div>
                    <div class="modal-body text-center"> <h4>Your updated reference number is</h4> <br/>
                        <br/>
                        <span class="badge bg-green font-28 p-t-10 p-b-10 p-l-30 p-r-30"><%=request.getParameter("workcode")%></span> </div>
                    <div class="modal-footer">
                        <a href="pr_webview.jsp?searchresult=PW"><button type="button" class="btn btn-link waves-effect" data-dismiss="modal">CLOSE</button></a>
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
        </script>
    </body>
</html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>

