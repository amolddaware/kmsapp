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
        <!-- Favicon-->
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


        <script>
//            $(document).ready(function () {
//                if (window.location.href.indexOf("success") > -1) {
//
//                    var modal = document.getElementById('myModal').style.display = "block";
////                    var mytext = getUrlVars()["workcode"];
////                                        alert(mytext);
//                    //                    document.getElementById("mobile").value = mytext;
//                    document.getElementById("editSuccess").innerHTML = "Record  updated successfully";
//                    //                    window.location.href = "thanks.html";
//                    var span = document.getElementsByClassName("close")[0];
//                    span.onclick = function () {
//                        modal.style.display = "none";
//                    }
//                    window.onclick = function (event) {
//                        if (event.target == modal) {
//                            modal.style.display = "none";
//                        }
//                    }
//                }
//            });

//            $(function () {
//                function split(val) {
//                    return val.split(/,\s*/);
//                }
//                function extractLast(term) {
//                    return split(term).pop();
//                }
//
//                $("#generalTag input")
//                        .autocomplete({
//                            source: function (request, response) {
//                                $.getJSON("jsonfile_1.jsp?description=" + document.getElementById("generaltag").value, {
//                                    term: extractLast(request.term)
//                                }, response);
//                            },
//                            search: function () {
//                                // custom minLength
//                                var term = extractLast(this.value);
//                                //           alert(term);
//                                if (term.length < 2) {
//
//                                    return false;
//                                }
//                            },
//                        });
//            });
        </script>
        <script>
