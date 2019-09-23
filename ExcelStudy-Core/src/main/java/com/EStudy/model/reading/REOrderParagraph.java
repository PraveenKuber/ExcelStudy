package com.EStudy.model.reading;

import java.util.List;

/**
 * Created by praveen on 23/8/19.
 */
public class REOrderParagraph {
    private List<ReorderQuestion> reOrderQuestions;
    private String previouslyOccurred;

    public List<ReorderQuestion> getReOrderQuestions() {
        return reOrderQuestions;
    }

    public void setReOrderQuestions(List<ReorderQuestion> reOrderQuestions) {
        this.reOrderQuestions = reOrderQuestions;
    }

    public String getPreviouslyOccurred() {
        return previouslyOccurred;
    }

    public void setPreviouslyOccurred(String previouslyOccurred) {
        this.previouslyOccurred = previouslyOccurred;
    }
}
