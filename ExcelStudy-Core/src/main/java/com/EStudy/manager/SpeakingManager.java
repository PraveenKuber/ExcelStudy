package com.EStudy.manager;

import com.EStudy.model.*;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by praveen on 22/3/19.
 */
public class SpeakingManager {
    private MongoPersistenceManager pm = null;

    public  SpeakingManager() {
        pm = MongoPersistenceManager.getInstance();
    }


    public int  getShortQuestionCount(){
        int count = pm.getCountOfCollection(ShortQuestion.class.getSimpleName(),new BasicDBObject());
        return count;
    }

    public int  getRetellLectureCount(){
        int count = pm.getCountOfCollection(RetellLecture.class.getSimpleName(),new BasicDBObject());
        return count;
    }

    public int  getCollectionCount(String collectionName){
        int count = pm.getCountOfCollection(collectionName,new BasicDBObject());
        return count;
    }

    public List<ShortQuestion> getShortQuestionList(int skip, int limit){
        List<ShortQuestion> ShortQuestionList = new ArrayList<>();
        DBCursor dbCursor = pm.searchEntity(ShortQuestion.class.getSimpleName());
        ShortQuestion shortQuestion = new ShortQuestion();
        DBObject dbObject;
        while (dbCursor.hasNext()){
            dbObject = dbCursor.next();
            shortQuestion.setAudioFilePath(dbObject.get("audioFilePath").toString());
            shortQuestion.setAudioScriptQuestion(dbObject.get("audioScriptQuestion").toString());
            shortQuestion.setAudioScriptAnswer(dbObject.get("audioScriptAnswer").toString());
            shortQuestion.setAudioFileLength(dbObject.get("audioFileLength").toString());
            shortQuestion.setRecordableTime(dbObject.get("recordableTime").toString());
            shortQuestion.setPreviouslyOccurred(dbObject.get("previouslyOccurred").toString());
            ShortQuestionList.add(shortQuestion);
        }
        return ShortQuestionList;
    }

    public ShortQuestion getShortQuestionDetails(int skip, int limit){
        System.out.println("Query in SQ ::::::skip ::::"+skip+":::::;; limit ::::"+limit);
        DBCursor dbCursor = pm.searchEntityWithSkipAndLimit(ShortQuestion.class.getSimpleName(),skip,limit);
        ShortQuestion shortQuestion = new ShortQuestion();
        DBObject dbObject;
        while (dbCursor.hasNext()){
            dbObject = dbCursor.next();
            shortQuestion.setAudioFilePath(dbObject.get("audioFilePath").toString());
            shortQuestion.setAudioScriptQuestion(dbObject.get("audioScriptQuestion").toString());
            shortQuestion.setAudioScriptAnswer(dbObject.get("audioScriptAnswer").toString());
            shortQuestion.setAudioFileLength(dbObject.get("audioFileLength").toString());
            shortQuestion.setRecordableTime(dbObject.get("recordableTime").toString());
            shortQuestion.setPreviouslyOccurred(dbObject.get("previouslyOccurred").toString());
        }
        return shortQuestion;
    }


    public RetellLecture getRetellLectureDetails(int skip, int limit){
        System.out.println("Query in RQ ::::::skip ::::"+skip+":::::;; limit ::::"+limit);
        DBCursor dbCursor = pm.searchEntityWithSkipAndLimit(RetellLecture.class.getSimpleName(),skip,limit);
        RetellLecture retellLecture = new RetellLecture();
        DBObject dbObject;
        while (dbCursor.hasNext()){
            dbObject = dbCursor.next();
            retellLecture.setAudioFilePath(dbObject.get("audioFilePath").toString());
            retellLecture.setAudioScript(dbObject.get("audioScript").toString());
            retellLecture.setAudioFileLength(dbObject.get("audioFileLength").toString());
            retellLecture.setRecordableTime(dbObject.get("recordableTime").toString());
            retellLecture.setPreviouslyOccurred(dbObject.get("previouslyOccurred").toString());
        }
        return retellLecture;
    }


    public DescribeImage getDescribeImageDetails(int skip, int limit){
        System.out.println("Query in DI ::::::skip ::::"+skip+":::::;; limit ::::"+limit);
        DBCursor dbCursor = pm.searchEntityWithSkipAndLimit(DescribeImage.class.getSimpleName(),skip,limit);
        DescribeImage describeImage = new DescribeImage();
        DBObject dbObject;
        while (dbCursor.hasNext()){
            dbObject = dbCursor.next();
            describeImage.setImagePath(dbObject.get("imagePath").toString());
            describeImage.setRecordableTime(dbObject.get("recordableTime").toString());
            describeImage.setPreviouslyOccurred(dbObject.get("previouslyOccurred").toString());
        }
        return describeImage;
    }

    public RepeatSentence getRepeatSentenceDetails(int skip, int limit){
        System.out.println("Query in RS ::::::skip ::::"+skip+":::::;; limit ::::"+limit);
        DBCursor dbCursor = pm.searchEntityWithSkipAndLimit(RepeatSentence.class.getSimpleName(),skip,limit);
        RepeatSentence repeatSentence = new RepeatSentence();
        DBObject dbObject;
        while (dbCursor.hasNext()){
            dbObject = dbCursor.next();
            repeatSentence.setAudioScript(dbObject.get("audioScript").toString());
            repeatSentence.setAudioPath(dbObject.get("audioPath").toString());
            repeatSentence.setAudioFileLength(dbObject.get("audioFileLength").toString());
            repeatSentence.setRecordableTime(dbObject.get("recordableTime").toString());
            repeatSentence.setPreviouslyOccurred(dbObject.get("previouslyOccurred").toString());
        }
        return repeatSentence;
    }


    public ReadAloud getReadAloudDetails(int skip, int limit){
        System.out.println("Query in RL ::::::skip ::::"+skip+":::::;; limit ::::"+limit);
        DBCursor dbCursor = pm.searchEntityWithSkipAndLimit(ReadAloud.class.getSimpleName(),skip,limit);
        ReadAloud readAloud = new ReadAloud();
        DBObject dbObject;
        while (dbCursor.hasNext()){
            dbObject = dbCursor.next();
            readAloud.setAudioScript(dbObject.get("audioScript").toString());
            readAloud.setRecordableLength(dbObject.get("recordableLength").toString());
            readAloud.setPreviouslyOccurred(dbObject.get("previouslyOccurred").toString());
        }
        return readAloud;
    }



    public static void main(String[] args) {
          SpeakingManager speakingManager = new SpeakingManager();
       /* int count = speakingManager.getShortQuestionCount();
        System.out.println("Count :::::::"+count);*/
        ShortQuestion shortQuestion = new ShortQuestion();
        shortQuestion =  speakingManager.getShortQuestionDetails(0,1);
        System.out.println(":::::::::"+shortQuestion.getAudioScriptAnswer()+"::::::::::"+shortQuestion.getAudioFilePath()+
                shortQuestion.getAudioScriptQuestion());
    }

}



