/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.mygov.graphics;

import java.sql.Connection;
import java.sql.PreparedStatement;
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
 * @author Amol
 */
public class GraphicsTagAction extends org.apache.struts.action.Action {

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
        HttpSession session = request.getSession(true);
//        System.out.println("hi");
//        String storedToken = (String) session.getAttribute("csrfToken");
//        String token = request.getParameter("token");

        String userid = session.getAttribute("userid").toString();
        String maxid = session.getAttribute("maxid").toString();
//        String table = session.getAttribute("language").toString();
//        String teletag = request.getParameter("teletag").trim();
//        String printtag = request.getParameter("printtag").trim();
//        String radiotag = request.getParameter("radiotag").trim();
//        String webtag = request.getParameter("webtag").trim();
        String table = "tbl_news_dataentry";
        String general = "", departmenttag = "", districttag = "", talukatag = "", villagetag = "", printtag = "", radiotag = "", webtag = "",
                sourcetag = "", schemetag = "", persontag = "", teletag = "", reportertag = "", designationtag = "", additional = "", programtag = "";

        if (request.getParameter("general") != "") {
            general = request.getParameter("general").trim();
        } else {
            general = "";
        }
        if (request.getParameter("additional") != "") {
            additional = request.getParameter("additional").trim();
        } else {
            additional = "";
        }

//        if (additional != null) {
//            additional = additional.substring(0, additional.length() - 1);
//        }
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
            String insertData = "update " + table + "  set general=?,tagdatetime=?,tagipaddress=?,additionaltag=? where iddataentry=? and userid=?";
            System.out.println("updataData:-" + insertData);
            PreparedStatement pstmtData = dh.prepareStatement(insertData);
            pstmtData.setString(1, general);
            pstmtData.setString(2, date);
            pstmtData.setString(3, ipAddress);
            pstmtData.setString(4, additional);
            pstmtData.setString(5, maxid);
            pstmtData.setString(6, userid);
            if (pstmtData.executeUpdate() > 0) {
//                response.sendRedirect(".jsp?success");
                response.sendRedirect("graphicstag.jsp#tags?success");
//                response.sendRedirect("userDataentry_1.jsp#tags?success");

            } else {
                response.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            System.out.println("Exception in Add Tag Action data :-" + e.getMessage());
        } finally {
            if (dh != null) {
                dh.close();

            }
        }
        return mapping.findForward(SUCCESS);
    }
}
