<%-- 
    Document   : header
    Created on : Nov 15, 2017, 11:36:31 PM
    Author     : Amol
--%>

<%
//    String role = session.getAttribute("role").toString();
     if (session != null && session.getAttribute("username") != null && (session.getAttribute("role").equals("2")||session.getAttribute("role").equals("3")||session.getAttribute("role").equals("4"))) {

//    if (session != null && session.getAttribute("username") != null && session.getAttribute("role").equals("3")) {
        String username = session.getAttribute("username").toString();
        String userid = session.getAttribute("userid").toString();
        String token = session.getAttribute("csrfToken").toString();
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setDateHeader("Expires", 0);
        response.addHeader("X-Frame-Options", "DENY");

        int timeout = session.getMaxInactiveInterval();
//                System.out.println("timeout:-"+timeout);
        response.setHeader("refresh", timeout + ";URL=logout.jsp");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/styledropdown.css" />
<link href="css/jquery-ui.css" rel="stylesheet">
<!--<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />-->
<link href="css/jquery.multiselect.css" rel="stylesheet" />

<!--<script src="https://code.jquery.com/jquery-1.12.4.js"></script>-->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="http://cdn.rawgit.com/davidstutz/bootstrap-multiselect/master/dist/css/bootstrap-multiselect.css"  rel="stylesheet" type="text/css" />
<script src="js/jquery.multiselect.js"></script>

<style>
    .chk{cursor: pointer;}
    .txtSearch{width: 100%;font-size: 0.8rem;margin-top: 20px;border-radius: 3px;padding: 12px 6px;line-height: 1.628571429;color: #000;vertical-align: middle;background-color: #fff;border: none;height: 40px;  }
    .txtFrom{
        width:70%;font-size:0.8rem;border-radius: 3px;padding: 6px 0px;line-height: 1.428571429;color: #000;vertical-align: middle;background-color: #fff;border: none;
    }
    .txtTo{
        width:70%;font-size:0.8rem;border-radius: 3px;padding: 6px 0px;line-height: 1.428571429;color: #000;vertical-align: middle;background-color: #fff;border: none;
    }
    .txtCmbCategory{
        width:100%;display: block;border: none;font-size:0.8rem;border-radius: 3px;padding: 12px 6px; line-height: 1.428571429;color: #000;vertical-align: middle;background-color: #fff;border: 0.5px solid  #00b8e6 ;-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,0.075); box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);-webkit-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    }
    /*                        .txtSearch:enabled {
                                width:100%;display: block;border-radius: 3px;padding: 12px 6px;line-height: 1.428571429;color: #000;vertical-align: middle;background-color: #fff;margin-top: 7px;
                            }*/
    .divSearch{
        border-radius: 2px;
        -webkit-box-shadow: inset 0 2px 2px rgba(0,0,0,0.075); box-shadow: inset 0 2px 2px rgba(0,0,0,0.075);-webkit-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
        margin-left: 10px;
        width: 80%;
        height: 40px;margin-top:22px;margin-left: -35px;
    }
    .divSearchDate{
        margin-left: 10px;
        width: 80%;
        height: 40px;margin-top:20px;
        border-radius: 2px;
        -webkit-box-shadow: inset 0 2px 2px rgba(0,0,0,0.075); box-shadow: inset 0 2px 2px rgba(0,0,0,0.075);-webkit-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;

    }

    .z1asCe, .qa__svg-icon {
        display: inline-block;
        fill: currentColor;
        height: 24px;
        line-height: 24px;
        position: relative;
        width: 24px;
    }.sbico {
        display: inline-block;
        height: 30px;
        width: 30px;
        cursor: pointer;
        vertical-align: middle;
        color: #FFF;
    }
    .sbico-c {
        background: transparent;
        border: 0;
        float: right;
        height: 40px;
        line-height: 40px;
        margin-top: -1px;
        outline: 0;
        padding-right: 0px;
        position: relative;
        width: 50px;
        top: -1px;border-radius: 3px;
    }
    .logina{
        font-size: 20px;
        text-decoration: none;
        font-family: auto;
        border: 2px solid gray;
        padding: 3px 20px;
        border-radius: 3px;
    }
    .logina:hover{
        text-decoration: none;
        color: #FFF;
    }
</style>
<%--
<nav class="navbar bg-primary-gradient col-lg-12 col-12 p-0 fixed-top navbar-inverse d-flex flex-row">
    <div class="bg-white text-center navbar-brand-wrapper">
        <!--                <a class="navbar-brand brand-logo" href="#">CM Office Member</a>-->
        <a class="navbar-brand " href="#"><img src="" alt=""></a>
        <!--                <a class="navbar-brand brand-logo" href="#"><img src="images/logo_star_black.png" /></a>
                        <a class="navbar-brand brand-logo-mini" href="#"><img src="images/logo_star_mini.jpg" alt=""></a>-->
    </div>
    <div class="navbar-menu-wrapper d-flex align-items-center">
<!--        <button class="navbar-toggler navbar-toggler hidden-md-down align-self-center mr-3"  data-target="#sidebar"   type="button" data-toggle="collapse">
            <span class="navbar-toggler-icon"></span>
        </button>-->
        <div class="offset-lg-3  ">

            <h4 class="text-white  mb-2 text-center" >Knowledge Management System </h4>
        </div>

        <ul class="navbar-nav ml-lg-auto d-flex align-items-center flex-row">
            <li class="nav-item">
                <a class="nav-link profile-pic" title="<%=username%>" href="#"><img class="rounded-circle" src="images/faceman.jpg" alt=""></a>
            </li>
            <li class="nav-item">
                <!--<a class="nav-link" href="#"><i class="fa fa-power-off" title="Logout"></i></a>-->
                <a class="nav-link" href="<%=request.getContextPath()%>/logout.do"><i class="fa fa-power-off" title="Logout"></i></a>

            </li>
        </ul>
        <button class="navbar-toggler navbar-toggler-right hidden-lg-up align-self-center" type="button" data-toggle="offcanvas">
            <span class="navbar-toggler-icon"></span>
        </button>
    </div>
</nav>--%>
<div class="row"><br>

    <div class="col-sm-12" style="background-color: #280850;height: 85px;">
        <form action="innerhomepage.jsp" id="myForm" method="get">
            <div class="row">
                <div class="col-sm-2">
                    <!--<br>-->
                     <a href="userHome.jsp"><img src="images/logo_2.png" height="40" width="150" style="margin-top:20px;"></a>
                </div>

                <div class="col-sm-3">
                    <!--<br>-->
                    <% if (request.getParameter("generaltag") != null) {
                            System.out.println("tests:-" + request.getParameter("generaltag"));
                            
                            %>
                            <input class="txtSearch"  type="text" name="generaltag" value="<%=request.getParameter("generaltag")%>" id="generaltag" autocomplete="off"  oninput="errBlank('errGeneral')" placeholder="Enter Keyword">

                    <%
                        }else{
                                                    System.out.println("testsadadadasd:-");
%>
                        <input class="txtSearch"  type="text" name="generaltag" id="generaltag" autocomplete="off"  oninput="errBlank('errGeneral')" placeholder="Enter Keyword">
<%}%>
                </div>
                <div class="col-sm-1 divSearchDate bg-white " style="padding-left: 5px;padding-right: 5px;">
                    <input class="txtFrom classdatepicker"  type="text"  name="fromDate" id="fromDate" autocomplete="off"  oninput="errBlank('errGeneral')" placeholder="From Date">
                    <i class="fa fa-calendar classdatepicker" style="font-size:18px;color:#b6b6b6;margin-top: 10px"></i>

                    <!--<br>-->
                    <!--<input class="txtSearch form-control p_input "  type="text" name="generaltag" id="generaltag"  oninput="errBlank('errGeneral')" placeholder="Enter Keyword">-->

                </div>
                <div class="col-sm-1 divSearchDate bg-white "style="padding-right: 5px;">
                    <input class="txtTo classdatepicker"  type="text" name="toDate" id="toDate" autocomplete="off"  oninput="errBlank('errGeneral')" placeholder="To Date">
                    <i class="fa fa-calendar classdatepicker" style="font-size:18px;color:#b6b6b6;margin-top: 10px"></i>

                    <!--<br>-->
                    <!--<input class="txtSearch form-control p_input "  type="text" name="generaltag" id="generaltag"  oninput="errBlank('errGeneral')" placeholder="Enter Keyword">-->

                </div>
                <div class="col-sm-2  " style="margin-top:20px;">
                    <select name="basic[]" id="idCategory" multiple="multiple" class="3col active txtCmbCategory" >
                        <!--<select name="basic[]" id="idCategory" multiple="multiple" class="3col active txtCmbCategory" style="margin-top: 20px;">-->
                        <!--<select id="idCategory1" class="txtCmb" multiple="multiple">-->
                        <option value="G">Creative Team</option>
                        <option value="N">Media Room</option>
                        <option value="R">Raw Data</option>
                    </select>
                    <!--<br>-->
                    <!--<input class="txtSearch form-control p_input "  type="text" name="generaltag" id="generaltag"  oninput="errBlank('errGeneral')" placeholder="Enter Keyword">-->

                </div>
              
                <div class="col-sm-1   divSearch align-middle ">
                    <button class="sbico-c bg-primary" value="Search" aria-label="" onclick="showData()" type="submit"><span class="sbico z1asCe MZy1Rb "><svg focusable="false" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M15.5 14h-.79l-.28-.27A6.471 6.471 0 0 0 16 9.5 6.5 6.5 0 1 0 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"></path></svg></span></button>

                </div>

                <div class="col-sm-2 align-middle " >
                    <div class="row">
                    <div style="width:85%;">
                    <a class="nav-link profile-pic" style="margin-top:20px;border:1px solid grey;border-radius: 3px;height: 40px;" title="<%%>" href="#"><img class="rounded-circle" src="images/faceman.jpg" height="25" width="25" alt="">
                    </a>
                    <!--welcome-->
                    <!--<br>-->
                    &nbsp;&nbsp;&nbsp;
                    <div id="dd" class="wrapper-dropdown-3" style="z-index:1" tabindex="1">
                        <span><%=username%></span>
<%--                        <ul class="dropdown">
                            <li><a href="userHome.jsp"><i class=""></i>Home</a></li>

                            <li><a href="#"><i class="icon-truck icon-large"></i></a></li>
                            <li><a href="<%=request.getContextPath()%>/logout.do" target="_self"><i class=""></i>Logout</a></li>
                        </ul>--%>

                        ​</div>
                    </div>
                        <div style="width:15%;margin-top:30px;border-radius: 3px;height: 40px;">
                            <a href="logout.do" ><img src="images/login_icon.png" height="25" width="25" style="margin-left:10px"></a>
                        </div>
                        </div>

                    <!--<button class="sbico-c bg-primary" value="Search" aria-label="" onclick="showData()" type="submit"><span class="sbico z1asCe MZy1Rb "><svg focusable="false" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M15.5 14h-.79l-.28-.27A6.471 6.471 0 0 0 16 9.5 6.5 6.5 0 1 0 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"></path></svg></span></button>-->

                </div>

            </div>
        </form>
        <!--<a href="login_1.jsp" class="logina"><img src="images/login_icon.png"> &nbsp;Login</a>-->
    </div>


</div>
<!--<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>-->
<!--                                       <script>
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

        </script>-->
<%} else {
        response.sendRedirect("login.jsp");
    }%>