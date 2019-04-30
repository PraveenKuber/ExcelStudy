package com.EStudy.model;

/**
 * Created by praveen on 29/3/19.
 */
public class ShortQuestion {
    private String audioFilePath;
    private String audioScriptQuestion;
    private String audioScriptAnswer;
    private String audioFileLength;
    private String recordableTime;
    private String previouslyOccurred;

    public String getPreviouslyOccurred() {
        return previouslyOccurred;
    }

    public void setPreviouslyOccurred(String previouslyOccurred) {
        this.previouslyOccurred = previouslyOccurred;
    }

    ;

    public String getAudioFilePath() {
        return audioFilePath;
    }

    public void setAudioFilePath(String audioFilePath) {
        this.audioFilePath = audioFilePath;
    }

    public String getAudioScriptQuestion() {
        return audioScriptQuestion;
    }

    public void setAudioScriptQuestion(String audioScriptQuestion) {
        this.audioScriptQuestion = audioScriptQuestion;
    }

    public String getAudioScriptAnswer() {
        return audioScriptAnswer;
    }

    public void setAudioScriptAnswer(String audioScriptAnswer) {
        this.audioScriptAnswer = audioScriptAnswer;
    }

    public String getAudioFileLength() {
        return audioFileLength;
    }

    public void setAudioFileLength(String audioFileLength) {
        this.audioFileLength = audioFileLength;
    }

    public String getRecordableTime() {
        return recordableTime;
    }

    public void setRecordableTime(String recordableTime) {
        this.recordableTime = recordableTime;
    }
}
