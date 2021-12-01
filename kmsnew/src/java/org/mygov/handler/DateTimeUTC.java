/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.mygov.handler;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

/**
 *
 * @author mrsac1
 */
public class DateTimeUTC {
      static final String DATEFORMAT = "yyyy-MM-dd HH:mm:ss";
      static final String DATEFORMAT2 = "yyyy-MM-dd HH:mm:ss";
      static final String DATEFORMAT3 = "MM-dd-yyyy_HH-mm-ss";
      static final String DATEFORMAT4 = "yyyyMMddHHmmss";
      static final String DATEFORMAT1 = "dd-MM-yyyy";
  
   
       
      public static String getCurrentDate(){
       final SimpleDateFormat sdf = new SimpleDateFormat(DATEFORMAT1);
        sdf.setTimeZone(TimeZone.getTimeZone("IST"));
        final String utcTime = sdf.format(new Date());
          return utcTime;
      }
      public static String getCurrentDateTime(){
       final SimpleDateFormat sdf = new SimpleDateFormat(DATEFORMAT3);
        sdf.setTimeZone(TimeZone.getTimeZone("IST"));
        final String utcTime = sdf.format(new Date());
          return utcTime;
      }
      public static String getNewCurrentDateTime(){
       final SimpleDateFormat sdf = new SimpleDateFormat(DATEFORMAT4);
        sdf.setTimeZone(TimeZone.getTimeZone("IST"));
        final String utcTime = sdf.format(new Date());
          return utcTime;
      }

public static Date GetUTCdatetimeAsDate()
{
    //note: doesn't check for null
    return StringDateToDate(GetUTCdatetimeAsString());
}

public static String GetUTCdatetimeAsString()
{
    final SimpleDateFormat sdf = new SimpleDateFormat(DATEFORMAT);
    sdf.setTimeZone(TimeZone.getTimeZone("IST"));
    final String utcTime = sdf.format(new Date());

    return utcTime;
}

public static Date StringDateToDate(String StrDate)
{
    Date dateToReturn = null;
    SimpleDateFormat dateFormat = new SimpleDateFormat(DATEFORMAT);

    try
    {
        dateToReturn = (Date)dateFormat.parse(StrDate);
    }
    catch (ParseException e)
    {
        e.printStackTrace();
    }

    return dateToReturn;
}
  public static void main(String args[]){
      System.out.println(GetUTCdatetimeAsString()+"5:30");
      System.out.println(GetUTCdatetimeAsDate());
      System.out.println(GetUTCdatetimeAsDate());
      System.out.println(getCurrentDate());
      
}

    
}
