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

<% if (session != null && session.getAttribute("username") != null ) {
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
        String table = "tbl_news_dataentry";
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

                    fullString = subject+":"+rsTag.getString("chname") ;
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
          

            String districtTag = "";
            String districtTag1 = "";
            String fulldist = "";
            try {
                String selectDistrict = "";
                selectDistrict = "select dtname11 from village_master WHERE INSTR('" + fulltext + "',dtname11 )<>0  group by dtname11 ";
                System.out.println("selctDist:-" + selectDistrict);
                PreparedStatement pstmtDistrict = dh.prepareStatement(selectDistrict);
                ResultSet rsDistrict = pstmtDistrict.executeQuery();
                String strDistrict = "";
                while (rsDistrict.next()) {
                    System.out.println("dist:-" + rsDistrict.getString(1));
                    if (!dist.equals(rsDistrict.getString(1))) {

                        districtTag = districtTag + "'" + rsDistrict.getString(1) + "', ";
                        districtTag1 = districtTag1 + rsDistrict.getString(1) + ", ";
                    }
                }
                if (districtTag != "") {
//                text.substring(0, text.length() - 1)
                    districtTag = districtTag.substring(0, districtTag.length() - 2);
                    System.out.println("fulldist :-" + fulldist);
                    districtTag1 = districtTag1.substring(0, districtTag1.length() - 2);
                }
                System.out.println("districtTag :-" + districtTag);
                System.out.println("districtTag :-" + districtTag1);
            } catch (Exception e) {
                System.out.println("Exception in districtTag try catch block:-" + e.getMessage());
            }
            String talukaTag = "";
            String talukaTag1 = "";
            String villageTag = "";
//        districtTag=dist;
            if (districtTag != "") {
                try {
                    String selectTaluka = "";
                    selectTaluka = "select thname11 from village_master where dtname11 in(" + districtTag + ") and INSTR('" + fulltext + "',thname11 )<>0  group by thname11 ";
                    System.out.println("selectTaluka:-" + selectTaluka);
                    PreparedStatement pstmtTaluka = dh.prepareStatement(selectTaluka);
                    ResultSet rsTaluka = pstmtTaluka.executeQuery();
                    while (rsTaluka.next()) {
//                    System.out.println("rataluka:-" + rsTaluka.getString(1));
                        if (!tal.equals(rsTaluka.getString(1))) {
                            talukaTag = talukaTag + "'" + rsTaluka.getString(1) + "'" + ",";
                            talukaTag1 = talukaTag1 + rsTaluka.getString(1) + ",";
                        }
                    }
                    if (talukaTag != "") {
                        talukaTag = talukaTag.substring(0, talukaTag.length() - 1);
                        talukaTag1 = talukaTag1.substring(0, talukaTag1.length() - 1);
                    }
                    System.out.println("talukaTag :-" + talukaTag);

                } catch (Exception e) {
                    System.out.println("Exception in talukaTag try catch block:-" + e.getMessage());
                }

                if (talukaTag != null) {
                    try {
                        String selectVillage = "";
                        selectVillage = "select vlname11 from village_master where thname11 in (" + talukaTag + ") and INSTR('" + fulltext + "',vlname11 )<>0 group by vlname11 ";
                        System.out.println("selectvillage:-" + selectVillage);
                        PreparedStatement pstmtVillage = dh.prepareStatement(selectVillage);
                        ResultSet rsVillage = pstmtVillage.executeQuery();
                        while (rsVillage.next()) {
//                        System.out.println("village-" + rsVillage.getString(1));
                            if (!vil.equals(rsVillage.getString(1))) {
                                villageTag = villageTag + rsVillage.getString(1) + ",";
//                            System.out.println("vig :-" + villageTag);
                            }
                        }
                        if (villageTag != "") {
                            villageTag = villageTag.substring(0, villageTag.length() - 1);
                        }
                        System.out.println("villageTag :-" + villageTag);
                    } catch (Exception e) {
                        System.out.println("Exception in VillageTag try catch block:-" + e.getMessage());
                    }
                }
            }
//        String replaceString=fullString.replace("null","-");
//        String fullscheme=schemtag+
            
            out.println(fullString.trim() + ":" + genralTag.trim() +":" + districtTag1.trim() + ":" + talukaTag1.trim() + ":" + villageTag.trim());
            System.out.println(fullString + ":" + genralTag + ":" + districtTag1 + ":" + talukaTag1 + ":" + villageTag);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Exception in gettags try catch block:-" + e.getMessage());

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