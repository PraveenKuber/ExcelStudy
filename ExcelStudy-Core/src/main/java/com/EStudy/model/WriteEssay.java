package com.EStudy.model;

import java.util.List;

/**
 * Created by praveen on 8/4/19.
 */
public class WriteEssay {
    private String essayQuestion;
    private String themeName;
    private List<String> suggestedPoints;

    public String getEssayQuestion() {
        return essayQuestion;
    }

    public void setEssayQuestion(String essayQuestion) {
        this.essayQuestion = essayQuestion;
    }

    public String getThemeName() {
        return themeName;
    }

    public void setThemeName(String themeName) {
        this.themeName = themeName;
    }

    public List<String> getSuggestedPoints() {
        return suggestedPoints;
    }

    public void setSuggestedPoints(List<String> suggestedPoints) {
        this.suggestedPoints = suggestedPoints;
    }
}
