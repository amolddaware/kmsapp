/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.mygov.news;

import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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
public class NewsUploadAction extends org.apache.struts.action.Action {

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

        String rbPath = rb.getString("filePath");
//        String uploadPath = rb.getString("uploadFilePath");
//        String nwpath = rb.getString("nwPath");
        System.out.println("tetststt");
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
                String subject = null, desc = null, summary = null, tags = null, sourcedate, titlemarathi = null, sentiment = null, tempvideo = null;
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
                if (request.getParameter("summary") != null) {
                    summary = request.getParameter("summary").trim();
                } else {
                    summary = null;
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

                String link = null, ilink = "", dlink = "", uploadedvideo = "", str = "";
                String separatePath[];

                if (request.getParameter("newFilename") != "") {
//                if (request.getParameter("getUpload") != "") {
                    uploadedvideo = request.getParameter("newFilename").trim();
//                    uploadedvideo = request.getParameter("getUpload").trim();
                    str = uploadedvideo;
                } else {
                    uploadedvideo = null;
                }

                if (request.getParameter("tempvideo") != "") {
                    tempvideo = request.getParameter("tempvideo").trim();
//                    str = uploadedvideo.substring(9);
                } else {
                    tempvideo = null;
                }
                final String date1 = dtime.getCurrentDate();
                System.out.println("uploadedvideo:-" + uploadedvideo);
                StringBuilder imgpath = new StringBuilder();
                StringBuilder docpath = new StringBuilder();
                StringBuilder vdopath = new StringBuilder();
                StringBuilder audiopath = new StringBuilder();
                String fullPath[] = str.split(",");

//                Path dir = Files.createDirectories(Paths.get(rbPath + "\\" + date1));
                String pathofUploadingFile = request.getServletContext().getRealPath("/");

                System.out.println("test upload:-" + pathofUploadingFile);
                Path dir = Files.createDirectories(Paths.get( rbPath + "/" + date1));

                String uploadFolder = dir.toString();
//        if(uploadedvideo.contains("txt")||uploadedvideo.contains("doc")||uploadedvideo.contains("pdf")){
//            System.out.println("docpath:-"+uploadedvideo);
//    }
                String upString = uploadFolder + "/";

//        System.out.println(upString);
                String newpath = "";
                for (int i = 0; i < fullPath.length; i++) {
                    String selectQuery = "select vdopath from tbl_news_dataentry where vdopath like '%" + fullPath[i].trim() + "%'";
                    System.out.println("selectquery:-" + selectQuery);
                    PreparedStatement pstmt = dh.prepareStatement(selectQuery);
                    ResultSet rs = pstmt.executeQuery();
                    if (rs.next()) {
                        System.out.println("available:-" + str);
                        response.sendRedirect("em_videoadd.jsp?available");

//                        request.setAttribute("filename", fullFileName);
//                        out.println("exist,"+fullFileName);
                    } else {
                        newpath = newpath + fullPath[i] + ",";
//                         item.write(uploadedFile);
                        System.out.println("not available:-");
                    }
                }
                System.out.println("newpath:-" + newpath);

                if (newpath != "") {
                    fullPath = newpath.split(",");
                    for (int i = 0; i < fullPath.length; i++) {
//            System.out.println("fullpath:-" + fullPath[i]);

                        int j = fullPath[i].lastIndexOf('.');
                        String extension;
                        if (j > 0) {
                            extension = fullPath[i].substring(j + 1);
                            if (extension.equals("txt") || extension.equals("doc") || extension.equals("docx") || extension.equals("xls") || extension.equals("xlsx") || extension.equals("pdf") || extension.equals("ppt") || extension.equals("pptx")) {
                                docpath = docpath.append(upString + fullPath[i].toString().trim() + ",");
//                    System.out.println(docpath);
                            } else if (extension.equals("png") || extension.equals("jpg") || extension.equals("jpeg") || extension.equals("gif")) {
                                imgpath = imgpath.append(upString + fullPath[i].toString().trim() + ",");
//                    System.out.println(imgpath);

                            } //                            mov m4v mp4 mpeg avi wmv
                            else if (extension.equals("mov") || extension.equals("m4v") || extension.equals("mp4") || extension.equals("mkv") || extension.equals("mpeg") || extension.equals("avi") || extension.equals("wmv")) {
                                vdopath = vdopath.append(upString + fullPath[i].toString().trim());
//                    System.out.println(vdopath);
                            } else if (extension.equals("wav") || extension.equals("aif") || extension.equals("mp3") || extension.equals("mid")) {
//                else if (extension.equals("mov") || extension.equals("m4v") || extension.equals("mp4") || extension.equals("mpeg") || extension.equals("avi") || extension.equals("wmv")) {
                                audiopath = audiopath.append(upString + fullPath[i].toString().trim() + ",");
//                    System.out.println(vdopath);
                            }
                        }
//            System.out.println("fullimagepath:-" + imgpath);
//            System.out.println("fulldocpath:-" + docpath);

                    }

                    System.out.println("fullvdopath:-" + vdopath);
                    String chname = "";
                    String newFullPath[];
                    try {
                        String vpath = vdopath.toString();
//            String datetime[]=vpath.split("_");

                        String startdate = "", enddate = "";

                        newFullPath = newpath.split(",");
                        fullPath = newpath.split("_");
                        chname = fullPath[0];
                        startdate = fullPath[1];
                        enddate = fullPath[2];
                        String endDate[] = enddate.split("\\.");
                        String dd = "", tablename = "", mm = "", yy = "", tdd = "", tmm = "", tyy = "", hh = "", mi = "", ss = "", fullSourceDate = "";
                        tablename = "tbl_news_dataentry";
                        yy = startdate.substring(0, 4);
                        mm = startdate.substring(4, 6);
                        dd = startdate.substring(6, 8);
                        hh = startdate.substring(8, 10);
                        mi = startdate.substring(10, 12);
                        ss = startdate.substring(12, 14);
                        fullSourceDate = yy+ "-" + mm + "-" + dd;
                        String code = "E";
                        String splitTag[] = null;

                        String insertData = "insert into " + tablename + "(userid,subject,description,sourcedate,vdopath,startdatetime,enddatetime, chname,datetime,titlemarathi,sentiment,additionaltag) "
                                + "values (?,?,?,?,?,?,?,?,?,?,?,?)";
                        PreparedStatement pstmtData = dh.prepareStatement(insertData);
                        System.out.println("insertdata:-" + insertData);
                        pstmtData.setString(1, userid);
                        pstmtData.setString(2, subject);
                        pstmtData.setString(3, desc);
                        pstmtData.setString(4, fullSourceDate);
                        pstmtData.setString(5, vdopath.toString());
                        pstmtData.setString(6, startdate);
                        pstmtData.setString(7, endDate[0]);
                        pstmtData.setString(8, chname);
                        pstmtData.setString(9, date);
                        pstmtData.setString(10, titlemarathi);
                        pstmtData.setString(11, sentiment);
                        pstmtData.setString(12, tags);
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

                                String deleteData = "delete from tbl_temp_video_files where vdopath=? ";
                                PreparedStatement pstmtDelete = dh.prepareStatement(deleteData);
                                pstmtDelete.setString(1, vdopath.toString().trim());
//                                pstmtDelete.setString(2, userid);
                                pstmtDelete.executeUpdate();

                                System.out.println("max id:-" + rs.getString(1));
                                session.setAttribute("maxid", rs.getString(1));
                                String getData = "select workcode from " + tablename + " where iddataentry=(select max(iddataentry) from " + tablename + " where userid=?)";
                                PreparedStatement pstmt1 = dh.prepareStatement(getData);
                                pstmt1.setString(1, userid);
                                ResultSet rs1 = pstmt1.executeQuery();
                                String workcode = "";
                                if (rs1.next()) {
                                    workcode = rs1.getString(1);

                                    if (!tags.isEmpty()) {
                                        String str1 = tags.replaceAll(" ", ",");
                                        splitTag = str1.split(",");
//                for(String data:splitTag){
//                    System.out.println("data:-"+data);
                                        for (int i = 0; i < splitTag.length; i++) {
//                    System.out.println("splittt:-"+splitTag[i]);
//                    System.out.println("numbererere:-"+i);

                                            String selectQuery1 = "select tag from tbl_tag_master where tag like ? ";
                                            PreparedStatement pstmtQuery = dh.prepareStatement(selectQuery1);
                                            pstmtQuery.setString(1, splitTag[i].toLowerCase());
//                                            pstmtQuery.setString(2, workcode);
                                            ResultSet rsTag = pstmtQuery.executeQuery();
                                            if (rsTag.next()) {
                                            } else {
                                                String insertQuery = "insert into tbl_temp_tag_master (tag,datetime,ipaddress,workcode) values(?,?,?,?)";
                                                PreparedStatement pstmtTag = dh.prepareStatement(insertQuery);
                                                pstmtTag.setString(1, splitTag[i]);
                                                pstmtTag.setString(2, DateTimeUTC.GetUTCdatetimeAsString());
                                                pstmtTag.setString(3, ipAddress);
                                                pstmtTag.setString(4, workcode);
                                                pstmtTag.executeUpdate();
//                     response.sendRedirect("error.jsp");
                                            }
                                        }

                                    }
//                            session.setAttribute("table", table);
                                    response.sendRedirect("em_videoadd.jsp?workcode=" + workcode + "&success");
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
                    } finally {
                        if (dh != null) {
                            dh.close();
                        }
                    }
                }
            } catch (Exception e) {
                System.out.println("Error in data entry:-" + e.getMessage());
            }
        } else {
            response.sendRedirect("csrf.html");
        }
        return mapping.findForward(SUCCESS);
    }
}
