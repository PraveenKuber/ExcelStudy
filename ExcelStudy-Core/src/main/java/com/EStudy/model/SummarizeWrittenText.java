package com.EStudy.model;

import java.util.List;

/**
 * Created by praveen on 6/4/19.
 */
public class SummarizeWrittenText {
    private String writtenText;
    private String sampleAnswerHeader;
    private String sampleAnswerContent;
    private List<String> suggestedPoints;

    public String getWrittenText() {
        return writtenText;
    }

    public void setWrittenText(String writtenText) {
        this.writtenText = writtenText;
    }

    public String getSampleAnswerHeader() {
        return sampleAnswerHeader;
    }

    public void setSampleAnswerHeader(String sampleAnswerHeader) {
        this.sampleAnswerHeader = sampleAnswerHeader;
    }

    public String getSampleAnswerContent() {
        return sampleAnswerContent;
    }

    public void setSampleAnswerContent(String sampleAnswerContent) {
        this.sampleAnswerContent = sampleAnswerContent;
    }

    public List<String> getSuggestedPoints() {
        return suggestedPoints;
    }

    public void setSuggestedPoints(List<String> suggestedPoints) {
        this.suggestedPoints = suggestedPoints;
    }
}
