<%-- 
    Document   : login
    Created on : Nov 15, 2017, 10:26:41 PM
    Author     : Amol
--%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page autoFlush="true" buffer="2094kb"%>
<%--<%@ taglib uri="http://htmlcompressor.googlecode.com/taglib/compressor" prefix="compress" %>--%>
<%--<%@/taglib uri="http://htmlcompressor.googlecode.com/taglib/compressor" prefix="compress" %>--%>


<%
    ResourceBundle rb = ResourceBundle.getBundle("msg");
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("1") || session.getAttribute("role").equals("5"))) {

// if (session != null && session.getAttribute("username") != null && session.getAttribute("role").equals("3")) {
        String username = session.getAttribute("username").toString();
        String userid = session.getAttribute("userid").toString();
        response.addHeader("X-Frame-Options", "DENY");
//    if (session != null && session.getAttribute("username") != null) {
//        response.sendRedirect("workcontrol");
//    }
        String fail = "";
//    if (request.getParameter("fail") != null) {
//        fail = "Please enter correct Captcha";
//    }
        String jsessionid = "";
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("JSESSIONID")) {
//                System.out.println("JSESSIONIDLoginpage=" + cookie.getValue());
                    jsessionid = request.getSession().toString();
                    break;
                }
            }
        }

//    String fail="";
        if (request.getParameter("fail") != null) {
            fail = "Incorrect Username or Password !!";
        }
//    
        request.setAttribute("jession", jsessionid);
