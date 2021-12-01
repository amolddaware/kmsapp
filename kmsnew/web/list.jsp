<%-- 
    Document   : list
    Created on : Sep 17, 2018, 1:19:52 PM
    Author     : Amol
--%>

<%@page import="mrsac.db.connection.ConnectionDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<%
    Statement st = null;
    ResultSet rs = null;
    Connection con = null;
    try {
        String s[] = null;
//        ConnectionDB conn = new ConnectionDB();
//        con = conn.getConnection();
        Class.forName("com.mysql.jdbc.Driver");
         con = DriverManager.getConnection("jdbc:mysql://192.168.0.202:3306/kms", "root", "pass@123");
//         con = DriverManager.getConnection("jdbc:mysql://localhost:3310/kms", "root", "pass@123");
        String query = (String) request.getParameter("q");
        st = con.createStatement();
        String sql = "select * from tbl_news_dataentry where subject like '%" + query + "%' or description like '%" + query + "%' or summary like '%" + query + "%'or (general like '%" + query + "%' and general is not null)"
                + " or (districttag like '%" + query + "%' and districttag is not null) or (talukatag like '%" + query + "%' and talukatag is not null)  or (villagetag like '%" + query + "%' and villagetag is not null)"
                + "or (teletag like '%" + query + "%' and teletag is not null)   or (additionaltag like '%" + query + "%' and  additionaltag is not null) ";
        rs = st.executeQuery(sql);
        System.out.println("sqltes:-" + sql);
//        List li = new ArrayList();
//       
        Set<String> li = new HashSet<String>();
        String sub = null;
        try {
            while (rs.next()) {

                //sub=sub+" "+rs.getString("subject")+" "+rs.getString("general")+" "+rs.getString("teletag")+" "+rs.getString("districttag")+" "+rs.getString("talukatag")+" "+rs.getString("villagetag")+" "+rs.getString("additionaltag");
                li.add(rs.getString("subject"));
                li.add(rs.getString("general"));
                li.add(rs.getString("teletag"));
                li.add(rs.getString("districttag"));
                li.add(rs.getString("talukatag"));
                li.add(rs.getString("villagetag"));
                li.add(rs.getString("additionaltag"));

            }
//            li.add(sub);
        } catch (NullPointerException e) {
            System.out.println("Exccepition in null pointer:-" + e.getMessage());
        }
//        li.remove("null");
        boolean isremoved = li.remove(null);

        System.out.println("Return value after remove: " + isremoved);
//         Set<String> hashSet = new HashSet<String>();
//        hashSet.add(li.toString());
        System.out.println(li);
//         System.out.print("Set output without the duplicates"); 

//        Set<String> tree_Set = new TreeSet<String>(li);
//        System.out.println(tree_Set);
        String[] str = new String[li.size()];
//        System.out.println(li);
        Iterator it = li.iterator();
//StringBuilder str11=new StringBuilder();

        String mystring = "";
        int i = 0;
        while (it.hasNext()) {

            String p = (String) it.next();
            if (p.toLowerCase().contains(query)) {
//            str[i]=p;
                mystring = mystring + p + ",";
//           mystring=mystring+" "+ str11.append(p);
                i++;
            }
        }
        System.out.println("plist:-" + mystring);
        String strBuild[] = mystring.split(",");
        //jQuery related start
        int cnt = 1;
        for (int j = 0; j < strBuild.length; j++) {
//            if (strBuild[j].toUpperCase().startsWith(query.toUpperCase())) {
            out.print(strBuild[j] + "\n");
            if (cnt >= 5)// 5=How many results have to show while we are typing(auto suggestions)
            {
                break;
            }

            cnt++;
//                continue;
//            }
        }
        //jQuery related end

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        rs.close();
        st.close();
        con.close();
    }
//www.java4s.com
%>