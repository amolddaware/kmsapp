/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.fsc.excel;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Iterator;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author Fluidscapes
 */
public class TwitterMain2018 {

    XSSFRow row;

    private boolean flag = false;
    TwitterPost t = new TwitterPost();
    TwitterPostDao2018 t1 = new TwitterPostDao2018();

    public static void main(String[] args) throws IOException, FileNotFoundException, ClassNotFoundException, SQLException, ServletException {

//        String fileName = "D:\\daily highlights - 2nd march 2020.xlsx";
        String fileName = "D:\\KMS\\KMS Excel files for upload\\Daily Highlights 2020\\Daily Highlights 2020\\March 2020.xlsx";
        TwitterMain2018 poIex2 = new TwitterMain2018();
        poIex2.readFile(fileName);
    }
//    public boolean runExcelFile(String fileName, String userid,String sourcedate,String schedule,String date11,String ipAddress,String keyword) throws IOException, FileNotFoundException, ClassNotFoundException, SQLException, ServletException {
//
////        String fileName = "D:\\testreport.xlsx";
//        TwitterMain2018 poIex2 = new TwitterMain2018();
//        if (poIex2.readFile(fileName, userid,sourcedate,schedule,date11,ipAddress,keyword) == true) {
//            flag = true;
//        } else {
//            flag = false;
//
//        }
//        System.out.println("flag:-"+flag);
//        return flag;
//    }

    private void readFile(String fileName) throws FileNotFoundException, IOException, ClassNotFoundException, SQLException, ServletException {
        FileInputStream fis;
        try {
            System.out.println("-------------------------------READING THE SPREADSHEET-------------------------------------");
            fis = new FileInputStream(fileName);
            XSSFWorkbook workbookRead = new XSSFWorkbook(fis);
            XSSFSheet spreadsheetRead = workbookRead.getSheetAt(25);
            String sourcedate = "2020-03-31";

            int countNumber = 0;
            Iterator< Row> rowIterator = spreadsheetRead.iterator();
            while (rowIterator.hasNext()) {
                countNumber++;
                row = (XSSFRow) rowIterator.next();
                Iterator< Cell> cellIterator = row.cellIterator();

                while (cellIterator.hasNext()) {

                    Cell cell = cellIterator.next();
                    cell.setCellType(CellType.STRING);
//                    if(cell()==CellType.STRING){
//                    
//                    }
                    switch (cell.getColumnIndex()) {
                        case 0:
                            System.out.print(
                                    cell.getStringCellValue() + " \t\t");
                            break;
                        case 1:
                            System.out.print(
                                    cell.getStringCellValue() + " \t\t");
                            break;
                        case 2:
                            System.out.print(
                                    cell.getStringCellValue() + " \t\t");
                            break;
                        case 3:
                            System.out.print(
                                    cell.getStringCellValue() + " \t\t");
                            break;
                        case 4:
                            System.out.print(
                                    cell.getStringCellValue() + " \t\t");
//                                    cell.getStringCellValue()+ " \t\t");
                            break;
                        case 5:
                            System.out.print(
                                    cell.getStringCellValue() + " \t\t");
                            break;
                        case 6:
                            System.out.print(
                                    cell.getStringCellValue() + " \t\t");
                            break;
//                        case 7:
//                            System.out.print(
//                                    cell.getStringCellValue() + " \t\t");
//                            break;
                    }
                }
                System.out.println();
//             if (cellIterator. == CellType.BLANK) {
                //do your stuff here
//}
                t.source = row.getCell(1).getStringCellValue();
//                t.source = Integer.parseInt(row.getCell(0).getStringCellValue());
                t.topic = row.getCell(2).getStringCellValue();
                t.url = row.getCell(3).getStringCellValue();
                t.post = row.getCell(4).getStringCellValue();
                t.count = row.getCell(5).getStringCellValue();
                t.sentiment = row.getCell(6).getStringCellValue();
                HttpServletResponse response = null;
                if (t.url != null) {

                    t1.InsertTwitterRowInDB(t.source,t.topic, t.url, t.post, t.count,t.sentiment, sourcedate);
//                    if(t1.InsertTwitterRowInDB(t.topic, t.url, t.post, t.count, userid,sourcedate,schedule,date11,ipAddress,keyword)==true){
                    System.err.println("true");
//                        flag = true;
//                    }else{
//                        HttpServletRequest request=null;
//                        RequestDispatcher req=null;
//                        RequestDispatcher rd = request.getRequestDispatcher("dm_add.jsp?fail");
//                rd.forward(request, response);
//                        req.forward("dm_add.jsp?fail", response);
//                        response.sendRedirect("dm_add.jsp?fail");
//                        flag = false;
//                        System.out.println("false"); 
//                    }

                } else {
//                    flag = false;
                }

//                }
            }
            System.out.println("Values Inserted Successfully");

            fis.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
//        return flag;
    }

//    private void readFile(String fileName) {
//        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
//    }
}
