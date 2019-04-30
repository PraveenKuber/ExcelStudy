<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.EStudy.manager.WritingManager" %>
<%@ page import="com.EStudy.model.SummarizeWrittenText" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 4/4/19
  Time: 10:37 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    WritingManager writingManager = new WritingManager();
    SummarizeWrittenText summarizeWrittenText = writingManager.getSummarizeWrittenTextDetails(0,1);
    StringBuilder stringBuilder= new StringBuilder();
    Gson gson = new Gson();
    JsonObject jsonObject = new JsonObject();
    String previouslyOccurred = "-";
    if(summarizeWrittenText.getPreviouslyOccurred()!=null && !summarizeWrittenText.getPreviouslyOccurred().isEmpty()){
        previouslyOccurred = summarizeWrittenText.getPreviouslyOccurred();
    }

    stringBuilder.append("<div class=\"swt-render-div\">");
    stringBuilder.append("<div class=\"header-data\">Summarize written text</div>");
    stringBuilder.append("<div class=\"difficulty-level\"></div>");
    stringBuilder.append("<div class=\"module-description\">");
    stringBuilder.append("Read the passage below and summarize it using one sentence. Type your response in the box at the bottom of the screen. You have 10 minutes to finish this task. " +
            "Your response will be judged on the quality of your writing and on how well your response presents the key points in the passage.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"repeated-question\">Previously repeated :");
    stringBuilder.append("<div class=\"repeated-question-number\">"+previouslyOccurred+"</div>");
    stringBuilder.append("</div>");



    stringBuilder.append("<div class=\"summarizeTextDescription\">");
    stringBuilder.append(summarizeWrittenText.getWrittenText());
    stringBuilder.append("</div>");


    stringBuilder.append("<textarea rows=\"4\" cols=\"130\" class=\"summarizeTextDescription-output\" onkeyup=\"summarizeWrittenText.getInputTextCount()\">");
    stringBuilder.append("</textarea>");

    stringBuilder.append("<div class=\"basic-util\">");
    stringBuilder.append("<div class=\"common cut\">Cut</div>");
    stringBuilder.append("<div class=\"common copy\">Copy</div>");
    stringBuilder.append("<div class=\"common paste\">Paste</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"swt-counter\">");
    stringBuilder.append("<div class=\"swt-word-counter\">");
    stringBuilder.append("<span class=\"word-counter-header\">Total word count : </span>");
    stringBuilder.append("<span class=\"word-counter-content\"> </span>");
    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"swt-time-counter\">");
    stringBuilder.append("<span class=\"time-counter-header\">Timer : </span>");
    stringBuilder.append("<span class=\"time-counter-content\"> </span>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"alert-message swt-alertMessage\">");
    stringBuilder.append("<div class=\"close-icon swt-closeIcon\" style=\"color:rgba(0, 0, 0, 0.5);\">x</div>");
    stringBuilder.append("<div class=\"alert-header\">! Alert</div>");
    stringBuilder.append("<div class=\"alert-content\">Times Up! The allocated time for finishing this task is finished!</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"swt-answer-analysis\">");
    stringBuilder.append("<div class=\"swt-your-answer-close\">x</div>");
    stringBuilder.append("<div class=\"swt-your-answer\">");
    stringBuilder.append("<div class=\"swt-your-answer-header\">Your words :</div>");
    stringBuilder.append("<textarea rows=\"6\" cols=\"60\" readonly class=\"swt-your-answer-content\"></textarea>");
    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"swt-sample-answer\">");
    stringBuilder.append("<div class=\"swt-sample-header\">Sample answer</div>");
    stringBuilder.append("<div class=\"swt-sample-keyPoint-header-one\">"+summarizeWrittenText.getSampleAnswerHeader()+"</div>");
    stringBuilder.append("<div class=\"swt-sample-keyPoint-desc\">");
    stringBuilder.append(summarizeWrittenText.getSampleAnswerContent());
    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"swt-sample-suggestion-header\">Suggested Key Points:</div>");
    stringBuilder.append("<div class=\"suggestion-list\">");
    if(summarizeWrittenText.getSuggestedPoints().size()>0){
        for(String suggestion:summarizeWrittenText.getSuggestedPoints()){
            stringBuilder.append("<div class=\"suggestion-list-number\">"+suggestion+"</div>");
        }
    }
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"swt-control\">");
    stringBuilder.append("<div class=\"swt-try-again\">Try again</div>");
    stringBuilder.append("<div class=\"swt-check-answer\">Check answer</div>");
    stringBuilder.append("<div class=\"swt-save-my-answer\">Save answer</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"swt-stop-my-answer\">Stop</div>");

    stringBuilder.append("</div>");




       /*Pagination div*/
    stringBuilder.append("<div class=\"swt-pagination-div\">");
    stringBuilder.append("<div id=\"cp-style-div\" class=\"swt-pagination\">");
    stringBuilder.append("<div id=\"cp-style\"  class=\"swt-previous\" style=\"visibility: hidden\" data-page=\"previous\" data-page-id=\"2\">Previous</div>");
    for(int i=1;i<=5;i++){
        if(i==1){
            stringBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"swt-"+i+" active swt-common-pagination\">"+i+"</div>");
        }else{
            stringBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"swt-"+i+" swt-common-pagination\">"+i+"</div>");
        }

    }
    stringBuilder.append("<div id=\"cp-style\" class=\"swt-next\" data-page=\"next\" data-page-id=\"2\">Next</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");
    /*End*/


    jsonObject.addProperty("details",stringBuilder.toString());
    out.print(gson.toJson(jsonObject));


%>


