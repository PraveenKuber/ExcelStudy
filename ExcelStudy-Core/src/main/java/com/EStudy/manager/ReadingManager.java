package com.EStudy.manager;

import com.EStudy.GUI.FillInTheBlanksGUI;
import com.EStudy.model.reading.*;
import com.google.gson.Gson;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

import java.util.List;

/**
 * Created by praveen on 2/5/19.
 */
public class ReadingManager {
    private MongoPersistenceManager pm = null;

    public ReadingManager(){
        pm = MongoPersistenceManager.getInstance();
    }

    public int  getCollectionCount(String collectionName){
        int count = pm.getCountOfCollection(collectionName,new BasicDBObject());
        return count;
    }

    public ChooseSingleAnswerRE getChooseSingleAnswerRE(int skip, int limit){
        System.out.println("Query in RA-CSA ::::::skip ::::"+skip+":::::;; limit ::::"+limit);
        DBCursor dbCursor = pm.searchEntityWithSkipAndLimit(ChooseSingleAnswerRE.class.getSimpleName(),skip,limit);
        ChooseSingleAnswerRE chooseSingleAnswerRE = new ChooseSingleAnswerRE();
        DBObject dbObject;
        while (dbCursor.hasNext()){
            dbObject = dbCursor.next();
            chooseSingleAnswerRE.setReadableScript(dbObject.get("readableScript").toString());
            chooseSingleAnswerRE.setDescription(dbObject.get("description").toString());
            chooseSingleAnswerRE.setPreviouslyOccurred(dbObject.get("previouslyOccurred").toString());
            List<String> questions = (List)dbObject.get("questions");
            String answer = dbObject.get("answer").toString();
            chooseSingleAnswerRE.setQuestions(questions);
            chooseSingleAnswerRE.setAnswer(answer);
            chooseSingleAnswerRE.setMainQuestion(dbObject.get("mainQuestion").toString());
        }
        return chooseSingleAnswerRE;
    }


    public ChooseMultipleAnswersRE getChooseMultipleAnswersRE(int skip, int limit){
        System.out.println("Query in RA-CMA ::::::skip ::::"+skip+":::::;; limit ::::"+limit);
        DBCursor dbCursor = pm.searchEntityWithSkipAndLimit(ChooseMultipleAnswersRE.class.getSimpleName(),skip,limit);
        ChooseMultipleAnswersRE chooseMultipleAnswersRE = new ChooseMultipleAnswersRE();
        DBObject dbObject;
        while (dbCursor.hasNext()){
            dbObject = dbCursor.next();
            chooseMultipleAnswersRE.setReadableScript(dbObject.get("readableScript").toString());
            chooseMultipleAnswersRE.setPreviouslyOccurred(dbObject.get("previouslyOccurred").toString());
            List<String> questions = (List)dbObject.get("questions");
            List<String>  answers = (List) dbObject.get("answers");
            chooseMultipleAnswersRE.setQuestions(questions);
            chooseMultipleAnswersRE.setAnswers(answers);
            chooseMultipleAnswersRE.setMainQuestion(dbObject.get("mainQuestion").toString());
        }
        return chooseMultipleAnswersRE;
    }

    public FillInTheBlanksRE getFillInTheBlanksRE(int skip, int limit){
        System.out.println("Query in RA-FIB ::::::skip ::::"+skip+":::::;; limit ::::"+limit);
        DBCursor dbCursor = pm.searchEntityWithSkipAndLimit(FillInTheBlanksRE.class.getSimpleName(),skip,limit);
        FillInTheBlanksRE fillInTheBlanksRE = new FillInTheBlanksRE();
        DBObject dbObject;
        Gson gson = new Gson();
        while (dbCursor.hasNext()){
            dbObject = dbCursor.next();
            fillInTheBlanksRE = gson.fromJson(gson.toJson(dbObject.toMap()),FillInTheBlanksRE.class);
        }
        return fillInTheBlanksRE;
    }


    public FillInTheBlanksDrag getFillInTheBlanksDrag(int skip, int limit){
        System.out.println("Query in RA-FIBD::::::skip ::::"+skip+":::::;; limit ::::"+limit);
        DBCursor dbCursor = pm.searchEntityWithSkipAndLimit(FillInTheBlanksDrag.class.getSimpleName(),skip,limit);
        FillInTheBlanksDrag fillInTheBlanksDrag = new FillInTheBlanksDrag();
        DBObject dbObject;
        Gson gson = new Gson();
        while (dbCursor.hasNext()){
            dbObject = dbCursor.next();
            fillInTheBlanksDrag = gson.fromJson(gson.toJson(dbObject.toMap()),FillInTheBlanksDrag.class);
        }
        return fillInTheBlanksDrag;
    }

    public FillInTheBlanksGUI getValueForFillInTheBlanksList(List<FillInTheBlanksGUI> list,String value){
        FillInTheBlanksGUI fillInTheBlanksGUIResult = null;
        for (FillInTheBlanksGUI fillInTheBlanksGUI:list){
            //System.out.println("Comparing ----> answer :::"+fillInTheBlanksGUI.getAnswer()+":::: value ::::"+value);
            if (fillInTheBlanksGUI.getAnswer().trim().equals(value.trim())){
                fillInTheBlanksGUIResult = fillInTheBlanksGUI;
                break;
            }

        }
        return fillInTheBlanksGUIResult;
    }






    public REOrderParagraph getReOrderParagraphRE(int skip, int limit){
        System.out.println("Query in RA-ROP ::::::skip ::::"+skip+":::::;; limit ::::"+limit);
        DBCursor dbCursor = pm.searchEntityWithSkipAndLimit("ReOrderParagraph",skip,limit);
        REOrderParagraph reOrderParagraph = new REOrderParagraph();
        DBObject dbObject;
        Gson gson = new Gson();
        while (dbCursor.hasNext()){
            dbObject = dbCursor.next();
            reOrderParagraph = gson.fromJson(gson.toJson(dbObject.toMap()),REOrderParagraph.class);
        }
        return reOrderParagraph;
    }





    public static void main(String[] args) {
        ReadingManager readingManager = new ReadingManager();
        /*REOrderParagraph reOrderParagraph = readingManager.getReOrderParagraphRE(0,1);
        System.out.println("PR=---"+reOrderParagraph.getPreviouslyOccurred());
        List<ReorderQuestion>  test = reOrderParagraph.getReOrderQuestions();
        for(ReorderQuestion t:test){
            System.out.println("Ttttttttttttttttt--->"+t.getQuestion());
        }*/

        FillInTheBlanksRE fillInTheBlanksRE = readingManager.getFillInTheBlanksRE(0,1);
        List<FillInTheBlanksGUI> fillInTheBlanksGUIList = fillInTheBlanksRE.getFillInTheBlanks();
        /*for(FillInTheBlanksGUI fillInTheBlanksGUI:fillInTheBlanksGUIList){
            List<String> test = fillInTheBlanksGUI.getChoices();
            for(String te:test){
                System.out.println("Choice -------------->"+te+":::: answer :::"+fillInTheBlanksGUI.getAnswer());
            }
        }*/
        FillInTheBlanksGUI result  = readingManager.getValueForFillInTheBlanksList(fillInTheBlanksGUIList,"Ignite");
        System.out.println("Fill in the blnaks answer=------------->"+result.getAnswer());


    }



}
