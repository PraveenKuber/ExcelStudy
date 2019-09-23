package com.EStudy.util;

import com.EStudy.manager.MongoPersistenceManager;

/**
 * Created by praveen on 11/5/19.
 */
public class ParseExcelFiles {
    private MongoPersistenceManager pm = null;

    public ParseExcelFiles(){
        pm = MongoPersistenceManager.getInstance();
    }


    public void parseAndInsertRS(String filePath){

    }

    public static void main(String[] args) {
        ParseExcelFiles parseExcelFiles = new ParseExcelFiles();
        parseExcelFiles.parseAndInsertRS("");
    }
}
