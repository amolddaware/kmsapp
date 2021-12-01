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

// System.out.println("data:-"+request.getParameter("data"));
        ConnectionDB ds = new ConnectionDB();

        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stmt = null;
        try {

            conn = ds.getConnection();

            String description = request.getParameter("description");

            String lastWord = description.substring(description.lastIndexOf(" ") + 1);
            String removeLastwordfromString = removeWord(description, lastWord);

            if (!lastWord.isEmpty()) {

                String sql = "select tag from tbl_tag_master where tag like '%" + lastWord + "%'";
                stmt = conn.prepareStatement(sql);
                rs = stmt.executeQuery();
                al.add(removeLastwordfromString);
                String text[] = null;
                while (rs.next()) {
                    al.add(rs.getString("tag"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
//    System.out.println("lsit:-"+al);
        JSONArray json = new JSONArray(al);
        response.setContentType("application/json");
        response.getWriter().print(json);
    } catch (ArrayIndexOutOfBoundsException ex) {
        ex.printStackTrace();
    }
%>