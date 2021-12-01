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
        <script src="https://maps.googleapis.com/maps/api/js?libraries=places&key=AIzaSyASzoq7WLThZ45UOIkCpTphfmQ0l0NlOSs"></script>
        <!--<script src="https://maps.googleapis.com/maps/api/js?libraries=places&key=AIzaSyD-eGqLReBVwTTRNsl7XTWk2NRRV71p4To"></script>-->
        <!--<script async defer src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=initMap"-->
        <!--type="text/javascript"></script>-->
        <script>

            function closeFileDiv() {
                document.getElementById("displayFileFormat").style.display = "none";

            }

            function errorBlank(err) {
                document.getElementById(err).innerHTML = "";
            }
        </script>
        <script>
            var autocomplete;
            function initialize() {
                autocomplete = new google.maps.places.Autocomplete(
                        (document.getElementById('autocomplete')),
                        {types: ['geocode']});
                 autocomplete.setFields(["address_component"]);
                google.maps.event.addListener(autocomplete, 'place_changed', function () {
                });
            }
            
            function geolocate() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition((position) => {
      const geolocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude,
      };
      const circle = new google.maps.Circle({
        center: geolocation,
        radius: position.coords.accuracy,
      });
      autocomplete.setBounds(circle.getBounds());
    });
  }
}
        </script>
        <script>
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
        </script>
    </head>

    <body class="theme-blue" onload="initialize()">
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
                                    <h2>ADD PRINT MEDIA INFORMATION</h2>
                                    <ul class="header-dropdown m-r--5">
                                        <li class="dropdown"> <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <i class="material-icons">more_vert</i> </a>
                                            <ul class="dropdown-menu pull-right">
                                                <!--                                                <li><a href="javascript:void(0);">Action</a></li>
                                                                                                <li><a href="javascript:void(0);">Another action</a></li>
                                                                                                <li><a href="javascript:void(0);">Something else here</a></li>-->
                                            </ul>
                                        </li>
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
                                                        <form class="form-horizontal m-t-30" action="<%=request.getContextPath()%>/addprintmedia.do"  id="uploadform" method="post" accept-charset="UTF-8" enctype="multipart/form-data">
                                                        <!--<input type="hidden"  id="textInput" name="getUpload" >-->
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
                                                                    <input type="radio" name="dfnondf" value="DF" id="df" onclick="errBlank('errDFNonDF')" class="filled-in chk-col-blue"  />
                                                                    <label for="df">DF</label>
                                                                    <input type="radio" name="dfnondf" value="Non DF" id="nondf" oninput="errBlank('errDFNonDF')" class="filled-in chk-col-blue"  />
                                                                    <label for="nondf">Non DF</label>
                                                                    <!--</div>-->

                                                                </div>
                                                                <span id="errDFNonDF" class="text-danger"></span>

                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="autocomplete" class="col-sm-3 control-label">Location</label>
                                                            <div class="col-sm-9">
                                                                <div id="locationField">

                                                                    <input id="autocomplete" placeholder="Location" oninput="errBlank('errAutocomplete')" class="form-control" name="location" onFocus="geolocate()" type="text"></input>
                                                                </div>
                                                                <span id="errAutocomplete" class="text-danger"></span>
                                                            </div>
                                                            <!--<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15094.063092311517!2d72.81608609999999!3d18.9528158!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3be7ce11624bd7f5%3A0x9e69b276b442c51a!2sSir%20H.%20N.%20Reliance%20Foundation%20Hospital%20and%20Research%20Centre!5e0!3m2!1sen!2sin!4v1581604572056!5m2!1sen!2sin" width="600" height="450" frameborder="0" style="border:0;" allowfullscreen=""></iframe>-->
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="date" class="col-sm-3 control-label">Date</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" >
                                                                    <input type="text" class="form-control" id="date" onblur="errBlank('errDate')" name="date" placeholder="Date" >
                                                                    <span id="errDate" class="text-danger"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="language" class="col-sm-3 control-label">Language</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <select  class="form-control " name="language" id="language" onchange="selectNewsPaper('lang');errBlank('errLanguage')" >
                                                                        <option value="-1">Select Language</option>
                                                                        <%
                                                                            Connection dh = null;
                                                                            PreparedStatement stmSelect = null;
                                                                            ResultSet rsSelect = null;
                                                                            String imag[];
                                                                            ConnectionDB connectionDB = new ConnectionDB();
                                                                            dh = connectionDB.getConnection();
                                                                            try {

                                                                                try {
                                                                                    String sqlSelect = "SELECT * FROM tbl_language_master ";
                                                                                    System.out.println("sqlSelect-" + sqlSelect);
                                                                                    stmSelect = dh.prepareStatement(sqlSelect);
                                                                                    rsSelect = stmSelect.executeQuery();
                                                                                    while (rsSelect.next()) {
                                                                        %>
                                                                        <option value="<%=rsSelect.getString(1)%>"><%=rsSelect.getString(2)%></option>
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
                                                                    <input id="language1" name="language1" type="hidden">
                                                                    <span id="errLanguage" class="text-danger"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="newspaper" class="col-sm-3 control-label">News Paper</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" id="idnewspaper">
                                                                    <select  class="form-control " name="newspaper" id="newspaper" onchange="selectNewsPaper('np');errBlank('errNp')" >
                                                                        <option value="-1">Select NewsPaper</option>
                                                                    </select>  
                                                                    <input id="newspaper1" name="newspaper1" type="hidden">

                                                                    <span class="text-danger" id="errNp"></span>
                                                                    <!--<input type="text" class="form-control" id="Program" name="Program" placeholder="Title / Name of Program" required>-->

                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="edition" class="col-sm-3 control-label">Edition</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <select  class="form-control " name="edition" id="edition" onchange="selectNewsPaper('edition');errBlank('errEdition')" >
                                                                        <option value="-1">Select Edition</option>
                                                                    </select>   
                                                                    <input id="edition1" name="edition1" type="hidden">

                                                                    <span class="text-danger" id="errEdition"></span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="subedition" class="col-sm-3 control-label">Sub Edition</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <select  class="form-control " name="subedition" id="subedition"  >
                                                                        <option value="-1">Select Sub Edition</option>
                                                                    </select>   
                                                                    <input id="subedition1" name="subedition1" type="hidden">

                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="title" class="col-sm-3 control-label">Title (English)</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <input type="text" class="form-control" id="title" name="title" placeholder="Title (English)" oninput="errBlank('errTitle')"  >
                                                                    <!--<textarea class="form-control" id="description" name="description" autocomplete="off" oninput="errorBlank('errDescription')" placeholder="Enter Description " rows="3" required></textarea>-->
                                                                    <span class="text-danger" id="errTitle"></span>
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
                                                                        <%PreparedStatement stmSentiment = null;
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
                                                            <label for="Additional" class="col-sm-3 control-label">Tags</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line" id="newTag">
                                                                    <!--<div class="col-lg-9 form-control"  style="display: none;" >-->
                                                                    <input type="text" id="tags" name="tags"  class="form-control" placeholder="Tags" autocomplete="off" oninput="errBlank('errTag')" />
                                                                    <!--<span id="errTag" class="text-danger"></span>-->
                                                                </div>

                                                                <div id="divAa" style="font-size: 14px;border:1px solid #c8cbce;display: none" class="text-white"></div>
                                                                <input type="hidden" class="txt" name="additional" id="additional" >
                                                                <!--<input type="text" class="form-control" id="Additional" name="Additional" placeholder="Additional Tags" required>-->
                                                                <!--</div>-->
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="Upload" class="col-sm-3 control-label">Upload Image file</label>
                                                            <div class="col-sm-9">
                                                                <div class="form-line">
                                                                    <!--<div class="col-lg-9 form-control"  style="display: none;" >-->
                                                                    <!--<input type="file" id="upload" name="upload" class="form-control" accept=".xls,.xlsx" onchange="errBlank('errFile')" placeholder="Upload Image" autocomplete="off" multiple />-->
                                                                    <input type="file" id="upload" name="upload" class="form-control" accept=".png,.PNG,.jpeg,.jpg" onchange="errBlank('errFile')" placeholder="Upload Image" autocomplete="off" multiple />
                                                                    <span class="text-danger" id="errFile"></span>
                                                                    <i class="small text-success" >Upload multiple image files</i>

                                                                    <!--<input id="fileselector" type="file" onchange="browseResult()" webkitdirectory directory  />-->
                                                                    <!--<button onclick="getElementById('fileselector').click()">browse</button>-->
                                                                </div>

                                                                <!--<input type="text" class="form-control" id="Additional" name="Additional" placeholder="Additional Tags" required>-->
                                                                <!--</div>-->
                                                            </div>
                                                        </div>
                                                        <%} catch (Exception e) {

                                                                e.printStackTrace();
                                                            } finally {
                                                                if (dh != null) {
                                                                    dh.close();
                                                                }
                                                            }
                                                        %>
                                                        <div class="form-group">
                                                            <div class="col-sm-12 text-right">
                                                                <button class="btn btn-danger" onclick="return saveSubmitBtnInfo();" id="btnSavePrint" >SAVE</button>
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
            <div class="modal bodyBackground " id="myModel1" tabindex="-1" role="dialog" style="display: none">
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

                            <p class="text-success semi-bold" style="font-size:18px">Generated Print Media Reference Number  is:-<%=workcode%> </p>

                            <!--<iframe width="560" height="315" src="https://www.youtube.com/embed/u3xKgwKUQLc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>-->
                        </div>
                        <div class="modal-footer">
                            <!--<a >TAG</a>-->
                            <a href="pr_add.jsp"> <button type="button" class="btn btn-link waves-effect"  data-dismiss="#myModel1" >CLOSE</button></a>
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
//                            $(function () {
//                                function split(val) {
//                                    return val.split(/,\s*/);
//                                }
//                                function extractLast(term) {
//                                    return split(term).pop();
//                                }
//                               
//                            });
                            $(function () {
                                function split(val) {
                                    return val.split(/,\\s+/);
                                }
                                function extractLast(term) {
                                    return split(term).pop();
                                }
                                function extractLastTemp(term) {
                                    return split(term).pop();
                                }
                                $("#title")
                                        .autocomplete({
                                            source: function (request, response) {
//                                                alert(document.getElementById("temp").textContent);
//                                                var text = node.textContent || node.innerText;

//                                                document.getElementById("idhiddentemp").value=document.getElementById("temp").textContent;
//                                                document.getElementById("temp").textContent=document.getElementById("idhiddentemp").value;
                                                $.getJSON("jsonfile_mediaroom.jsp?description=" + document.getElementById("title").value, {
                                                    term: extractLast(request.term)
                                                }, response);
                                            },
                                            search: function () {
                                                // custom minLength
                                                var term = extractLastTemp(this.value);
//          $('#temp').val(term);

                                                if (term.length < 2) {

                                                    return false;
                                                }
                                            },
                                        });
                                $("#titlemarathi")
                                        .autocomplete({
                                            source: function (request, response) {
//                                                alert(document.getElementById("temp").textContent);
//                                                var text = node.textContent || node.innerText;

//                                                document.getElementById("idhiddentemp").value=document.getElementById("temp").textContent;
//                                                document.getElementById("temp").textContent=document.getElementById("idhiddentemp").value;
                                                $.getJSON("jsonfile_mediaroom.jsp?description=" + document.getElementById("titlemarathi").value, {
                                                    term: extractLast(request.term)
                                                }, response);
                                            },
                                            search: function () {
                                                // custom minLength
                                                var term = extractLastTemp(this.value);
//          $('#temp').val(term);
//                                    alert(term);
                                                if (term.length < 2) {

                                                    return false;
                                                }
                                            },
                                        });

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
//                alert(document.getElementById("temp").textContent);
//                var dfnondf = $("input[name='dfnondf']").serializeArray();
//                if (dfnondf.length === 0)
//                {
//                    document.getElementById("errDFNonDF").innerHTML = "Please select checkbox";
//                    document.getElementById("df").focus();
//                    return false;
//                }
//                document.getElementById("btnSavePrint").disabled = true;

                var option = document.getElementsByName('dfnondf');

                if (!(option[0].checked || option[1].checked)) {
                    document.getElementById("errDFNonDF").innerHTML = "Please select Brand";
                    document.getElementById("df").focus();
                    return false;
                }
                if (document.getElementById("autocomplete").value == "") {

                    document.getElementById("errAutocomplete").innerHTML = "Please enter location";
                    document.getElementById("autocomplete").focus();
                    return false;
                }
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
                if (document.getElementById("newspaper").value == "-1") {

                    document.getElementById("errNp").innerHTML = "Please select Newspaper";
                    document.getElementById("newspaper").focus();
                    return false;
                }
                if (document.getElementById("edition").value == "-1") {

                    document.getElementById("errEdition").innerHTML = "Please select Newspaper";
                    document.getElementById("edition").focus();
                    return false;
                }
                if (document.getElementById("edition").value == "-1") {

                    document.getElementById("errEdition").innerHTML = "Please select Newspaper";
                    document.getElementById("edition").focus();
                    return false;
                }
                if (document.getElementById("title").value == "") {

                    document.getElementById("errTitle").innerHTML = "Please enter Title";
                    document.getElementById("title").focus();
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

//                if (document.getElementById("tags").value == "") {
//
//                    document.getElementById("errTag").innerHTML = "Please enter Tag";
//                    document.getElementById("tags").focus();
//                    return false;
//                }
                if (document.getElementById("upload").value == "") {

                    document.getElementById("errFile").innerHTML = "Please select file";
                    document.getElementById("upload").focus();
                    return false;
                }
                var sellanguage = document.getElementById("language");
                var textsellanguage = sellanguage.options[sellanguage.selectedIndex].text;
                document.getElementById("language1").value = textsellanguage;
                var selnewspaper = document.getElementById("newspaper");
                var textnewspaper = selnewspaper.options[selnewspaper.selectedIndex].text;
                document.getElementById("newspaper1").value = textnewspaper;

                var seledition = document.getElementById("edition");
                var textedition = seledition.options[seledition.selectedIndex].text;
                document.getElementById("edition1").value = textedition;
                if (document.getElementById("subedition").value != "-1") {
                    var selsubedition = document.getElementById("subedition");
                    var textsubedition = selsubedition.options[selsubedition.selectedIndex].text;
                    document.getElementById("subedition1").value = textsubedition;
                }
                var a = document.getElementById("divAa").innerHTML;

//                alert(textedition);
                document.getElementById("tags").value = a;
//                alert(a);
                document.getElementById("uploadform").submit();
            }
            function removeTag(tag, id) {
//                alert(tag);
                document.getElementById("additional").value = "";
                return false;
            }
            $(function () { // DOM ready

                // ::: TAGS BOX

//                $("#title").on({
//                    focusout: function () {
//
////                        var regex = /([\u0041-\u005A\u0061-\u007A\u00AA\u00B5\u00BA\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02C1\u02C6-\u02D1\u02E0-\u02E4\u02EC\u02EE\u0370-\u0374\u0376\u0377\u037A-\u037D\u0386\u0388-\u038A\u038C\u038E-\u03A1\u03A3-\u03F5\u03F7-\u0481\u048A-\u0527\u0531-\u0556\u0559\u0561-\u0587\u05D0-\u05EA\u05F0-\u05F2\u0620-\u064A\u066E\u066F\u0671-\u06D3\u06D5\u06E5\u06E6\u06EE\u06EF\u06FA-\u06FC\u06FF\u0710\u0712-\u072F\u074D-\u07A5\u07B1\u07CA-\u07EA\u07F4\u07F5\u07FA\u0800-\u0815\u081A\u0824\u0828\u0840-\u0858\u08A0\u08A2-\u08AC\u0904-\u0939\u093D\u0950\u0958-\u0961\u0971-\u0977\u0979-\u097F\u0985-\u098C\u098F\u0990\u0993-\u09A8\u09AA-\u09B0\u09B2\u09B6-\u09B9\u09BD\u09CE\u09DC\u09DD\u09DF-\u09E1\u09F0\u09F1\u0A05-\u0A0A\u0A0F\u0A10\u0A13-\u0A28\u0A2A-\u0A30\u0A32\u0A33\u0A35\u0A36\u0A38\u0A39\u0A59-\u0A5C\u0A5E\u0A72-\u0A74\u0A85-\u0A8D\u0A8F-\u0A91\u0A93-\u0AA8\u0AAA-\u0AB0\u0AB2\u0AB3\u0AB5-\u0AB9\u0ABD\u0AD0\u0AE0\u0AE1\u0B05-\u0B0C\u0B0F\u0B10\u0B13-\u0B28\u0B2A-\u0B30\u0B32\u0B33\u0B35-\u0B39\u0B3D\u0B5C\u0B5D\u0B5F-\u0B61\u0B71\u0B83\u0B85-\u0B8A\u0B8E-\u0B90\u0B92-\u0B95\u0B99\u0B9A\u0B9C\u0B9E\u0B9F\u0BA3\u0BA4\u0BA8-\u0BAA\u0BAE-\u0BB9\u0BD0\u0C05-\u0C0C\u0C0E-\u0C10\u0C12-\u0C28\u0C2A-\u0C33\u0C35-\u0C39\u0C3D\u0C58\u0C59\u0C60\u0C61\u0C85-\u0C8C\u0C8E-\u0C90\u0C92-\u0CA8\u0CAA-\u0CB3\u0CB5-\u0CB9\u0CBD\u0CDE\u0CE0\u0CE1\u0CF1\u0CF2\u0D05-\u0D0C\u0D0E-\u0D10\u0D12-\u0D3A\u0D3D\u0D4E\u0D60\u0D61\u0D7A-\u0D7F\u0D85-\u0D96\u0D9A-\u0DB1\u0DB3-\u0DBB\u0DBD\u0DC0-\u0DC6\u0E01-\u0E30\u0E32\u0E33\u0E40-\u0E46\u0E81\u0E82\u0E84\u0E87\u0E88\u0E8A\u0E8D\u0E94-\u0E97\u0E99-\u0E9F\u0EA1-\u0EA3\u0EA5\u0EA7\u0EAA\u0EAB\u0EAD-\u0EB0\u0EB2\u0EB3\u0EBD\u0EC0-\u0EC4\u0EC6\u0EDC-\u0EDF\u0F00\u0F40-\u0F47\u0F49-\u0F6C\u0F88-\u0F8C\u1000-\u102A\u103F\u1050-\u1055\u105A-\u105D\u1061\u1065\u1066\u106E-\u1070\u1075-\u1081\u108E\u10A0-\u10C5\u10C7\u10CD\u10D0-\u10FA\u10FC-\u1248\u124A-\u124D\u1250-\u1256\u1258\u125A-\u125D\u1260-\u1288\u128A-\u128D\u1290-\u12B0\u12B2-\u12B5\u12B8-\u12BE\u12C0\u12C2-\u12C5\u12C8-\u12D6\u12D8-\u1310\u1312-\u1315\u1318-\u135A\u1380-\u138F\u13A0-\u13F4\u1401-\u166C\u166F-\u167F\u1681-\u169A\u16A0-\u16EA\u1700-\u170C\u170E-\u1711\u1720-\u1731\u1740-\u1751\u1760-\u176C\u176E-\u1770\u1780-\u17B3\u17D7\u17DC\u1820-\u1877\u1880-\u18A8\u18AA\u18B0-\u18F5\u1900-\u191C\u1950-\u196D\u1970-\u1974\u1980-\u19AB\u19C1-\u19C7\u1A00-\u1A16\u1A20-\u1A54\u1AA7\u1B05-\u1B33\u1B45-\u1B4B\u1B83-\u1BA0\u1BAE\u1BAF\u1BBA-\u1BE5\u1C00-\u1C23\u1C4D-\u1C4F\u1C5A-\u1C7D\u1CE9-\u1CEC\u1CEE-\u1CF1\u1CF5\u1CF6\u1D00-\u1DBF\u1E00-\u1F15\u1F18-\u1F1D\u1F20-\u1F45\u1F48-\u1F4D\u1F50-\u1F57\u1F59\u1F5B\u1F5D\u1F5F-\u1F7D\u1F80-\u1FB4\u1FB6-\u1FBC\u1FBE\u1FC2-\u1FC4\u1FC6-\u1FCC\u1FD0-\u1FD3\u1FD6-\u1FDB\u1FE0-\u1FEC\u1FF2-\u1FF4\u1FF6-\u1FFC\u2071\u207F\u2090-\u209C\u2102\u2107\u210A-\u2113\u2115\u2119-\u211D\u2124\u2126\u2128\u212A-\u212D\u212F-\u2139\u213C-\u213F\u2145-\u2149\u214E\u2183\u2184\u2C00-\u2C2E\u2C30-\u2C5E\u2C60-\u2CE4\u2CEB-\u2CEE\u2CF2\u2CF3\u2D00-\u2D25\u2D27\u2D2D\u2D30-\u2D67\u2D6F\u2D80-\u2D96\u2DA0-\u2DA6\u2DA8-\u2DAE\u2DB0-\u2DB6\u2DB8-\u2DBE\u2DC0-\u2DC6\u2DC8-\u2DCE\u2DD0-\u2DD6\u2DD8-\u2DDE\u2E2F\u3005\u3006\u3031-\u3035\u303B\u303C\u3041-\u3096\u309D-\u309F\u30A1-\u30FA\u30FC-\u30FF\u3105-\u312D\u3131-\u318E\u31A0-\u31BA\u31F0-\u31FF\u3400-\u4DB5\u4E00-\u9FCC\uA000-\uA48C\uA4D0-\uA4FD\uA500-\uA60C\uA610-\uA61F\uA62A\uA62B\uA640-\uA66E\uA67F-\uA697\uA6A0-\uA6E5\uA717-\uA71F\uA722-\uA788\uA78B-\uA78E\uA790-\uA793\uA7A0-\uA7AA\uA7F8-\uA801\uA803-\uA805\uA807-\uA80A\uA80C-\uA822\uA840-\uA873\uA882-\uA8B3\uA8F2-\uA8F7\uA8FB\uA90A-\uA925\uA930-\uA946\uA960-\uA97C\uA984-\uA9B2\uA9CF\uAA00-\uAA28\uAA40-\uAA42\uAA44-\uAA4B\uAA60-\uAA76\uAA7A\uAA80-\uAAAF\uAAB1\uAAB5\uAAB6\uAAB9-\uAABD\uAAC0\uAAC2\uAADB-\uAADD\uAAE0-\uAAEA\uAAF2-\uAAF4\uAB01-\uAB06\uAB09-\uAB0E\uAB11-\uAB16\uAB20-\uAB26\uAB28-\uAB2E\uABC0-\uABE2\uAC00-\uD7A3\uD7B0-\uD7C6\uD7CB-\uD7FB\uF900-\uFA6D\uFA70-\uFAD9\uFB00-\uFB06\uFB13-\uFB17\uFB1D\uFB1F-\uFB28\uFB2A-\uFB36\uFB38-\uFB3C\uFB3E\uFB40\uFB41\uFB43\uFB44\uFB46-\uFBB1\uFBD3-\uFD3D\uFD50-\uFD8F\uFD92-\uFDC7\uFDF0-\uFDFB\uFE70-\uFE74\uFE76-\uFEFC\uFF21-\uFF3A\uFF41-\uFF5A\uFF66-\uFFBE\uFFC2-\uFFC7\uFFCA-\uFFCF\uFFD2-\uFFD7\uFFDA-\uFFDC]+)/g;
//
////                        var txt = this.value.replace(/[^a-z0-9_\+\-\.\#\u0041-\u005A\u0061-\u007A\u00AA\u00B5\u00BA\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02C1\u02C6-\u02D1\u02E0-\u02E4\u02EC\u02EE\u0370-\u0374\u0376\u0377\u037A-\u037D\u0386\u0388-\u038A\u038C\u038E-\u03A1\u03A3-\u03F5\u03F7-\u0481\u048A-\u0527\u0531-\u0556\u0559\u0561-\u0587\u05D0-\u05EA\u05F0-\u05F2\u0620-\u064A\u066E\u066F\u0671-\u06D3\u06D5\u06E5\u06E6\u06EE\u06EF\u06FA-\u06FC\u06FF\u0710\u0712-\u072F\u074D-\u07A5\u07B1\u07CA-\u07EA\u07F4\u07F5\u07FA\u0800-\u0815\u081A\u0824\u0828\u0840-\u0858\u08A0\u08A2-\u08AC\u0904-\u0939\u093D\u0950\u0958-\u0961\u0971-\u0977\u0979-\u097F\u0985-\u098C\u098F\u0990\u0993-\u09A8\u09AA-\u09B0\u09B2\u09B6-\u09B9\u09BD\u09CE\u09DC\u09DD\u09DF-\u09E1\u09F0\u09F1\u0A05-\u0A0A\u0A0F\u0A10\u0A13-\u0A28\u0A2A-\u0A30\u0A32\u0A33\u0A35\u0A36\u0A38\u0A39\u0A59-\u0A5C\u0A5E\u0A72-\u0A74\u0A85-\u0A8D\u0A8F-\u0A91\u0A93-\u0AA8\u0AAA-\u0AB0\u0AB2\u0AB3\u0AB5-\u0AB9\u0ABD\u0AD0\u0AE0\u0AE1\u0B05-\u0B0C\u0B0F\u0B10\u0B13-\u0B28\u0B2A-\u0B30\u0B32\u0B33\u0B35-\u0B39\u0B3D\u0B5C\u0B5D\u0B5F-\u0B61\u0B71\u0B83\u0B85-\u0B8A\u0B8E-\u0B90\u0B92-\u0B95\u0B99\u0B9A\u0B9C\u0B9E\u0B9F\u0BA3\u0BA4\u0BA8-\u0BAA\u0BAE-\u0BB9\u0BD0\u0C05-\u0C0C\u0C0E-\u0C10\u0C12-\u0C28\u0C2A-\u0C33\u0C35-\u0C39\u0C3D\u0C58\u0C59\u0C60\u0C61\u0C85-\u0C8C\u0C8E-\u0C90\u0C92-\u0CA8\u0CAA-\u0CB3\u0CB5-\u0CB9\u0CBD\u0CDE\u0CE0\u0CE1\u0CF1\u0CF2\u0D05-\u0D0C\u0D0E-\u0D10\u0D12-\u0D3A\u0D3D\u0D4E\u0D60\u0D61\u0D7A-\u0D7F\u0D85-\u0D96\u0D9A-\u0DB1\u0DB3-\u0DBB\u0DBD\u0DC0-\u0DC6\u0E01-\u0E30\u0E32\u0E33\u0E40-\u0E46\u0E81\u0E82\u0E84\u0E87\u0E88\u0E8A\u0E8D\u0E94-\u0E97\u0E99-\u0E9F\u0EA1-\u0EA3\u0EA5\u0EA7\u0EAA\u0EAB\u0EAD-\u0EB0\u0EB2\u0EB3\u0EBD\u0EC0-\u0EC4\u0EC6\u0EDC-\u0EDF\u0F00\u0F40-\u0F47\u0F49-\u0F6C\u0F88-\u0F8C\u1000-\u102A\u103F\u1050-\u1055\u105A-\u105D\u1061\u1065\u1066\u106E-\u1070\u1075-\u1081\u108E\u10A0-\u10C5\u10C7\u10CD\u10D0-\u10FA\u10FC-\u1248\u124A-\u124D\u1250-\u1256\u1258\u125A-\u125D\u1260-\u1288\u128A-\u128D\u1290-\u12B0\u12B2-\u12B5\u12B8-\u12BE\u12C0\u12C2-\u12C5\u12C8-\u12D6\u12D8-\u1310\u1312-\u1315\u1318-\u135A\u1380-\u138F\u13A0-\u13F4\u1401-\u166C\u166F-\u167F\u1681-\u169A\u16A0-\u16EA\u1700-\u170C\u170E-\u1711\u1720-\u1731\u1740-\u1751\u1760-\u176C\u176E-\u1770\u1780-\u17B3\u17D7\u17DC\u1820-\u1877\u1880-\u18A8\u18AA\u18B0-\u18F5\u1900-\u191C\u1950-\u196D\u1970-\u1974\u1980-\u19AB\u19C1-\u19C7\u1A00-\u1A16\u1A20-\u1A54\u1AA7\u1B05-\u1B33\u1B45-\u1B4B\u1B83-\u1BA0\u1BAE\u1BAF\u1BBA-\u1BE5\u1C00-\u1C23\u1C4D-\u1C4F\u1C5A-\u1C7D\u1CE9-\u1CEC\u1CEE-\u1CF1\u1CF5\u1CF6\u1D00-\u1DBF\u1E00-\u1F15\u1F18-\u1F1D\u1F20-\u1F45\u1F48-\u1F4D\u1F50-\u1F57\u1F59\u1F5B\u1F5D\u1F5F-\u1F7D\u1F80-\u1FB4\u1FB6-\u1FBC\u1FBE\u1FC2-\u1FC4\u1FC6-\u1FCC\u1FD0-\u1FD3\u1FD6-\u1FDB\u1FE0-\u1FEC\u1FF2-\u1FF4\u1FF6-\u1FFC\u2071\u207F\u2090-\u209C\u2102\u2107\u210A-\u2113\u2115\u2119-\u211D\u2124\u2126\u2128\u212A-\u212D\u212F-\u2139\u213C-\u213F\u2145-\u2149\u214E\u2183\u2184\u2C00-\u2C2E\u2C30-\u2C5E\u2C60-\u2CE4\u2CEB-\u2CEE\u2CF2\u2CF3\u2D00-\u2D25\u2D27\u2D2D\u2D30-\u2D67\u2D6F\u2D80-\u2D96\u2DA0-\u2DA6\u2DA8-\u2DAE\u2DB0-\u2DB6\u2DB8-\u2DBE\u2DC0-\u2DC6\u2DC8-\u2DCE\u2DD0-\u2DD6\u2DD8-\u2DDE\u2E2F\u3005\u3006\u3031-\u3035\u303B\u303C\u3041-\u3096\u309D-\u309F\u30A1-\u30FA\u30FC-\u30FF\u3105-\u312D\u3131-\u318E\u31A0-\u31BA\u31F0-\u31FF\u3400-\u4DB5\u4E00-\u9FCC\uA000-\uA48C\uA4D0-\uA4FD\uA500-\uA60C\uA610-\uA61F\uA62A\uA62B\uA640-\uA66E\uA67F-\uA697\uA6A0-\uA6E5\uA717-\uA71F\uA722-\uA788\uA78B-\uA78E\uA790-\uA793\uA7A0-\uA7AA\uA7F8-\uA801\uA803-\uA805\uA807-\uA80A\uA80C-\uA822\uA840-\uA873\uA882-\uA8B3\uA8F2-\uA8F7\uA8FB\uA90A-\uA925\uA930-\uA946\uA960-\uA97C\uA984-\uA9B2\uA9CF\uAA00-\uAA28\uAA40-\uAA42\uAA44-\uAA4B\uAA60-\uAA76\uAA7A\uAA80-\uAAAF\uAAB1\uAAB5\uAAB6\uAAB9-\uAABD\uAAC0\uAAC2\uAADB-\uAADD\uAAE0-\uAAEA\uAAF2-\uAAF4\uAB01-\uAB06\uAB09-\uAB0E\uAB11-\uAB16\uAB20-\uAB26\uAB28-\uAB2E\uABC0-\uABE2\uAC00-\uD7A3\uD7B0-\uD7C6\uD7CB-\uD7FB\uF900-\uFA6D\uFA70-\uFAD9\uFB00-\uFB06\uFB13-\uFB17\uFB1D\uFB1F-\uFB28\uFB2A-\uFB36\uFB38-\uFB3C\uFB3E\uFB40\uFB41\uFB43\uFB44\uFB46-\uFBB1\uFBD3-\uFD3D\uFD50-\uFD8F\uFD92-\uFDC7\uFDF0-\uFDFB\uFE70-\uFE74\uFE76-\uFEFC\uFF21-\uFF3A\uFF41-\uFF5A\uFF66-\uFFBE\uFFC2-\uFFC7\uFFCA-\uFFCF\uFFD2-\uFFD7\uFFDA-\uFFDC]/ig, ''); // allowed characters
////                        var txt = this.value.replace(/[^a-z0-9_\+\-\.\#]/ig, ''); // allowed characters
//                        var txt = this.value.replace(/[^a-z0-9_\+\-\.\#\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]/ig, ''); // allowed characters
//                        if (txt)
////                                                $("<input type='text' name='stag'">), {text: txt.toLowerCase(), insertBefore: this});
////                            $("<span />", {text: txt, insertBefore: this});
//                            $("#temp").append(" " + this.value);
//                        //                                $('#sourcetag').appendVal(value);
////                        document.getElementById("add").value = this.value;
//                        this.value = "";
//                    },
//                    keyup: function (ev) {
//                        // if: comma|enter (delimit more keyCodes with | pipe)
//                        if (/(188|13|32)/.test(ev.which))
//                            $(this).focusout();
//                        return false;
//                    }
//                });
            });
            $(function () { // DOM ready

                // ::: TAGS BOX

                $("#newTag input").on({
                    focusout: function () {

//                        var regex = /([\u0041-\u005A\u0061-\u007A\u00AA\u00B5\u00BA\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02C1\u02C6-\u02D1\u02E0-\u02E4\u02EC\u02EE\u0370-\u0374\u0376\u0377\u037A-\u037D\u0386\u0388-\u038A\u038C\u038E-\u03A1\u03A3-\u03F5\u03F7-\u0481\u048A-\u0527\u0531-\u0556\u0559\u0561-\u0587\u05D0-\u05EA\u05F0-\u05F2\u0620-\u064A\u066E\u066F\u0671-\u06D3\u06D5\u06E5\u06E6\u06EE\u06EF\u06FA-\u06FC\u06FF\u0710\u0712-\u072F\u074D-\u07A5\u07B1\u07CA-\u07EA\u07F4\u07F5\u07FA\u0800-\u0815\u081A\u0824\u0828\u0840-\u0858\u08A0\u08A2-\u08AC\u0904-\u0939\u093D\u0950\u0958-\u0961\u0971-\u0977\u0979-\u097F\u0985-\u098C\u098F\u0990\u0993-\u09A8\u09AA-\u09B0\u09B2\u09B6-\u09B9\u09BD\u09CE\u09DC\u09DD\u09DF-\u09E1\u09F0\u09F1\u0A05-\u0A0A\u0A0F\u0A10\u0A13-\u0A28\u0A2A-\u0A30\u0A32\u0A33\u0A35\u0A36\u0A38\u0A39\u0A59-\u0A5C\u0A5E\u0A72-\u0A74\u0A85-\u0A8D\u0A8F-\u0A91\u0A93-\u0AA8\u0AAA-\u0AB0\u0AB2\u0AB3\u0AB5-\u0AB9\u0ABD\u0AD0\u0AE0\u0AE1\u0B05-\u0B0C\u0B0F\u0B10\u0B13-\u0B28\u0B2A-\u0B30\u0B32\u0B33\u0B35-\u0B39\u0B3D\u0B5C\u0B5D\u0B5F-\u0B61\u0B71\u0B83\u0B85-\u0B8A\u0B8E-\u0B90\u0B92-\u0B95\u0B99\u0B9A\u0B9C\u0B9E\u0B9F\u0BA3\u0BA4\u0BA8-\u0BAA\u0BAE-\u0BB9\u0BD0\u0C05-\u0C0C\u0C0E-\u0C10\u0C12-\u0C28\u0C2A-\u0C33\u0C35-\u0C39\u0C3D\u0C58\u0C59\u0C60\u0C61\u0C85-\u0C8C\u0C8E-\u0C90\u0C92-\u0CA8\u0CAA-\u0CB3\u0CB5-\u0CB9\u0CBD\u0CDE\u0CE0\u0CE1\u0CF1\u0CF2\u0D05-\u0D0C\u0D0E-\u0D10\u0D12-\u0D3A\u0D3D\u0D4E\u0D60\u0D61\u0D7A-\u0D7F\u0D85-\u0D96\u0D9A-\u0DB1\u0DB3-\u0DBB\u0DBD\u0DC0-\u0DC6\u0E01-\u0E30\u0E32\u0E33\u0E40-\u0E46\u0E81\u0E82\u0E84\u0E87\u0E88\u0E8A\u0E8D\u0E94-\u0E97\u0E99-\u0E9F\u0EA1-\u0EA3\u0EA5\u0EA7\u0EAA\u0EAB\u0EAD-\u0EB0\u0EB2\u0EB3\u0EBD\u0EC0-\u0EC4\u0EC6\u0EDC-\u0EDF\u0F00\u0F40-\u0F47\u0F49-\u0F6C\u0F88-\u0F8C\u1000-\u102A\u103F\u1050-\u1055\u105A-\u105D\u1061\u1065\u1066\u106E-\u1070\u1075-\u1081\u108E\u10A0-\u10C5\u10C7\u10CD\u10D0-\u10FA\u10FC-\u1248\u124A-\u124D\u1250-\u1256\u1258\u125A-\u125D\u1260-\u1288\u128A-\u128D\u1290-\u12B0\u12B2-\u12B5\u12B8-\u12BE\u12C0\u12C2-\u12C5\u12C8-\u12D6\u12D8-\u1310\u1312-\u1315\u1318-\u135A\u1380-\u138F\u13A0-\u13F4\u1401-\u166C\u166F-\u167F\u1681-\u169A\u16A0-\u16EA\u1700-\u170C\u170E-\u1711\u1720-\u1731\u1740-\u1751\u1760-\u176C\u176E-\u1770\u1780-\u17B3\u17D7\u17DC\u1820-\u1877\u1880-\u18A8\u18AA\u18B0-\u18F5\u1900-\u191C\u1950-\u196D\u1970-\u1974\u1980-\u19AB\u19C1-\u19C7\u1A00-\u1A16\u1A20-\u1A54\u1AA7\u1B05-\u1B33\u1B45-\u1B4B\u1B83-\u1BA0\u1BAE\u1BAF\u1BBA-\u1BE5\u1C00-\u1C23\u1C4D-\u1C4F\u1C5A-\u1C7D\u1CE9-\u1CEC\u1CEE-\u1CF1\u1CF5\u1CF6\u1D00-\u1DBF\u1E00-\u1F15\u1F18-\u1F1D\u1F20-\u1F45\u1F48-\u1F4D\u1F50-\u1F57\u1F59\u1F5B\u1F5D\u1F5F-\u1F7D\u1F80-\u1FB4\u1FB6-\u1FBC\u1FBE\u1FC2-\u1FC4\u1FC6-\u1FCC\u1FD0-\u1FD3\u1FD6-\u1FDB\u1FE0-\u1FEC\u1FF2-\u1FF4\u1FF6-\u1FFC\u2071\u207F\u2090-\u209C\u2102\u2107\u210A-\u2113\u2115\u2119-\u211D\u2124\u2126\u2128\u212A-\u212D\u212F-\u2139\u213C-\u213F\u2145-\u2149\u214E\u2183\u2184\u2C00-\u2C2E\u2C30-\u2C5E\u2C60-\u2CE4\u2CEB-\u2CEE\u2CF2\u2CF3\u2D00-\u2D25\u2D27\u2D2D\u2D30-\u2D67\u2D6F\u2D80-\u2D96\u2DA0-\u2DA6\u2DA8-\u2DAE\u2DB0-\u2DB6\u2DB8-\u2DBE\u2DC0-\u2DC6\u2DC8-\u2DCE\u2DD0-\u2DD6\u2DD8-\u2DDE\u2E2F\u3005\u3006\u3031-\u3035\u303B\u303C\u3041-\u3096\u309D-\u309F\u30A1-\u30FA\u30FC-\u30FF\u3105-\u312D\u3131-\u318E\u31A0-\u31BA\u31F0-\u31FF\u3400-\u4DB5\u4E00-\u9FCC\uA000-\uA48C\uA4D0-\uA4FD\uA500-\uA60C\uA610-\uA61F\uA62A\uA62B\uA640-\uA66E\uA67F-\uA697\uA6A0-\uA6E5\uA717-\uA71F\uA722-\uA788\uA78B-\uA78E\uA790-\uA793\uA7A0-\uA7AA\uA7F8-\uA801\uA803-\uA805\uA807-\uA80A\uA80C-\uA822\uA840-\uA873\uA882-\uA8B3\uA8F2-\uA8F7\uA8FB\uA90A-\uA925\uA930-\uA946\uA960-\uA97C\uA984-\uA9B2\uA9CF\uAA00-\uAA28\uAA40-\uAA42\uAA44-\uAA4B\uAA60-\uAA76\uAA7A\uAA80-\uAAAF\uAAB1\uAAB5\uAAB6\uAAB9-\uAABD\uAAC0\uAAC2\uAADB-\uAADD\uAAE0-\uAAEA\uAAF2-\uAAF4\uAB01-\uAB06\uAB09-\uAB0E\uAB11-\uAB16\uAB20-\uAB26\uAB28-\uAB2E\uABC0-\uABE2\uAC00-\uD7A3\uD7B0-\uD7C6\uD7CB-\uD7FB\uF900-\uFA6D\uFA70-\uFAD9\uFB00-\uFB06\uFB13-\uFB17\uFB1D\uFB1F-\uFB28\uFB2A-\uFB36\uFB38-\uFB3C\uFB3E\uFB40\uFB41\uFB43\uFB44\uFB46-\uFBB1\uFBD3-\uFD3D\uFD50-\uFD8F\uFD92-\uFDC7\uFDF0-\uFDFB\uFE70-\uFE74\uFE76-\uFEFC\uFF21-\uFF3A\uFF41-\uFF5A\uFF66-\uFFBE\uFFC2-\uFFC7\uFFCA-\uFFCF\uFFD2-\uFFD7\uFFDA-\uFFDC]+)/g;

//                        var txt = this.value.replace(/[^a-z0-9_\+\-\.\#\u0041-\u005A\u0061-\u007A\u00AA\u00B5\u00BA\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02C1\u02C6-\u02D1\u02E0-\u02E4\u02EC\u02EE\u0370-\u0374\u0376\u0377\u037A-\u037D\u0386\u0388-\u038A\u038C\u038E-\u03A1\u03A3-\u03F5\u03F7-\u0481\u048A-\u0527\u0531-\u0556\u0559\u0561-\u0587\u05D0-\u05EA\u05F0-\u05F2\u0620-\u064A\u066E\u066F\u0671-\u06D3\u06D5\u06E5\u06E6\u06EE\u06EF\u06FA-\u06FC\u06FF\u0710\u0712-\u072F\u074D-\u07A5\u07B1\u07CA-\u07EA\u07F4\u07F5\u07FA\u0800-\u0815\u081A\u0824\u0828\u0840-\u0858\u08A0\u08A2-\u08AC\u0904-\u0939\u093D\u0950\u0958-\u0961\u0971-\u0977\u0979-\u097F\u0985-\u098C\u098F\u0990\u0993-\u09A8\u09AA-\u09B0\u09B2\u09B6-\u09B9\u09BD\u09CE\u09DC\u09DD\u09DF-\u09E1\u09F0\u09F1\u0A05-\u0A0A\u0A0F\u0A10\u0A13-\u0A28\u0A2A-\u0A30\u0A32\u0A33\u0A35\u0A36\u0A38\u0A39\u0A59-\u0A5C\u0A5E\u0A72-\u0A74\u0A85-\u0A8D\u0A8F-\u0A91\u0A93-\u0AA8\u0AAA-\u0AB0\u0AB2\u0AB3\u0AB5-\u0AB9\u0ABD\u0AD0\u0AE0\u0AE1\u0B05-\u0B0C\u0B0F\u0B10\u0B13-\u0B28\u0B2A-\u0B30\u0B32\u0B33\u0B35-\u0B39\u0B3D\u0B5C\u0B5D\u0B5F-\u0B61\u0B71\u0B83\u0B85-\u0B8A\u0B8E-\u0B90\u0B92-\u0B95\u0B99\u0B9A\u0B9C\u0B9E\u0B9F\u0BA3\u0BA4\u0BA8-\u0BAA\u0BAE-\u0BB9\u0BD0\u0C05-\u0C0C\u0C0E-\u0C10\u0C12-\u0C28\u0C2A-\u0C33\u0C35-\u0C39\u0C3D\u0C58\u0C59\u0C60\u0C61\u0C85-\u0C8C\u0C8E-\u0C90\u0C92-\u0CA8\u0CAA-\u0CB3\u0CB5-\u0CB9\u0CBD\u0CDE\u0CE0\u0CE1\u0CF1\u0CF2\u0D05-\u0D0C\u0D0E-\u0D10\u0D12-\u0D3A\u0D3D\u0D4E\u0D60\u0D61\u0D7A-\u0D7F\u0D85-\u0D96\u0D9A-\u0DB1\u0DB3-\u0DBB\u0DBD\u0DC0-\u0DC6\u0E01-\u0E30\u0E32\u0E33\u0E40-\u0E46\u0E81\u0E82\u0E84\u0E87\u0E88\u0E8A\u0E8D\u0E94-\u0E97\u0E99-\u0E9F\u0EA1-\u0EA3\u0EA5\u0EA7\u0EAA\u0EAB\u0EAD-\u0EB0\u0EB2\u0EB3\u0EBD\u0EC0-\u0EC4\u0EC6\u0EDC-\u0EDF\u0F00\u0F40-\u0F47\u0F49-\u0F6C\u0F88-\u0F8C\u1000-\u102A\u103F\u1050-\u1055\u105A-\u105D\u1061\u1065\u1066\u106E-\u1070\u1075-\u1081\u108E\u10A0-\u10C5\u10C7\u10CD\u10D0-\u10FA\u10FC-\u1248\u124A-\u124D\u1250-\u1256\u1258\u125A-\u125D\u1260-\u1288\u128A-\u128D\u1290-\u12B0\u12B2-\u12B5\u12B8-\u12BE\u12C0\u12C2-\u12C5\u12C8-\u12D6\u12D8-\u1310\u1312-\u1315\u1318-\u135A\u1380-\u138F\u13A0-\u13F4\u1401-\u166C\u166F-\u167F\u1681-\u169A\u16A0-\u16EA\u1700-\u170C\u170E-\u1711\u1720-\u1731\u1740-\u1751\u1760-\u176C\u176E-\u1770\u1780-\u17B3\u17D7\u17DC\u1820-\u1877\u1880-\u18A8\u18AA\u18B0-\u18F5\u1900-\u191C\u1950-\u196D\u1970-\u1974\u1980-\u19AB\u19C1-\u19C7\u1A00-\u1A16\u1A20-\u1A54\u1AA7\u1B05-\u1B33\u1B45-\u1B4B\u1B83-\u1BA0\u1BAE\u1BAF\u1BBA-\u1BE5\u1C00-\u1C23\u1C4D-\u1C4F\u1C5A-\u1C7D\u1CE9-\u1CEC\u1CEE-\u1CF1\u1CF5\u1CF6\u1D00-\u1DBF\u1E00-\u1F15\u1F18-\u1F1D\u1F20-\u1F45\u1F48-\u1F4D\u1F50-\u1F57\u1F59\u1F5B\u1F5D\u1F5F-\u1F7D\u1F80-\u1FB4\u1FB6-\u1FBC\u1FBE\u1FC2-\u1FC4\u1FC6-\u1FCC\u1FD0-\u1FD3\u1FD6-\u1FDB\u1FE0-\u1FEC\u1FF2-\u1FF4\u1FF6-\u1FFC\u2071\u207F\u2090-\u209C\u2102\u2107\u210A-\u2113\u2115\u2119-\u211D\u2124\u2126\u2128\u212A-\u212D\u212F-\u2139\u213C-\u213F\u2145-\u2149\u214E\u2183\u2184\u2C00-\u2C2E\u2C30-\u2C5E\u2C60-\u2CE4\u2CEB-\u2CEE\u2CF2\u2CF3\u2D00-\u2D25\u2D27\u2D2D\u2D30-\u2D67\u2D6F\u2D80-\u2D96\u2DA0-\u2DA6\u2DA8-\u2DAE\u2DB0-\u2DB6\u2DB8-\u2DBE\u2DC0-\u2DC6\u2DC8-\u2DCE\u2DD0-\u2DD6\u2DD8-\u2DDE\u2E2F\u3005\u3006\u3031-\u3035\u303B\u303C\u3041-\u3096\u309D-\u309F\u30A1-\u30FA\u30FC-\u30FF\u3105-\u312D\u3131-\u318E\u31A0-\u31BA\u31F0-\u31FF\u3400-\u4DB5\u4E00-\u9FCC\uA000-\uA48C\uA4D0-\uA4FD\uA500-\uA60C\uA610-\uA61F\uA62A\uA62B\uA640-\uA66E\uA67F-\uA697\uA6A0-\uA6E5\uA717-\uA71F\uA722-\uA788\uA78B-\uA78E\uA790-\uA793\uA7A0-\uA7AA\uA7F8-\uA801\uA803-\uA805\uA807-\uA80A\uA80C-\uA822\uA840-\uA873\uA882-\uA8B3\uA8F2-\uA8F7\uA8FB\uA90A-\uA925\uA930-\uA946\uA960-\uA97C\uA984-\uA9B2\uA9CF\uAA00-\uAA28\uAA40-\uAA42\uAA44-\uAA4B\uAA60-\uAA76\uAA7A\uAA80-\uAAAF\uAAB1\uAAB5\uAAB6\uAAB9-\uAABD\uAAC0\uAAC2\uAADB-\uAADD\uAAE0-\uAAEA\uAAF2-\uAAF4\uAB01-\uAB06\uAB09-\uAB0E\uAB11-\uAB16\uAB20-\uAB26\uAB28-\uAB2E\uABC0-\uABE2\uAC00-\uD7A3\uD7B0-\uD7C6\uD7CB-\uD7FB\uF900-\uFA6D\uFA70-\uFAD9\uFB00-\uFB06\uFB13-\uFB17\uFB1D\uFB1F-\uFB28\uFB2A-\uFB36\uFB38-\uFB3C\uFB3E\uFB40\uFB41\uFB43\uFB44\uFB46-\uFBB1\uFBD3-\uFD3D\uFD50-\uFD8F\uFD92-\uFDC7\uFDF0-\uFDFB\uFE70-\uFE74\uFE76-\uFEFC\uFF21-\uFF3A\uFF41-\uFF5A\uFF66-\uFFBE\uFFC2-\uFFC7\uFFCA-\uFFCF\uFFD2-\uFFD7\uFFDA-\uFFDC]/ig, ''); // allowed characters
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

