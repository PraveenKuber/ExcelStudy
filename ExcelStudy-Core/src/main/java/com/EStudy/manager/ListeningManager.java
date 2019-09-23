package com.EStudy.manager;

import com.EStudy.model.*;
import com.mongodb.BasicDBObject;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

import java.util.List;

/**
 * Created by praveen on 20/4/19.
 */
public class ListeningManager {
    private MongoPersistenceManager pm = null;

    public ListeningManager(){
        pm = MongoPersistenceManager.getInstance();
    }

    public int  getCollectionCount(String collectionName){
        int count = pm.getCountOfCollection(collectionName,new BasicDBObject());
        return count;
    }

    public SummarizeSpokenText getSummarizeSpokenTextDetails(int skip, int limit){
        System.out.println("Query in SST ::::::skip ::::"+skip+":::::;; limit ::::"+limit);
        DBCursor dbCursor = pm.searchEntityWithSkipAndLimit(SummarizeSpokenText.class.getSimpleName(),skip,limit);
        SummarizeSpokenText summarizeSpokenText = new SummarizeSpokenText();
        DBObject dbObject;
        while (dbCursor.hasNext()){
            dbObject = dbCursor.next();
            summarizeSpokenText.setAudioScript(dbObject.get("audioScript").toString());
            summarizeSpokenText.setAudioFilePath(dbObject.get("audioFilePath").toString());
            summarizeSpokenText.setPreviouslyOccurred(dbObject.get("previouslyOccurred").toString());
            summarizeSpokenText.setWritingTime(dbObject.get("writingTime").toString());
            summarizeSpokenText.setAudioFileLength(dbObject.get("audioFileLength").toString());
        }
        return summarizeSpokenText;
    }

    public WriteFromDictation getWriteFromDictation(int skip, int limit){
        System.out.println("Query in WFD ::::::skip ::::"+skip+":::::;; limit ::::"+limit);
        DBCursor dbCursor = pm.searchEntityWithSkipAndLimit(WriteFromDictation.class.getSimpleName(),skip,limit);
        WriteFromDictation writeFromDictation = new WriteFromDictation();
        DBObject dbObject;
        while (dbCursor.hasNext()){
            dbObject = dbCursor.next();
            writeFromDictation.setAudioScript(dbObject.get("audioScript").toString());
            writeFromDictation.setAudioFilePath(dbObject.get("audioFilePath").toString());
            writeFromDictation.setPreviouslyOccurred(dbObject.get("previouslyOccurred").toString());
            writeFromDictation.setWritingTime(dbObject.get("writingTime").toString());
            writeFromDictation.setAudioFileLength(dbObject.get("audioFileLength").toString());
        }
        return writeFromDictation;
    }


    public ChooseMultipleAnswers getChooseMultipleAnswers(int skip, int limit){
        System.out.println("Query in CMA ::::::skip ::::"+skip+":::::;; limit ::::"+limit);
        DBCursor dbCursor = pm.searchEntityWithSkipAndLimit(ChooseMultipleAnswers.class.getSimpleName(),skip,limit);
        ChooseMultipleAnswers chooseMultipleAnswers = new ChooseMultipleAnswers();
        DBObject dbObject;
        while (dbCursor.hasNext()){
            dbObject = dbCursor.next();
            chooseMultipleAnswers.setAudioScript(dbObject.get("audioScript").toString());
            chooseMultipleAnswers.setAudioFilePath(dbObject.get("audioFilePath").toString());
            chooseMultipleAnswers.setPreviouslyOccurred(dbObject.get("previouslyOccurred").toString());
            List<String> questions = (List)dbObject.get("questions");
            List<String> answers = (List)dbObject.get("answers");
            chooseMultipleAnswers.setQuestions(questions);
            chooseMultipleAnswers.setAnswers(answers);
            chooseMultipleAnswers.setAudioFileLength(dbObject.get("audioFileLength").toString());
            chooseMultipleAnswers.setMainQuestion(dbObject.get("mainQuestion").toString());
        }
        return chooseMultipleAnswers;
    }

    public HighlightCorrectSummary getHighlightCorrectSummary(int skip, int limit){
        System.out.println("Query in HCS ::::::skip ::::"+skip+":::::;; limit ::::"+limit);
        DBCursor dbCursor = pm.searchEntityWithSkipAndLimit(HighlightCorrectSummary.class.getSimpleName(),skip,limit);
        HighlightCorrectSummary highlightCorrectSummary = new HighlightCorrectSummary();
        DBObject dbObject;
        while (dbCursor.hasNext()){
            dbObject = dbCursor.next();
            highlightCorrectSummary.setAudioScript(dbObject.get("audioScript").toString());
            highlightCorrectSummary.setAudioFilePath(dbObject.get("audioFilePath").toString());
            highlightCorrectSummary.setPreviouslyOccurred(dbObject.get("previouslyOccurred").toString());
            List<String> questions = (List)dbObject.get("questions");
            String answer = dbObject.get("answer").toString();
            highlightCorrectSummary.setQuestions(questions);
            highlightCorrectSummary.setAnswer(answer);
            highlightCorrectSummary.setAudioFileLength(dbObject.get("audioFileLength").toString());
        }
        return highlightCorrectSummary;
    }


