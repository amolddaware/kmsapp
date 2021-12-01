<%-- 
    Document   : dragndrop1
    Created on : Dec 18, 2017, 8:34:23 PM
    Author     : Amol
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%ResourceBundle rb = ResourceBundle.getBundle("msg");%>

<%
//    if (session != null && session.getAttribute("username") != null) {

//    String role = session.getAttribute("role").toString();
    if (session != null && session.getAttribute("username") != null && session.getAttribute("role").equals("2")) {
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
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <title><%=rb.getString("title")%></title>

        <!-- Favicon-->
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

        <!-- Custom Css -->
        <link href="css/style.css" rel="stylesheet">

        <!-- AdminBSB Themes. You can choose a theme from css/themes instead of get all themes -->
        <link href="css/themes/all-themes.css" rel="stylesheet" />  
        <link href="css/jquery-ui.css" rel="stylesheet">
         <script src="https://maps.googleapis.com/maps/api/js?libraries=places&key=AIzaSyD-eGqLReBVwTTRNsl7XTWk2NRRV71p4To"></script>
       
        <script>
            var autocomplete;
            function initialize() {
                autocomplete = new google.maps.places.Autocomplete(
                        (document.getElementById('placeofprogram')),
                        {types: ['geocode']});
                google.maps.event.addListener(autocomplete, 'place_changed', function () {
                });
            }</script>
        <style>
            #dragandrophandler
            {
                border:2px dotted #0B85A1;
                /*width:450px;*/
                color:#92AAB0;
                text-align:left;vertical-align:middle;
                padding:10px 10px 30px 10px;
                margin-bottom:10px;
                font-size:200%;
            }
            .progressBar {
                width: 100px;
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
                width:580px;
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
                width:60px;
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
        </style>

    </head>
    <body  class="theme-blue" onload="initialize()">
        <jsp:include page="cr_header.jsp"></jsp:include>
        <jsp:include page="cr_left.jsp"></jsp:include>
            <!--<div class=" container-scroller">-->
            <!--End navbar-->
            <section class="content">
                <div class="col-md-12"> 
                    <!-- Unordered List -->
                    <div class="row clearfix">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <div class="card">
                                <div class="header">
                                    <h2>ADD NEW INFORMATION</h2>
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
                                                        <form class="form-horizontal m-t-50" action="<%=request.getContextPath()%>/addgraphics.do"  id="uploadform" method="post" accept-charset="UTF-8" enctype="multipart/form-data">

                                                        <input id="token" name="token" type="hidden" value="<%=token%>" />

                                                        <div class="form-group">
                                                            <label for="Program" class="col-sm-3 control-label">Title </label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" id="subjectTag">
                                                                    <input type="text" class="form-control" name="subject" autocomplete="off" oninput="errorBlank('errSubject')" id="subject"  placeholder="Enter  Title" required>
                                                                    <span id="errSubject" class="text-danger"></span>
                                                                    <!--<input type="text" class="form-control" id="Program" name="Program" placeholder="Title / Name of Program" required>-->
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="Details" class="col-sm-3 control-label">Details / Topic / Information of Program</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <!--                                                                    <textarea type="text" class="form-control" id="description" name="description" placeholder="Details / Topic / Information of Program" required></textarea>-->
                                                                    <textarea class="form-control" id="description" name="description" autocomplete="off" oninput="errorBlank('errDescription')" placeholder="Details / Topic / Information of Program " rows="3" required></textarea>
                                                                    <span id="errDescription" class="text-danger"></span>

                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="Category" class="col-sm-3 control-label">Category</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <select id="sector" name="sector" class="form-control"  onchange="errorBlank('errSector')" >
                                                                        <option value="-1">-Select Sector-</option>
                                                                        <!--                                                                               
                                                                        <select id="idCategory2" name="basic[]" class="3col active txtCmbCategory2" multiple="multiple" >-->
                                                                        <%
                                                                            String selectRecord = "select category_name from tbl_category_master";
                                                                            PreparedStatement pstmt = ConnectionDB.getDBConnection().prepareStatement(selectRecord);
                                                                            ResultSet rs = pstmt.executeQuery();
                                                                            while (rs.next()) {
                                                                        %>

                                                                        <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
                                                                        <%}%></select>
                                                                    <span id="errSector" class="text-danger"></span>

                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="nameofprogram" class="col-sm-3 control-label">Name of Program</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <input type="text" class="form-control" name="nameofprogram" id="nameofprogram" autocomplete="off" oninput="errorBlank('errNameofprogram')" aria-describedby="tag" placeholder="Enter Name of Program" required>

                                                                    <span id="errNameofprogram" class="text-danger"></span>
                                                                    <!--<input type="text" class="form-control" id="Summary" name="Summary" placeholder="Summary" required>-->
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="placeofprogram" class="col-sm-3 control-label">Place of Program</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <input type="text" class="form-control" name="placeofprogram" id="placeofprogram" onFocus="geolocate()" autocomplete="off" oninput="errorBlank('errPlaceofprogram')" aria-describedby="tag" placeholder="Enter Place of Program" required>

                                                                    <span id="errPlaceofprogram" class="text-danger"></span>
                                                                    <!--<input type="text" class="form-control" id="Summary" name="Summary" placeholder="Summary" required>-->
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="sourcedate" class="col-sm-3 control-label">Source Date</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <input type="text" class="form-control" name="sourcedate" id="date-start2" autocomplete="off" oninput="errorBlank('errSourcedate')" aria-describedby="tag" placeholder="Enter Source Date"  required>

                                                                    <span id="errSourcedate" class="text-danger"></span>
                                                                    <!--<input type="text" class="form-control" id="Summary" name="Summary" placeholder="Summary" required>-->
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="additional" class="col-sm-3 control-label">Additional Tags</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line " id="newTag">
                                                                    <input type="text" class="form-control" name="additional" oninput="errorBlank('errAdditional')" id="additional" autocomplete="off"  aria-describedby="additional" placeholder="Add Tags here">

                                                                    <!--<input type="text" class="form-control" id="Links" name="Links" placeholder="Add Links" required>-->
                                                                </div>
                                                                <span id="errAdditional" class="text-danger"></span>

                                                                <div id="divAa" style="font-size: 14px;border:1px solid #c8cbce;display: none" class="text-white"></div>
                                                                <!--<input type="hidden" class="txt" name="additional" id="additional" >-->

                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="additionaltag" class="col-sm-3 control-label">Upload Files</label>

                                                            <div class="col-md-9 ">
                                                                <input type="file" id="upload" name="upload" accept=".pdf,.PDF,.jpef,.jpg,.png,.gif,.3gp,.mov,.mp4,.MXF"  class="form-control" onchange="errorBlank('errFile')" placeholder="Upload Files" autocomplete="off" multiple  />
                                                                <span class="text-danger" id="errFile"></span>

                                                                <!--                                                                <div id="dragandrophandler" ><small>Drag & Drop only single .mp4 Files Here</small>
                                                                                                                                    <span id="errDragnDrop" class="text-danger"></span></div>
                                                                
                                                                                                                                <br/>
                                                                                                                                <div class="form-group">
                                                                                                                                    <div id="status1"></div>
                                                                                                                                    <input type="hidden" oninput="errorBlank('errDragnDrop')" onblur="errorBlank('errDragnDrop')" id="uploadstatus">
                                                                                                                                                                                                        <input type="hidden" id="tempvideo" name="tempvideo">
                                                                                                                                                                                                        <input type="hidden" id="newFilename" name="newFilename">
                                                                                                                                </div>-->
                                                            </div>

                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-sm-12 text-right">
                                                                <button type="submit" class="btn btn-danger" data-toggle="modal" data-target="#defaultModal" onclick="return saveCreativeData()" id="btnSaveVideo"  >SAVE</button>
                                                            </div>
                                                        </div>
                                                        <!--modal-->

                                                    </form>
                                                    <form>
                                                        <input type="hidden" id="fd">

                                                    </form>

                                                </div>
                                            </section>
                                            <div class="modal  bodyBackground" id="myModal12" tabindex="-1" role="dialog" style="display:none">
                                                <div class="modal-dialog m-t-125" role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                        </div>
                                                        <div class="modal-body text-center"> <h4>Your Creative Reference Number is</h4> <br/>
                                                            <br/>
                                                            <span class="badge bg-green font-28 p-t-10 p-b-10 p-l-30 p-r-30"><%=request.getParameter("workcode")%></span> </div>
                                                        <div class="modal-footer">
                                                            <a href="cr_add.jsp"><button type="button" class="btn btn-link waves-effect" data-dismiss="modal">CLOSE</button></a>
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
            </div>
        </section>
        <!-- Bootstrap Core Js --> 

        <script src="js/jquery-1.12.4.js"></script>
        <script src="js/jquery-ui.js"></script>
        <script src="plugins/bootstrap/js/bootstrap.js"></script> 

        <!-- Select Plugin Js --> 
        <!--<script src="plugins/bootstrap-select/js/bootstrap-select.js"></script>--> 

        <!-- Slimscroll Plugin Js --> 
        <script src="plugins/jquery-slimscroll/jquery.slimscroll.js"></script> 

        <!-- Bootstrap Colorpicker Js --> 
        <script src="plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script> 

        <!-- Dropzone Plugin Js --> 
        <script src="plugins/dropzone/dropzone.js"></script> 

        <!-- Jquery Validation Plugin Css --> 
        <!--<script src="plugins/jquery-validation/jquery.validate.js"></script>--> 

        <!-- JQuery Steps Plugin Js --> 
        <!--<script src="plugins/jquery-steps/jquery.steps.js"></script>--> 

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
        <!--        <script src="js/pages/forms/form-validation.js"></script> 
                <script src="js/pages/forms/form-wizard.js"></script> -->
        <!--        <script src="js/pages/forms/basic-form-elements.js"></script> 
                <script src="js/pages/forms/advanced-form-elements.js"></script> -->

        <!-- Demo Js --> 
        <script src="js/demo.js"></script>
        <script>
                                                                    $('#date-end').bootstrapMaterialDatePicker({weekStart: 0, time: false});
                                                                    $('#date-start').bootstrapMaterialDatePicker({weekStart: 0, time: false}).on('change', function (e, date)
                                                                    {
                                                                        $('#date-end').bootstrapMaterialDatePicker('setMinDate', date);
                                                                    });
                                                                    $('#date-start2').bootstrapMaterialDatePicker({weekStart: 0, time: false});
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
        </script>
        <script>
            $(document).ready(function () {
                if (window.location.href.indexOf("success") > -1) {
//                    alert("test");
                    document.getElementById('myModal12').style.display = "block";

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
        </script>
        <script>
            function saveCreativeData() {
//                var aa = document.getElementsByClassName("filename");
                var subject = document.getElementById("subject").value;
                var description = document.getElementById("description").value;
                var sector = document.getElementById("sector").value;
                var nameofprogram = document.getElementById("nameofprogram").value;
                var placeofprogram = document.getElementById("placeofprogram").value;
                var sourcedate = document.getElementById("date-start2").value;
                var additionaltag = document.getElementById("additional").value;

//                var uploadstatus = document.getElementById("uploadstatus").value;
                var abc;
//                for (var i = 0; i < aa.length; i++) {
//                    abc += aa[i].textContent + ",\n";
//                    document.getElementById("textInput").value = abc;
//
//                }
                if (subject == "") {
                    document.getElementById("errSubject").innerHTML = "Please Enter Subject";
                    document.getElementById("subject").focus();
                    return false;
                }
                if (description == "") {
                    document.getElementById("errDescription").innerHTML = "Please Enter Description";
                    document.getElementById("description").focus();
                    return false;
                }
                if (sector == "-1") {
                    document.getElementById("errSector").innerHTML = "Please select Sector";
                    document.getElementById("sector").focus();
                    return false;
                }
                if (nameofprogram == "") {
                    document.getElementById("errNameofprogram").innerHTML = "Please Enter Name of Program";
                    document.getElementById("nameofprogram").focus();
                    return false;
                }
                if (placeofprogram == "") {
                    document.getElementById("errPlaceofprogram").innerHTML = "Please Enter Place of Program";
                    document.getElementById("placeofprogram").focus();
                    return false;
                }
                if (sourcedate == "") {
//                    document.getElementById("errsourcedate").innerHTML = "Please Enter Place of Program";
                    document.getElementById("date-start2").focus();
                    return false;
                }
                if (additionaltag == "" && $('#divAa:empty').length) {
                    document.getElementById("errAdditional").innerHTML = "Please enter tag";
                    document.getElementById("additional").focus();
                    return false;
                }
                if (document.getElementById("upload").value == "") {

                    document.getElementById("errFile").innerHTML = "Please select file";
                    document.getElementById("upload").focus();
                    return false;
                }
//                if (uploadstatus != "test") {
//                    document.getElementById("errDragnDrop").innerHTML = "Please upload files";
//                    document.getElementById("dragndrophandler").focus();
//                    return false;
//                }
//                var cbo = document.getElementById("idCategory");
//		alert("The selected value is " + cbo.options[cbo.selectedIndex].value);
                var a = document.getElementById("divAa").innerHTML;

//                alert(a);
                document.getElementById("additional").value = a;

                document.getElementById("uploadform").submit();
//                document.getElementById("uploadform").submit();

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

            function errorBlank(err) {
                document.getElementById(err).innerHTML = "";
            }


        </script>
        <script type="text/javascript">

        </script>

        <script>
//            $(function () {
//                function split(val) {
//                    return val.split(/,\s*/);
//                }
//                function extractLast(term) {
//                    return split(term).pop();
//                }
//
//                $("#creativetag")
//                        .autocomplete({
//                            source: function (request, response) {
//                                $.getJSON("jsonfile_creativetag.jsp?description=" + document.getElementById("creativetag").value, {
//                                    term: extractLast(request.term)
//                                }, response);
//                            },
//                            search: function () {
//                                // custom minLength
//                                var term = extractLast(this.value);
////           alert(term);
//                                if (term.length < 2) {
//
//                                    return false;
//                                }
//                            },
//                        });
//            });
        </script>
    </body>
</html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>

