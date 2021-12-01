<%-- 
    Document   : jsonfile
    Created on : Sep 18, 2018, 4:44:31 PM
    Author     : Amol
--%>

<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONArray"%>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
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
        request.setCharacterEncoding("UTF-8");
        System.out.println("data:-" + request.getParameter("description"));
        try {
            ConnectionDB ds = new ConnectionDB();

            Connection conn = ds.getConnection();
            Statement stmt = conn.createStatement();

            String description = request.getParameter("description");

//        String splitKeyword[]=description.split(" ");
//        for(int i=0;i<=splitKeyword.length;i++){
            String lastWord = description.substring(description.lastIndexOf(" ") + 1);

            String removeLastwordfromString = removeWord(description, lastWord);

//            System.out.println("removeLastwordfromString:-" + removeLastwordfromString);
            if (!lastWord.isEmpty()) {

                String sql = "select subject from tbl_printmedia_dataentry where subject like '%" + lastWord + "%'  ";
//        String sql = "select tag from tbl_tag_master where tag like '%"+lastWord+"%'";
//        String sql = "select tag from tbl_tag_master where tag like '%"+splitKeyword[i]+"%'";
//      String sql="select subject,districttag,talukatag,villagetag,additionaltag,teletag from tbl_news_dataentry ";
//                System.out.println("sql:-" + sql);
                ResultSet rs = stmt.executeQuery(sql);
                while (rs.next()) {
//            if(removeLastwordfromString.equals(rs.getString(1))){
//            System.out.println(rs.getString("tag"));
                    al.add(rs.getString("subject"));
//                    al.add(rs.getString("additionaltag"));
//            al.add(removeLastwordfromString+" "+rs.getString("tag"));
//        }
                }
//         al.add(removeLastwordfromString+" "+rs.getString("tag"));
                rs.close();
                stmt.close();
                conn.close();
            } else {
                al.add(description);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("lsit:-" + al);
        JSONArray json = new JSONArray(al);
//        response.setContentType("application/json");
        response.getWriter().print(json);
    } catch (ArrayIndexOutOfBoundsException ex) {
        ex.printStackTrace();
    }
%>