    public ChooseSingleAnswer getChooseSingleAnswer(int skip, int limit){
        System.out.println("Query in CSA ::::::skip ::::"+skip+":::::;; limit ::::"+limit);
        DBCursor dbCursor = pm.searchEntityWithSkipAndLimit(ChooseSingleAnswer.class.getSimpleName(),skip,limit);
        ChooseSingleAnswer chooseSingleAnswer = new ChooseSingleAnswer();
        DBObject dbObject;
        while (dbCursor.hasNext()){
            dbObject = dbCursor.next();
            chooseSingleAnswer.setAudioScript(dbObject.get("audioScript").toString());
            chooseSingleAnswer.setAudioFilePath(dbObject.get("audioFilePath").toString());
            chooseSingleAnswer.setPreviouslyOccurred(dbObject.get("previouslyOccurred").toString());
            List<String> questions = (List)dbObject.get("questions");
            String answer = dbObject.get("answer").toString();
            chooseSingleAnswer.setQuestions(questions);
            chooseSingleAnswer.setAnswer(answer);
            chooseSingleAnswer.setAudioFileLength(dbObject.get("audioFileLength").toString());
            chooseSingleAnswer.setMainQuestion(dbObject.get("mainQuestion").toString());
        }
        return chooseSingleAnswer;
    }


    public SelectMissingWord getSelectMissingWord(int skip, int limit){
        System.out.println("Query in SMW ::::::skip ::::"+skip+":::::;; limit ::::"+limit);
        DBCursor dbCursor = pm.searchEntityWithSkipAndLimit(SelectMissingWord.class.getSimpleName(),skip,limit);
        SelectMissingWord selectMissingWord = new SelectMissingWord();
        DBObject dbObject;
        while (dbCursor.hasNext()){
            dbObject = dbCursor.next();
            selectMissingWord.setAudioScript(dbObject.get("audioScript").toString());
            selectMissingWord.setAudioFilePath(dbObject.get("audioFilePath").toString());
            selectMissingWord.setPreviouslyOccurred(dbObject.get("previouslyOccurred").toString());
            List<String> questions = (List)dbObject.get("questions");
            String answer = dbObject.get("answer").toString();
            selectMissingWord.setQuestions(questions);
            selectMissingWord.setAnswer(answer);
            selectMissingWord.setAudioFileLength(dbObject.get("audioFileLength").toString());
        }
        return selectMissingWord;
    }


    public HighlightIncorrectWords getHighlightIncorrectWords(int skip, int limit){
        System.out.println("Query in HIW ::::::skip ::::"+skip+":::::;; limit ::::"+limit);
        DBCursor dbCursor = pm.searchEntityWithSkipAndLimit(HighlightIncorrectWords.class.getSimpleName(),skip,limit);
        HighlightIncorrectWords highlightIncorrectWords = new HighlightIncorrectWords();
        DBObject dbObject;
        while (dbCursor.hasNext()){
            dbObject = dbCursor.next();
            highlightIncorrectWords.setAudioScript(dbObject.get("audioScript").toString());
            highlightIncorrectWords.setAudioFilePath(dbObject.get("audioFilePath").toString());
            highlightIncorrectWords.setPreviouslyOccurred(dbObject.get("previouslyOccurred").toString());
            List<String> incorrectWords = (List)dbObject.get("incorrectWords");
            List<String> correctWords = (List)dbObject.get("correctWords");
            highlightIncorrectWords.setAudioFileLength(dbObject.get("audioFileLength").toString());
            highlightIncorrectWords.setIncorrectWords(incorrectWords);
            highlightIncorrectWords.setCorrectWords(correctWords);
        }
        return highlightIncorrectWords;
    }


    public FillInTheBlanks getFillInTheBlanks(int skip, int limit){
        System.out.println("Query in FIB ::::::skip ::::"+skip+":::::;; limit ::::"+limit);
        DBCursor dbCursor = pm.searchEntityWithSkipAndLimit(FillInTheBlanks.class.getSimpleName(),skip,limit);
        FillInTheBlanks fillInTheBlanks = new FillInTheBlanks();
        DBObject dbObject;
        while (dbCursor.hasNext()){
            dbObject = dbCursor.next();
            fillInTheBlanks.setAudioScript(dbObject.get("audioScript").toString());
            fillInTheBlanks.setAudioFilePath(dbObject.get("audioFilePath").toString());
            fillInTheBlanks.setPreviouslyOccurred(dbObject.get("previouslyOccurred").toString());
            List<String> correctWords = (List)dbObject.get("correctWords");
            fillInTheBlanks.setAudioFileLength(dbObject.get("audioFileLength").toString());
            fillInTheBlanks.setCorrectWords(correctWords);
        }
        return fillInTheBlanks;
    }









}
