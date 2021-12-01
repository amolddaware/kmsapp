<%-- 
    Document   : edit_unsaved_video_file
    Created on : Sep 10, 2018, 3:25:43 PM
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
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title><%=rb.getString("title")%></title>
        <!--        <link rel="stylesheet" href="node_modules/font-awesome/css/font-awesome.min.css" />
                <link rel="stylesheet" href="node_modules/perfect-scrollbar/dist/css/perfect-scrollbar.min.css" />-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery.perfect-scrollbar/0.8.1/css/perfect-scrollbar.min.css" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
        <!--        <link rel="stylesheet" type="text/css" href="jquery.autocomplete.css" />
                <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>-->

        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/extra.css" />
        <link rel="shortcut icon" href="images/Maharashtra1.jpg" type="image/jpg" />
        <!--<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>-->
        <!--<script src="js/alertify.min.js"></script>-->
        <link rel="stylesheet" href="css/alertify.core.css" />
        <link rel="stylesheet" href="css/alertify.default.css" id="toggleCSS" />
        <!--<script src="js/sweetalert-dev.js"></script>-->
        <!--<script src="javascript.js"></script>-->
          <link href="css/jquery-ui.css" rel="stylesheet">
        <!--<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />-->
        <link href="css/jquery.multiselect.css" rel="stylesheet" />
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <link href="http://cdn.rawgit.com/davidstutz/bootstrap-multiselect/master/dist/css/bootstrap-multiselect.css"  rel="stylesheet" type="text/css" />
        <script src="js/jquery.multiselect.js"></script>
        <link rel="stylesheet" type="text/css" href="style.css" />
        <!--<link rel="stylesheet" type="text/css" href="css/sweetalert.css" />-->
 <script>
            $(function () {

                $('#generaltag').keypress(function () {
                    $.ajax({
                        url: "jsonfile.jsp",
                        type: "post",
                        data: '',
                        success: function (data) {
                            $("#generaltag").autocomplete({
                                source: data
                            });

                        }, error: function (data, status, er) {
                            console.log(data + "_" + status + "_" + er);
                        },
                    });

                });

            });
        </script>
        <style>
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
        </style>
        <script>
            function saveData() {
                var aa = document.getElementsByClassName("filename");
                var abc;
//                var ilink = document.getElementById("ilink").value;
//                var vlink = document.getElementById("vlink").value;
//                var dlink = document.getElementById("dlink").value;
//                alert("hi");
//if(ilink!=""|| dlink!="" || vlink!="" || aa.length==""){
//    
//      document.getElementById("uploadform").submit();
//
//}
//                if(aa.length==""){
//                    document.getElementById("skipDiv").style.display="block";
////                    alert("errormad");
//return false;
//                }
                for (var i = 0; i < aa.length; i++) {
                    abc += aa[i].textContent + ",\n";
//                    alert(aa[i].textContent);
//            if(abc!=""){       
                    document.getElementById("textInput").value = abc;

                }
                document.getElementById("uploadform").submit();

            }
        </script>
        <script>
            function checkextensionImg() {
                var file = document.querySelector("#fileImg");
                if (/\.(jpe?g|png|gif)$/i.test(file.files[0].name) === false) {
//      alert("not an image!");
                    document.getElementById("errFileImg").innerHTML = "File Format not match";
                    document.getElementById("fileImg").focus();
                    return false;
                }
                else {
                    document.getElementById("errFileImg").innerHTML = "";

                }
            }
            function checkextensionVdo() {
                var file = document.querySelector("#fileVdo");
                if (/\.(mov|m4v|webm|mp4|mpeg|avi|wmv)$/i.test(file.files[0].name) === false) {
//      alert("not an image!");
                    document.getElementById("errFileVdo").innerHTML = "File Format not match";
                    document.getElementById("fileVdo").focus();
                    return false;
                } else {
                    document.getElementById("errFileVdo").innerHTML = "";
                }
            }
            function checkextensionDoc() {
                var file = document.querySelector("#file");
                if (/\.(txt|doc|docx|xls|xlsx|pdf|ppt|pptx)$/i.test(file.files[0].name) === false) {
//      alert("not an image!");
                    document.getElementById("errFile").innerHTML = "File Format not match";
                    document.getElementById("file").focus();
                    return false;
                } else {
                    document.getElementById("errFile").innerHTML = "";

                }
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
            function addFiles() {
                var items = document.getElementsByName('vfiles');
                var selectedItems = "";
                var selectedItems1 = "";
                for (var i = 0; i < items.length; i++) {
                    if (items[i].type == 'checkbox' && items[i].checked == true) {
                        selectedItems += items[i].value + "\n<br>";
                        selectedItems1 += items[i].value + ",\n";
                        document.getElementById("addFiles").innerHTML = selectedItems;
                        document.getElementById("vdofiles").value = selectedItems1;
                        document.getElementById("Vfiles").style.display = "block";
                        document.getElementById("displayFileModal").style.display = "none";
                    } else {
                        document.getElementById("errVfiles").innerHTML = "Please select files";
                    }
                }

//                alert(selectedItems);
            }
        </script>
        <script type="text/javascript">
            $(document).ready(function () {
                if (window.location.href.indexOf("success") > -1) {

                    var modal = document.getElementById('myModal').style.display = "block";
                    ;

// Get the button that opens the modal
//var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
                    var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 
//btn.onclick = function() {
//    modal.style.display = "block";
//}

// When the user clicks on <span> (x), close the modal
                    span.onclick = function () {
                        modal.style.display = "none";
                    }

// When the user clicks anywhere outside of the modal, close it
                    window.onclick = function (event) {
                        if (event.target == modal) {
                            modal.style.display = "none";
                        }
                    }
//                    alert("your url contains the name franky");
                }
            });
        </script>
     
        <style>
            .modal {
                display: none; /* Hidden by default */
                position: fixed; /* Stay in place */
                z-index: 1; /* Sit on top */
                padding-top: 100px; /* Location of the box */
                left: 0;
                top: 0;
                width: 100%; /* Full width */
                height: 100%; /* Full height */
                overflow: auto; /* Enable scroll if needed */
                background-color: rgb(0,0,0); /* Fallback color */
                background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
            }

            /* Modal Content */
            .modal-content {
                background-color: #fefefe;
                margin: auto;
                padding: 20px;
                border: 1px solid #888;
                width: 50%;
            }

            /* The Close Button */
            .close {
                color: #aaaaaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .close:hover,
            .close:focus {
                color: #000;
                text-decoration: none;
                cursor: pointer;
            }

        </style>
    </head>

    <body>
        <div class=" container-scroller">
            <!--Navbar-->
            <jsp:include page="userHeader.jsp"></jsp:include>
                <!--End navbar-->
                <div class="container-fluid">
                    <div class="row row-offcanvas row-offcanvas-right">
                    <%--<jsp:include page="userLeft.jsp"></jsp:include>--%>
                        <!-- SIDEBAR ENDS -->
                        <div class="content-wrapper">
                            <!--<h5 class="text-primary mb-4 ">News Data Entry</h5>-->
                            <div class="row mb-2">
                                <div class="col-lg-12">
                                    <div class="card">
                                        <div class="card-block">



                                            <div class="col-xs-12"> 
                                                <!--<h5 class="card-title mb-4">Basic form elements</h5>-->
                                                <!--<form class="forms-sample" action="check.do" method="post" enctype="multipart/form-data">-->
                                                <!--<form class="forms-sample" action="<%//=request.getContextPath()%>/dataentry.do" method="post" enctype="multipart/form-data">-->
                                            <section class="design-process-section col-sm-12" id="process-tab">
                                                <!--<div class="container">-->
                                                <div class="row">
                                                    <div class="col-sm-9 offset-2">
                                                    
                                                        <div class="tab-content">
                                                            <!--                                                            <div role="tabpanel" class="tab-pane active" id="information">
                                                                                                                            <div class="design-process-content">
                                                                                                                                <h3 class="semi-bold">Information</h3>
                                                                                                                                <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincid unt ut laoreet dolore magna aliquam erat volutpat</p>
                                                            
                                                            <%--<jsp:include page="information.jsp"></jsp:include>--%>

                                                                </div>
                                                            </div>
                                                        </div>-->
                                                            <div role="tabpanel"  id="upload">
                                                                <!--<div role="tabpanel" class="tab-pane" id="upload">-->
                                                                <div class="design-process-content col-sm-12">
                                                                    <h4 class="semi-bold">Video Information 
                                                                    </h4>
                                                                    <br>

                                                                    <form action="<%=request.getContextPath()%>/addunsavedvideo.do"  id="uploadform" method="post">
                                                                        <%
                                                                        String vdopath=null;
                                                                        
                                                                        if(request.getParameter("vdopath")!=null){
                                                                        vdopath=request.getParameter("vdopath");
                                                                        }
                                                                        
                                                                        %>

                                                                        <!--<input type="hidden"  id="textInput" name="getUpload" >-->
                                                                        <div class="row mb-2">
                                                                            <!--<div class="col-sm-12">-->
                                                                            <div class="col-lg-3">
                                                                                <input id="token" name="token" type="hidden" value="<%=token%>" />

                                                                                <label for="subject">Title/Name of program</label>
                                                                            </div>
                                                                            <div class="col-lg-6">
                                                                                <input type="text" class="txt" name="subject"  autocomplete="off" oninput="errorBlank('errSubject')" id="subject"  placeholder="Enter  Title">

                                                                                <!--<small id="emailHelp" class="form-text text-muted text-success"><span class="fa fa-info mt-1"></span>&nbsp;</small>-->
                                                                            </div>
                                                                            <div class="col-lg-3">
                                                                                <span id="errSubject" class="text-danger">&nbsp;</span>

                                                                            </div>
                                                                            <!--</div>-->
                                                                        </div>


                                                                        <div class="row mb-2">
                                                                            <div class="col-lg-3">
                                                                                <label for="description">Details/Topic/Information of program</label>
                                                                            </div><div class="col-lg-6">
                                                                                <textarea class="txtarea" id="description" name="description" autocomplete="off" oninput="errorBlank('errDesc')" placeholder="Enter Description " rows="3"></textarea>

                                                                                <!--<small id="emailHelp" class="form-text text-muted text-success"><span class="fa fa-info mt-1"></span>&nbsp;</small>-->
                                                                            </div>
                                                                            <div class="col-lg-3">
                                                                                <span id="errDesc" class="text-danger">&nbsp;</span>

                                                                            </div>
                                                                        </div>

                                                                        <div class="row mb-2">
                                                                            <!--<div class="col-sm-12">-->
                                                                            <div class="col-lg-3">

                                                                                <label for="tag">Summary</label>
                                                                            </div>
                                                                            <div class="col-lg-6">
                                                                                <input type="text" class="txt" name="summary" id="summary"   autocomplete="off" oninput="errorBlank('errSummary')" aria-describedby="tag" placeholder="Enter Summary">

                                                                                <!--<small id="emailHelp" class="form-text text-muted text-success"><span class="fa fa-info mt-1"></span>&nbsp;</small>-->
                                                                            </div>
                                                                            <div class="col-lg-3">
                                                                                <span class="text-danger" id="errSummary"></span>
                                                                            </div>
                                                                            <!--</div>-->
                                                                        </div>
                                                                        <div class="row mb-2">
                                                                            <!--<div class="col-sm-12">-->
                                                                            <div class="col-lg-3">

                                                                                <label for="link">Add Links</label>
                                                                            </div>
                                                                            <div class="col-lg-6">
                                                                                <input type="text" class="txt" name="link" id="link" autocomplete="off"   aria-describedby="link" placeholder="Add links here">
                                                                                <small id="dlinkHelp" class="form-text text-muted text-success"><span class="fa fa-info mt-1"></span>&nbsp;Add links with comma
                                                                                </small>

                                                                                <!--<small id="emailHelp" class="form-text text-muted text-success"><span class="fa fa-info mt-1"></span>&nbsp;</small>-->
                                                                                <!--</div>-->
                                                                            </div>
                                                                        </div>                                                                        
                                                                                          
                                                                                                                               
                                                                        <div class="row mb-2">
                                                                            <!--<div class="col-sm-12">-->
                                                                            <div class="col-lg-3">

                                                                                <label for="dragandrophandler">Video File </label>

                                                                            </div>
                                                                            <div class="col-lg-6">
                                                                                <input type="text" class="txt" name="getUpload"  id="vdopath" autocomplete="off" value="<%=vdopath%>" readonly  >

                                                                                <!--<div id="dragandrophandler" ><small>Drag & Drop only 1 .mp4 Files Here</small></div>-->
                                                                                <br><br>

                                                                            </div>
                                                                        </div>
                                                                        <div class="row mb-2">
                                                                            <!--<div class="col-sm-12">-->
                                                                            <!--        <div class="col-lg-3">
                                                                            
                                                                                        <label for="dlink">Drag & Drop Files here </label>
                                                                                    </div>-->
                                                                            <div class="col-lg-8">
                                                                                <div id="status1"></div>
                                                                                <br><br>
                                                                                <!--<input type="text" class="txt" name="dlink" id="dlink"  aria-describedby="Dlink" placeholder="Add Documents links here">-->
                                                                                <!--<small id="dlinkHelp" class="form-text text-muted text-success"><span class="fa fa-info mt-1"></span>&nbsp;Add Documents links with comma</small>-->

                                                                                <!--<small id="emailHelp" class="form-text text-muted text-success"><span class="fa fa-info mt-1"></span>&nbsp;</small>-->
                                                                                <!--</div>-->
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-sm-12">
                                                                            <div class="form-group text-md-center">
                                                                                <!--<a href="newssource.jsp#source?skip" target="_top" onClick="window.location.reload();" class="text-success btn semi-bold" title="Skip to next tab">skip</a>-->
                                                                                <input type="button" class="btn btn-primary" onclick="saveData()"  value="Save and Continue">
                                                                                <!--<input type="submit" class="btn btn-primary"   value="Save and Continue">-->
                                                                            </div>
                                                                        </div>

                                                                    </form>
                                                                    <%//}%>

                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="myModal" class="modal" style="display: none">
                                                    <!-- Modal content -->
                                                    <div class="modal-content">
                                                        <div class="row mb-2 text-center">
                                                            <!--<span class="close">&times;</span>-->
                                                            <div class="col-lg-12">
                                                                <%
                                                                    String workcode = "";
                                                                    if (request.getParameter("workcode") != null) {
                                                                        workcode = request.getParameter("workcode");
//                                                                            out.println(request.getParameter("workcode"));
                                                                    }%>

                                                                <p class="text-success semi-bold" style="font-size:18px">Successfully edited Reference Number  is:-<%=workcode%> </p>
                                                                <!--<p></p>-->

                                                            </div>
                                                            <div class="col-lg-12">

                                                                <a href="userHome.jsp"> <button class="btn btn-primary" onclick="closeDiv()">Close</button></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="openDiv" class="modal" style="display: none">
                                                    <!-- Modal content -->
                                                    <div class="modal-content">
                                                        <div class="row mb-2 text-center">
                                                            <!--<span class="close">&times;</span>-->
                                                            <div class="col-lg-12">
                                                                <p class="text-success semi-bold" id="ajaxData" style="font-size:18px"></p>
                                                            </div>
                                                            <div class="col-lg-12">
                                                                <!--<a href="source1.jsp?workcode=<%//=workcode%>#source"> <button class="btn btn-primary" onclick="closeDiv()">Close</button></a>-->
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="skipDiv" class="modal" style="display: none">
                                                    <!-- Modal content -->
                                                    <div class="modal-content">
                                                        <div class="row mb-2 text-center">
                                                            <!--<span class="close">&times;</span>-->
                                                            <div class="col-lg-12">
                                                                <p class="text-success semi-bold"  style="font-size:18px"> Do you want skip this stage?</p>
                                                            </div>
                                                            <div class="col-lg-12">
                                                                <a href="newssource.jsp#source?skip"> <button class="btn btn-primary" >Yes</button></a>
                                                                <a href="#"><button class="btn btn-danger" onclick="closeSkipDiv()" >NO</button></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="displayFileModal" class="modal" style="display: none">
                                                    <!-- Modal content -->
                                                    <div class="modal-content">
                                                        <div class="row mb-2 text-center">
                                                            <!--<span class="close">&times;</span>-->
                                                            <div class="col-lg-12">

                                                                <div id="demotext"></div>
                                                                <!--<p class="text-success semi-bold" id="demotext" style="font-size:18px"></p>-->
                                                            </div>
                                                            <div class="col-lg-12">
                                                                <!--<a href="source1.jsp?workcode=<%//=workcode%>#source"> <button class="btn btn-primary" onclick="closeDiv()">Close</button></a>-->
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
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
                                                <div id="displayAvailable" class="modal" style="display: none">
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
                                                <% //if(request.getParameter("sameentry")!=""){%>
                                                <div id="sameEntry" class="modal" style="display: none;" >
                                                    <!-- Modal content -->
                                                    <div class="modal-content">
                                                        <div class="row mb-2 text-center">
                                                            <!--<span class="close">&times;</span>-->
                                                            <div class="col-lg-12">

                                                                <!--<div id=""></div>-->
                                                                <p class="text-success semi-bold" id="sameEntryExist" style="font-size:18px"><%
//                                                               String message="";
//                                                                if(request.getAttribute("filename")!=null){
//                                                                   message=request.getAttribute("filename").toString();
//                                                                System.out.println("The:-"+message +" file already exist. Please choose another file.");    
//                                                                }
//                                                                out.println(message);
                                                                    %> </p>
                                                            </div>
                                                            <div class="col-lg-12">
                                                                <button class="btn btn-primary" onclick="closeEntryDiv()">Close</button></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div><% //}%>
                                            </section>
                                            <!--<input type="text" id="ajaxData1">-->
                                        </div>
                                        <!--                                            <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
                                                                                    <script src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js'></script>-->
                                        <script >// script for tab steps

                                            $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {

                                                var href = $(e.target).attr('href');
                                                var $curr = $(".process-model  a[href='" + href + "']").parent();
                                                window.location.hash = href;
                                                $('.process-model li').removeClass();
                                                $curr.addClass("active");
                                                $curr.prevAll().addClass("visited");

                                            });

                                        </script>  <script type="text/javascript">
                                            // Get URL
                                            var url = window.location.href;
                                            // Get DIV
//  var msg = document.getElementById('upload');
                                            // Check if URL contains the keyword

                                            if (url.search('information') > 0) {
                                                // Display the message

                                                document.getElementById('information').style.display = "block";
                                                document.getElementById('upload').style.display = "none";
                                                document.getElementById('source').style.display = "none";
                                                document.getElementById('tag').style.display = "none";
//                                                    location.reload();

                                            } else if (url.search('upload') > 0) {
                                                // Display the message
                                                document.getElementById('upload').style.display = "block";

//                                                    document.getElementById('upload').addClass = "active";
                                                document.getElementById('information').style.display = "none";
                                                document.getElementById('source').style.display = "none";
                                                document.getElementById('tag').style.display = "none";
//                                                    location.reload();



                                            }
                                            else if (url.search('source') > 0) {
                                                // Display the message
                                                document.getElementById('source').style.display = "block";
                                                document.getElementById('upload').style.display = "none";
                                                document.getElementById('information').style.display = "none";
                                                document.getElementById('tag').style.display = "none";
//                                                                                                    location.reload();
                                            }
                                            else if (url.search('tags') > 0) {
                                                // Display the message 
//                                                     $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
//
////                                                    var href = $(e.target).attr('href');
//                                                   var $curr = $(".process-model  a[href='" + url + "']").parent();
//                                                    window.location.hash = url;
//                                                    $('.process-model li').removeClass();
//                                                    $curr.addClass("active");
//                                                    $curr.prevAll().addClass("visited");
//
//                                                });
                                                document.getElementById('tags').style.display = "block";
                                                document.getElementById('source').style.display = "none";
                                                document.getElementById('upload').style.display = "none";
                                                document.getElementById('information').style.display = "none";
//                                                                                                    location.reload();
                                            }
                                        </script>

                                        <!--<script src="js/jquery.js"></script>-->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--<jsp:include page="userFooter.jsp"></jsp:include>--%>
                    </div>
                </div>
            </div>
                     <script>
            $(function () {
                $('select[multiple].active.3col').multiselect({
                    columns: 1,
                    placeholder: 'Select Category',
                    search: true,
                    searchOptions: {
                        'default': 'Search Category'
                    },
                    selectAll: true
                });

            });
        </script>
        <script type="text/javascript">

            function DropDown(el) {
                this.dd = el;
                this.placeholder = this.dd.children('span');
                this.opts = this.dd.find('ul.dropdown > li');
                this.val = '';
                this.index = -1;
                this.initEvents();
            }
            DropDown.prototype = {
                initEvents: function () {
                    var obj = this;

                    obj.dd.on('click', function (event) {
                        $(this).toggleClass('active');
                        return false;
                    });

                    obj.opts.on('click', function () {
                        var opt = $(this);
                        obj.val = opt.text();
                        obj.index = opt.index();
                        obj.placeholder.text(obj.val);
                    });
                },
                getValue: function () {
                    return this.val;
                },
                getIndex: function () {
                    return this.index;
                }
            }

            $(function () {

                var dd = new DropDown($('#dd'));

                $(document).click(function () {
                    // all dropdowns
                    $('.wrapper-dropdown-3').removeClass('active');
                });

            });

        </script>
            <!--<script src="js/jquery-1.9.1.js" type="text/javascript"></script>-->
            <!--Load jQuery UI Main JS-->  
            <!--<script src="js/jquery-ui.js" type="text/javascript"></script>-->
            <!--Load SCRIPT.JS which will create datepicker for input field-->  
            <script src="js/script.js" type="text/javascript"></script>
        </body>
    </html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>

