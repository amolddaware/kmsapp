<%-- 
    Document   : newjsp
    Created on : Nov 25, 2017, 2:18:44 PM
    Author     : Amol
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.sql.Connection"%>
<%@page  pageEncoding="UTF-8"%>
<%
    if (session != null && session.getAttribute("username") != null && session.getAttribute("role").equals("3")) {
        String username = session.getAttribute("username").toString();
        String userid = session.getAttribute("userid").toString();
        String token = session.getAttribute("csrfToken").toString();
//System.out.println(token);
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setDateHeader("Expires", 0);
        response.addHeader("X-Frame-Options", "DENY");
        String s = request.getParameter("generaltag");
//        System.out.println("subjectc:-" + subject);
// String buffer="<div>";  
        Connection dh = null;
        ConnectionDB connectionDB = new ConnectionDB();
        dh = connectionDB.getConnection();
//        String sql = "select * from govt_tag_master_view where general like '%" + subject + "%' or sourcetag like '%" + subject + "%' or schemetag like '%" + subject + "%'"
//                + " or persontag like '%" + subject + "%' or departmenttag like '%" + subject + "%' or designationtag like '%" + subject + "%'"
//                + " or districttag like '%" + subject + "%' or talukatag like '%" + subject + "%' or villagetag like '%" + subject + "%' or additionaltag like '%" + subject + "%'";
////        String sql = "Select * from dataentry where subject LIKE '" + subject + "%'";
//        PreparedStatement stm = dh.prepareStatement(sql);
//        System.out.println("sql:-" + sql);
//        ResultSet rs = stm.executeQuery();
//        String sql1 = "select * from new_all_in_one_view where subject like '%" + subject + "%' or description like '%" + subject + "%' or summary like '%" + subject + "%'or general like '%" + subject + "%'"
//                + " or districttag like '%" + subject + "%' or talukatag like '%" + subject + "%' or villagetag like '%" + subject + "%'"
//                + "or teletag like '%" + subject + "%'  or additionaltag like '%" + subject + "%'";
//        String sql1 = "select * from tbl_news_dataentry where subject like '%" + subject + "%' or description like '%" + subject + "%' or summary like '%" + subject + "%'or general like '%" + subject + "%'"
//                + " or districttag like '%" + subject + "%' or talukatag like '%" + subject + "%' or villagetag like '%" + subject + "%'"
//                + "or teletag like '%" + subject + "%'  or additionaltag like '%" + subject + "%'";
//        String sql1 = "SELECT * FROM tbl_news_dataentry WHERE MATCH "
//                                + "(subject, description, summary,general,teletag,districttag,talukatag,villagetag,additionaltag) "
//                + " AGAINST ('"+subject+"')";
         String subject="";
 String spliWord[]=s.split(" ");
 
 for (int k=0;k<spliWord.length;k++){
 subject=subject+"+"+spliWord[k]+" ";
 }
 subject.trim();
        String sql1="SELECT *,MATCH(`subject`) AGAINST ('"+subject.trim()+"' IN BOOLEAN MODE) * 10 as rel1,"
+"MATCH(`description`) AGAINST ('"+subject.trim()+"' IN BOOLEAN MODE) * 3 as rel2,"
+"MATCH(`summary`) AGAINST ('"+subject.trim()+"' IN BOOLEAN MODE) as rel3,"
+"MATCH(general) AGAINST ('"+subject.trim()+"' IN BOOLEAN MODE) as rel4,"
+"MATCH(teletag) AGAINST ('"+subject.trim()+"' IN BOOLEAN MODE) as rel5,"
+"MATCH(districttag) AGAINST ('"+subject.trim()+"' IN BOOLEAN MODE) as rel6,"
+"MATCH(talukatag) AGAINST ('"+subject.trim()+"' IN BOOLEAN MODE) as rel7,"
+"MATCH(villagetag) AGAINST ('"+subject.trim()+"' IN BOOLEAN MODE) as rel8,"
+"MATCH(additionaltag) AGAINST ('"+subject.trim()+"' IN BOOLEAN MODE) as rel9 "
+" FROM tbl_news_dataentry "
+"WHERE MATCH (subject, description, summary,general,teletag,districttag,talukatag,villagetag,additionaltag) "
+"      AGAINST ('"+subject.trim()+"' IN BOOLEAN MODE)"
+"ORDER BY (rel1)+(rel2)+(rel3)+(rel4)+(rel5)+(rel6)+(rel7)+(rel8)+(rel9) ASC";
        PreparedStatement stm1 = dh.prepareStatement(sql1);
        System.out.println("sql1:-" + sql1);
        ResultSet rs = stm1.executeQuery();

%>

<table class="table center-aligned-table">    <thead>
        <tr>
            <th colspan="10" class="text-center "><h6>Information</h6></th>
<!--<th colspan="5" class="text-center "><h6>Reference Files</h6></th>-->
<!--<th colspan="10" class="text-center"><h6>Tags</h6></th>-->
</tr>
<tr class="text-primary">
    <th>Sr.No</th>
    <th>Channel Name</th>
    <th>Video Reference No</th>
    <!--<th>Read Description</th>-->
    <th>Title</th>
    <th>Description</th>
    <th>summary</th>
    <th>Source Date</th>
    <!--<th>Document</th>-->
    <th>Image</th>
    <th>Video</th>
    <!--<th>Audio</th>-->
    <th>Links</th>
    <!--<th style="border-right: 3px solid #f3f1f1">Audio</th>-->
    <!--    <th>General Tag</th>
        <th>Source Tag</th>
        <th>Scheme Tag</th>
        <th>Responsible Person Tag</th>
        <th>Department Tag</th>
        <th>Designation Tag</th>
        <th>District Tag</th>
        <th>Taluka Tag</th>
        <th>Village Tag</th>
        <th>Additional Tag</th>-->
</tr>
</thead>
<tbody>
    <%int number = 0;
        String img = "";
        String docs = "";
        int num = 0;
        String table = "";
        while (rs.next()) {
            number++;
//    System.out.println("teletag:-"+rs.getString("teletag"));
    %>

    <tr >
        <td><%=number%></td>
        <td>
            <% if (rs.getString("teletag") != null) {
                    out.println(rs.getString("teletag"));
                } else {
                    out.println("tagging is not completed");
                }%></td>
        <td>
            <% if(rs.getString("workcode").contains("N")){
            %>
            <a href="generatenewsreport.jsp?searchresult=<%=rs.getString("workcode")%>"  target='_blank'  title='Click Here' ><%=rs.getString("workcode")%></a>
        
            <%}else if(rs.getString("workcode").contains("G")){%>
            <a href="generate_graphicsreport.jsp?searchresult=<%=rs.getString("workcode")%>"  target='_blank'  title='Click Here' ><%=rs.getString("workcode")%></a>
        
            <%}
            %>
            
        </td>
            <%--<td><a href="generatereport.jsp?maxid=<%=rs.getString("iddataentry")%>" title="Click Here" >Read</a></td>--%>
        <td><% if (rs.getString("subject") != null) {
                out.println(rs.getString("subject"));
            }%></td>
        <td><% if (rs.getString("description") != null) {
                out.println(rs.getString("description"));
            }%></td>
        <td><% if (rs.getString("summary") != null) {
                out.println(rs.getString("summary"));
            }%></td>
        <td><%
            if (rs.getString("sourcedate") != null) {
                String yy = "", mm = "", dd = "", hh = "", mi = "", ss = "";
//                yy = rs.getString("sourcedate").substring(0, 4);
//                mm = rs.getString("sourcedate").substring(4, 6);
//                dd = rs.getString("sourcedate").substring(6, 8);
//                hh = rs.getString("sourcedate").substring(8, 10);
//                mi = rs.getString("sourcedate").substring(10, 12);
//                ss = rs.getString("sourcedate").substring(12, 14);
//                out.println(dd + "-" + mm + "-" + yy + " " + hh + ":" + mi + ":" + ss);
                out.println(rs.getString("sourcedate"));
            }
            %></td>


        <td>
            <%
                if (rs.getString("graphicspath") != null) {
//        if (!rs.getString("vdopath").isEmpty()) {
//                                                                                    imag = rs.getString("vdopath").split(",");
//                                                                                    for (int j = 0; j < imag.length; j++) {%>
            <%--<a href="<%=imag[j]%>" target="_blank" ><span class="fa fa-play-circle"></span></a>--%>
            <a href="imagegrid_homepage.jsp?searchresult=<%=rs.getString("workcode")%>"  target="_blank" title="Click Here"><span class="fa fa-image"></span></a>

            <%           }
//                                                                                    }
            %> 
        </td>
        <td>
            <%
                if (rs.getString("vdopath") != null) {
//        if (!rs.getString("vdopath").isEmpty()) {
//                                                                                    imag = rs.getString("vdopath").split(",");
//                                                                                    for (int j = 0; j < imag.length; j++) {%>
            <%--<a href="<%=imag[j]%>" target="_blank" ><span class="fa fa-play-circle"></span></a>--%>
            <a href="javascript:displayVdoFiles('<%=rs.getString("workcode")%>')" onclick="displayVdoFiles('<%=rs.getString("workcode")%>')" target="_blank" title="Click Here"><span class="fa fa-video-camera"></span></a>
                <%--<a href="videogrid_homepage.jsp?searchresult=<%=rs.getString("workcode")%>" onclick="displayVdoFiles('<%=rs.getString("workcode")%>')" target="_blank" title="Click Here"><span class="fa fa-video-camera"></span></a>--%>

            <%           }
//                                                                                    }
            %> 
        </td>

        <td>
            <%
                String link[];
                if (rs.getString("link") != null) {
                    link = rs.getString("link").split(",");
                    for (int i = 0; i < link.length; i++) {
            %>
            <!--out.println(rs.getString("vlink"));-->
            <a target="_blank" href="<%=link[i]%>"><%=link[i]%></a>
            <%}
                }%>

        </td>

    </tr>
    <%}

    %>
    <tr>
        <td colspan="19" class="text-center">
            <%                if (number == 0) {%>
            <span class="text-danger ">Record not found for this query</span>
            <!--out.println("Record not found for this query");-->
            <%  }%></td>
    </tr>
</tbody>
</table>

<%
//   buffer=buffer+rs.getString("subject")+"<br>"; 

// buffer=buffer+"</div>";  
// response.getWriter().println(buffer);  
    } else {
        response.sendRedirect("login.jsp");
    }

%>
