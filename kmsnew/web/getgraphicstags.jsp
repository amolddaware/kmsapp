<%-- 
    Document   : gettags
    Created on : Dec 8, 2017, 12:28:02 PM
    Author     : Amol
--%>

<%@page import="java.util.LinkedHashSet"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% if (session != null && session.getAttribute("username") != null && session.getAttribute("role").equals("3")) {
        String username = session.getAttribute("username").toString();
        String userid = session.getAttribute("userid").toString();

//        String token = session.getAttribute("csrfToken").toString();
//System.out.println(token);
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setDateHeader("Expires", 0);
        response.addHeader("X-Frame-Options", "DENY");
        String selectUserid = "";
//    String userid = session.getAttribute("userid").toString();
//    System.out.println("workcode:-");
//    String workcode = request.getParameter("workcode");
//    String workcode = session.getAttribute("workcode").toString();
//      System.out.println("workcode:-"+workcode);
        String maxid = session.getAttribute("maxid").toString();

        Connection dh = null;
        String logintime = "";
        ConnectionDB conn = new ConnectionDB();
        dh = conn.getConnection();
        PreparedStatement pstmtTag = null;
        ResultSet rsTag = null;
        String getString[];
        String fulltext = "";
        String fullString = "";
        StringBuilder str = new StringBuilder();
        String str1 = "";
        String str2 = "";
        String fullData = "";
        String person[];
        String fulldbtext[];
        String dist = "";
        String tal = "";
        String vil = "";
        String fulldata = "";
        String schemtag = "", desigtag = "", depttag = "";
        String table = "tbl_graphics_dataentry";
        try {
            try {

//            selectUserid = "select * from " + table + " where userid=? and workcode=? ";
//            System.out.println(selectUserid);
                selectUserid = "select * from " + table + " where userid=? and iddataentry=? ";
//                                                                    System.out.println("selectdist:-" + dist);
                pstmtTag = dh.prepareStatement(selectUserid);
                pstmtTag.setString(1, userid);
                pstmtTag.setString(2, maxid);

            //                                                                                                pstmtDist.setString(1, dist);
                //                                        pstmtTal.setString(2, tal);
                rsTag = pstmtTag.executeQuery();
                String subject = "", persontag = "", tele = "", redio = "", web = "", reporter = "", print = "";
                if (rsTag.next()) {
                    subject = rsTag.getString("subject");

                    fullString = subject ;
                    fulltext = rsTag.getString("subject") + " " + rsTag.getString("description") + " " + rsTag.getString("summary");
                    fulldata = fullString + " " + fulltext;
                }

            } catch (Exception e) {
                System.out.println("Excecption in select data try catch block:-" + e.getMessage());
            }
            String genralTag = "";
            try {

                String selectQuery = "";
//            if (table.equals("dataentry_marathi")) {
//                selectQuery = "select tag_marathi from tbl_tag_master where tag_marathi is not null";
//
//            } else {
                selectQuery = "select tag from tbl_tag_master WHERE INSTR('" + fulltext + "',tag )<>0";
//            }
//            String selectQuery = "select tag from tbl_tag_master";
                PreparedStatement pstmt = dh.prepareStatement(selectQuery);
                ResultSet rs = pstmt.executeQuery();

                while (rs.next()) {
                    if (fulltext.contains(rs.getString(1))) {
                        genralTag = genralTag + rs.getString(1) + ",";
                    } else {
                        genralTag = "";
                    }
                }
                if (genralTag != null) {
                    genralTag = genralTag.substring(0, genralTag.length() - 1);
                }
                System.out.println("genralTag:-" + genralTag);
            } catch (Exception e) {
                System.out.println("Exception in tag master try catch block:-" + e.getMessage());
            }
//        String replaceString=fullString.replace("null","-");
//        String fullscheme=schemtag+
            
            out.println(fullString.trim() + ":" + genralTag.trim() );
            System.out.println(fullString + ":" + genralTag );
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Exception in getgraphicstags try catch block:-" + e.getMessage());

        } finally {
        // pstmtDist.close();
            // rsDist.close();

        }
    } else {
        response.sendRedirect("login.jsp");
    }
%>
<%!public String deDup(String s) {
        return new LinkedHashSet<String>(Arrays.asList(s.split(" "))).toString().replaceAll("(^\\[|\\]$)", "").replace(", ", " ");
    }
%>