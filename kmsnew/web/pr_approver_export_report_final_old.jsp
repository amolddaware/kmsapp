<%-- 
    Document   : login
    Created on : Nov 15, 2017, 10:26:41 PM
    Author     : Amol
--%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.ListIterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ResourceBundle rb = ResourceBundle.getBundle("msg");
    if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("4") || session.getAttribute("role").equals("5"))) {

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
        <title>Print Media Monitoring</title>
         <link rel="icon" href="images/favicon.ico" type="image/x-icon">
 <link href=css/font/materialicon.css rel=stylesheet type=text/css>
        <link href=css/font/googlefont.css rel=stylesheet type=text/css>
        <link href=plugins/bootstrap/css/bootstrap.css rel=stylesheet>
        <link href=plugins/node-waves/waves.css rel=stylesheet />
        <link href=plugins/animate-css/animate.css rel=stylesheet />
        <link href=plugins/bootstrap-material-datetimepicker/css/bootstrap-material-datetimepicker.css rel=stylesheet />
        <link href=plugins/jquery-datatable/skin/bootstrap/css/dataTables.bootstrap.css rel=stylesheet>
        <link href=css/style.css rel=stylesheet>
        <link href=css/themes/all-themes.css rel="stylesheet"/>
        <link href=css/print.css rel="stylesheet"/>
        <link href=css/jquery-ui.css rel=stylesheet>
        <style>
            /*.brImg img:first-child {display:none;}*/
            /*brImg*/
        </style>
    </head>
    <body class=theme-blue>
        <jsp:include page="userHeader1.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>
        <%
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
            try {
                //            String s = null;

                //            String generaltag = request.getParameter("generaltagprint");
                //        s.getBytes("UTF-8");
                //            s = new String(generaltag.getBytes("ISO-8859-1"), "UTF-8");
                //                StringBuilder str = new StringBuilder();
                //
                String fromDate = null, toDate = null;
                String dateQuery = null;
                Set<String> hash_Set = new HashSet<String>();
                String serchQuery = null;
                try {
        %>
        <section class=content>
            <div class=panel-group id=accordion_1 role=tablist aria-multiselectable=true>
                <div class="panel panel-primary">
                    <div class=panel-heading role=tab id=headingOne_1>
                        <h4 class=panel-title> <a role=button data-toggle=collapse data-parent=#accordion_1 href=#collapseOne_1 aria-expanded=true aria-controls=collapseOne_1 onclick=""> <span class="glyphicon glyphicon-menu-right"></span> Filters </a> </h4>
                    </div>
                    <div id=collapseOne_1 class="panel-collapse collapse" role=tabpanel aria-labelledby=headingOne_1>
                        <jsp:include page="pr_approver_export_filter_show.jsp"></jsp:include>
                        </div>
                    </div>
                </div>
                <div class=col-md-12>
                    <div class="row clearfix">
                        <input class="btn bg-black pull-right" type=button value=Print onclick="javascript:printDiv('printablediv')" /><br><br>
                        <!--<input class="btn bg-black pull-right" type=button value="PrintData" onclick="javascript:printData()" /><br><br>-->

                        <div id=printablediv>
                            <div class=col-md-12>
                                <div class="card profile-card"><br>
                                    <div class=header>
                                        <div class="content-area clearfix">
                                            <div class=col-md-12>
                                                <div class="pull-left text-left">
                                                    <h3>Print Media Monitoring Report</h3>
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
                                                <div class="panel panel-default panel-post">
                                                <%
                                                    String query = request.getParameter("query");
                                                    System.out.println("brandquerry:-" + query);
                                                    String sql = "SELECT graphicspath,workcode,brand,location,language,npname,edition,subedition,subject,titlemarathi,sourcedate,sentiment  FROM tbl_news_dataentry  " + query + " and workcode like ? and npname is not null and graphicspath!=''  group by npname,subject,titlemarathi,sourcedate order by npname ";
                                                    //                String sql = "SELECT * FROM tbl_news_dataentry WHERE " + query + " and workcode like ? and workcode not like ? limit 0,10";
                                                    System.out.println("sql11111:-" + sql);
                                                    stm = dh.prepareStatement(sql);
                                                    //                    stm.setString(1, "%P%");
                                                    stm.setString(1, "%P%");
                                                    rs = stm.executeQuery();
                                                    String npname = null, tempNpname = null;
                                                    int flag = 0;
                                                    int flag1 = 0;
                                                    int count = 0;
                                                    List<String> lstNpname = new ArrayList();
                                                    List<String> lstBrand = new ArrayList();
                                                    while (rs.next()) {
                                                        count++;

                                                        hash_Set.add(rs.getString("npname"));
                                                        //                                                       
                                                        tempNpname = rs.getString("npname");
                                                        npname = rs.getString("npname");
//                                                        
                                                %>
                                                <div class="panel-heading clearfix newsHeading">
                                                    <div class="col-md-12 col-sm-12">
                                                        <%if (rs.getString("npname").equalsIgnoreCase("Navbharat times")) {%>
                                                        <img class="npnameImg" src="images/epaper/Navbharat_times.png" alt="<%=rs.getString("npname")%>" width="200">
                                                        <%} else {%>
                                                        <img class="npnameImg" src="images/epaper/<%=rs.getString("npname")%>.png" alt="<%=rs.getString("npname")%>" width="200">

                                                        <%}%>
                                                    </div>
                                                    <div class="col-md-9 col-sm-9 m-t-10">
                                                        <h3 class="npnameH3">

                                                            <%--<%=rs.getString("npname")%>--%>

                                                        </h3>
                                                    </div>

                                                </div>
                                                <%//}
                                                    //  break;
                                                    //}%>
                                                <div class=panel-body><br>
                                                    <div class=col-md-12>
                                                        <div class=well>
                                                            <div class=card-about-me>
                                                                <div class="body padding-0">
                                                                    <div class=row>
                                                                        <%
                                                                            if (rs.getString("graphicspath") != null) {
                                                                                String image[] = rs.getString("graphicspath").split("::");
                                                                                for (int i = 0; i < image.length; i++) {
                                                                        %> <div class="col-md-4 col-sm-4">
                                                                            <%--          <img class="img-responsive img-rounded" src="<%=image[i].substring(34).replace(" ", "%20")%>" width=300 height=150> --%>
                                                                            <img src="<%=image[i].substring(34).replace(" ", "%20")%>" id="imageContainer"  width="200" height="100"  ></div>

                                                                        <%}
                                                                            }%>

                                                                    </div>
                                                                    <div class="well bg-white">
                                                                        <ul>
                                                                            <li>
                                                                                <div class=title> <i class=material-icons>alternate_email</i> Brand</div>
                                                                                <div class=content> <%if (rs.getString("brand") != null) {%><%=rs.getString("brand")%><%} else {%><%}%> </div>
                                                                            </li>
                                                                            <li>
                                                                                <div class=title> <i class=material-icons>date_range</i> Date</div>
                                                                                <div class=content> <%=rs.getString("sourcedate")%> </div>
                                                                            </li>
                                                                            <li>
                                                                                <div class=title> <i class=material-icons>room</i> Location</div>
                                                                                <div class=content><%if (rs.getString("location") != null) {%><%=rs.getString("location")%><%} else {%><%}%> </div>
                                                                            </li>
                                                                            <li>
                                                                                <div class=title> <i class=material-icons>language</i> Language</div>
                                                                                <div class=content> <%=rs.getString("language")%> </div>
                                                                            </li>
                                                                            <li>
                                                                                <div class=title> <i class=material-icons>edit</i> Edition </div>
                                                                                <div class=content> <%=rs.getString("edition")%> </div>
                                                                            </li>
                                                                            <li>
                                                                                <div class=title> <i class=material-icons>subtitles</i> Sub Edition </div>
                                                                                <div class=content><%if (rs.getString("subedition") != null) {%><%=rs.getString("subedition")%><%} else {%><%}%></div>
                                                                            </li>
                                                                            <li>
                                                                                <div class=title> <i class=material-icons>title</i> Title (English) </div>
                                                                                <div class=content> <%=rs.getString("subject")%></div>
                                                                            </li>
                                                                            <li>
                                                                                <div class=title> <i class=material-icons>title</i> Title (Marathi) </div>
                                                                                <div class=content> <%=rs.getString("titlemarathi")%> </div>
                                                                            </li>

                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="hrsolid"></div>
                                                        <div class=hrdotted></div>
                                                    </div>
                                                </div>
                                                <%}
                                                    if (count == 0) {
                                                        out.println("<span class='text-danger '><b>Record not found</b></span>");
                                                    }
                                                    System.out.println("sixe:" + lstNpname.size());
                                                    ListIterator litr = lstNpname.listIterator();
                                                    while (litr.hasNext()) {
//                Object element = litr.next();
                                                        System.out.print(litr.next() + " ");
//                litr.set(element + "+");
                                                    }
                                                    ListIterator lstBrandlt = lstBrand.listIterator();
                                                    while (lstBrandlt.hasNext()) {
//                Object element = litr.next();
                                                        System.out.print(lstBrandlt.next() + " ");
//                litr.set(element + "+");
                                                    }
                                                %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="elementH"></div>
                </div>
            </div>
        </section>
        <%      } catch (Exception e) {
                    System.out.println("error in innerexport:-" + e.getMessage());
                }
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
        <script src=js/jquery.min.js></script>
        <script src=js/jspdf.min.js></script>
        <script src=js/jquery-1.12.4.js></script>
        <script src=js/jquery-ui.js></script>
        <script src=plugins/bootstrap/js/bootstrap.js></script>
        <script src=plugins/bootstrap-select/js/bootstrap-select.js></script>
        <script src=plugins/jquery-slimscroll/jquery.slimscroll.js></script>
        <script src=plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.js></script>
        <script src=plugins/jquery-validation/jquery.validate.js></script>
        <!--<script src=plugins/jquery-steps/jquery.steps.js></script>-->
        <script src=plugins/autosize/autosize.js></script>
        <script src=plugins/momentjs/moment.js></script>
        <script src=plugins/bootstrap-material-datetimepicker/js/bootstrap-material-datetimepicker.js></script>
        <script src=plugins/bootstrap-datepicker/js/bootstrap-datepicker.js></script>
        <script src=js/demo.js></script>

        <script src=js/admin.js></script>

        <script>
        </script>
        <script>
//$( "div span:first-child" )
//  .css( "text-decoration", "underline" )
//  .hover(function() {
//    $( this ).addClass( "sogreen" );
//  }, function() {
//    $( this ).removeClass( "sogreen" );
//  });
        </script>

        <script>

            var seen = {};

//            $('.npnameH3').each(function () {
//                var txt = $(this).text();
//                if (seen[txt])
//                    $(this).remove();
//                else
//                    seen[txt] = true;
//            });
//            var seen1 = {};
//            $('.npnameImg').each(function (i) {
//                var txt = $(this).attr("src");
//
//                if (seen1[txt]) {
//                    $(this).remove();
////                    $(".hrdotted").addClass("hr_dotted");
//                } else {
//                    seen1[txt] = true;
//                    if ($(this).is(':last-child')) {
//                        // Your code here
//                        $(this).before("<div class='col-md-12 brImg'><img class='img-responsive ' src='images/border.png'/></div>");
////                        $(this).prepend("<div class='hr_solid'></div>"); 
//
////  .css( "text-decoration", "underline" )
////  .hover(function() {
////    $( this ).addClass( "sogreen" );
////  }, function() {
////    $( this ).removeClass( "sogreen" );
////  });
////                        $(".brImg").find(':first-child').remove();
////                        $(this).addClass("col-sm-12  hr_solid");
////                    $(".hr_dotted").removeClass("hr_dotted");
////                    $(".hrsolid").addClass("hr_solid");
////                    alert(txt + ":-last");
//                    }
//                }
//
////                
//            });

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
            ;</script>
        <script>
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
        </script>
        <script>
            function printData() {
                var margin = {
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0
                };
                var doc = new jsPDF();
                var elementHTML = $('#printablediv').html();
                var specialElementHandlers = {
                    '#elementH': function (element, renderer) {
                        return true;
                    }
                };
                doc.fromHTML(elementHTML, 0, 0, {
                    'width': 100,
                    'elementHandlers': specialElementHandlers
                }, function (dispose) {
                    // dispose: object with X, Y of the last line add to the PDF
                    //          this allow the insertion of new lines after html
                    // pdf.save('Test.pdf');

                    if (navigator.msSaveBlob) {
                        var string = doc.output('datauristring');
                    } else {
                        var string = doc.output('bloburi');
                    }

                    $('.previewIFRAME').attr('src', string);
                });



// Save the PDF
//                doc.save('sample-document.pdf');
            }
        </script>
    </body>
</html>
<%} else {
        response.sendRedirect("login.jsp");
    }%>
