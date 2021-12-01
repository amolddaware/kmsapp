/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.fsc.excel;

/**
 *
 * @author Fluidscapes
 */

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Iterator;
import java.util.Properties;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author nidhi
 */
public class POIex2 {

    XSSFRow row;
    Employee e = new Employee();
    EmployeeDao e1 = new EmployeeDao();

    public static void main(String[] args) throws IOException {

        String fileName = "D:\\testreport.xlsx";
        POIex2 poIex2 = new POIex2();
        poIex2.readFile(fileName);
    }
    public static void runExcelFile(String fileName) throws IOException {

//        String fileName = "D:\\testreport.xlsx";
        POIex2 poIex2 = new POIex2();
        poIex2.readFile(fileName);
    }

    public void readFile(String fileName) throws FileNotFoundException, IOException {
        FileInputStream fis;
        try {
            System.out.println("-------------------------------READING THE SPREADSHEET-------------------------------------");
            fis = new FileInputStream(fileName);
            XSSFWorkbook workbookRead = new XSSFWorkbook(fis);
            XSSFSheet spreadsheetRead = workbookRead.getSheetAt(0);

            Iterator< Row> rowIterator = spreadsheetRead.iterator();
            while (rowIterator.hasNext()) {
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
//                            System.out.print(
//                                    cell.getNumericCellValue()+ " \t\t");
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
                            break;
                    }
                }
                System.out.println();
                e.empId = Integer.parseInt(row.getCell(0).getStringCellValue());
                e.firstName = row.getCell(1).getStringCellValue();
                e.lastName = row.getCell(2).getStringCellValue();
                e.emailid = row.getCell(3).getStringCellValue();

                e1.InsertRowInDB(e.empId, e.firstName, e.lastName, e.emailid);
            }
            System.out.println("Values Inserted Successfully");

            fis.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
