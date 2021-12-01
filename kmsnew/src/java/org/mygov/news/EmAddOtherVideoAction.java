/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.mygov.news;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.DirectoryNotEmptyException;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Iterator;
import java.util.List;
import java.util.ResourceBundle;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jcifs.smb.NtlmPasswordAuthentication;
import jcifs.smb.SmbFile;
import jcifs.smb.SmbFileOutputStream;
import mrsac.db.connection.ConnectionDB;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.mygov.handler.DateTimeUTC;

/**
 *
 * @author Fluidscapes
 */
public class EmAddOtherVideoAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private final int maxFileSize = 500 * 1024 * 1024;
    private final int maxMemSize = 40 * 1024 * 1024;

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
        ResourceBundle rb = ResourceBundle.getBundle("msg");
        String rbPath = rb.getString("filePath");
        DateTimeUTC dtime = new DateTimeUTC();
        final String date11 = DateTimeUTC.GetUTCdatetimeAsString();
        Connection dh = null;
        final String newDateTime = DateTimeUTC.getNewCurrentDateTime();
        String subject = null, desc = null, summary = null, chname = null, tags = null, sourcedate = null, titlemarathi = null, sentiment = null, tempvideo = null;

//        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        if (ServletFileUpload.isMultipartContent(request)) {
//                    if (!isMultipart) {
//        //            return;
//                    }
            // Create a factory for disk-based file items
            DiskFileItemFactory factory = new DiskFileItemFactory();

            // Sets the size threshold beyond which files are written directly to
            // disk.
            factory.setSizeThreshold(maxMemSize);

            // Sets the directory used to temporarily store files that are larger
            // than the configured size threshold. We use temporary directory for
            // java
            factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
            final String date1 = DateTimeUTC.getCurrentDate();
            // constructs the folder where uploaded file will be stored
//                String uploadFolder = "c://temp//directory";
            String pathofUploadingFile = request.getServletContext().getRealPath("/");

            System.out.println("test upload:-" + pathofUploadingFile);
            Path dir = Files.createDirectories(Paths.get(rbPath + "/" + date1));

//                Path dir = Files.createDirectories(Paths.get(rbPath + "\\" + date1));
//            Path dir = Files.createDirectories(Paths.get("c://temp/upload"));
            String uploadFolder = dir.toString();
            //        String up = dir.toString();
            //        System.out.println(up);
            //        String uploadFolder = getServletContext().getRealPath("")
            //                + File.separator + "c://temp";
            // Create a new file upload handler
            ServletFileUpload upload = new ServletFileUpload(factory);

            // Set overall request size constraint
            upload.setSizeMax(maxFileSize);
//            String subject = "";
            String fileDocPath = "", fileVdoPath = "", fileImgPath = "";
            System.out.println("ttttt");
