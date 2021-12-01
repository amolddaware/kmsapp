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
public class ApproverTagUpdateAction extends org.apache.struts.action.Action {

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
//        String maxid = session.getAttribute("maxid").toString();
//        String table = session.getAttribute("language").toString();
//        String teletag = request.getParameter("teletag").trim();
//        String printtag = request.getParameter("printtag").trim();
//        String radiotag = request.getParameter("radiotag").trim();
//        String webtag = request.getParameter("webtag").trim();
//        String table = "tbl_news_dataentry";
        String tag = null, id = null, workcode = null;

        if (request.getParameter("tag") != "") {
            tag = request.getParameter("tag").trim();
        } else {
            tag = null;
        }
        if (request.getParameter("id") != "") {
            id = request.getParameter("id").trim();
        } else {
            id = null;
        }
        if (request.getParameter("workcode") != "") {
            workcode = request.getParameter("workcode").trim();
        } else {
            workcode = null;
        }
        Connection dh = null;

        try {
//            PrintWriter out = response.getWriter();
            ConnectionDB conn = new ConnectionDB();
            dh = conn.getConnection();
//            System.out.println("tag:-" + request.getParameter("tag"));
            String ipAddress = request.getHeader("X-FORWARDED-FOR");
            if (ipAddress == null) {
                ipAddress = request.getRemoteAddr();
            }
            DateTimeUTC dtime = new DateTimeUTC();
            final String date = dtime.GetUTCdatetimeAsString();

//                    System.out.println("splittt:-"+splitTag[i]);
//                    System.out.println("numbererere:-"+i);
//                    String selectQuery = "select tag from tbl_temp_tag_master where tag = ?";
//                    PreparedStatement pstmtQuery = dh.prepareStatement(selectQuery);
//                    pstmtQuery.setString(1, splitTag[i].toLowerCase());
//                    ResultSet rs = pstmtQuery.executeQuery();
//                    if (rs.next()) {
////                    String insertQuery = "insert into tbl_temp_tag_master (tag,datetime,ipaddress) values(?,?,?)";
////                    PreparedStatement pstmt = dh.prepareStatement(insertQuery);
////                    pstmt.setString(1, splitTag[i]);
////                    pstmt.setString(2, DateTimeUTC.GetUTCdatetimeAsString());
////                    pstmt.setString(3, ipAddress);
////                    pstmt.executeUpdate();
//                    } else {
            String selectQuery = "select tag from tbl_tag_master where tag = ? ";
            PreparedStatement pstmtQuery = dh.prepareStatement(selectQuery);
            pstmtQuery.setString(1, tag);
            ResultSet rs = pstmtQuery.executeQuery();
            if (rs.next()) {

//                out.println("success");
                String updateData = "update tbl_news_dataentry set approvedtag=case when approvedtag is null then '" + tag + "'\n"
                        + "                  else concat(approvedtag, ' " + tag + "') end where workcode=?";
                System.out.println("updataData:-" + updateData);
                PreparedStatement pstmtData = dh.prepareStatement(updateData);
//                pstmtData.setString(1, tag);
                pstmtData.setString(1, workcode);
                if (pstmtData.executeUpdate() > 0) {
                    String removeQuery = "delete from tbl_temp_print_tag_master where idtbl_temp_tag_master=?";
                    PreparedStatement pstmtRemove = dh.prepareStatement(removeQuery);
                    pstmtRemove.setString(1, id);
                    pstmtRemove.executeUpdate();

                    response.sendRedirect("pr_approver_reviewapprove.jsp?searchresult=P&exist&tag=" + tag);

                }
            } else {
                String insertQuery = "insert into tbl_tag_master (tag,userid,datetime,ipaddress) values(?,?,?,?)";
                PreparedStatement pstmt = dh.prepareStatement(insertQuery);
                pstmt.setString(1, tag);
                pstmt.setString(2, userid);
                pstmt.setString(3, DateTimeUTC.GetUTCdatetimeAsString());
                pstmt.setString(4, ipAddress);
                if (pstmt.executeUpdate() > 0) {
                    String removeQuery = "delete from tbl_temp_print_tag_master where idtbl_temp_tag_master=?";
                    PreparedStatement pstmtRemove = dh.prepareStatement(removeQuery);
                    pstmtRemove.setString(1, id);
                    pstmtRemove.executeUpdate();
//                out.println("success");
//                    String updateData = "update tbl_news_dataentry set approvedtag = CONCAT(approvedtag, '" +tag+"') where workcode=?";
                    String updateData = "update tbl_news_dataentry set approvedtag=case when approvedtag is null then '" + tag + "'\n"
                            + "                  else concat(approvedtag, ' " + tag + "') end where workcode=?";
                    System.out.println("updataData:-" + updateData);
                    PreparedStatement pstmtData = dh.prepareStatement(updateData);
//                    pstmtData.setString(1, tag);
                    pstmtData.setString(1, workcode);
                    pstmtData.executeUpdate();
                    response.sendRedirect("pr_approver_reviewapprove.jsp?searchresult=N&success");
                }
            }
//                     response.sendRedirect("error.jsp");
//                    }
//                    if(pstmt.executeUpdate()>0){
//                     response.sendRedirect("newstag.jsp#tags?exist");
//                    }
//                }else{
//                     String insertQuery = "insert into tbl_temp_tag_master (tag,datetime,ipaddress) values(?,?,?)";
//                    PreparedStatement pstmt = dh.prepareStatement(insertQuery);
//                    pstmt.setString(1, splitTag[i]);
//                    pstmt.setString(2, DateTimeUTC.GetUTCdatetimeAsString());
//                    pstmt.setString(3, ipAddress);
//                  pstmt.executeUpdate();
//                    }
//                }
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
