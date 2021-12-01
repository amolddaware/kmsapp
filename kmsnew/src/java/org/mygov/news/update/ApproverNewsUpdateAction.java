/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.mygov.news.update;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
public class ApproverNewsUpdateAction extends org.apache.struts.action.Action {

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
                String subject = null, desc = null,importance=null, hour = null, minute = null, ampm = null, timestamp = null, additional = null, summary = null, sourcedate, criticality = null, sentiment = null, tempvideo = null, channel = null;
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
             
                if (request.getParameter("criticality") != null) {
                    criticality = request.getParameter("criticality").trim();
                } else {
                    criticality = null;
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
                if (request.getParameter("importance") != "") {
                    importance = request.getParameter("importance").trim();
                } else {
                    importance = null;
                }
//                
                final String date1 = dtime.getCurrentDate();
                String chname = "";
//            String datetime[]=vpath.split("_");
                try {
                    String workcode = request.getParameter("workcode").trim();

                    String dd = "", tablename = "", mm = "", yy = "", tdd = "", tmm = "", tyy = "", hh = "", mi = "", ss = "", fullSourceDate = "";
                    tablename = "tbl_news_dataentry";

                    String updateData = "update tbl_news_dataentry set subject=?,description=?,link=?, "
                            + "criticality=?,sentiment=?,timestamp=?,chname=?,additionaltag=?,sourcedate=?,importance=? where workcode=? ";
                    PreparedStatement pstmtupData = ConnectionDB.getDBConnection().prepareStatement(updateData);
                    pstmtupData.setString(1, subject);
                    pstmtupData.setString(2, desc);
                    pstmtupData.setString(3, link);
                    pstmtupData.setString(4, criticality);
                    pstmtupData.setString(5, sentiment);
                    pstmtupData.setString(6, timestamp);
                    pstmtupData.setString(7, channel);
                    pstmtupData.setString(8, additional);
                    pstmtupData.setString(9, sourcedate);
                    pstmtupData.setString(10, importance);
                    pstmtupData.setString(11, workcode);
                    pstmtupData.executeUpdate();
                    if (pstmtupData.executeUpdate() > 0) {
//                        if (request.getParameter("additional") != "") {
//                     response.sendRedirect("text_news_approver_dataentry_edit.jsp?workcode=" + workcode + "&success");
//                   
//                } else {
                     response.sendRedirect("em_newsedit.jsp?workcode=" + workcode + "&success");
                   
//                }
                       } else {
//                            out.println("Record not found");
                        response.sendRedirect("error.jsp#upload?success");
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
