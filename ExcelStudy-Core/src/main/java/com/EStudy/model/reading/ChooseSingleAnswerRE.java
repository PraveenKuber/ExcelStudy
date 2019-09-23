package com.EStudy.model.reading;

import java.util.List;

/**
 * Created by praveen on 2/5/19.
 */
public class ChooseSingleAnswerRE {
    private String previouslyOccurred;
    private List<String> questions;
    private String answer;
    private String readableScript;
    private String description;
    private String mainQuestion;

    public String getReadableScript() {
        return readableScript;
    }

    public void setReadableScript(String readableScript) {
        this.readableScript = readableScript;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }



    public String getPreviouslyOccurred() {
        return previouslyOccurred;
    }

    public void setPreviouslyOccurred(String previouslyOccurred) {
        this.previouslyOccurred = previouslyOccurred;
    }

    public List<String> getQuestions() {
        return questions;
    }

    public void setQuestions(List<String> questions) {
        this.questions = questions;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }



    public String getMainQuestion() {
        return mainQuestion;
    }

    public void setMainQuestion(String mainQuestion) {
        this.mainQuestion = mainQuestion;
    }
}
