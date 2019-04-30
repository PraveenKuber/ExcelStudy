package com.EStudy.model;

/**
 * Created by praveen on 1/4/19.
 */
public class DescribeImage {
    private String imagePath;
    private String recordableTime;
    private String previouslyOccurred;

    public String getPreviouslyOccurred() {
        return previouslyOccurred;
    }

    public void setPreviouslyOccurred(String previouslyOccurred) {
        this.previouslyOccurred = previouslyOccurred;
    }

    public String getRecordableTime() {
        return recordableTime;
    }

    public void setRecordableTime(String recordableTime) {
        this.recordableTime = recordableTime;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

}
