package org.mygov.handler;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Amol
 */
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Amol
 */
//import com.mysql.jdbc.Connection;
//import com.mysql.jdbc.PreparedStatement;
import com.sun.mail.smtp.SMTPTransport;
import java.awt.Image;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.Security;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.imageio.ImageIO;
import javax.mail.*;
import javax.mail.internet.*;

public class SendMailGov {

    public static void SendLocal(String recipientEmail,String user,String randomPass) throws AddressException, MessagingException, MalformedURLException, IOException {
//        final String ccEmail = "dhulekirana@gmail.com";//change accordingly  
//        final String ccEmail = "amol@fluidscapes.in";//change accordingly  
//        final String password = "a1m1o1l1";
        final String username = "fscdev@fluidscapes.in";//change accordingly  
//        final String username = "amol@fluidscapes.in";//change accordingly  
//        final String password = "fsc@1234";
// final String username = "nashikkirana2020@gmail.com";//change accordingly  
// final String username = "info@studyatukraine.com";//change accordingly  
//        final String username = "mygov.cmomh";//change accordingly  
//        final String user = "sahabhag.maharashtra";//change accordingly  
//         final String user = "cmfellow1.cmo";//change accordingly  
//        final String password = "Amol@123";
        final String password = "Dev@FSC.com1234";
//     
        Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
        final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
        // Get a Properties object
        Properties props = System.getProperties();
        props.setProperty("mail.smtps.host", "smtp.gmail.com"); //change this to your email host if using mail exchanger then use ip of that server
//        props.setProperty("mail.smtps.host", "mail.gov.in"); //change this to your email host if using mail exchanger then use ip of that server
        props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
        props.setProperty("mail.smtp.socketFactory.fallback", "false");
        props.setProperty("mail.smtp.port", "587");  // use port 465 for ssl / 25 for exchanger
        props.setProperty("mail.smtp.socketFactory.port", "587");
        props.setProperty("mail.smtp.auth", "true");

        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.auth", "true");

        /*
         If set to false, the QUIT command is sent and the connection is immediately closed. If set 
         to true (the default), causes the transport to wait for the response to the QUIT command.

         ref :   http://java.sun.com/products/javamail/javadocs/com/sun/mail/smtp/package-summary.html
         http://forum.java.sun.com/thread.jspa?threadID=5205249
         smtpsend.java - demo program from javamail
         */
        props.put("mail.smtps.quitwait", "false");

        Session session = Session.getInstance(props, null);

        // -- Create a new message --
        final MimeMessage msg = new MimeMessage(session);

        // -- Set the FROM and TO fields --
        msg.setFrom(new InternetAddress(username.trim()));
//        msg.setFrom(new InternetAddress(username.trim() + "@gov.in"));
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail, false));

//        if (ccEmail.length() > 0) {
//            msg.setRecipients(Message.RecipientType.BCC, InternetAddress.parse(ccEmail, false));
//        }

        msg.setSubject("Knowledge Management System");
        msg.setContent("Hi "+ user+",\n"
                + "Your account has been created for Knowledge Management System. \n"
                + "Please use the below credentials for login into your account."
                + "Username:- "+recipientEmail+"\n"
                + "Password:-"+randomPass+"\n", "text/html");
        SMTPTransport t = (SMTPTransport) session.getTransport("smtps");
        t.connect("smtp.gmail.com", username, password);
//        t.connect("mail.gov.in", username, password);
        t.sendMessage(msg, msg.getAllRecipients());
        t.close();
    }
    public static void main(String[] args) throws MessagingException, AddressException, IOException {
//        SendLocal("sunilbadame05@gmail.com", "Sunil", "12345");
//        SendLocal("nashikkirana2020@gmail.com", "Amol", "12345");
        SendLocal("amol@fluidscapes.in", "Amol", "12345");
    }
}


