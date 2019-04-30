package com.EStudy.model;

import java.util.List;

/**
 * Created by praveen on 29/4/19.
 */
public class ChooseSingleAnswer {
    private String previouslyOccurred;
    private List<String> questions;
    private String answer;
    private String audioFilePath;
    private String audioScript;
    private String audioFileLength;
    private String mainQuestion;

    public String getMainQuestion() {
        return mainQuestion;
    }

    public void setMainQuestion(String mainQuestion) {
        this.mainQuestion = mainQuestion;
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

    public String getAudioFilePath() {
        return audioFilePath;
    }

    public void setAudioFilePath(String audioFilePath) {
        this.audioFilePath = audioFilePath;
    }

    public String getAudioScript() {
        return audioScript;
    }

    public void setAudioScript(String audioScript) {
        this.audioScript = audioScript;
    }

    public String getAudioFileLength() {
        return audioFileLength;
    }

    public void setAudioFileLength(String audioFileLength) {
        this.audioFileLength = audioFileLength;
    }
}
