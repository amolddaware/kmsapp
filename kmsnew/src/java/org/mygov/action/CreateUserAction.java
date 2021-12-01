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
//i/mport org.mygov.handler.MailGov;
import org.mygov.handler.RandomStringGenerator;
import org.mygov.handler.SendMailGov;
import org.mygov.handler.SendMailGov_old;

/**
 *
 * @author Amol
 */
public class CreateUserAction extends org.apache.struts.action.Action {

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

        System.out.println("Storedtoken:-" + storedToken);
        System.out.println("token:-" + token);
        String role = session.getAttribute("role").toString();
        String emailid = request.getParameter("emailid").trim();
        String name = request.getParameter("name").trim();
        String mobile = request.getParameter("mobile").trim();
        String userrole = request.getParameter("role").trim();
        DateTimeUTC dtime = new DateTimeUTC();
        final String date = dtime.GetUTCdatetimeAsString();
        String ipAddress = request.getHeader("X-FORWARDED-FOR");
        if (ipAddress == null) {
            ipAddress = request.getRemoteAddr();
        }
        RandomStringGenerator random = new RandomStringGenerator();
        String password = random.getRandomPassword(8);

        //do check
        if (storedToken.equals(token)) {
            //go ahead and process ... do business logic here
            Connection dh = null;

            try {
                ConnectionDB conn = new ConnectionDB();
                dh = conn.getConnection();
                try {
                    PreparedStatement pstmtSelect = null, pstmtInsert = null;
                    ResultSet rsSelect = null;
                    String selectquery = "select * from createuser where emailid=?  ";
                    pstmtSelect = dh.prepareStatement(selectquery);
                    pstmtSelect.setString(1, emailid);
//                pstmtSelect.setString(2, pass);
//                    pstmtSelect.setString(2, password);
                    rsSelect = pstmtSelect.executeQuery();
                    if (rsSelect.next()) {
                        response.sendRedirect("createuser.jsp?allready&db_user=" + emailid);
//                            response.sendRedirect("mrsac_admin_userreg.jsp?allready&db_user="+username);

                    } else {

                        String inserquery = "insert into createuser (name,emailid,mobileno,createdby,password,status,role,datetime,ipaddress) "
                                + "values(?,?,?,?,?,?,?,?,?)";
                        pstmtInsert = dh.prepareStatement(inserquery);
                        pstmtInsert.setString(1, name);
                        pstmtInsert.setString(2, emailid);
                        pstmtInsert.setString(3, mobile);
                        pstmtInsert.setString(4, role);
                        pstmtInsert.setString(5, password);
                        pstmtInsert.setInt(6, 0);
                        pstmtInsert.setString(7, userrole);
                        pstmtInsert.setString(8, date);
                        pstmtInsert.setString(9, ipAddress);
                        pstmtInsert.executeUpdate();
                        
                        SendMailGov.SendLocal(emailid, name,password);

                        response.sendRedirect("createuser.jsp?user=" + emailid + "&success");
//                response.sendRedirect("mrsac_admin_home.jsp?user="+username+"&admin_home");
                    }
                } catch (Exception e) {
                    System.out.println("Exception in try catch block:-" + e.getMessage());
                }
            } catch (Exception e) {
                System.out.println("Exception in create user action try cathc block:-" + e.getMessage());
            } finally {
                if(dh!=null){
                dh.close();
            }
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
