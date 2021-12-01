/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.mygov.action;

import java.io.PrintWriter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author Fluidscapes
 */
public class LogoutAction extends org.apache.struts.action.Action {

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
            PrintWriter out = response.getWriter();
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("JSESSIONID")) {
                        System.out.println("JSESSIONID=" + cookie.getValue());
                        break;
                    }
                }
            }
            //invalidate the session if exists
            HttpSession session = request.getSession(false);
//            HttpSession session = request.getSession(true);
            String username = session.getAttribute("username").toString();
            String csrfToken = session.getAttribute("csrfToken").toString();
            String userid = session.getAttribute("userid").toString();
            System.out.println("username:-" + username);
            System.out.println("userid:-" + userid);
            if (session != null) {
                session.removeAttribute(username);
                session.removeAttribute(userid);
                session.removeAttribute(csrfToken);
//                System.out.println("logout success");
                session.invalidate();
                response.sendRedirect("logout.jsp");
//            response.sendRedirect("mrsac_logout.jsp?logout");
//        out.println("logout successfully");
            }
        } catch (Exception e) {
            System.out.println("Exception in logout try catch block:-" + e.getMessage());
        }
        return mapping.findForward(SUCCESS);
    }
}
