<%-- 
    Document   : jsonfile
    Created on : Sep 18, 2018, 4:44:31 PM
    Author     : Amol
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONArray"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!  public static String removeWord(String string, String word) {

        // Check if the word is present in string 
        // If found, remove it using removeAll() 
        if (string.contains(word)) {

            // To cover the case 
            // if the word is at the 
            // beginning of the string 
            // or anywhere in the middle 
            String tempWord = word + " ";
            string = string.replaceAll(tempWord, "");

            // To cover the edge case 
            // if the word is at the 
            // end of the string 
            tempWord = " " + word;
            string = string.replaceAll(tempWord, "");
        }

        // Return the resultant string 
        return string;
    }%>
<%
    try {
        Set<String> al = new HashSet<String>();
 ConnectionDB ds = new ConnectionDB();

            Connection dh = ds.getConnection();
// System.out.println("data:-"+request.getParameter("data"));
        try {
           
            PreparedStatement pstmt = null;

            String description = request.getParameter("description");
            System.out.println("description:-" + description);
            String lastWord = description.substring(description.lastIndexOf(" ") + 1);

            String removeLastwordfromString = removeWord(description, lastWord);

            if (!lastWord.isEmpty()) {

//                String sql = "select subject from tbl_news_dataentry where subject like ?  ";
                String sql = "select subject from tbl_news_dataentry where subject like '%" + lastWord + "%' and workcode like '%P%' ";
//        String sql = "select tag from tbl_tag_master where tag like '%"+splitKeyword[i]+"%'";
//      String sql="select subject,districttag,talukatag,villagetag,additionaltag,teletag from tbl_news_dataentry ";
                System.out.println("sql:-" + sql);
                pstmt = dh.prepareStatement(sql);
//                pstmt.setString(1, "%P%");
                ResultSet rs = pstmt.executeQuery(sql);
                while (rs.next()) {
                    al.add(rs.getString("subject"));
                }
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (dh != null) {
                    dh.close();
                }

            } else {
                al.add(description);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    System.out.println("lsit:-"+al);
        JSONArray json = new JSONArray(al);
        response.setContentType("application/json");
        response.getWriter().print(json);
    } catch (ArrayIndexOutOfBoundsException ex) {
        ex.printStackTrace();
    }
%>