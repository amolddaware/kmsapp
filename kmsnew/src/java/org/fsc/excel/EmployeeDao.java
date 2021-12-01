/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.fsc.excel;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

/**
 *
 * @author Fluidscapes
 */
public class EmployeeDao {
    
    public void InsertRowInDB(int empId, String firstName, String lastName, String emailId) {

//        Float salaryDB = Float.parseFloat(salary);
        try {

            Properties properties = new Properties();
            properties.setProperty("user", "root");
            properties.setProperty("password", "pass@123");
            properties.setProperty("useSSL", "false");
            properties.setProperty("autoReconnect", "true");

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/springappdb", properties);
            Statement stmt = connect.createStatement();
            PreparedStatement ps = null;
            String sql = "INSERT INTO employees "
                    + "(`emp_id`,\n"
                    + "`first_name`,\n"
                    + "`last_name`,\n"
                    + "`email_address`)\n"
                    + "VALUES(?,?,?,?)";
            ps = connect.prepareStatement(sql);
            ps.setInt(1, empId);
            ps.setString(2, firstName);
            ps.setString(3, lastName);
            ps.setString(4, emailId);
            ps.executeUpdate();
            connect.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