%>
<!DOCTYPE html>
<html lang=en>
    <head>
        <meta charset=utf-8>
        <meta name=viewport content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title><%=rb.getString("title")%></title>
        <link rel=icon href=images/favicon.ico type=image/x-icon>
        <link href=css/font/materialicon.css rel=stylesheet type=text/css>
        <link href=css/font/googlefont.css rel=stylesheet type=text/css>
        <link href=plugins/bootstrap/css/bootstrap.css rel=stylesheet>
        <!--<link href=plugins/node-waves/waves.css rel=stylesheet />-->
        <link href=plugins/animate-css/animate.css rel=stylesheet />
        <link href=plugins/bootstrap-material-datetimepicker/css/bootstrap-material-datetimepicker.css rel=stylesheet />
        <link href=plugins/jquery-datatable/skin/bootstrap/css/dataTables.bootstrap.css rel=stylesheet>
        <link href=css/style.css rel=stylesheet>
        <link href=css/themes/all-themes.css rel="stylesheet"/>
        <link href=css/print.css rel="stylesheet"/>
        <link href=css/jquery-ui.css rel=stylesheet>
    </head>
    <body class=theme-blue>
        <%--<compress:html>--%>
      <% if (session.getAttribute("role").equals("1")) {%>
        <jsp:include page="header.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <%} else if (session.getAttribute("role").equals("5")) {%>
        <jsp:include page="userHeader1.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <% }%>  <%
            String table = "";
            request.setCharacterEncoding("UTF-8");
            Connection dh = null;
            String imag[];
            ConnectionDB conn = new ConnectionDB();
            dh = conn.getConnection();
            PreparedStatement stm = null;
            ResultSet rs = null;
            //            String s = "Narendra modi";
            //            String s = request.getParameter("generaltagprint");
//                try {
            //            String s = null;

            //            String generaltag = request.getParameter("generaltagprint");
            //        s.getBytes("UTF-8");
            //            s = new String(generaltag.getBytes("ISO-8859-1"), "UTF-8");
            //                StringBuilder str = new StringBuilder();
            //
            String fromDate = null, toDate = null;
            String dateQuery = null;

            String serchQuery = null;
            try {
        %>
        <section class=content>
            <div class=panel-group id=accordion_1 role=tablist aria-multiselectable=true>
                <div class="panel panel-primary">
                    <div class=panel-heading role=tab id=headingOne_1>
                        <h4 class=panel-title> <a role=button data-toggle=collapse data-parent=#accordion_1 href=#collapseOne_1 aria-expanded=true aria-controls=collapseOne_1 onclick=""> 

                                <span class="glyphicon glyphicon-menu-right rotate"></span> Electronic Media Filters </a> 
                        </h4>
                    </div>
                    <div id=collapseOne_1 class="panel-collapse collapse" role=tabpanel aria-labelledby=headingOne_1>
                        <jsp:include page="em_approver_export_filter_show.jsp"></jsp:include>
                        </div>
                    </div>
                </div>
                <div class=col-md-12>
                    <div class="row clearfix">
                        <div id=printablediv>
                            <div class=col-md-12>
                                <input class="btn bg-black pull-right" type=button value=Print onclick="javascript:printDiv('printablediv')" /><br><br>
                                <div class="card profile-card"><br>
                                    <div class=header>
                                        <div class="content-area clearfix">
                                            <div class=col-md-12>
                                                <div class="pull-left text-left">
                                                    <h3>Electronic Media Report</h3>
                                                </div>
                                                <div class=pull-right> <img class="img-responsive text-right" src=images/logo_circle.png> </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id=border>
                                        <div id=blue></div>
                                        <div id=black></div>
                                    </div>
                                    <div class="profile-body profile-footer clearfix">
                                        <div class=row>
                                            <div class=col-md-12><br>
                                                <div class="panel panel-default panel-titlemarathi">
                                                <%
                                                    StringBuffer query = new StringBuffer();
                                                    String channel = request.getParameter("channel");
                                                    String subject = request.getParameter("title");
                                                    String titlemarathi = request.getParameter("titlemarathi");
                                                    String sentiment = request.getParameter("sentiment");
                                                    String tags = request.getParameter("tags");
                                                    String fromdate = request.getParameter(""
                                                            + "fromdate");
                                                    String todate = request.getParameter("todate");

                                                    System.out.println("querySearchREportr:-");
                                                    StringBuffer querySearch = new StringBuffer();
                                                    if (!channel.isEmpty()) {
                                                        querySearch.append(channel + "::");
                                                    }
                                                    if (!subject.isEmpty()) {
                                                        querySearch.append(subject + "::");
                                                    }
                                                    if (!titlemarathi.isEmpty()) {
                                                        querySearch.append(titlemarathi + "::");
                                                    }
                                                    if (!sentiment.isEmpty()) {
                                                        querySearch.append(sentiment + "::");
                                                    }
                                                    if (!tags.isEmpty()) {
                                                        querySearch.append(tags + "::");
                                                    }
                                                    if (!fromdate.isEmpty() && !todate.isEmpty()) {
                                                        querySearch.append(fromdate + " to " + todate);
                                                    }

                                                    System.out.println("querySearchREportr:-" + querySearch);

                                                    if ((fromdate.isEmpty()) && (todate.isEmpty()) && !tags.isEmpty() && sentiment.isEmpty() && titlemarathi.isEmpty() && subject.isEmpty() && channel.isEmpty()) {
                                                        query.append(" where (additionaltag like '%" + tags + "%'  || approvedtag like '%" + tags + "%') ");
                                                    }
                                                    if ((fromdate.isEmpty()) && (todate.isEmpty()) && tags.isEmpty() && sentiment.isEmpty() && titlemarathi.isEmpty() && subject.isEmpty() && !channel.isEmpty()) {
                                                        query.append(" where chname='" + channel + "' ");
                                                    }
                                                    if ((fromdate.isEmpty()) && (todate.isEmpty()) && tags.isEmpty() && sentiment.isEmpty() && titlemarathi.isEmpty() && !subject.isEmpty() && !channel.isEmpty()) {
                                                        query.append(" where chname='" + channel + "' and subject='%" + subject + "%' ");
                                                    }
                                                    if ((fromdate.isEmpty()) && (todate.isEmpty()) && tags.isEmpty() && sentiment.isEmpty() && !titlemarathi.isEmpty() && !subject.isEmpty() && !channel.isEmpty()) {
                                                        query.append(" where chname='" + channel + "' and subject='%" + subject + "%' and titlemarathi='%" + titlemarathi + "%' ");
                                                    }
                                                    if ((fromdate.isEmpty()) && (todate.isEmpty()) && tags.isEmpty() && !sentiment.isEmpty() && !titlemarathi.isEmpty() && !subject.isEmpty() && !channel.isEmpty()) {
                                                        query.append(" where chname='" + channel + "' and sentiment='%" + sentiment + "%' and subject='%" + subject + "%' and titlemarathi='%" + titlemarathi + "%' ");
                                                    }
                                                    if ((fromdate.isEmpty()) && (todate.isEmpty()) && !tags.isEmpty() && !sentiment.isEmpty() && !titlemarathi.isEmpty() && !subject.isEmpty() && !channel.isEmpty()) {
                                                        query.append(" where chname='" + channel + "' and (additionaltag like '%" + tags + "%'  || approvedtag like '%" + tags + "%')  and sentiment='%" + sentiment + "%' and subject='%" + subject + "%' and titlemarathi='%" + titlemarathi + "%' ");
                                                    }
                                                    if ((!fromdate.isEmpty()) && (!todate.isEmpty()) && !tags.isEmpty() && !sentiment.isEmpty() && !titlemarathi.isEmpty() && !subject.isEmpty() && !channel.isEmpty()) {
                                                        query.append(" where (sourcedate BETWEEN '" + fromdate + "' AND '" + todate + "') and chname='" + channel + "' and (additionaltag like '%" + tags + "%'  || approvedtag like '%" + tags + "%')  and sentiment='%" + sentiment + "%' and subject='%" + subject + "%' and titlemarathi='%" + titlemarathi + "%' ");
                                                    }
                                                    if ((fromdate.isEmpty()) && (todate.isEmpty()) && tags.isEmpty() && sentiment.isEmpty() && !titlemarathi.isEmpty() && subject.isEmpty() && !channel.isEmpty()) {
                                                        query.append(" where chname='" + channel + "'  and titlemarathi='%" + titlemarathi + "%' ");
                                                    }
                                                    if ((fromdate.isEmpty()) && (todate.isEmpty()) && tags.isEmpty() && !sentiment.isEmpty() && titlemarathi.isEmpty() && subject.isEmpty() && channel.isEmpty()) {
                                                        query.append(" where sentiment='" + sentiment + "' ");
                                                    }
                                                    if ((fromdate.isEmpty()) && (todate.isEmpty()) && tags.isEmpty() && sentiment.isEmpty() && titlemarathi.isEmpty() && !subject.isEmpty() && channel.isEmpty()) {
                                                        query.append(" where subject like '%" + subject + "%' ");
                                                    }
                                                    if ((fromdate.isEmpty()) && (todate.isEmpty()) && tags.isEmpty() && sentiment.isEmpty() && !titlemarathi.isEmpty() && subject.isEmpty() && channel.isEmpty()) {
                                                        query.append(" where titlemarathi like '%" + titlemarathi + "%' ");
                                                    }
                                                    if ((!fromdate.isEmpty()) && (!todate.isEmpty()) && tags.isEmpty() && sentiment.isEmpty() && titlemarathi.isEmpty() && subject.isEmpty() && channel.isEmpty()) {
                                                        query.append(" where   (sourcedate BETWEEN '" + fromdate + "' AND '" + todate + "') ");
                                                    }
                                                    if ((!fromdate.isEmpty()) && (!todate.isEmpty()) && tags.isEmpty() && sentiment.isEmpty() && titlemarathi.isEmpty() && !subject.isEmpty() && !channel.isEmpty()) {
                                                        query.append(" where   (sourcedate BETWEEN '" + fromdate + "' AND '" + todate + "') and chname= '"+channel+"' and subject='"+subject+"' ");
                                                    }

                                                    if ((!fromdate.isEmpty()) && (!todate.isEmpty()) && tags.isEmpty() && sentiment.isEmpty() && !titlemarathi.isEmpty() && subject.isEmpty() && channel.isEmpty()) {
                                                        query.append(" where titlemarathi like '%" + titlemarathi + "%' and  (sourcedate BETWEEN '" + fromdate + "' AND '" + todate + "') ");
                                                    }
                                                    if ((!fromdate.isEmpty()) && (!todate.isEmpty()) && tags.isEmpty() && sentiment.isEmpty() && titlemarathi.isEmpty() && !subject.isEmpty() && channel.isEmpty()) {
                                                        query.append(" where subject like '%" + subject + "%' and  (sourcedate BETWEEN '" + fromdate + "' AND '" + todate + "') ");
                                                    }
                                                    if ((!fromdate.isEmpty()) && (!todate.isEmpty()) && tags.isEmpty() && !sentiment.isEmpty() && titlemarathi.isEmpty() && subject.isEmpty() && channel.isEmpty()) {
                                                        query.append(" where sentiment='" + sentiment + "' and  (sourcedate BETWEEN '" + fromdate + "' AND '" + todate + "') ");
                                                    }
                                                    if ((!fromdate.isEmpty()) && (!todate.isEmpty()) && !tags.isEmpty() && sentiment.isEmpty() && titlemarathi.isEmpty() && subject.isEmpty() && channel.isEmpty()) {
                                                        query.append(" where (additionaltag like '%" + tags + "%'  || approvedtag like '%" + tags + "%') and  (sourcedate BETWEEN '" + fromdate + "' AND '" + todate + "') ");
                                                    }
                                                    if ((!fromdate.isEmpty()) && (!todate.isEmpty()) && tags.isEmpty() && sentiment.isEmpty() && titlemarathi.isEmpty() && subject.isEmpty() && !channel.isEmpty()) {
                                                        query.append(" where chname='" + channel + "' and  (sourcedate BETWEEN '" + fromdate + "' AND '" + todate + "') ");
                                                    }

                                                    if ((!fromdate.isEmpty()) && (!todate.isEmpty()) && tags.isEmpty() && !sentiment.isEmpty() && titlemarathi.isEmpty() && !subject.isEmpty() && channel.isEmpty()) {
                                                        query.append(" where (sourcedate BETWEEN '" + fromdate + "' AND '" + todate + "') and sentiment='%" + sentiment + "%' and subject='%" + subject + "%'  ");
                                                    }
                                                    if ((!fromdate.isEmpty()) && (!todate.isEmpty()) && tags.isEmpty() && !sentiment.isEmpty() && titlemarathi.isEmpty() && subject.isEmpty() && !channel.isEmpty()) {
                                                        query.append(" where (sourcedate BETWEEN '" + fromdate + "' AND '" + todate + "') and sentiment='%" + sentiment + "%' and chname='%" + channel + "%'  ");
                                                    }
                                                    if ((fromdate.isEmpty()) && (todate.isEmpty()) && tags.isEmpty() && !sentiment.isEmpty() && titlemarathi.isEmpty() && subject.isEmpty() && !channel.isEmpty()) {
                                                        query.append(" where sentiment='" + sentiment + "' and chname='%" + channel + "%'  ");
                                                    }
//                                                     if ((fromdate.isEmpty()) && (todate.isEmpty()) && tags.isEmpty() && sentiment.isEmpty() && !titlemarathi.isEmpty() && subject.isEmpty() && !channel.isEmpty()) {
//                                                        query.append(" where titlemarathi='" + titlemarathi + "' and chname='%" + channel + "%'  ");
//                                                    }

                                                    if (query != null) {
                                                %>
                                                <jsp:forward page="em_approver_export_report_final.jsp">
                                                    <jsp:param name="querySearch" value="<%=querySearch%>" /> 
                                                    <jsp:param name="query" value="<%=query%>" /> 
                                                    <jsp:param name="fromdate" value="<%=fromdate%>" /> 
                                                    <jsp:param name="todate" value="<%=todate%>" /> 
                                                </jsp:forward>
                                                <%                                                    }
                                                %>
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
        <% //      } catch (Exception e) {
//                        System.out.println("error in innerexport:-" + e.getMessage());
//                    }
            } catch (Exception e) {
                System.out.println("error in outerexport:-" + e.getMessage());
            } finally {
                if (stm != null) {
                    stm.close();
                }
                if (rs != null) {
                    rs.close();
                }
                if (dh != null) {
                    dh.close();
                }

            }
        %>
        <script src="js/jquery-1.12.4.js"></script>
        <!--<script src="plugins/jquery/jquery.min.js"></script>-->
        <script src="js/jquery-ui.js"></script>

        <!-- Bootstrap Core Js --> 
        <script src="plugins/bootstrap/js/bootstrap.js"></script> 

        <!-- Select Plugin Js --> 
        <script src="plugins/bootstrap-select/js/bootstrap-select.js"></script> 

        <!-- Slimscroll Plugin Js --> 
        <script src="plugins/jquery-slimscroll/jquery.slimscroll.js"></script> 

        <!-- Bootstrap Colorpicker Js --> 
        <script src="plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script> 

        <!-- Dropzone Plugin Js --> 
        <!--<script src="plugins/dropzone/dropzone.js"></script>--> 

        <!-- Jquery Validation Plugin Css --> 
        <script src="plugins/jquery-validation/jquery.validate.js"></script> 

        <!-- JQuery Steps Plugin Js --> 
        <script src="plugins/jquery-steps/jquery.steps.js"></script> 

        <!-- Waves Effect Plugin Js --> 
        <script src="plugins/node-waves/waves.js"></script> 

        <!-- Autosize Plugin Js --> 
        <script src="plugins/autosize/autosize.js"></script> 

        <!--Moment Plugin Js-->  
        <script src="plugins/momentjs/moment.js"></script> 

        <!-- Bootstrap Material Datetime Picker Plugin Js --> 
        <script src="plugins/bootstrap-material-datetimepicker/js/bootstrap-material-datetimepicker.js"></script>

        <!-- Bootstrap Datepicker Plugin Js --> 
        <script src="plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script> 

        <!-- Demo Js --> 
        <script src="js/admin.js"></script> 
        <script src="js/dmm.js"></script>     
        <script src="js/demo.js"></script> 

        <!--        <script>
        //            $(document).ready(function () {
        //        $(".collapse.in").each(function () {
        //            $(this).siblings(".panel-heading").find(".glyphicon").addClass("rotate")
        //        });
        //        $(".collapse").on("show.bs.collapse", function () {
        //            $(this).parent().find(".glyphicon").addClass("rotate")
        //        }).on("hide.bs.collapse", function () {
        //            $(this).parent().find(".glyphicon").removeClass("rotate")
        //        })
        //    });
                    $("#date-end1").bootstrapMaterialDatePicker({weekStart: 0, time: false});
                    $("#date-start1").bootstrapMaterialDatePicker({weekStart: 0, time: false}).on("change", function (b, a) {
                        $("#date-end1").bootstrapMaterialDatePicker("setMinDate", a)
                    });
                    $("#date-end").bootstrapMaterialDatePicker({weekStart: 0, time: false});
                    $("#date-start").bootstrapMaterialDatePicker({weekStart: 0, time: false}).on("change", function (b, a) {
                        $("#date-end").bootstrapMaterialDatePicker("setMinDate", a)
                    });</script>
                <script>
                    function printDiv(a) {
                        var b = document.getElementById(a).innerHTML;
                        var c = document.body.innerHTML;
                        document.body.innerHTML = "<html><head><title></title></head><body>" + b + "</body>";
                        window.print();
                        document.body.innerHTML = c
                    }</script>
                <script>$(document).ready(function () {
                        $(".card-about-me .body ul li .content :nth-child(odd)").addClass("bg-black");
                        $(".card-about-me .body ul li .content :nth-child(even)").addClass("bg-blue")
                    });
                    function submitExport() {
                        var e = document.getElementById("language");
                        var a = e.options[e.selectedIndex].text;
                        document.getElementById("language1").value = a;
                        var f = document.getElementById("newspaper");
                        var g = f.options[f.selectedIndex].text;
                        document.getElementById("newspaper1").value = g;
                        var b = document.getElementById("edition");
                        var h = b.options[b.selectedIndex].text;
                        document.getElementById("edition1").value = h;
                        if (document.getElementById("subedition").value != "-1") {
                            var d = document.getElementById("subedition");
                            var c = d.options[d.selectedIndex].text;
                            document.getElementById("subedition1").value = c
                        }
                    }
                    function selectNewsPaper1(c) {
                        if (c == "lang") {
                            var b = new XMLHttpRequest();
                            var d = document.getElementById("language").value;
                            var a = "get_newspaper.jsp?language=" + d;
                            b.onreadystatechange = function () {
                                if (this.readyState == 4 && this.status == 200) {
                                    document.getElementById("newspaper").innerHTML = this.responseText;
                                    $("#edition").empty();
                                    $("#edition").append($("<option>", {text: "Select Edition", value: "-1", selected: true}));
                                    $("#edition").change();
                                    $("#subedition").empty();
                                    $("#subedition").append($("<option>", {text: "Select Sub Edition", value: "-1", selected: true}));
                                    $("#subedition").change()
                                }
                            };
                            b.open("POST", a, true);
                            b.send()
                        } else {
                            if (c == "np") {
                                var b = new XMLHttpRequest();
                                var d = document.getElementById("newspaper").value;
                                var a = "get_newspaper.jsp?newspaper=" + d;
                                b.onreadystatechange = function () {
                                    if (this.readyState == 4 && this.status == 200) {
                                        document.getElementById("edition").innerHTML = this.responseText;
                                        $("#subedition").empty();
                                        $("#subedition").append($("<option>", {text: "Select Sub Edition", value: "-1", selected: true}));
                                        $("#subedition").change()
                                    }
                                };
                                b.open("GET", a, true);
                                b.send()
                            } else {
                                if (c == "edition") {
                                    var b = new XMLHttpRequest();
                                    var d = document.getElementById("edition").value;
                                    var a = "get_newspaper.jsp?edition=" + d;
                                    b.onreadystatechange = function () {
                                        if (this.readyState == 4 && this.status == 200) {
                                            document.getElementById("subedition").innerHTML = this.responseText
                                        }
                                    };
                                    b.open("GET", a, true);
                                    b.send();
                                }
                            }
                        }
                    }
                    ;</script>-->
        <!--        <script>
                    function showFilterDiv() {
                        var b = new XMLHttpRequest();
                        //                    var d = document.getElementById("edition").value;
                        var a = "pr_approver_export_filter_show.jsp";
                        b.onreadystatechange = function () {
                            if (this.readyState == 4 && this.status == 200) {
                                document.getElementById("collapseOne_1").innerHTML = this.responseText;
        
                            }
                        };
                        b.open("GET", a, true);
                        b.send();
                    }
                </script>-->
        <%--</compress:html>--%>
    </body>
</html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>