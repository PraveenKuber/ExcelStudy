package com.EStudy.model;

/**
 * Created by praveen on 22/3/19.
 */
public class RepeatSentence {
    private String audioPath;
    private String audioScript;
    private String audioFileLength;
    private String recordableTime;
    private String previouslyOccurred;

    public String getPreviouslyOccurred() {
        return previouslyOccurred;
    }

    public void setPreviouslyOccurred(String previouslyOccurred) {
        this.previouslyOccurred = previouslyOccurred;
    }

    public String getAudioPath() {
        return audioPath;
    }

    public void setAudioPath(String audioPath) {
        this.audioPath = audioPath;
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

    public String getRecordableTime() {
        return recordableTime;
    }

    public void setRecordableTime(String recordableTime) {
        this.recordableTime = recordableTime;
    }
}