//            String smbUrl = "smb://172.16.16.199/k/KMS/uploads/electronic/" + date1;
//            System.out.println("smburl:" + smbUrl);
//            String smbImgPath = "", smbVdoPath = "", smbDocPath = "", smbFilepath = "";
//            StringBuffer strBuff = new StringBuffer();
//            StringBuffer strBuffVdo = new StringBuffer();

            try {
                // Parse the request
                List items = upload.parseRequest(request);
                Iterator iter = items.iterator();
                while (iter.hasNext()) {
                    FileItem item = (FileItem) iter.next();
                    System.out.println(item);
                    if (!item.isFormField()) {
                        String fileName = new File(item.getName()).getName();
                        String fileExt = new File(item.getName()).getPath();
//                        System.out.println(fileName);
//                        System.out.println(fileExt);
                        File uploadedFile = null;
                        System.out.println("hjjh khkhk:-" + fileName);
                        int i = fileName.lastIndexOf('.');
                        String extension;
                        if (i > 0) {
                            System.out.println("extesdad:-" + i);
                            extension = fileName.substring(i + 1).toLowerCase();
//                               File oldfile =new File("oldfile.txt");
//		File newfile =new File("d" + newDateTime + "." + extension);
//                 	String sss=fileName.replaceFirst(fileName,"g" + newDateTime + "." + extension);

//                                String newFilename = fileName.replaceAll(fileName, "g" + newDateTime + "." + extension);
                            String filePath = uploadFolder + File.separator + fileName.toLowerCase();
                            uploadedFile = new File(filePath);
//                            smbFilepath = smbUrl + File.separator + fileName.toLowerCase();
//                            System.out.println(sss);
                            System.out.println(uploadedFile);
//                            txt doc docx xls xlsx pdf ppt pptx
//                            if (extension.equals("txt") || extension.equals("doc") || extension.equals("docx") || extension.equals("xls") || extension.equals("xlsx") || extension.equals("pdf") || extension.equals("ppt") || extension.equals("pptx") || extension.equals("PDF")) {
//                                fileDocPath = fileDocPath + filePath + "::";
//                            System.out.println(fileDocPath);
//                            } else
                            if (extension.equals("png") || extension.equals("jpg") || extension.equals("jpeg") || extension.equals("gif")) {
                                fileImgPath = fileImgPath + filePath + "::";
                                System.out.println("uploadimagepath:-" + fileImgPath);
//                                strBuff.append(fileImgPath + "::");

//                                smbImgPath = smbImgPath + smbFilepath + "::";

                            } //                            mov m4v mp4 mpeg avi wmv
                            else if (extension.equals("mov") || extension.equals("m4v") || extension.equals("mp4") || extension.equals("mpeg") || extension.equals("avi") || extension.equals("wmv") || extension.equals("mxf")) {
                                fileVdoPath = fileVdoPath + filePath + "::";
//                                strBuffVdo.append(fileVdoPath + "::");
                                System.out.println("fileVdoPath:-" + fileVdoPath);
//                                smbVdoPath = smbVdoPath + smbFilepath + "::";
                            }
                        }
                        //                    String content = new String(Files.readAllBytes(Paths.get(fileName)));

                        // saves the file to upload directory
                        item.write(uploadedFile);
                    }
//                    System.out.println("fileImgPath:"+fileImgPath);
//                    System.out.println("filevdoPath:"+fileVdoPath);
                    if (item.isFormField()) {
                        if (item.getFieldName().equals("subject")) {
                            subject = item.getString("UTF-8");
                            System.out.println(item.getString("UTF-8"));
                        }
                        if (item.getFieldName().equals("titlemarathi")) {
                            titlemarathi = item.getString("UTF-8");
                            System.out.println(item.getString());
                        }
                        if (item.getFieldName().equals("description")) {
                            desc = item.getString("UTF-8");
                            System.out.println(item.getString());
                        }
                        if (item.getFieldName().equals("sentiment")) {
                            sentiment = item.getString("UTF-8");
                            System.out.println(item.getString());
                        }
                        if (item.getFieldName().equals("tags")) {
                            tags = item.getString("UTF-8");
                            System.out.println(item.getString());
                        }
                        if (item.getFieldName().equals("sourcedate")) {
                            sourcedate = item.getString("UTF-8");
                            System.out.println(item.getString());
                        }
                        if (item.getFieldName().equals("channel")) {
                            chname = item.getString("UTF-8");
                            System.out.println(item.getString());
                        }
                    }
                }
//                String user = "kms:CSF@1234";
//                NtlmPasswordAuthentication auth = new NtlmPasswordAuthentication(user);
//
//                InputStream in = null;
//                OutputStream out = null;
//                System.out.println("test by me");
//                String ff[] = strBuff.toString().split("::");
//                SmbFile remoteFile = null;
//                for (String dd : ff) {
//                    try {
//                        SmbFile remoteDir = new SmbFile(smbUrl, auth);
//// Create remote folder if not exist
//                        if (!remoteDir.exists()) {
//                            remoteDir.mkdirs();
//                        }
////                        String proHttp="http://35.234.46.225/"+filePath.substring(21);
//                        File localFile = new File(dd.toString());
//                        String fileName1 = localFile.getName();
//                        String pp = smbUrl + "/" + fileName1;
//                        remoteFile = new SmbFile(pp, auth);
//                        in = new BufferedInputStream(new FileInputStream(localFile));
//                        out = new BufferedOutputStream(new SmbFileOutputStream(remoteFile));
//                        byte[] buffer = new byte[1024];
//                        while ((in.read(buffer)) != -1) {
//                            out.write(buffer);
////                            System.out.println("tete");
//                            buffer = new byte[1024];
//                        }
//                        int i = 0;
////                SmbFile checkFile = new SmbFile(pp, auth);
//                        if (remoteFile.exists()) {
//
//                            System.out.println("exist");
//                            System.out.println("loooo:" + localFile);
//                            if (localFile.delete()) {
//                                System.out.println("File deleted successfully");
//                            } else {
//                                System.out.println("Failed to delete the file");
//                            }
//                            try {
//                                Files.deleteIfExists(Paths.get(localFile.toString()));
//                            } catch (NoSuchFileException e) {
//                                System.out.println("No such file/directory exists");
//                            } catch (DirectoryNotEmptyException e) {
//                                System.out.println("Directory is not empty.");
//                            } catch (IOException e) {
//                                System.out.println("Invalid permissions.");
//                            }
//
//                            System.out.println("Deletion successful.");
////                    System.out.println("<br>");
//                        } else {
//                            System.out.println("not available");
//                        }
//                    } catch (IOException e) {
//                        System.out.println("error in upload file:" + e.getMessage());
////                        e.printStackTrace();
//                    }
//                }
                ConnectionDB conn = new ConnectionDB();
                dh = conn.getConnection();
                HttpSession session = request.getSession();
                String code = "E";
                fileImgPath = fileImgPath.replace("\\", "/");
                fileVdoPath = fileVdoPath.replace("\\", "/");
                System.out.println("fileImgPath:-" + fileImgPath);
                System.out.println("fileVdoPath:-" + fileVdoPath);

                String splitTag[] = null;
                String ipAddress = request.getHeader("X-FORWARDED-FOR");
                if (ipAddress == null) {
                    ipAddress = request.getRemoteAddr();
                }
//             DateTimeUTC dtime = new DateTimeUTC();
                final String date = DateTimeUTC.GetUTCdatetimeAsString();

                String userid = session.getAttribute("userid").toString();
                String insertData = "insert into tbl_news_dataentry(userid,subject,description,sourcedate,graphicspath,vdopath,chname,datetime,titlemarathi,sentiment,additionaltag) "
                        + "values (?,?,?,?,?,?,?,?,?,?,?)";
                PreparedStatement pstmtData = dh.prepareStatement(insertData);
                System.out.println("insertdata:-" + insertData);
                pstmtData.setString(1, userid);
                pstmtData.setString(2, subject);
                pstmtData.setString(3, desc);
                pstmtData.setString(4, sourcedate);
                pstmtData.setString(5, fileImgPath);
                pstmtData.setString(6, fileVdoPath);
//            pstmtData.setString(7, endDate[0]);
                pstmtData.setString(7, chname);
                pstmtData.setString(8, date);
                pstmtData.setString(9, titlemarathi);
                pstmtData.setString(10, sentiment);
                pstmtData.setString(11, tags);
                if (pstmtData.executeUpdate() > 0) {
                    String selectQuery = "select max(iddataentry) from tbl_news_dataentry ";
                    PreparedStatement pstmt = dh.prepareStatement(selectQuery);
                    ResultSet rs = pstmt.executeQuery();
                    if (rs.next()) {

                        String updateData = "update tbl_news_dataentry set workcode=? where iddataentry=?";
                        PreparedStatement pstmtup = dh.prepareStatement(updateData);
                        pstmtup.setString(1, code + rs.getInt(1));
                        pstmtup.setString(2, rs.getString(1));
                        pstmtup.executeUpdate();

                        System.out.println("max id:-" + rs.getString(1));
                        session.setAttribute("maxid", rs.getString(1));
                        String getData = "select workcode from tbl_news_dataentry where iddataentry=(select max(iddataentry) from tbl_news_dataentry where userid=?)";
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
                                for (String splitTag1 : splitTag) {
                                    //                    System.out.println("splittt:-"+splitTag[i]);
//                    System.out.println("numbererere:-"+i);

                                    String selectQuery1 = "select tag from tbl_tag_master where tag like ? ";
                                    PreparedStatement pstmtQuery = dh.prepareStatement(selectQuery1);
                                    pstmtQuery.setString(1, splitTag1.toLowerCase());
//                                            pstmtQuery.setString(2, workcode);
                                    ResultSet rsTag = pstmtQuery.executeQuery();
                                    if (rsTag.next()) {
                                    } else {
                                        String insertQuery = "insert into tbl_temp_tag_master (tag,datetime,ipaddress,workcode) values(?,?,?,?)";
                                        PreparedStatement pstmtTag = dh.prepareStatement(insertQuery);
                                        pstmtTag.setString(1, splitTag1);
                                        pstmtTag.setString(2, DateTimeUTC.GetUTCdatetimeAsString());
                                        pstmtTag.setString(3, ipAddress);
                                        pstmtTag.setString(4, workcode);
                                        pstmtTag.executeUpdate();
//                     response.sendRedirect("error.jsp");
                                    }
                                }

                            }
                            response.sendRedirect("em_othervideo.jsp?workcode=" + workcode + "&success");
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
        return mapping.findForward(SUCCESS);
    }
}
