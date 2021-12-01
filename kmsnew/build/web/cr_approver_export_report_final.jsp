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
        <title>Creative Team Report</title>
        <link rel=icon href=images/favicon.ico type=image/x-icon>
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
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.3/jspdf.min.js"></script>
        <script src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>


        <script>

            function getPDF() {
                $("#downloadbtn").hide();
                $("#genmsg").show();
                var HTML_Width = $(".canvas_div_pdf").width();
                var HTML_Height = $(".canvas_div_pdf").height();
                var top_left_margin = 15;
                var PDF_Width = HTML_Width + (top_left_margin * 2);
                var PDF_Height = (PDF_Width * 1.2) + (top_left_margin * 2);
                var canvas_image_width = HTML_Width;
                var canvas_image_height = HTML_Height;

                var totalPDFPages = Math.ceil(HTML_Height / PDF_Height) - 1;


                html2canvas($(".canvas_div_pdf")[0], {allowTaint: true}).then(function (canvas) {
                    canvas.getContext('2d');

                    console.log(canvas.height + "  " + canvas.width);


                    var imgData = canvas.toDataURL("image/jpeg", 1.0);
                    var pdf = new jsPDF('p', 'pt', [PDF_Width, PDF_Height]);
                    pdf.addImage(imgData, 'JPG', top_left_margin, top_left_margin, canvas_image_width, canvas_image_height);


                    for (var i = 1; i <= totalPDFPages; i++) {
                        pdf.addPage(PDF_Width, PDF_Height);
                        pdf.addImage(imgData, 'JPG', top_left_margin, -(PDF_Height * i) + (top_left_margin * 4), canvas_image_width, canvas_image_height);
                    }

                    pdf.save("HTML-Document.pdf");

                    setTimeout(function () {
                        $("#downloadbtn").show();
                        $("#genmsg").hide();
                    }, 0);

                });
            }
            ;


        </script>

        <style>
            /*.brImg img:first-child {display:none;}*/
            /*brImg*/
        </style>
    </head>
    <body class=theme-blue>
        <% if (session.getAttribute("role").equals("1")) {%>
        <jsp:include page="header.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <%} else if (session.getAttribute("role").equals("5")) {%>
        <jsp:include page="userHeader1.jsp"></jsp:include>
        <jsp:include page="userLeft.jsp"></jsp:include>

        <% }%> <%
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
        <section class=content style="overflow: hidden">
            <div class=panel-group id=accordion_1 role=tablist aria-multiselectable=true>
                <div class="panel panel-primary">
                    <div class=panel-heading role=tab id=headingOne_1>
                        <h4 class=panel-title> <a role=button data-toggle=collapse data-parent=#accordion_1 href=#collapseOne_1 aria-expanded=true aria-controls=collapseOne_1 onclick=""> <span class="glyphicon glyphicon-menu-right"></span>Creative Team Filters </a> </h4>
                    </div>
                    <div id=collapseOne_1 class="panel-collapse collapse" role=tabpanel aria-labelledby=headingOne_1>
                        <jsp:include page="cr_approver_export_filter_show.jsp"></jsp:include>
                        </div>
                    </div>
                </div>
                <div class=col-md-12  m-t-100>
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-8 col-sm-offset-2">
                                <input class="btn btn-dark noprint" type="button" value="Print" onclick="javascript:printDiv('printablediv')" />
                                <!--<input class="btn bg-black pull-right" type=button value="PrintData" onclick="getPDF()" /><br><br>-->

                                <div id="printablediv">
                                <%
                                    String fromdate = null;
                                    if (request.getParameter("fromdate") != null) {
                                        fromdate = request.getParameter("fromdate");
                                    }
                                    String todate = null;
                                    if (request.getParameter("todate") != null) {
                                        todate = request.getParameter("todate");
                                    }
                                    String query = request.getParameter("query");
                                    String querySearch = request.getParameter("querySearch");
                                    System.out.println("querySearch:-" + querySearch);
                                    System.out.println("brandquerry:-" + query);
                                    String sql = "SELECT workcode,subject,description,sector,name_of_program,place_of_program,sourcedate,vdopath,docpath,graphicspath,additionaltag  FROM tbl_news_dataentry  " + query + " and workcode like ? order by sourcedate desc ";
                                    //                String sql = "SELECT * FROM tbl_news_dataentry WHERE " + query + " and workcode like ? and workcode not like ? limit 0,10";
                                    System.out.println("sql11111:-" + sql);
                                    stm = dh.prepareStatement(sql);
                                    //                    stm.setString(1, "%P%");
                                    stm.setString(1, "%C%");
                                    rs = stm.executeQuery();
                                    String npname = null, tempNpname = null;
                                    int flag = 0;
                                    int flag1 = 0;
                                    int count = 0;
                                    List<String> lstNpname = new ArrayList();
                                    List<String> lstBrand = new ArrayList();


                                %>
                                <div class="col-sm-12 padding-0">
                                    <div class="col-sm-offset-3 col-sm-6 text-center cover_data text-capitalize">
                                        <h1>KMS REPORT</h1>
                                        <hr class="hr_dashed">
                                        <h2 class="text-capitalize">Creative Team</h2>
                                        <hr class="hr_dashed">
                                        <h3>Search By:                                                

                                            <%                                                String qq[] = querySearch.split("::");
                                                for (int i = 0; i < qq.length; i++) {
                                            %>
                                            <span class="badge badge-pill badge-primary"><%=qq[i]%></span>
                                            <%}%>
                                        </h3>
                                    </div>
                                    <img class="img-responsive" src="images/cover_bg.svg"> </div>
                                    <% while (rs.next()) {
                                            count++;%>
                                <div class="col-sm-12 padding-0">
                                    <div class="body-main inner ">
                                        <div class="row">
                                            <div class="col-sm-8">
                                                <h4 style="color: #009fe2;"><strong>Creative Team Report</strong></h4>
                                                <!--                                                <p>
                                                                                                    <strong>From: 2017-04-24</strong><br>
                                                                                                    <strong>To: 2020-04-24</strong></p>-->
                                            </div>
                                            <div class="col-sm-4"> 
                                                <img class="img-responsive pull-right" width="70" alt="" src="images/logo_f.png" /> </div>

                                            <div class="col-sm-12">
                                                <hr class="dotted">
                                                <div class="row">
                                                    <div class="col-md-12 m-b-15"> 

                                                        <!--<img class="img-responsive" alt="" src="images/card-img.png" />--> 
                                                        <h5> <%=count%>. <% if (rs.getString("subject") != null) {%><%=rs.getString("subject")%> <% } %> </h5>
                                                    </div>

                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-12">
                                                        <div class="card bg-light m-b-15">
                                                            <div class="card-body">
                                                                <div class="row">

                                                                    <%
                                                                        if (!rs.getString("graphicspath").isEmpty()) {
                                                                            String image[] = rs.getString("graphicspath").split("::");
                                                                            for (int i = 0; i < image.length; i++) {

                                                                    %> <div class="col-md-4 col-sm-4">
                                                                        <img src="/kmsvdo/<%=image[i].substring(25).replace(" ", "%20")%>"   class="img-responsive" id="imageContainer"  width="200" height="100"  ></div>

                                                                    <%}
                                                                        }%>
                                                                    

                                                                    <div class="col-md-9 col-sm-9 m-t-10">
                                                                        <h3 class="npnameH3">


                                                                        </h3>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="card bg-light">
                                                            <div class="card-body">
                                                                <table class="table table-responsive d-md-table mb-0">
                                                                    <tbody>

                                                                        <tr>
                                                                            <td><strong>Description</strong></td>
                                                                            <td><% if (rs.getString("description") != null) {%><%=rs.getString("description")%><%}%> </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Sector</strong></td>
                                                                            <td><%=rs.getString("sector")%>   </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Name of Program</strong></td>
                                                                            <td> <% if (rs.getString("name_of_program") != null) {%> <%=rs.getString("name_of_program")%><% }%>  </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Place of Program</strong></td>
                                                                            <td> <% if (rs.getString("place_of_program") != null) {%> <%=rs.getString("place_of_program")%><% }%>  </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><strong>Date</strong></td>
                                                                            <td> <%=rs.getString("sourcedate")%> </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--                                                    <div class="col-sm-12">
                                                                                                            <hr class="dotted">
                                                    
                                                                                                        </div>-->

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%}
                                    if (count == 0) {
                                        out.println("<span class='text-danger '><b>Record not found</b></span>");
                                    }
                                %>
                            </div>
                        </div>
                    </div>
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
        <script src=plugins/node-waves/waves.js ></script>
        <script src=plugins/momentjs/moment.js></script>
        <script src=plugins/bootstrap-material-datetimepicker/js/bootstrap-material-datetimepicker.js></script>
        <script src=plugins/bootstrap-datepicker/js/bootstrap-datepicker.js></script>
        <script src=js/demo.js></script>
        <script src=js/admin.js></script>
        <script>

                                    var seen = {};
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
        </script>
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
