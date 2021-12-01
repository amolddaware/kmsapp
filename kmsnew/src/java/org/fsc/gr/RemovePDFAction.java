/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.fsc.gr;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mrsac.db.connection.ConnectionDB;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author Fluidscapes
 */
public class RemovePDFAction extends org.apache.struts.action.Action {

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
        PrintWriter out = response.getWriter();
//        System.out.println("hi");
//        String storedToken = (String) session.getAttribute("csrfToken");
//        String token = request.getParameter("token");

//        String userid = session.getAttribute("userid").toString();
        String removeImageid = request.getParameter("removepdfid");
        System.out.println("remove:-"+removeImageid);
        Connection dh = null;

        try {
//            PrintWriter out = response.getWriter();
            ConnectionDB conn = new ConnectionDB();
            dh = conn.getConnection();
//            System.out.println("tag:-" + request.getParameter("tag"));
            String selectQuery = "UPDATE tbl_news_dataentry SET  docpath = REPLACE(docpath, ? ,'') where docpath like ?";
            PreparedStatement pstmtQuery = dh.prepareStatement(selectQuery);
            System.out.println("selectQuery:-" + selectQuery);
            pstmtQuery.setString(1, removeImageid);
            pstmtQuery.setString(2, removeImageid);
            if (pstmtQuery.executeUpdate() > 0) {

                out.println("success");
                System.out.println("success");
            } else {
                out.println("not removed");
                System.out.println("not removed");

            }
        } catch (Exception e) {
            e.printStackTrace();
        } //            response.sendRedirect("newstag.jsp#tags?success");
        //                response.sendRedirect("userDataentry_1.jsp#tags?success");
        //        } catch (Exception e) {
        //            System.out.println("Exception in Add Tag Action data :-" + e.getMessage());
        //        } 
        finally {
            if (dh != null) {
                dh.close();

            }
        }
        return mapping.findForward(SUCCESS);
    }
}