//            function onchangeCriticality() {
//                var optionValues = [];
//                $('#criticality option').each(function () {
//                    if ($.inArray(this.value, optionValues) > -1) {
//                        $(this).remove()
//                    } else {
//                        optionValues.push(this.value);
//                    }
//                });
//            }
//            function onchangeSentiment() {
//                var optionValues = [];
//                $('#sentiment option').each(function () {
//                    if ($.inArray(this.value, optionValues) > -1) {
//                        $(this).remove()
//                    } else {
//                        optionValues.push(this.value);
//                    }
//                });
//            }
        </script>
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

    </head>

    <body class="theme-blue">


        <% if (session.getAttribute("role").equals("5")) {%>
        <jsp:include page="userHeader1.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <%} else if (session.getAttribute("role").equals("3")) {%>
        <jsp:include page="em_header.jsp"></jsp:include>
        <jsp:include page="em_left.jsp"></jsp:include>
        <%}%>    <!--<div class=" container-scroller">-->
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
                                    </ul>
                                </div>
                                <div class="body clearfix">
                                    <div class="col-md-10 col-lg-offset-1 well">
                                        <div id="wizard_horizontal">
                                            <h2>Information (<%=request.getParameter("workcode")%>)</h2>
                                        <section>
                                            <div>
                                                <form class="form-horizontal m-t-50" action="<%=request.getContextPath()%>/updatetextnewsaction.do"  id="uploadform" method="post" accept-charset="UTF-8">
                                                    <%Connection dh = null;
                                                        ConnectionDB connectionDB = new ConnectionDB();
                                                        dh = connectionDB.getConnection();
                                                        String subject = "", description = "", date = "";
                                                        System.out.println("workcode:-" + request.getParameter("workcode"));
                                                        String selectData = "Select * from tbl_news_dataentry where workcode=?";
                                                        PreparedStatement pstmt = dh.prepareStatement(selectData);
                                                        pstmt.setString(1, request.getParameter("workcode"));
                                                        ResultSet rs = pstmt.executeQuery();
                                                        if (rs.next()) {

                                                    %>

                                                    <!--<input type="hidden"  id="textInput" name="getUpload" >-->
                                                    <input id="maxid" name="workcode" type="hidden" value="<%=request.getParameter("workcode")%>" />
                                                    <input  name="fromDate" type="hidden" value="<%=request.getParameter("fromdate")%>" />
                                                    <input  name="toDate" type="hidden" value="<%=request.getParameter("todate")%>" />
                                                    <input  name="admin" type="hidden" value="" />
                                                    <input  name="importance" type="hidden" value="" />

                                                    <input id="token" name="token" type="hidden" value="<%=token%>" />
                                                    <div class="form-group">
                                                        <label for="channel" class="col-sm-3 control-label">Channel Name</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <select  class="form-control " name="channel" id="channel"  required>
                                                                    <option value="<%=rs.getString("chname")%>"><%=rs.getString("chname")%></option>
                                                                    <%
                                                                        String sqlSelect = "SELECT * FROM tbl_television_master order by telename ";
                                                                        System.out.println("sqlSelect-" + sqlSelect);
                                                                        PreparedStatement stmSelect = ConnectionDB.getDBConnection().prepareStatement(sqlSelect);
                                                                        ResultSet rsSelect = stmSelect.executeQuery();
                                                                        while (rsSelect.next()) {
                                                                    %>
                                                                    <option value="<%=rsSelect.getString(2)%>"><%=rsSelect.getString(2)%></option>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </select>   
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="Program" class="col-sm-3 control-label">Title / Name of Program</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <input type="text" class="form-control" name="subject" value="<%=rs.getString("subject")%>" autocomplete="off" oninput="errorBlank('errSubject')" id="subject"  placeholder="Enter  Title" required>

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
                                                        <label for="sourcedate" class="col-sm-3 control-label">Source Date </label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line" >
                                                                <input type="text" class="form-control" name="sourcedate" value="<%=rs.getString("sourcedate")%>" autocomplete="off" oninput="errorBlank('errsourcedate')" id="sourcedate-start"  placeholder="Enter Sourcedate" required>

                                                                <!--<input type="text" class="form-control" id="Program" name="Program" placeholder="Title / Name of Program" required>-->
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="timestamp" class="col-sm-3 control-label">Timestamp</label>
                                                        <div class="col-sm-9">
                                                            <%
                                                                String hour = null, minute = null, ampm = null;
                                                                String timestamp[], minuteampm[];
                                                                if (rs.getString("timestamp") != null) {
                                                                    timestamp = rs.getString("timestamp").split("\\.");
                                                                    hour = timestamp[0];
                                                                    minuteampm = timestamp[1].split(" ");
                                                                    minute = minuteampm[0];
                                                                    ampm = minuteampm[1];
                                                                }
                                                            %>
                                                            <div class="">
                                                                <div class="col-sm-4 ">

                                                                    <select  class="form-control " name="hour"  id="hour"  required>
                                                                        <option value="<%=hour%>"><%=hour%></option>
                                                                        <option value="1">1</option>
                                                                        <option value="2">2</option>
                                                                        <option value="3">3</option>
                                                                        <option value="4">4</option>
                                                                        <option value="5">5</option>
                                                                        <option value="6">6</option>
                                                                        <option value="7">7</option>
                                                                        <option value="8">8</option>
                                                                        <option value="9">9</option>
                                                                        <option value="10">10</option>
                                                                        <option value="11">11</option>
                                                                        <option value="12">12</option>

                                                                    </select>   </div>
                                                                <div class="col-sm-4">
                                                                    <select  class="form-control " name="minute" id="minute"  required>
                                                                        <option value="<%=minute%>"><%=minute%></option>
                                                                        <option value="0">0</option>
                                                                        <option value="1">1</option>
                                                                        <option value="2">2</option>
                                                                        <option value="3">3</option>
                                                                        <option value="4">4</option>
                                                                        <option value="5">5</option>
                                                                        <option value="6">6</option>
                                                                        <option value="7">7</option>
                                                                        <option value="8">8</option>
                                                                        <option value="9">9</option>
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
                                                                </div>
                                                                <div class="col-sm-4">
                                                                    <select  class="form-control " name="ampm" id="ampm"  required>

                                                                        <option value="<%=ampm%>"><%=ampm%></option>
                                                                        <option value="AM">AM</option>
                                                                        <option value="PM">PM</option>
                                                                    </select>
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
                                                                            sentiment = "";
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
                                                        <label for="Links" class="col-sm-3 control-label">Add Links</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line">
                                                                <%
                                                                    String link = "";
                                                                    if (rs.getString("link") != null) {
                                                                        link = rs.getString("link");
                                                                    } else {
                                                                        link = "";
                                                                    }

                                                                %>
                                                                <input type="text" class="form-control" name="link" id="link" value="<%=link%>"  autocomplete="off"  aria-describedby="link" placeholder="Add links here">

                                                                <!--<input type="text" class="form-control" id="Links" name="Links" placeholder="Add Links" required>-->

                                                                <%}%></div><small class="text-success">Add links with <code>,</code> comma</small> </div>

                                                    </div>
                                                    <div class="form-group">
                                                        <label for="additional" class="col-sm-3 control-label">Additional Tags</label>
                                                        <div class="col-sm-9">
                                                            <div class="form-line" id="newTag">
                                                                <input type="text" class="form-control"  value="<%=rs.getString("additionaltag")%>"  id="additional1" autocomplete="off"  aria-describedby="additional" >
                                                                <input type="text" class="form-control" name="additional" id="additional" autocomplete="off"  aria-describedby="additional" placeholder="Add Tags here">

                                                                <!--<input type="text" class="form-control" id="Links" name="Links" placeholder="Add Links" required>-->
                                                            </div>
                                                            <div id="divAa" style="font-size: 14px;border:1px solid #c8cbce;display: none" class="text-white"></div>
                                                            <input type="hidden" class="txt" name="additional" id="additional" >

                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="col-sm-12 text-right">
                                                            <button type="submit" class="btn btn-danger " onclick="return updateSubmitBtnInfo();" id="btnSaveVideo"  >UPDATE</button>
                                                            <!--                                                            <button type="submit" class="btn btn-danger " data-toggle="modal" data-target="#defaultModal" onclick="saveEditData()" id="btnSaveVideo"  >UPDATE</button>-->
                                                        </div>
                                                    </div>
                                                    <!--modal-->
                                                    <div class="modal  m-t-125" id="myModal" tabindex="-1" role="dialog">
                                                        <div class="modal-dialog" role="document">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                </div>
                                                                <div class="modal-body text-center"> <h4 id="editSuccess"></h4> <br/>
                                                                    <br/>
                                                                    <span class="badge bg-green font-28 p-t-10 p-b-10 p-l-30 p-r-30"><%=request.getParameter("workcode")%></span> </div>
                                                                <div class="modal-footer">
                                                                    <a href="dataentry_edit.jsp?searchresult=N"><button type="button" class="btn btn-link waves-effect" data-dismiss="modal">CLOSE</button></a>
                                                                </div>
                                                            </div>
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
            <div class="modal bodyBackground " id="myModel12" tabindex="-1" role="dialog" style="display: none">
                <div class="modal-dialog m-t-125" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title text-center" id="defaultModalLabel">Workcode </h4>
                        </div>
                        <div class="modal-body text-center">
                            <!--<div id="sameEntryExist" class="text-danger"></div>-->
                            <%
                                String workcode = "";
                                if (request.getParameter("workcode") != null) {
                                    workcode = request.getParameter("workcode");
                                    //                                                                            out.println(request.getParameter("workcode"));
                                }%>

                            <p class="text-success semi-bold" style="font-size:18px">Update Reference Number  is:-<%=workcode%> </p>

                            <!--<iframe width="560" height="315" src="https://www.youtube.com/embed/u3xKgwKUQLc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>-->
                        </div>
                        <div class="modal-footer">
                            <a href="em_newsviewdatewise.jsp?workcode=<%=rs.getString("workcode")%>&fromSourceDate=<%=request.getParameter("fromdate")%>&toSourceDate=<%=request.getParameter("todate")%>" title="Click Here"  >  <button type="button" class="btn btn-link waves-effect">CLOSE</button>  </a>
                                                  
                        
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
                                $(document).ready(function () {
                                    if (window.location.href.indexOf("success") > -1) {
//alert("test");
                                        document.getElementById('myModel12').style.display = "block";

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

                                function updateSubmitBtnInfo() {
                                    var a = document.getElementById("divAa").innerHTML;

//                                    alert(a);
                                    var ab = document.getElementById("additional1").value;
//                                    alert(ab + " "+a);
                                    document.getElementById("additional").value = ab + " " + a;
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
                                function goBack() {
                                    window.history.back();
                                }
        </script>
        <script>
            $('#sourcedate-start').bootstrapMaterialDatePicker({weekStart: 0, time: false});
            $('#date-end').bootstrapMaterialDatePicker({weekStart: 0, time: false});
            $('#date-start').bootstrapMaterialDatePicker({weekStart: 0, time: false}).on('change', function (e, date)
            {
                $('#date-end').bootstrapMaterialDatePicker('setMinDate', date);
            });
        </script>

    </body>
</html>
<% } else {
        response.sendRedirect("login.jsp");
    }%>

