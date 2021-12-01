/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.mygov.action;

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
import org.mygov.handler.RandomStringGenerator;
import org.mygov.handler.SendMailGov_old;

/**
 *
 * @author Amol
 */
public class ChangePasswordAction extends org.apache.struts.action.Action {

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

        HttpSession session = request.getSession();
        String storedToken = (String) session.getAttribute("csrfToken");
        String token = request.getParameter("token");
        String userid = session.getAttribute("userid").toString();

        String role = session.getAttribute("role").toString();
        String password = request.getParameter("password").trim();
        String cpassword = request.getParameter("cpassword").trim();
        DateTimeUTC dtime = new DateTimeUTC();
        final String date = dtime.GetUTCdatetimeAsString();
        String ipAddress = request.getHeader("X-FORWARDED-FOR");
        if (ipAddress == null) {
            ipAddress = request.getRemoteAddr();
        }
        //do check
        if (storedToken.equals(token)) {
            //go ahead and process ... do business logic here
            Connection dh = null;

            try {
                ConnectionDB conn = new ConnectionDB();
                dh = conn.getConnection();
                try {
                    PreparedStatement pstmtSelect = null, pstmtInsert = null, pstmtUpdate = null;
                    ResultSet rsSelect = null;

                    String selectPass = "select password from createuser where userid=?";
                    pstmtSelect = dh.prepareStatement(selectPass);
                    pstmtSelect.setString(1, userid);
                    rsSelect = pstmtSelect.executeQuery();
                    if (rsSelect.next()) {

                        String inserquery = "insert into changepassword_histroy (userid,useroldpass,datetime,ipaddress) "
                                + "values(?,?,?,?)";
                        pstmtInsert = dh.prepareStatement(inserquery);
                        pstmtInsert.setString(1, userid);
                        pstmtInsert.setString(2, rsSelect.getString("password"));
                        pstmtInsert.setString(3, date);
                        pstmtInsert.setString(4, ipAddress);
                        if (pstmtInsert.executeUpdate() > 0) {
                            String updatequery = "update createuser set password=? , status=? where userid=? ";
                            pstmtUpdate = dh.prepareStatement(updatequery);
                            pstmtUpdate.setString(1, password);
                            pstmtUpdate.setInt(2, 1);
                            pstmtUpdate.setString(3, userid);
                            pstmtUpdate.executeUpdate();
                            response.sendRedirect("userHome.jsp");

                        }
                    } else {
                        response.sendRedirect("changepassword.jsp");
                    }
//                        SendMailGov_old.SendLocal(emailid, name,password);

//                response.sendRedirect("mrsac_admin_home.jsp?user="+username+"&admin_home");
                } catch (Exception e) {
                    System.out.println("Exception in try catch block:-" + e.getMessage());
                }
            } catch (Exception e) {
                System.out.println("Exception in create user action try cathc block:-" + e.getMessage());
            } finally {
                if(dh!=null){
                dh.close();}
            }
        } else {

            response.sendRedirect("csrfAttack.html");
//   session.invalidate();
//            session.removeAttribute("username");
            //DO NOT PROCESS ... this is to be considered a CSRF attack - handle appropriately
        }

        return mapping.findForward(SUCCESS);
    }
}
