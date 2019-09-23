package com.EStudy.model;

import java.util.List;

/**
 * Created by praveen on 30/4/19.
 */
public class FillInTheBlanks {
    private String previouslyOccurred;
    private String audioFilePath;
    private String audioFileLength;
    private List<String> correctWords;
    private String audioScript;

    public String getPreviouslyOccurred() {
        return previouslyOccurred;
    }

    public void setPreviouslyOccurred(String previouslyOccurred) {
        this.previouslyOccurred = previouslyOccurred;
    }

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

    public List<String> getCorrectWords() {
        return correctWords;
    }

    public void setCorrectWords(List<String> correctWords) {
        this.correctWords = correctWords;
    }

    public String getAudioScript() {
        return audioScript;
    }

    public void setAudioScript(String audioScript) {
        this.audioScript = audioScript;
    }
}
