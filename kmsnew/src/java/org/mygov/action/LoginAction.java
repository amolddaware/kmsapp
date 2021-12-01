/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.mygov.action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Enumeration;
import java.util.Properties;
import java.util.Random;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mrsac.db.connection.ConnectionDB;
import org.apache.catalina.filters.CsrfPreventionFilter;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.mygov.handler.DateTimeUTC;

/**
 *
 * @author Fluidscapes
 */
public class LoginAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private final Random randomSource = new Random();
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
        
         String method = request.getMethod();
        System.out.println("method:-" + method);
//        RandomStringGenerator random = new RandomStringGenerator();

//        String genCaptcha = request.getParameter("genCaptchaCode");
//        String txtCaptcha = request.getParameter("txtcaptcha");
////        System.out.println("gencaptcha:-" + genCaptcha);
////        System.out.println("txtcaptcha:-" + txtCaptcha);
//
//        if (genCaptcha.equals(txtCaptcha)) {
//        String remoteAddr = request.getRemoteAddr();
//        ReCaptchaImpl reCaptcha = new ReCaptchaImpl();
//        reCaptcha.setPrivateKey("6LdlHOsSAAAAACe2WYaGCjU2sc95EZqCI9wLcLXY");
//
//        String challenge = request.getParameter("recaptcha_challenge_field");
//        String uresponse = request.getParameter("recaptcha_response_field");
//        ReCaptchaResponse reCaptchaResponse = reCaptcha.checkAnswer(remoteAddr, challenge, uresponse);
//
//        if (reCaptchaResponse.isValid()) {
//			String user = request.getParameter("user");
//			out.print("CAPTCHA Validation Success! User "+user+" registered.");
        if (method.equals("POST")) {
//                System.out.println("method11:-" + method);
//        doPost(request,response);
            Connection dh = null;
            try {

                CsrfPreventionFilter csrf = new CsrfPreventionFilter();
//                    UserActionForm user = (UserActionForm) form;
//                    final String username = user.getUsername();
//                    final String password = user.getPassword();
//        System.out.println("username:-"+username);
//        System.out.println("password:-"+password);
                try {
                    ConnectionDB conn = new ConnectionDB();

                    dh = conn.getConnection();
                } catch (Exception e) {
                    System.out.println("Exception in dataconncetion:-" + e.getMessage());
                }

                HttpSession oldSession = request.getSession();

                Enumeration attrNames = oldSession.getAttributeNames();
                Properties props = new Properties();

                if (attrNames != null) {
                    while (attrNames.hasMoreElements()) {
                        String key = (String) attrNames.nextElement();
                        props.put(key, oldSession.getAttribute(key));
                    }

                    //Invalidating previous newSession
                    oldSession.invalidate();
                    //Generate new newSession
                    HttpSession newSession = request.getSession(true);
                    attrNames = props.keys();

                    while (attrNames.hasMoreElements()) {
                        String key = (String) attrNames.nextElement();
                        newSession.setAttribute(key, props.get(key));
                    }

//        InetAddress ip;
//	  try {
//
//		ip = InetAddress.getLocalHost();
//		System.out.println("Current IP address : " + ip.getHostAddress());
//
//	  } catch (UnknownHostException e) {
//
//		e.e.printStackTrace();
//
//	  }
                    String brname = request.getParameter("browserName");
                    String brver = request.getParameter("fullVersion");
                    String osName = System.getProperty("os.name");

                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    DateTimeUTC dtime = new DateTimeUTC();
                    final String date = dtime.GetUTCdatetimeAsString();
                    String ipAddress = request.getHeader("X-FORWARDED-FOR");
                    if (ipAddress == null) {
                        ipAddress = request.getRemoteAddr();
                    }
//            
                    String selectUser = "select userid,name,role from createuser where emailid=? and password=? and status=?  ";
                    PreparedStatement pstmtUser = dh.prepareStatement(selectUser);
                    pstmtUser.setString(1, username);
                    pstmtUser.setString(2, password);
                    pstmtUser.setInt(3, 0);
                    ResultSet rsUser = pstmtUser.executeQuery();
                    if (rsUser.next()) {
                        newSession.setAttribute("userid", rsUser.getInt("userid"));
                        newSession.setAttribute("username", rsUser.getString("name"));
                        newSession.setAttribute("role", rsUser.getString("role"));
                        newSession.setAttribute("csrfToken", generateCSRFToken());
                        String insertLog = "insert into loginhistory(userid,datetime,ipaddress) values(?,?,?)";
                        PreparedStatement pstmtLogin = dh.prepareStatement(insertLog);
                        pstmtLogin.setInt(1, rsUser.getInt("userid"));
                        pstmtLogin.setString(2, date);
                        pstmtLogin.setString(3, ipAddress);
                        pstmtLogin.executeUpdate();
                        if (rsUser.getString("role").equals("2") || rsUser.getString("role").equals("3") || rsUser.getString("role").equals("4") || rsUser.getString("role").equals("5") || rsUser.getString("role").equals("6") || rsUser.getString("role").equals("7")) {
                            response.sendRedirect("changepassword.jsp");
                        }
                    } else {
                        String selectDist = "select userid,name,password,role from createuser where emailid=? and password=?";
                        PreparedStatement pstmt = dh.prepareStatement(selectDist);
                        pstmt.setString(1, username);
                        pstmt.setString(2, password);
                        ResultSet rs = pstmt.executeQuery();
                        if (rs.next()) {
                            newSession.setAttribute("userid", rs.getString("userid"));
                            newSession.setAttribute("username", rs.getString("name"));
                            newSession.setAttribute("role", rs.getString("role"));
                            newSession.setAttribute("csrfToken", generateCSRFToken());
                            String insertDistLog = "insert into loginhistory(userid,datetime,ipaddress) values(?,?,?)";
                            PreparedStatement pstmtLogin = dh.prepareStatement(insertDistLog);
                            pstmtLogin.setString(1, rs.getString("userid"));
                            pstmtLogin.setString(2, date);
                            pstmtLogin.setString(3, ipAddress);
                            pstmtLogin.executeUpdate();
                            if (rs.getString("role").equals("1")) {
                                response.sendRedirect("home.jsp");
                            } else if (rs.getString("role").equals("2")) {
                                response.sendRedirect("cr_home.jsp");
                            } else if (rs.getString("role").equals("3")) {
                                response.sendRedirect("em_home.jsp");
                            } else if (rs.getString("role").equals("4")) {
                                response.sendRedirect("pr_home.jsp");
                            } else if (rs.getString("role").equals("5")) {
                                response.sendRedirect("user_home_approver.jsp");
                            } else if (rs.getString("role").equals("6")) {
                                response.sendRedirect("dm_home.jsp");
                            } else if (rs.getString("role").equals("7")) {
                                response.sendRedirect("gr_home.jsp");
                            }
                        } else {
                            response.sendRedirect("login.jsp?fail");
                        }
                    }
                }

            } catch (Exception e) {
                System.out.println("Exception in login Action try catch block:-" + e.getMessage());

            } finally {
                if (dh != null) {
                    dh.close();
                }
            }
        } else {
            response.sendRedirect("login?fail");
        }

        return mapping.findForward(SUCCESS);
    }
    //in authentication function
//sample implementation of token generation

    protected String generateCSRFToken() {
        byte random[] = new byte[16];

        // Render the result as a String of hexadecimal digits
        StringBuilder buffer = new StringBuilder();
        randomSource.nextBytes(random);
        for (int j = 0; j < random.length; j++) {
            byte b1 = (byte) ((random[j] & 0xf0) >> 4);
            byte b2 = (byte) (random[j] & 0x0f);
            if (b1 < 10) {
                buffer.append((char) ('0' + b1));
            } else {
                buffer.append((char) ('A' + (b1 - 10)));
            }
            if (b2 < 10) {
                buffer.append((char) ('0' + b2));
            } else {
                buffer.append((char) ('A' + (b2 - 10)));
            }
        }

        return buffer.toString();
    }
}