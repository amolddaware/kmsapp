/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.fsc.excel;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import javax.servlet.http.HttpServletResponse;
import mrsac.db.connection.ConnectionDB;

/**
 *
 * @author Fluidscapes
 */
public class TwitterPostDao {

    private boolean flag = false;

    public boolean InsertTwitterRowInDB(String source, String topic, String url, String post, String count, String sentiment, String userid,String sourcedate,String schedule,String date11,String ipAddress,String keyword) throws ClassNotFoundException, SQLException {

//        Float salaryDB = Float.parseFloat(salary);
        ConnectionDB conn = new ConnectionDB();
        Connection dh = null;

        try {
            dh = conn.getConnection();
//            Properties properties = new Properties();
//            properties.setProperty("user", "root");
//            properties.setProperty("password", "pass@123");
//            properties.setProperty("useSSL", "false");
//            properties.setProperty("autoReconnect", "true");

//            Class.forName("com.mysql.cj.jdbc.Driver");
//            Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/springappdb", properties);
//            Statement stmt = dh.createStatement();
            PreparedStatement ps = null;
            if (source != "") {
                String sql = "INSERT INTO tbl_news_dataentry "
                        + "(dm_source,subject,link,description,total_engagement,sentiment,userid,sourcedate,schedule,datetime,ipaddress,additionaltag)"
                        + "VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
//                String sql = "INSERT INTO tbl_twitter_post "
//                        + "(source,topic,url,post,count,sentiment,userid,sourcedate,schedule,datetime,ipaddress,tag)"
//                        + "VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
                ps = dh.prepareStatement(sql);
                ps.setString(1, source);
                ps.setString(2, topic);
                ps.setString(3, url);
                ps.setString(4, post);
                ps.setString(5, count);
                ps.setString(6, sentiment);
                ps.setString(7, userid);
                ps.setString(8, sourcedate);
                ps.setString(9, schedule);
                ps.setString(10, date11);
                ps.setString(11, ipAddress);
                ps.setString(12, keyword);
                if(ps.executeUpdate()>0){
                String code = "D";

                    String selectQuery = "select max(iddataentry) from tbl_news_dataentry where userid=? ";
                    PreparedStatement pstmt = dh.prepareStatement(selectQuery);
                    pstmt.setString(1, userid);
                    ResultSet rs = pstmt.executeQuery();
                    if (rs.next()) {

                        String updateData = "update tbl_news_dataentry set workcode=? where iddataentry=?";
                        PreparedStatement pstmtup = dh.prepareStatement(updateData);
                        pstmtup.setString(1, code + rs.getInt(1));
                        pstmtup.setString(2, rs.getString(1));
                        if (pstmtup.executeUpdate() > 0) {
//                            HttpServletResponse res=null;
//                            res.sendRedirect("dm_add.jsp?success");
                flag = true;
                        }else{
                        flag=false;
                        }
                       
                }
                }
            } else {
                System.out.println("error record not found");
                flag = false;
            }

        } catch (NullPointerException e) {
            e.printStackTrace();
        } catch (Exception e ) {
            e.printStackTrace();
        } finally {
            if (dh != null) {
                dh.close();
            }
        }
        return flag;
    }
}
