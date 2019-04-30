package com.EStudy.manager;

import com.EStudy.model.SummarizeWrittenText;
import com.EStudy.model.WriteEssay;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by praveen on 6/4/19.
 */
public class WritingManager {
    private MongoPersistenceManager pm = null;

    public  WritingManager() {
        pm = MongoPersistenceManager.getInstance();
    }

    public int  getCollectionCount(String collectionName){
        int count = pm.getCountOfCollection(collectionName,new BasicDBObject());
        return count;
    }

    public SummarizeWrittenText getSummarizeWrittenTextDetails(int skip, int limit){
        System.out.println("Query in SWT ::::::skip ::::"+skip+":::::;; limit ::::"+limit);
        DBCursor dbCursor = pm.searchEntityWithSkipAndLimit(SummarizeWrittenText.class.getSimpleName(),skip,limit);
        SummarizeWrittenText summarizeWrittenText = new SummarizeWrittenText();
        DBObject dbObject;
        while (dbCursor.hasNext()){
            List<String> suggestionList = new ArrayList<>();
            dbObject = dbCursor.next();
            summarizeWrittenText.setWrittenText(dbObject.get("writtenText").toString());
            summarizeWrittenText.setSampleAnswerHeader(dbObject.get("sampleAnswerHeader").toString());
            summarizeWrittenText.setSampleAnswerContent(dbObject.get("sampleAnswerContent").toString());
            suggestionList = (List) dbObject.get("suggestedPoints");
            summarizeWrittenText.setSuggestedPoints(suggestionList);
            summarizeWrittenText.setPreviouslyOccurred(dbObject.get("previouslyOccurred").toString());
        }
        return summarizeWrittenText;
    }

    public WriteEssay getWriteEssayDetails(int skip, int limit){
        System.out.println("Query in WE ::::::skip ::::"+skip+":::::;; limit ::::"+limit);
        DBCursor dbCursor = pm.searchEntityWithSkipAndLimit(WriteEssay.class.getSimpleName(),skip,limit);
        WriteEssay writeEssay = new WriteEssay();
        DBObject dbObject;
        while (dbCursor.hasNext()){
            List<String> suggestionList = new ArrayList<>();
            dbObject = dbCursor.next();
            writeEssay.setEssayQuestion(dbObject.get("essayQuestion").toString());
            writeEssay.setThemeName(dbObject.get("themeName").toString());
            suggestionList = (List) dbObject.get("suggestedPoints");
            writeEssay.setSuggestedPoints(suggestionList);
            writeEssay.setPreviouslyOccurred(dbObject.get("previouslyOccurred").toString());
        }
        return writeEssay;
    }



}
