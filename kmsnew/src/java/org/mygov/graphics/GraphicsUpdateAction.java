/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.mygov.graphics;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.nio.file.DirectoryNotEmptyException;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.ResourceBundle;
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
 * @author Amol
 */
public class GraphicsUpdateAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";

    private int maxFileSize = 200 * 1024 * 1024;
    private int maxMemSize = 100 * 1024 * 1024;

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
        String rbPath = rb.getString("filePathCreative");
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException ex) {
            System.out.println("ex:-" + ex.getMessage());
        }
//        System.out.println("tetststt");
        HttpSession session = request.getSession();
        String storedToken = (String) session.getAttribute("csrfToken");
        String token = request.getParameter("token");
        String userid = session.getAttribute("userid").toString();

//
        System.out.println("Storedtoken:-" + storedToken);
        System.out.println("token:-" + token);
//        //do check
//        if (storedToken.equals(token)) {

        Connection dh = null;

//            PrintWriter out = response.getWriter();
        ConnectionDB conn = new ConnectionDB();
        dh = conn.getConnection();
//            System.out.println(request.getParameter("subject"));
        String ipAddress = request.getHeader("X-FORWARDED-FOR");
        if (ipAddress == null) {
            ipAddress = request.getRemoteAddr();
        }
        DateTimeUTC dtime = new DateTimeUTC();
        final String date11 = dtime.GetUTCdatetimeAsString();

        final String newDateTime = dtime.getNewCurrentDateTime();
//                        DataentryActionForm dataentry = (DataentryActionForm) form;
//            String subject = "";
//            System.out.println(subject);
        String deptdate = null;
        String workcode = null;
        String date = null;
        String sourcedate = null;
        String subject = null;
        String description = null;
        String edition = null;
        String subedition = null;
        String deptmarathi = null;
        String placeofprogram = null;
        String additionaltag = null, sector = null;
        String nameofprogram = null;
        String link = null;
        String uplodedVdo = "",uplodedImage="",uplodedDoc="";

        boolean isMultipart = ServletFileUpload.isMultipartContent(request);

        //            if (!isMultipart) {
        ////            return;
        //            }
        // Create a factory for disk-based file items
        DiskFileItemFactory factory = new DiskFileItemFactory();

        // Sets the size threshold beyond which files are written directly to
        // disk.
        factory.setSizeThreshold(maxMemSize);

        // Sets the directory used to temporarily store files that are larger
        // than the configured size threshold. We use temporary directory for
        // java
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
        final String date1 = dtime.getCurrentDate();
        // constructs the folder where uploaded file will be stored
//                String uploadFolder = "c://temp//directory";
//        Path dir = Files.createDirectories(Paths.get(rbPath + "\\" + date1));
         String pathofUploadingFile = request.getServletContext().getRealPath("/");

            System.out.println("test upload:-" + pathofUploadingFile);
            Path dir = Files.createDirectories(Paths.get( rbPath + "/" + date1));

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
        String filefullDocPath = "", filefullVdoPath = "", filefullImgPath = "";
