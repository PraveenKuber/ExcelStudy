package com.EStudy.model.reading;

import java.util.List;

/**
 * Created by praveen on 6/5/19.
 */
public class ChooseMultipleAnswersRE {
    private List<String> answers;
    private String previouslyOccurred;
    private List<String> questions;
    private String readableScript;
    private String mainQuestion;

    public List<String> getAnswers() {
        return answers;
    }

    public void setAnswers(List<String> answers) {
        this.answers = answers;
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

    public String getReadableScript() {
        return readableScript;
    }

    public void setReadableScript(String readableScript) {
        this.readableScript = readableScript;
    }

    public String getMainQuestion() {
        return mainQuestion;
    }

    public void setMainQuestion(String mainQuestion) {
        this.mainQuestion = mainQuestion;
    }
}
