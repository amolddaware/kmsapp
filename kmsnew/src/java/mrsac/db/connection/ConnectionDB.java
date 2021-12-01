/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mrsac.db.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


/**
 *
 * @author mrsac1
 */
public class ConnectionDB {

    private static final String DBURL="jdbc:mysql://35.200.151.64:3306/kmsdb"+"?useSSL=false&&useUnicode=true&characterEncoding=UTF-8";
//    private static final String dbURL="jdbc:mysql://35.200.151.64:3306/kmsdb"+"?requireSSL=true&useSSL=true&&useUnicode=true&characterEncoding=UTF-8";;
//    private static final String dbURL="jdbc:mysql://192.168.0.202:3306/kmsdb"+"?requireSSL=false&useUnicode=true&characterEncoding=UTF-8";
//private static final String dbURL="jdbc:mysql://localhost:3306/kmsdb1"+"?requireSSL=false&useSSL=false&useUnicode=true&characterEncoding=UTF-8";
//    private static final String dbURL="jdbc:mysql://localhost:3306/kmsdb"+"?requireSSL=true&useSSL=true&useUnicode=true&characterEncoding=UTF-8";
    public static Connection getDBConnection() throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
//ResourceBundle bundle=ResourceBundle.getBundle("msg");
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
//        Class.forName("com.mysql.jdbc.Driver");
//        Connection con = DriverManager.getConnection("jdbc:mysql://node3050-env-5588280.mj.milesweb.cloud/kms", "root", "AKZkdn80447");
//        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/kmsdb"+"?requireSSL=false&useUnicode=true&characterEncoding=UTF-8", "root", "pass@123");
//        Connection con = DriverManager.getConnection(dbURL, "root", "faQVjMH3cEEu");
        Connection con = DriverManager.getConnection(DBURL, "root", "pass@123");
     return con;
    }
    public  Connection getConnectionDB() throws ClassNotFoundException, SQLException {
//ResourceBundle bundle=ResourceBundle.getBundle("msg");
        Class.forName("com.mysql.cj.jdbc.Driver");
//        Class.forName("com.mysql.jdbc.Driver");
//        Connection con = DriverManager.getConnection("jdbc:mysql://node3050-env-5588280.mj.milesweb.cloud/kms", "root", "AKZkdn80447");
//        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/kmsdb"+"?requireSSL=false&useUnicode=true&characterEncoding=UTF-8", "root", "pass@123");
//        Connection con = DriverManager.getConnection(dbURL, "root", "faQVjMH3cEEu");
        Connection con = DriverManager.getConnection(DBURL, "root", "pass@123");
     return con;
    }
    public  Connection getConnection() throws ClassNotFoundException, SQLException {
//ResourceBundle bundle=ResourceBundle.getBundle("msg");
        Class.forName("com.mysql.cj.jdbc.Driver");
//        Class.forName("com.mysql.jdbc.Driver");
//        Connection con = DriverManager.getConnection("jdbc:mysql://node3050-env-5588280.mj.milesweb.cloud/kms", "root", "AKZkdn80447");
//        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/kmsdb"+"?requireSSL=false&useUnicode=true&characterEncoding=UTF-8", "root", "pass@123");
//        Connection con = DriverManager.getConnection(dbURL, "root", "faQVjMH3cEEu");
        Connection con = DriverManager.getConnection(DBURL, "root", "pass@123");
     return con;
    }
}
