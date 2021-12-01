/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.fsc.digital;

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
import org.apache.commons.fileupload.FileUploadException;
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
public class UpdateDigitalMediaAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";

    private int maxFileSize = 100 * 1024 * 1024;
    private int maxMemSize = 40 * 1024 * 1024;

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
        HttpSession session = request.getSession();
        String storedToken = (String) session.getAttribute("csrfToken");
        String token = "";
        ResourceBundle rb = ResourceBundle.getBundle("msg");

        String rbPath = rb.getString("filePathDigitalMedia");
//        request.getParameter("token");
        String userid = session.getAttribute("userid").toString();

//
        System.out.println("Storedtoken:-" + storedToken);
        System.out.println("token:-" + token);
//        //do check
//        if (storedToken.equals(token)) {

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
            final String date11 = dtime.GetUTCdatetimeAsString();

            final String newDateTime = dtime.getNewCurrentDateTime();
//                        DataentryActionForm dataentry = (DataentryActionForm) form;
//            String subject = "";
//            System.out.println(subject);
            String sourcedate = null;
            String date = null;
            String newspaper = null;
            String source = null;
            String edition = null;
            String subedition = null;
            String title = null;
            String sentiment = null;
            String tags = null, post = null;
            String totalengagement = null;
            String link = null;
            String workcode = null;

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

            String pathofUploadingFile = request.getServletContext().getRealPath("/");

            System.out.println("test upload:-" + pathofUploadingFile);
            Path dir = Files.createDirectories(Paths.get( rbPath + "/" + date1));
//Path dir = Files.createDirectories(Paths.get(rbPath + "\\" + date1));
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
//            String smbUrl = "smb://172.16.16.199/k/KMS/uploads/digital/" + date1;
//            System.out.println("smburl:" + smbUrl);
//            String smbImgPath = "", smbVdoPath = "", smbDocPath = "", smbFilepath = "";
//            StringBuffer strBuff = new StringBuffer();
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
                            String sss = fileName.replaceFirst(fileName, "d" + newDateTime + "." + extension);

                            String newFilename = fileName.replaceAll(fileName, "d" + newDateTime + "." + extension);

                            String filePath = uploadFolder + File.separator + newFilename.toLowerCase();
                            uploadedFile = new File(filePath);
//                            smbFilepath = smbUrl + File.separator + fileName.toLowerCase();
                            System.out.println(sss);
                            System.out.println(uploadedFile);
//                            txt doc docx xls xlsx pdf ppt pptx
                            if (extension.equals("txt") || extension.equals("doc") || extension.equals("docx") || extension.equals("xls") || extension.equals("xlsx") || extension.equals("pdf") || extension.equals("ppt") || extension.equals("pptx")) {
                                fileDocPath = filePath;
//                                strBuff.append(fileDocPath + "::");

//                                smbDocPath = smbDocPath + smbFilepath + "::";
//                            System.out.println(fileDocPath);
                            } else if (extension.equals("png") || extension.equals("jpg") || extension.equals("jpeg") || extension.equals("gif")) {
                                fileImgPath = filePath;
                                System.out.println("uploadimagepath:-" + fileImgPath);

                            } //                            mov m4v mp4 mpeg avi wmv
                            else if (extension.equals("mov") || extension.equals("m4v") || extension.equals("mp4") || extension.equals("mpeg") || extension.equals("avi") || extension.equals("wmv")) {
                                fileVdoPath = filePath;
                                System.out.println("fileVdoPath:-" + fileVdoPath);

                            }
                        }
                        //                    String content = new String(Files.readAllBytes(Paths.get(fileName)));

                        // saves the file to upload directory
                        item.write(uploadedFile);
                    }

                    if (item.isFormField()) {
                        if (item.getFieldName().equals("date")) {
                            date = item.getString();
//                            System.out.println(subject);
                        }
                        if (item.getFieldName().equals("source")) {
                            source = item.getString("UTF-8");
//                            System.out.println(subject);
                        }
                        if (item.getFieldName().equals("topic")) {
                            title = item.getString("UTF-8");
//                            System.out.println(subject);
                        }
                        if (item.getFieldName().equals("post")) {
                            post = item.getString("UTF-8");
//                            System.out.println(subject);
                        }
                        if (item.getFieldName().equals("totalengagement")) {
                            totalengagement = item.getString();
//                            System.out.println(subject);
                        }

                        if (item.getFieldName().equals("sentiment")) {
                            sentiment = item.getString();
//                            System.out.println(taluka);
                        }
                        if (item.getFieldName().equals("link")) {
                            link = item.getString();
//                            System.out.println(village);
                        }
                        if (item.getFieldName().equals("workcode")) {
                            workcode = item.getString();
//                            System.out.println(village);
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
                String insertData = "update tbl_news_dataentry  set sourcedate=?,dm_source=?,subject=?,description=?,"
                        + "sentiment=?,link=?,docpath=?,datetime=?,ipaddress=?,total_engagement=? where workcode=?";
                PreparedStatement pstmtData = dh.prepareStatement(insertData);
                pstmtData.setString(1, date);
                pstmtData.setString(2, source);
                pstmtData.setString(3, title);
                pstmtData.setString(4, post);
                pstmtData.setString(5, sentiment);
                pstmtData.setString(6, link);
                pstmtData.setString(7, fileDocPath);
                pstmtData.setString(8, date11);
                pstmtData.setString(9, ipAddress);
                pstmtData.setString(10, totalengagement);
                pstmtData.setString(11, workcode);
//                pstmtData.setString(12, ipAddress);
                if (pstmtData.executeUpdate() > 0) {
                    response.sendRedirect("dm_edit.jsp?workcode=" + workcode + "&success");

                }

            } catch (FileUploadException ex) {
                throw new ServletException(ex);
            } catch (Exception ex) {
                throw new ServletException(ex);
            }

        } catch (Exception e) {
            System.out.println("Exception in insert data :-" + e.getMessage());
        } finally {
            if (dh != null) {
                dh.close();

            }
        }
        return mapping.findForward(SUCCESS);
    }
}
