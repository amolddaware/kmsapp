package org.mygov.news.update;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
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
 * @author Amol
 */
public class NewsInformationUpdateAction extends org.apache.struts.action.Action {

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

        String rbPath = rb.getString("filePath");
//        request.getParameter("token");
        String userid = session.getAttribute("userid").toString();
        String role = session.getAttribute("role").toString();
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
            final String date = dtime.GetUTCdatetimeAsString();
            final String newDateTime = dtime.getNewCurrentDateTime();

//                        DataentryActionForm dataentry = (DataentryActionForm) form;
            String workcode = null;
//            System.out.println(subject);
            String subject = null, desc = null, summary = null, chname = null, tags = null, sourcedate = null, titlemarathi = null, sentiment = null, tempvideo = null;

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

//            System.out.println("test upload:-" + pathofUploadingFile);
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
            String filePathofImage = null;
//            String smbUrl = "smb://172.16.16.199/k/KMS/uploads/printmedia/" + date1;
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
//                    System.out.println("testitem:=" + item);
                    if (!item.isFormField()) {
                        String fileName = new File(item.getName()).getName();
                        String fileExt = new File(item.getName()).getPath();
//                        System.out.println("filename:---" + fileName);
//                        System.out.println(fileExt);
                        if (!fileName.isEmpty()) {
                            File uploadedFile = null;
//                            System.out.println("hjjh khkhk:-" + filePath);
                            int i = fileName.lastIndexOf('.');
                            String extension;
                            if (i > 0) {
                                extension = fileName.substring(i + 1).toLowerCase();
//                                String newFilename = fileName.replaceAll(fileName, "p" + newDateTime + "." + extension);

                                String filePath = uploadFolder + File.separator + fileName.toLowerCase();
                                uploadedFile = new File(filePath);
//                                smbFilepath = smbUrl + File.separator + fileName.toLowerCase();

//                            System.out.println(extension);
//                            txt doc docx xls xlsx pdf ppt pptx
                                if (extension.equals("png") || extension.equals("jpg") || extension.equals("jpeg") || extension.equals("gif")) {
                                    fileImgPath = fileImgPath + filePath + "::";
//                                    System.out.println("uploadimagepath:-" + fileImgPath);
//                                    strBuff.append(fileImgPath + "::");
//
//                                    smbImgPath = smbImgPath + smbFilepath + "::";
                                } //                            mov m4v mp4 mpeg avi wmv
                                else if (extension.equals("mov") || extension.equals("m4v") || extension.equals("mp4") || extension.equals("mpeg") || extension.equals("avi") || extension.equals("wmv") || extension.equals("mxf")) {
                                    fileVdoPath = fileVdoPath + filePath + "::";
//                                    System.out.println("fileVdoPath:-" + fileVdoPath);
//                                    strBuffVdo.append(fileImgPath + "::");

  //                                  smbVdoPath = smbVdoPath + smbFilepath + "::";

                                }
                            }
                            //                    String content = new String(Files.readAllBytes(Paths.get(fileName)));

                            // saves the file to upload directory
                            item.write(uploadedFile);
                        }
                    }
                    if (item.isFormField()) {
//                        if (item.getFieldName().equals("uploadImage")) {
//                            filePathofImage = item.getString();
////                            System.out.println(subject);
//                        }
                        if (item.getFieldName().equals("workcode")) {
                            workcode = item.getString();
//                            System.out.println(subject);
                        }
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
//                System.out.println("filePathofImage:-"+filePathofImage);
//                StringBuffer fullfilepath = new StringBuffer();
//                if (!filePathofImage.isEmpty()&& fileImgPath.isEmpty()) {
//                    fullfilepath.append(filePathofImage);
//                }
//                else if (!filePathofImage.isEmpty()&& !fileImgPath.isEmpty()) {
//                    fullfilepath.append(filePathofImage + "::" + fileImgPath);
//                } else if (!fileImgPath.isEmpty()) {
//                    fullfilepath.append(fileImgPath + "::");
//                }
                fileImgPath = fileImgPath.replace("\\", "/");
                fileVdoPath = fileVdoPath.replace("\\", "/");
                System.out.println("fileImgPath:-" + fileImgPath);
                System.out.println("fileVdoPath:-" + fileVdoPath);

                String updateData = "update tbl_news_dataentry set subject=?,description=?,titlemarathi=?,sentiment=?,"
                        + "additionaltag=?,sourcedate=?,vdopath=concat(vdopath,?),"
                        + "graphicspath=concat(graphicspath,?),chname=? where workcode=? ";
                System.out.println("updateData:" + updateData);
                PreparedStatement pstmtupData = dh.prepareStatement(updateData);
                pstmtupData.setString(1, subject);
                pstmtupData.setString(2, desc);
                pstmtupData.setString(3, titlemarathi);
                pstmtupData.setString(4, sentiment);
                pstmtupData.setString(5, tags);
                pstmtupData.setString(6, sourcedate);
                pstmtupData.setString(7, fileVdoPath);
                pstmtupData.setString(8, fileImgPath);
                pstmtupData.setString(9, chname);
                pstmtupData.setString(10, workcode);
                if (pstmtupData.executeUpdate() > 0) {
                    response.sendRedirect("em_videoedit.jsp?workcode=" + workcode + "&success&fromSourceDate=" + sourcedate + "&toSourceDate=" + sourcedate);

//                            response.sendRedirect("newsinformation_dataentry_edit.jsp?workcode=" + workcode + "&success");
//                       response.sendRedirect("userDataentry_1.jsp#upload?success");
                }
                // displays done.jsp page after upload finished
                //            getServletContext().getRequestDispatcher("/upload.html").forward(
                //                    request, response);
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
