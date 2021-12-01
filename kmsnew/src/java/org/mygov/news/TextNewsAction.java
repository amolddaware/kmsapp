/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.mygov.news;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ResourceBundle;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mrsac.db.connection.ConnectionDB;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.mygov.handler.DateTimeUTC;

/**
 *
 * @author Fluidscapes
 */
public class TextNewsAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";

    /**
     * This is the action called from the Struts framework.
     *
     * @param mapping The ActionMapping used to select this instance.
     * @param form The optional ActionForm bean for this request.
     * @param request The HTTP Request we are processing.
     * @param response The HTTP Response we are processing.
     * @throws java.lang.Exception
     * @return
     */
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
           try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException ex) {
            System.out.println("ex:-" + ex.getMessage());
        }
        ResourceBundle rb = ResourceBundle.getBundle("msg");

        HttpSession session = request.getSession();
        String storedToken = (String) session.getAttribute("csrfToken");
        String token = request.getParameter("token");
        String userid = session.getAttribute("userid").toString();
        String username = session.getAttribute("username").toString();
//
        System.out.println("Storedtoken:-" + storedToken);
        System.out.println("token:-" + token);
//        //do check
        if (storedToken.equals(token)) {

            Connection dh = null;

            try {
//            PrintWriter out = response.getWriter();
                ConnectionDB conn = new ConnectionDB();
                dh = conn.getConnection();
//            System.out.println(request.getParameter("subject"));
                String ipAddress = request.getHeader("X-FORWARDED-FOR");
                if (ipAddress == null) {
                    ipAddress = request.getRemoteAddr();
                }
                DateTimeUTC dtime = new DateTimeUTC();
                final String date = dtime.GetUTCdatetimeAsString();
                String subject = null, desc = null, hour = null, minute = null, ampm = null, timestamp = null, additional = null, summary = null, sourcedate, titlemarathi = null, sentiment = null, tempvideo = null, channel = null;
                if (request.getParameter("subject") != null) {
                    subject = request.getParameter("subject").trim();
                } else {
                    subject = null;
                }
                if (request.getParameter("description") != null) {
                    desc = request.getParameter("description").trim();
                } else {
                    desc = null;
                }
              
                if (request.getParameter("titlemarathi") != null) {
                    titlemarathi = request.getParameter("titlemarathi").trim();
                } else {
                    titlemarathi = null;
                }
                if (request.getParameter("sentiment") != null) {
                    sentiment = request.getParameter("sentiment").trim();
                } else {
                    sentiment = null;
                }
                if (request.getParameter("sourcedate") != null) {
                    sourcedate = request.getParameter("sourcedate").trim();
                } else {
                    sourcedate = null;
                }
                if (request.getParameter("hour") != null) {
                    hour = request.getParameter("hour").trim();
                } else {
                    hour = null;
                }
                if (request.getParameter("minute") != null) {
                    minute = request.getParameter("minute").trim();
                } else {
                    minute = null;
                }
                if (request.getParameter("ampm") != null) {
                    ampm = request.getParameter("ampm").trim();
                } else {
                    ampm = null;
                }
                timestamp = hour + "." + minute + " " + ampm;
                if (request.getParameter("channel") != null) {
                    channel = request.getParameter("channel").trim();
                } else {
                    channel = null;
                }
                String link = null, ilink = "", dlink = "", textInput = "", str = "";
                String separatePath[];

                if (request.getParameter("link") != "") {
                    link = request.getParameter("link").trim();
                } else {
                    link = null;
                }
                if (request.getParameter("additional") != "") {
                    additional = request.getParameter("additional").trim();
                } else {
                    additional = null;
                }
//                
                final String date1 = dtime.getCurrentDate();
                String chname = "";
                String splitTag[];

//            String datetime[]=vpath.split("_");
                try {

                    String dd = "", tablename = "", mm = "", yy = "", tdd = "", tmm = "", tyy = "", hh = "", mi = "", ss = "", fullSourceDate = "";
                    tablename = "tbl_news_dataentry";

                    String code = "EN";

                    String insertData = "insert into " + tablename + "(userid,subject,description,sourcedate,datetime,link,chname,additionaltag,titlemarathi,sentiment,timestamp)"
                            //                    String insertData = "insert into " + tablename + "(userid,subject,description,summary,sourcedate,startdatetime,enddatetime,chname,link,datetime,titlemarathi,sentiment) "
                            + "values (?,?,?,?,?,?,?,?,?,?,?)";
                    PreparedStatement pstmtData = dh.prepareStatement(insertData);
                    System.out.println("insertdata:-" + insertData);
                    pstmtData.setString(1, userid);
                    pstmtData.setString(2, subject);
                    pstmtData.setString(3, desc);
                    pstmtData.setString(4, sourcedate);
                    pstmtData.setString(5, date);
                    pstmtData.setString(6, link);
                    pstmtData.setString(7, channel);
                    pstmtData.setString(8, additional);
                    pstmtData.setString(9, titlemarathi);
                    pstmtData.setString(10, sentiment);
                    pstmtData.setString(11, timestamp);
                    if (pstmtData.executeUpdate() > 0) {
                        String selectQuery = "select max(iddataentry) from " + tablename + " ";
                        PreparedStatement pstmt = dh.prepareStatement(selectQuery);
                        ResultSet rs = pstmt.executeQuery();
                        if (rs.next()) {

                            String updateData = "update " + tablename + " set workcode=? where iddataentry=?";
                            PreparedStatement pstmtup = dh.prepareStatement(updateData);
                            pstmtup.setString(1, code + rs.getInt(1));
                            pstmtup.setString(2, rs.getString(1));
                            pstmtup.executeUpdate();

                            System.out.println("max id:-" + rs.getString(1));
                            session.setAttribute("maxid", rs.getString(1));
                            String getData = "select workcode from " + tablename + " where iddataentry=(select max(iddataentry) from " + tablename + " where userid=?)";
                            PreparedStatement pstmt1 = dh.prepareStatement(getData);
                            pstmt1.setString(1, userid);
                            ResultSet rs1 = pstmt1.executeQuery();
                            String workcode = "";
                            if (rs1.next()) {
                                workcode = rs1.getString(1);
                                System.out.println("additional:-"+additional);
                                if (!additional.isEmpty()) {
                                    String strSplit = additional.replaceAll(" ", ",");
                                    splitTag = strSplit.split(",");
//                for(String data:splitTag){
                    System.out.println("data:-"+splitTag[0]);
                                    for (int i = 0; i < splitTag.length; i++) {
//                    System.out.println("splittt:-"+splitTag[i]);
//                    System.out.println("numbererere:-"+i);

                                        String selectQuery1 = "select tag from tbl_temp_tag_master where tag = ? and workcode=?";
                                        PreparedStatement pstmtQuery = dh.prepareStatement(selectQuery1);
                                        pstmtQuery.setString(1, splitTag[i].toLowerCase());
                                        pstmtQuery.setString(2, workcode);
                                        ResultSet rsQuery = pstmtQuery.executeQuery();
                                        if (rsQuery.next()) {
//                    String insertQuery = "insert into tbl_temp_tag_master (tag,datetime,ipaddress) values(?,?,?)";
//                    PreparedStatement pstmt = dh.prepareStatement(insertQuery);
//                    pstmt.setString(1, splitTag[i]);
//                    pstmt.setString(2, DateTimeUTC.GetUTCdatetimeAsString());
//                    pstmt.setString(3, ipAddress);
//                    pstmt.executeUpdate();
                                        } else {
                                            String insertQuery = "insert into tbl_temp_tag_master (tag,datetime,ipaddress,workcode) values(?,?,?,?)";
                                            PreparedStatement pstmt2 = dh.prepareStatement(insertQuery);
                                            pstmt2.setString(1, splitTag[i]);
                                            pstmt2.setString(2, DateTimeUTC.GetUTCdatetimeAsString());
                                            pstmt2.setString(3, ipAddress);
                                            pstmt2.setString(4, workcode);
                                            pstmt2.executeUpdate();
//                     response.sendRedirect("error.jsp");
                                        }
                                    }
                                }
//                            session.setAttribute("table", table);
                                response.sendRedirect("em_newsadd.jsp?workcode=" + workcode + "&success");
                            } else {
//                            out.println("Record not found");
                                response.sendRedirect("error.jsp#upload?success");
                            }
                        } else {
                            response.sendRedirect("error.jsp#upload?success");

                        }
                    }
                } catch (Exception e) {
                    System.out.println("Exception in insert data :-" + e.getMessage());
                }

            } catch (Exception e) {
                System.out.println("Exception in insert data :-" + e.getMessage());
            } finally {
                if (dh != null) {
                    dh.close();
                }
            }
        }

        return mapping.findForward(SUCCESS);
    }
}
