package com.EStudy.model;

/**
 * Created by praveen on 20/4/19.
 */
public class SummarizeSpokenText {
    private String audioFilePath;
    private String audioFileLength;
    private String audioScript;
    private String writingTime;
    private String previouslyOccurred;

    public String getAudioFilePath() {
        return audioFilePath;
    }

    public void setAudioFilePath(String audioFilePath) {
        this.audioFilePath = audioFilePath;
    }

    public String getAudioFileLength() {
        return audioFileLength;
    }

    public void setAudioFileLength(String audioFileLength) {
        this.audioFileLength = audioFileLength;
    }

    public String getAudioScript() {
        return audioScript;
    }

    public void setAudioScript(String audioScript) {
        this.audioScript = audioScript;
    }

    public String getWritingTime() {
        return writingTime;
    }

    public void setWritingTime(String writingTime) {
        this.writingTime = writingTime;
    }

    public String getPreviouslyOccurred() {
        return previouslyOccurred;
    }

    public void setPreviouslyOccurred(String previouslyOccurred) {
        this.previouslyOccurred = previouslyOccurred;
    }
}
