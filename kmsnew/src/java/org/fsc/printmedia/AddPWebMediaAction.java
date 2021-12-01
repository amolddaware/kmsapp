/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.fsc.printmedia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
public class AddPWebMediaAction extends org.apache.struts.action.Action {

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
         request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String storedToken = (String) session.getAttribute("csrfToken");
        String token = request.getParameter("token");
//        ResourceBundle rb = ResourceBundle.getBundle("msg");

//        String rbPath = rb.getString("filePathPrintMedia");
//        request.getParameter("token");
        String userid = session.getAttribute("userid").toString();

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

            final String newDateTime = dtime.getNewCurrentDateTime();
//                        DataentryActionForm dataentry = (DataentryActionForm) form;
            String subject = null;
            String link = null;
//            System.out.println(subject);
            String sourcedate = null;
            String webmedianame = null;
            String language = null;
            String district = null;
            String edition = null;
            String subedition = null;
            String title = null;
            String sentiment = null;
            String tags = null, titlemarathi = null;

//              String subject = null, desc = null, summary = null, tags = null, sourcedate, criticality = null, sentiment = null, tempvideo = null;
            if (request.getParameter("sourcedate") != null) {
                sourcedate = request.getParameter("sourcedate").trim();
            } else {
                sourcedate = null;
            }
            if (request.getParameter("language") != null) {
                language = request.getParameter("language").trim();
            } else {
                language = null;
            }
            if (request.getParameter("webmedianame") != null) {
                webmedianame = request.getParameter("webmedianame").trim();
            } else {
                webmedianame = null;
            }
            if (request.getParameter("district") != null) {
                district = request.getParameter("district").trim();
            } else {
                district = null;
            }
            if (request.getParameter("subject") != null) {
                subject = request.getParameter("subject").trim();
            } else {
                subject = null;
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
            if (request.getParameter("tags") != null) {
                tags = request.getParameter("tags").trim();
            } else {
                tags = null;
            }
            if (request.getParameter("link") != null) {
                link = request.getParameter("link").trim();
            } else {
                link = null;
            }
            String insertData = "insert into tbl_news_dataentry(userid,language,npname,district,"
                    + "subject,titlemarathi,sentiment,sourcedate,additionaltag,datetime,ipaddress,link)"
                    + " values(?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pstmtData = dh.prepareStatement(insertData);
            pstmtData.setString(1, userid);
            pstmtData.setString(2, language);
            pstmtData.setString(3, webmedianame);
            pstmtData.setString(4, district);
            pstmtData.setString(5, subject);
            pstmtData.setString(6, titlemarathi);
            pstmtData.setString(7, sentiment);
            pstmtData.setString(8, sourcedate);
            pstmtData.setString(9, tags);
            pstmtData.setString(10, date);
            pstmtData.setString(11, ipAddress);
            pstmtData.setString(12, link);
            if (pstmtData.executeUpdate() > 0) {
                String code = "W";

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
                        String getData = "select workcode from tbl_news_dataentry where iddataentry=(select max(iddataentry) from tbl_news_dataentry where userid=?)";
                        PreparedStatement pstmt1 = dh.prepareStatement(getData);
                        pstmt1.setString(1, userid);
                        ResultSet rs1 = pstmt1.executeQuery();
                        String workcode = "";
                        if (rs1.next()) {
                            workcode = rs1.getString(1);
                        }

                        response.sendRedirect("pr_webadd.jsp?workcode=" + workcode + "&success");
                    } else {
                        response.sendRedirect("error.jsp");
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Exception in insert data :-" + e.getMessage());
        } finally {
            if (dh != null) {
                dh.close();

            }
        }
        }else{
        response.sendRedirect("csrf.html");
        }
        return mapping.findForward(SUCCESS);
    }
}