//        String smbUrl = "smb://172.16.16.199/k/KMS/uploads/creative/" + date1;
//            System.out.println("smburl:" + smbUrl);
//            String smbImgPath = "", smbVdoPath = "", smbDocPath = "", smbFilepath = "";
//            StringBuffer strBuff = new StringBuffer();
//            StringBuffer strBuffVdo = new StringBuffer();
//            StringBuffer strBuffDoc = new StringBuffer();

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
if(!fileName.isEmpty()){
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
//  smbFilepath = smbUrl + File.separator + fileName.toLowerCase();
//                            System.out.println(sss);
                        System.out.println(uploadedFile);
//                            txt doc docx xls xlsx pdf ppt pptx
                       if (extension.equals("txt") || extension.equals("doc") || extension.equals("docx") || extension.equals("xls") || extension.equals("xlsx") || extension.equals("pdf") || extension.equals("ppt") || extension.equals("pptx") || extension.equals("PDF")) {
                                fileDocPath = fileDocPath + filePath + "::";
//                                strBuffDoc.append(fileDocPath + "::");

//                                smbDocPath = smbDocPath + smbFilepath + "::";
//                            System.out.println(fileDocPath);
                            } else if (extension.equals("png") || extension.equals("jpg") || extension.equals("jpeg") || extension.equals("gif")) {
                                fileImgPath = fileImgPath + filePath + "::";
                                System.out.println("uploadimagepath:-" + fileImgPath);
//                                strBuff.append(fileImgPath + "::");

//                                smbImgPath = smbImgPath + smbFilepath + "::";
                            } //                            mov m4v mp4 mpeg avi wmv
                            else if (extension.equals("mov") || extension.equals("m4v") || extension.equals("mp4") || extension.equals("mpeg") || extension.equals("avi") || extension.equals("wmv") || extension.equals("mxf")) {
                                fileVdoPath = fileVdoPath + filePath + "::";
                                System.out.println("fileVdoPath:-" + fileVdoPath);
//                                strBuffVdo.append(fileVdoPath + "::");

//                                smbVdoPath = smbVdoPath + smbFilepath + "::";
                            }
                    }
                    //                    String content = new String(Files.readAllBytes(Paths.get(fileName)));

                    // saves the file to upload directory
                    item.write(uploadedFile);
                }
                }
                if (item.isFormField()) {
                    if (item.getFieldName().equals("sourcedate")) {
                        sourcedate = item.getString();
//                            System.out.println(subject);
                    }
                    if (item.getFieldName().equals("subject")) {
                        subject = item.getString("UTF-8");
//                            System.out.println(subject);
                    }
                    if (item.getFieldName().equals("description")) {
                        description = item.getString("UTF-8");
//                            System.out.println(subject);
                    }
                    if (item.getFieldName().equals("sector")) {
                        sector = item.getString("UTF-8");
//                            System.out.println(subject);
                    }
                    if (item.getFieldName().equals("nameofprogram")) {
                        nameofprogram = item.getString("UTF-8");
//                            System.out.println(subject);
                    }

                    if (item.getFieldName().equals("placeofprogram")) {
                        placeofprogram = item.getString();
//                            System.out.println(taluka);
                    }
                    if (item.getFieldName().equals("additional")) {
                        additionaltag = item.getString();
//                            System.out.println(taluka);
                    }
                    if (item.getFieldName().equals("workcode")) {
                        workcode = item.getString();
//                            System.out.println(taluka);
                    }
                    if (item.getFieldName().equals("uploadDoc")) {
                        uplodedDoc = item.getString();
//                            System.out.println(taluka);
                    }
                    if (item.getFieldName().equals("uploadVdo")) {
                        uplodedVdo = item.getString();
//                            System.out.println(taluka);
                    }
                    if (item.getFieldName().equals("uploadImage")) {
                        uplodedImage = item.getString();
//                            System.out.println(taluka);
                    }

                }

            }
            if(fileDocPath!=null){
            filefullDocPath=fileDocPath+uplodedDoc;
            }else{
            filefullDocPath=uplodedDoc;
            }
            if(fileVdoPath!=null){
            filefullVdoPath=fileVdoPath+uplodedVdo;
            }else{
            filefullVdoPath=uplodedVdo;
            }
            if(fileImgPath!=null){
            filefullImgPath=fileImgPath+uplodedImage;
            }else{
            filefullImgPath=uplodedImage;
            
            }
            
            

                    System.out.println("filefullDocPath:-" + filefullDocPath);
                    System.out.println("filefullVdoPath:-" + filefullVdoPath);
                    System.out.println("filefullVdoPath:-" + filefullVdoPath);
//                    System.out.println("fullvdopath:-" + vdopath);
//                    System.out.println("fullaudiopath:-" + audiopath);
//                    System.out.println("fulldocpath:-" + docpath);
// String user = "kms:CSF@1234";
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
String chname = "";
            String newFullPath[];    //                String insertData="insert into dataentry(userid,subject,desc)"
            String updateData = "update tbl_news_dataentry set subject = ?,description = ?,sector =?,name_of_program = ?,place_of_program = ?,sourcedate = ?,datetime = ?,additionaltag = ?,vdopath=?,docpath=?,graphicspath=? where  workcode=? ";
            PreparedStatement pstmtupData = dh.prepareStatement(updateData);
            System.out.println("pstmtupData:-" + pstmtupData);
            pstmtupData.setString(1, subject);
            pstmtupData.setString(2, description);
            pstmtupData.setString(3, sector);
            pstmtupData.setString(4, nameofprogram);
            pstmtupData.setString(5, placeofprogram);
            pstmtupData.setString(6, sourcedate);
            pstmtupData.setString(7, date);
            pstmtupData.setString(8, additionaltag);
            pstmtupData.setString(9, filefullVdoPath);
            pstmtupData.setString(10, filefullDocPath);
            pstmtupData.setString(11, filefullImgPath);
            pstmtupData.setString(12, workcode);
            if (pstmtupData.executeUpdate() > 0) {
                response.sendRedirect("cr_edit.jsp" + "?workcode=" + workcode + "&success");
                //                       response.sendRedirect("userDataentry_1.jsp#upload?success");
            } else {
                response.sendRedirect("error.jsp#information?success");

            }

//                if (pstmtData.executeUpdate() > 0) {
//                    response.sendRedirect("userDataentry_1.jsp#upload");
//                } else {
//                    response.sendRedirect("error.jsp");
//                }
        } catch (Exception e) {
            System.out.println("Exception in update data :-" + e.getMessage());
        } finally {
            if (dh != null) {
//                    dh.close();

            }
        }
//        } else {
//            response.sendRedirect("csrf.html");
//        }

        return mapping.findForward(SUCCESS);
    }
}
