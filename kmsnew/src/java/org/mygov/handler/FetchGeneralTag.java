/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.mygov.handler;

/**
 *
 * @author Amol
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import mrsac.db.connection.ConnectionDB;

public class FetchGeneralTag {

    private int totalCountries;
//	private String data = "Afghanistan,	Albania, Zimbabwe";
    private List<String> countries;

    public FetchGeneralTag() throws ClassNotFoundException, SQLException {
        countries = new ArrayList<String>();
//		StringTokenizer st = new StringTokenizer(data, ",");
        Connection dh = null;
        ConnectionDB connectionDB = new ConnectionDB();
        dh = connectionDB.getConnection();
        String sql = "Select * from dataentry ";
        PreparedStatement stm = dh.prepareStatement(sql);

        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            countries.add(rs.getString("description"));
//            countries.add(rs.getString("subject"));
//            countries.add(rs.getString("summary"));
//            countries.add(rs.getString("person"));
//            countries.add(rs.getString("scheme"));
//            countries.add(rs.getString("dept"));
//            countries.add(rs.getString("designation"));
//   buffer=buffer+rs.getString("subject")+"<br>";  
        }
//		while(st.hasMoreTokens()) {
//			countries.add(st.nextToken().trim());
//		}
        totalCountries = countries.size();
    }

    public List<String> getData(String query) {
        String country = null;
        query = query.toLowerCase();
        List<String> matched = new ArrayList<String>();
        for (int i = 0; i < totalCountries; i++) {
            country = countries.get(i).toLowerCase();
            if (country.startsWith(query)) {
                matched.add(countries.get(i));
            }
        }
        return matched;
    }
}
