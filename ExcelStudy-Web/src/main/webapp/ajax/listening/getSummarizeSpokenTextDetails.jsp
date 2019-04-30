<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.EStudy.manager.ListeningManager" %>
<%@ page import="com.EStudy.model.SummarizeSpokenText" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 25/2/19
  Time: 11:26 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ListeningManager listeningManager = new ListeningManager();
    SummarizeSpokenText summarizeSpokenText = listeningManager.getSummarizeSpokenTextDetails(0,1);
    System.out.println("summarizeSpokenText:::::::::::::::"+summarizeSpokenText);
    StringBuilder stringBuilder = new StringBuilder();
    Gson gson = new Gson();
    JsonObject jsonObject = new JsonObject();

    stringBuilder.append("<div class=\"sst-render-div\">");

    stringBuilder.append("<div class=\"header-data\">Summarize spoken text </div>");
    stringBuilder.append("<div class=\"difficulty-level\"></div>");
    stringBuilder.append("<div class=\"module-description\">");
    stringBuilder.append("You will hear a short lecture. Write a summary for a fellow student who was not present at the lecture. You should write 50-70 words. You have 10 minutes to finish this task. Your response will be judged on the Quality " +
            "of Your writing and on how well your response presents the key points presented in the lecture.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"repeated-question\">Previously repeated :");
    stringBuilder.append("<div class=\"repeated-question-number\">"+summarizeSpokenText.getPreviouslyOccurred()+"</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"status-div\">");
    stringBuilder.append("<div class=\"status-header\">Record Answer</div>");
    stringBuilder.append("<div class=\"current-status-header\">Current status:</div>");
    stringBuilder.append("<div class=\"current-status\">status</div>");
    stringBuilder.append("<div class=\"status-bar\"></div>");
    stringBuilder.append("<div class=\"progress-bar\">");
    stringBuilder.append("<span class=\"summarizeSpokenText\" style=\"width: 0%\"></span>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<audio controls class=\"audioFile sst\">");
    stringBuilder.append("<source class=\"audioFile\" src=\'../../"+summarizeSpokenText.getAudioFilePath()+"' type=\"audio/ogg\">");
    stringBuilder.append("</audio>");


    stringBuilder.append("<textarea class=\"common-writing-area writingArea-sst\" onkeyup=\"listening.getInputTextCount();\" rows=\"5\" cols=\"130\">");
    stringBuilder.append("</textarea>");

    stringBuilder.append("<div class=\"swt-counter\">");
    stringBuilder.append("<div class=\"swt-word-counter\">");
    stringBuilder.append("<span class=\"word-counter-header\">Total word count : </span>");
    stringBuilder.append("<span class=\"word-counter-content sst-word-counter-content\"> </span>");
    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"swt-time-counter\">");
    stringBuilder.append("<span class=\"time-counter-header\">Timer : </span>");
    stringBuilder.append("<span class=\"time-counter-content sst-time-counter-content\"> </span>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"basic-util\">");
    stringBuilder.append("<div class=\"common cut\">Cut</div>");
    stringBuilder.append("<div class=\"common copy\">Copy</div>");
    stringBuilder.append("<div class=\"common paste\">Paste</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"alert-message sst-alertMessage\">");
    stringBuilder.append("<div class=\"close-icon sst-close-icon\" style=\"color:rgba(0, 0, 0, 0.5);\">x</div>");
    stringBuilder.append("<div class=\"alert-header\">! Alert</div>");
    stringBuilder.append("<div class=\"alert-content\">Times Up!! The allocated time for finishing this task is finished!!</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"listening-answer-analysis sst-listening-answer-analysis\">");
    stringBuilder.append("<div class=\"listening-answer-close sst-your-answer-close\">x</div>");
    stringBuilder.append("<div class=\"listening-answer-see sst-your-answer\">");
    stringBuilder.append("<div class=\"listening-your-answer-header\">Your words :</div>");
    stringBuilder.append("<textarea rows=\"6\" cols=\"60\" readonly class=\"listening-answer-area sst-listening-answer-area\"></textarea>");
    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"listening-sample-answer\">");
    stringBuilder.append("<div class=\"listening-sample-header\">Audio Script</div>");
    stringBuilder.append("<div class=\"common-answer sst-audio-script\">"+
             summarizeSpokenText.getAudioScript()
            +"</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"listening-control\">");
    stringBuilder.append("<div class=\"listening-try-again listening-try-again-sst\">Try again</div>");
    stringBuilder.append("<div class=\"listening-check-answer listening-check-answer-sst\">Check answer</div>");
    stringBuilder.append("<div class=\"listening-save-my-answer listening-save-my-answer-sst\">Save answer</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"common-stop-button sst-stop-my-answer\">Stop</div>");

    stringBuilder.append("</div>");
    /*End*/

      /*Pagination div*/
    stringBuilder.append("<div class=\"sst-pagination-div\">");
    stringBuilder.append("<div id=\"cp-style-div\" class=\"sst-pagination\">");
    stringBuilder.append("<div id=\"cp-style\"  class=\"sst-previous\" style=\"visibility: hidden\" data-page=\"previous\" data-page-id=\"2\">Previous</div>");
    for(int i=1;i<=5;i++){
        if(i==1){
            stringBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"sst-"+i+" active sst-common-pagination\">"+i+"</div>");
        }else{
            stringBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"sst-"+i+" sst-common-pagination\">"+i+"</div>");
        }

    }
    stringBuilder.append("<div id=\"cp-style\" class=\"sst-next\" data-page=\"next\" data-page-id=\"2\">Next</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");
    /*End*/








    jsonObject.addProperty("details",stringBuilder.toString());
    jsonObject.addProperty("audioFileLength",summarizeSpokenText.getAudioFileLength());
    jsonObject.addProperty("writingTime",summarizeSpokenText.getWritingTime());
    out.print(gson.toJson(jsonObject));
%>





