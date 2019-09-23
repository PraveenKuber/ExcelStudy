package com.EStudy.util;


import com.EStudy.manager.MongoPersistenceManager;
import com.mongodb.BasicDBObject;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Iterator;

/**
 * Created by praveen on 1/5/19.
 */
public class ExcelReader {
    private MongoPersistenceManager pm = null;

    public ExcelReader(){
        pm = MongoPersistenceManager.getInstance();
    }

    public void parseAndInsertRA(String filePath) throws IOException {
        String excelFilePath = filePath;
        FileInputStream inputStream = new FileInputStream(new File(excelFilePath));
        HSSFWorkbook workbook = new HSSFWorkbook(inputStream);
        HSSFSheet firstSheet = workbook.getSheetAt(0);
        Iterator<Row> iterator = firstSheet.rowIterator();
        while (iterator.hasNext()) {
            Row nextRow = iterator.next();
            if (nextRow.getRowNum() == 0) {
                continue;
            }
            Cell cell = nextRow.getCell(2);
            String audioScript = cell.getStringCellValue();
            cell = nextRow.getCell(3);
            int previouslyOccurred = (int) cell.getNumericCellValue();
            cell = nextRow.getCell(5);
            int recordableLength = (int) cell.getNumericCellValue();
            String previouslyOccurredRA = String.valueOf(previouslyOccurred);
            String recordableLengthRA = String.valueOf(recordableLength);
            BasicDBObject insertQuery = new BasicDBObject("audioScript",audioScript).
                    append("recordableLength",recordableLengthRA).append("previouslyOccurred",previouslyOccurredRA);
            System.out.println("Query :::::::"+insertQuery);
            pm.insertBasicDBObject("RA",insertQuery);

        }
        workbook.close();
        inputStream.close();
    }


    public void parseAndInsertRS(String filePath) throws IOException {
        String excelFilePath = filePath;
        FileInputStream inputStream = new FileInputStream(new File(excelFilePath));
        HSSFWorkbook workbook = new HSSFWorkbook(inputStream);
        HSSFSheet firstSheet = workbook.getSheetAt(0);
        Iterator<Row> iterator = firstSheet.rowIterator();
        while (iterator.hasNext()) {
            Row nextRow = iterator.next();
            if (nextRow.getRowNum() == 0) {
                continue;
            }
            Cell cell = nextRow.getCell(1);
            String audioScript = cell.getStringCellValue();
            System.out.println("audioScript::::::"+audioScript);
            cell = nextRow.getCell(2);
            int previouslyOccurred = (int) cell.getNumericCellValue();
            cell = nextRow.getCell(3);
            int fileName = (int) cell.getNumericCellValue();
            String fileNameAbsolute = "resource/repeatSentence/"+fileName+".mp3";
            String previouslyOccurredRS = String.valueOf(previouslyOccurred);
            cell = nextRow.getCell(4);
            int recordableLength = (int) cell.getNumericCellValue();
            recordableLength = recordableLength + 3;
            String recordableLengthRS = String.valueOf(recordableLength);
            int audioFileLength = (int) cell.getNumericCellValue();
            String audioFileLengthRS = String.valueOf(audioFileLength);

            BasicDBObject insertQuery = new BasicDBObject("audioScript",audioScript).
                    append("recordableTime",recordableLengthRS).append("previouslyOccurred",previouslyOccurredRS).
                    append("audioFileLength",audioFileLengthRS).append("audioPath",fileNameAbsolute);

            System.out.println("Query RS:::::::"+insertQuery);
            pm.insertBasicDBObject("RS",insertQuery);

        }
        workbook.close();
        inputStream.close();
    }



    public void parseAndInsertDI(String filePath) throws IOException {
        String excelFilePath = filePath;
        FileInputStream inputStream = new FileInputStream(new File(excelFilePath));
        HSSFWorkbook workbook = new HSSFWorkbook(inputStream);
        HSSFSheet firstSheet = workbook.getSheetAt(0);
        Iterator<Row> iterator = firstSheet.rowIterator();
        while (iterator.hasNext()) {
            Row nextRow = iterator.next();
            if (nextRow.getRowNum() == 0) {
                continue;
            }
            Cell cell = nextRow.getCell(1);
            int fileName = (int) cell.getNumericCellValue();
            String fileNameDI = "resource/describeImage/"+fileName+".jpg";

            String previouslyOccurred = "-";

            cell = nextRow.getCell(3);
            int recordableLength = (int) cell.getNumericCellValue();
            String recordableLengthDI = String.valueOf(recordableLength);
            BasicDBObject insertQuery = new BasicDBObject("imagePath",fileNameDI).
                    append("recordableTime",recordableLengthDI).append("previouslyOccurred",previouslyOccurred);
            System.out.println("Query DI :::::::"+insertQuery);
            pm.insertBasicDBObject("DI",insertQuery);

        }
        workbook.close();
        inputStream.close();
    }


    public void parseAndInsertRL(String filePath) throws IOException {
        String excelFilePath = filePath;
        FileInputStream inputStream = new FileInputStream(new File(excelFilePath));
        HSSFWorkbook workbook = new HSSFWorkbook(inputStream);
        HSSFSheet firstSheet = workbook.getSheetAt(0);
        Iterator<Row> iterator = firstSheet.rowIterator();
        while (iterator.hasNext()) {
            Row nextRow = iterator.next();
            if (nextRow.getRowNum() == 0) {
                continue;
            }

            Cell cell = nextRow.getCell(2);
            int fileName = (int) cell.getNumericCellValue();
            String fileNameRL = "resource/retellLecture/"+fileName+".mp3";

            cell = nextRow.getCell(1);
            String audioScript = cell.getStringCellValue();


            cell = nextRow.getCell(3);
            String audioFileLength = cell.getRichStringCellValue().getString();
            System.out.println(":::::::::::"+audioFileLength);





            cell = nextRow.getCell(4);
            int recordableLength = (int) cell.getNumericCellValue();


            String previouslyOccurred = "-";


            System.out.println("Audio file length :::::::"+audioFileLength);
            BasicDBObject insertQuery = new BasicDBObject("audioFilePath",fileNameRL).
                    append("audioScript",audioScript).append("previouslyOccurred",previouslyOccurred).
                    append("recordableTime",recordableLength).append("audioFileLength",audioFileLength);
            //System.out.println("Query RL :::::::"+insertQuery);

            //pm.insertBasicDBObject("RL",insertQuery);

        }
        workbook.close();
        inputStream.close();
    }


    public static void main(String[] args) throws IOException {
        ExcelReader excelReader = new ExcelReader();
        //excelReader.parseAndInsertRS("/home/praveen/Documents/ExcelStudy/Parse/RS_New.xls");
        //excelReader.parseAndInsertRA("/home/praveen/Documents/ExcelStudy/Parse/test.xls");
        //excelReader.parseAndInsertDI("/home/praveen/Documents/ExcelStudy/Parse/DI_New.xls");
        excelReader.parseAndInsertRL("/home/praveen/Documents/ExcelStudy/Parse/RL_New.xls");
    }
}
