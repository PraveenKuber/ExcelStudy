package com.EStudy.model.reading;

import com.EStudy.GUI.FillInTheBlanksGUI;

import java.util.List;

/**
 * Created by praveen on 8/5/19.
 */
public class FillInTheBlanksRE {
    private List<FillInTheBlanksGUI> fillInTheBlanks;
    private String previouslyOccurred;
    private String question;


    public List<FillInTheBlanksGUI> getFillInTheBlanks() {
        return fillInTheBlanks;
    }

    public void setFillInTheBlanks(List<FillInTheBlanksGUI> fillInTheBlanks) {
        this.fillInTheBlanks = fillInTheBlanks;
    }

    public String getPreviouslyOccurred() {
        return previouslyOccurred;
    }

    public void setPreviouslyOccurred(String previouslyOccurred) {
        this.previouslyOccurred = previouslyOccurred;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }
}
