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
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.nio.file.DirectoryNotEmptyException;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.ResourceBundle;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
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
import org.apache.juli.logging.Log;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.mygov.handler.DateTimeUTC;

/**
 *
 * @author Fluidscapes
 */
public class NewsDragNDropAction extends org.apache.struts.action.Action {

    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private int maxFileSize = 10000 * 1024 * 1024;
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
     * @throws org.apache.commons.fileupload.FileUploadException
     * @throws java.io.FileNotFoundException
     * @throws java.io.IOException
     * @throws java.net.MalformedURLException
     */
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception, FileUploadException, FileNotFoundException, MalformedURLException, IOException {
        ResourceBundle rb = ResourceBundle.getBundle("msg");
        PrintWriter out = response.getWriter();
        String rbPath = rb.getString("filePath");
        HttpSession session = request.getSession();
        DateTimeUTC dtime = new DateTimeUTC();
        final String date = dtime.getCurrentDate();
        String userid = session.getAttribute("userid").toString();
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        String vlink = "";
        String ilink = "";
        String dlink = "";
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
        final File f = new File(NewsDragNDropAction.class.getProtectionDomain().getCodeSource().getLocation().getPath());
        System.out.println("ffff:-" + f);
        final String date1 = dtime.getCurrentDate();
//        String UPLOADED_FOLDER = request.getContextPath() + rbPath;

        // constructs the folder where uploaded file will be stored
//                String uploadFolder = "c://temp//directory";
//        Path dir = Files.createDirectories(Paths.get(UPLOADED_FOLDER + "\\" + date));
//        Path dir = Files.createDirectories(Paths.get(rbPath + "\\" + date));
        String pathofUploadingFile = request.getServletContext().getRealPath("/");

        System.out.println("test upload:-" + pathofUploadingFile);
        Path dir = Files.createDirectories(Paths.get(rbPath + "/" + date1));
//        Path dir = Files.createDirectories(Paths.get(pathofUploadingFile + rbPath + "/" + date1));
//        Path dirsmb = Files.createDirectories(Paths.get("/home/amol/myNas/myShare/" + rbPath + "/" + date1));
//        final InputStream dirsmb = Files.newInputStream(Paths.get("/home/amol/myNas/myShare/" + rbPath + "/" + date1));

//            Path dir = Files.createDirectories(Paths.get("D:\\KMS_Storage\\Upload\\"+date));
//            Path dir = Files.createDirectories(Paths.get("D:\\Tomcat\\webapps\\knowmgt\\NewStore\\"+date));
//            Path dir = Files.createDirectories(Paths.get("c://temp/upload/News"));
        String uploadFolder = dir.toString();
//        String uploadsmbFolder = dirsmb.toString();
        //        String up = dir.toString();
        System.out.println("localfolder:" + uploadFolder);
//        System.out.println("smbfolder:" + uploadsmbFolder);
        //        String uploadFolder = getServletContext().getRealPath("")
        //                + File.separator + "c://temp";
        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload(factory);

        // Set overall request size constraint
        upload.setSizeMax(maxFileSize);
//            String subject = "";
        String fileDocPath = "", fileVdoPath = "", fileImgPath = "", fileAudioPath = "";
//        String smbUrl = "smb://172.16.16.199/k/KMS/uploads/electronic/" + date1;
//        String user = "kms:CSF@1234";
//        NtlmPasswordAuthentication auth = new NtlmPasswordAuthentication(user);
//
//        try {
//            SmbFile remoteDir = new SmbFile(smbUrl, auth);
//// Create remote folder if not exist
//            if (!remoteDir.exists()) {
//                remoteDir.mkdirs();
//            }
//        } catch (IOException e) {
//            System.out.println("error in upload file:" + e.getMessage());
////                        e.printStackTrace();
//        }
//        System.out.println("smburl:" + smbUrl);
//        String smbImgPath = "", smbVdoPath = "", smbDocPath = "", smbFilepath = "";
//        StringBuffer strBuff = new StringBuffer();

        try {
            // Parse the request
            List items = upload.parseRequest(request);
//            ArrayList<String> lstImg = new ArrayList<>();
//            ArrayList<String> lstVdo = new ArrayList<>();
//            ArrayList<String> lstDoc = new ArrayList<>();
//            StringBuilder sbImg = new StringBuilder();
//            StringBuilder sbVdo = new StringBuilder();
//            StringBuilder sbDoc = new StringBuilder();

            ConnectionDB conn = new ConnectionDB();
            Connection dh = conn.getConnection();

            Iterator iter = items.iterator();
            while (iter.hasNext()) {
                FileItem item = (FileItem) iter.next();
//                    System.out.println(item);
                if (!item.isFormField()) {
                    String fileName = new File(item.getName()).getName();
                    String fileExt = new File(item.getName()).getPath();

                    String sss[] = fileName.split("\\[");
                    String chname[] = sss[0].split("_");
                    String chname11 = chname[1].toString();
                    String fullChName = chname11.trim().toString();
                    String ss = sss[1].toString();
//                    System.out.println("sss:-" + ss);
                    Pattern pt = Pattern.compile("[^a-zA-Z0-9.]");
                    Matcher match = pt.matcher(ss);
                    while (match.find()) {
                        String s = match.group();
                        ss = ss.replaceAll("\\" + s, "");
                    }
//                    System.out.println("pattern:-" + ss);
                    String ss1 = ss.replace("..", "_");

                    String fullFileName = fullChName + "_" + ss1;
//                    System.out.println("newfile:-" + fullFileName);
                    String filePath = uploadFolder + File.separator + fullFileName;
//                    String filePathSmb = smbUrl + File.separator + fullFileName;
//                    String filePathSmb = "/home/amol/myNas/myShare/" + rbPath + "/" + date1 + File.separator + fullFileName;
                    File uploadedFile = new File(filePath);
//                    File uploadedSmbFile = new File(filePathSmb);
//                    
                 
                    String selectQuery = "select vdopath from tbl_news_dataentry where vdopath like '%" + fullFileName + "%'";
                    System.out.println("selectquery:-" + selectQuery);
                    PreparedStatement pstmt = dh.prepareStatement(selectQuery);
                    ResultSet rs = pstmt.executeQuery();
                    if (rs.next()) {
                        System.out.println("available:-" + fullFileName);
                        out.println("exist," + fullFileName);
//                        request.setAttribute("filename", fullFileName);

                    } else {
                        System.out.println("ttttest ");
                        item.write(uploadedFile);
//                        item.write(uploadedFile);
                        String insertData = "insert into tbl_temp_video_files (userid,vdopath,datetime) "
                                + "values (?,?,?)";
                        PreparedStatement pstmtData = dh.prepareStatement(insertData);
                        System.out.println("insertdata:-" + insertData);
                        pstmtData.setString(1, userid);
                        pstmtData.setString(2, filePath);
                        pstmtData.setString(3, date);
                        pstmtData.executeUpdate();

                        System.out.println("not available:-" + fullFileName);

//                }
                    }
                }
            }
//            String user = "kms:CSF@1234";
//            NtlmPasswordAuthentication auth = new NtlmPasswordAuthentication(user);
//
//            InputStream in = null;
//            OutputStream out1 = null;
//            System.out.println("test by me");
////                String ff[] = strBuff.toString().split("::");
//            SmbFile remoteFile = null;
////                for (String dd : ff) {
//            try {
//                SmbFile remoteDir = new SmbFile(smbUrl, auth);
//// Create remote folder if not exist
//                if (!remoteDir.exists()) {
//                    remoteDir.mkdirs();
//                }
////                        String proHttp="http://35.234.46.225/"+filePath.substring(21);
//                File localFile = new File(smbFilepath);
//                String fileName1 = localFile.getName();
//                String pp = smbUrl + "/" + fileName1;
//                remoteFile = new SmbFile(pp, auth);
//                in = new BufferedInputStream(new FileInputStream(localFile));
//                out1 = new BufferedOutputStream(new SmbFileOutputStream(remoteFile));
//                byte[] buffer = new byte[1024];
//                while ((in.read(buffer)) != -1) {
//                    out1.write(buffer);
////                            System.out.println("tete");
//                    buffer = new byte[1024];
//                }
//                int i = 0;
////                SmbFile checkFile = new SmbFile(pp, auth);
//                if (remoteFile.exists()) {
//
//                    System.out.println("exist");
//                    System.out.println("loooo:" + localFile);
//                    if (localFile.delete()) {
//                        System.out.println("File deleted successfully");
//                    } else {
//                        System.out.println("Failed to delete the file");
//                    }
//                    try {
//                        Files.deleteIfExists(Paths.get(localFile.toString()));
//                    } catch (NoSuchFileException e) {
//                        System.out.println("No such file/directory exists");
//                    } catch (DirectoryNotEmptyException e) {
//                        System.out.println("Directory is not empty.");
//                    } catch (IOException e) {
//                        System.out.println("Invalid permissions.");
//                    }
//
//                    System.out.println("Deletion successful.");
////                    System.out.println("<br>");
//                } else {
//                    System.out.println("not available");
//                }
//            } catch (IOException e) {
//                System.out.println("error in upload file:" + e.getMessage());
////                        e.printStackTrace();
//            }
        } catch (FileUploadException ex) {
            throw new ServletException(ex);
        } catch (Exception ex) {
            throw new ServletException(ex);
        }

        return mapping.findForward(SUCCESS);
    }
}
