package com.EStudy.model;

/**
 * Created by praveen on 1/4/19.
 */
public class ReadAloud {
    private String audioScript;
    private String recordableLength;
    private String previouslyOccurred;

    public String getPreviouslyOccurred() {
        return previouslyOccurred;
    }

    public void setPreviouslyOccurred(String previouslyOccurred) {
        this.previouslyOccurred = previouslyOccurred;
    }

    public String getAudioScript() {
        return audioScript;
    }

    public void setAudioScript(String audioScript) {
        this.audioScript = audioScript;
    }

    public String getRecordableLength() {
        return recordableLength;
    }

    public void setRecordableLength(String recordableLength) {
        this.recordableLength = recordableLength;
    }
}
