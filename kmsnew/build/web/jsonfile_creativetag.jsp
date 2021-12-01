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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!  public static String removeWord(String string, String word) 
    { 
  
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
    } %>
<%
   try{
       Set<String> al = new HashSet<String>();
   
// System.out.println("data:-"+request.getParameter("data"));
   
    try {
        ConnectionDB ds = new ConnectionDB();

        Connection conn = ds.getConnection();
        Statement stmt = conn.createStatement();
        
        String description=request.getParameter("description");
        
//        int i = description.indexOf(' ');
//String word = description.substring(0, i);
//        String splitKeyword[]=description.split(" ");
//        for(int i=0;i<=splitKeyword.length;i++){
        String lastWord = description.substring(description.lastIndexOf(" ")+1);
//        String firstWord =splitKeyword[0];
        
        
        String removeLastwordfromString=removeWord(description,lastWord);
        
//        System.out.println("firstWord:-"+word);
        System.out.println("removeLastwordfromString:-"+removeLastwordfromString);
        if(!lastWord.isEmpty()){
        
       
        
        String sql = "select tag from tbl_tag_master where tag like '%"+lastWord+"%'";
//        String sql = "select tag from tbl_tag_master where tag like '%"+splitKeyword[i]+"%'";
//      String sql="select subject,districttag,talukatag,villagetag,additionaltag,teletag from tbl_news_dataentry ";
        System.out.println("sql:-" + sql);
        ResultSet rs = stmt.executeQuery(sql);
        al.add(removeLastwordfromString);
        while (rs.next()) {
//            if(removeLastwordfromString.equals(rs.getString(1))){
//            System.out.println(rs.getString("tag"));
//            al.add(rs.getString("tag"));
//            al.add(removeLastwordfromString);
            al.add(rs.getString("tag"));
//            al.a
//        }
//       al.add(rs.getString("districttag"));
//       al.add(rs.getString("talukatag"));
//       al.add(rs.getString("villagetag"));
//       al.add(rs.getString("additionaltag"));
//       al.add(rs.getString("teletag"));
        }
//         al.add(removeLastwordfromString+" "+rs.getString("tag"));
        rs.close();
        stmt.close();
        conn.close();
         }else{
        al.add(description);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
//    System.out.println("lsit:-"+al);
    JSONArray json = new JSONArray(al);
    response.setContentType("application/json");
    response.getWriter().print(json);
}catch(ArrayIndexOutOfBoundsException ex){
ex.printStackTrace();
}
%>