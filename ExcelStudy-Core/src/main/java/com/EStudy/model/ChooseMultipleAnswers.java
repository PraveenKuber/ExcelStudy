package com.EStudy.model;

import java.util.List;

/**
 * Created by praveen on 28/4/19.
 */
public class ChooseMultipleAnswers {
    private String previouslyOccurred;
    private List<String> questions;
    private List<String> answers;
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

    public String getAudioFileLength() {
        return audioFileLength;
    }

    public void setAudioFileLength(String audioFileLength) {
        this.audioFileLength = audioFileLength;
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

    public List<String> getAnswers() {
        return answers;
    }

    public void setAnswers(List<String> answers) {
        this.answers = answers;
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
}
