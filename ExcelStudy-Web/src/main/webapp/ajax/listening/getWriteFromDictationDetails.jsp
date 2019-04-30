<%@ page import="com.EStudy.manager.ListeningManager" %>
<%@ page import="com.EStudy.model.SummarizeSpokenText" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.EStudy.model.WriteFromDictation" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 20/4/19
  Time: 10:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ListeningManager listeningManager = new ListeningManager();
    WriteFromDictation writeFromDictation = listeningManager.getWriteFromDictation(0,1);
    StringBuilder stringBuilder = new StringBuilder();
    Gson gson = new Gson();
    JsonObject jsonObject = new JsonObject();

    stringBuilder.append("<div class=\"wfd-render-div\">");

    stringBuilder.append("<div class=\"header-data\">Write from dictation</div>");
    stringBuilder.append("<div class=\"difficulty-level\"></div>");
    stringBuilder.append("<div class=\"module-description\">");
    stringBuilder.append("    You will hear a sentence. Type the sentence in the box below exactly as you hear it. Write as much of the sentence as you can. You will hear the sentence only once.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"repeated-question\">Previously repeated :");
    stringBuilder.append("<div class=\"repeated-question-number\">"+writeFromDictation.getPreviouslyOccurred()+"</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"status-div\">");
    stringBuilder.append("<div class=\"status-header\">Record Answer</div>");
    stringBuilder.append("<div class=\"current-status-header\">Current status:</div>");
    stringBuilder.append("<div class=\"current-status\">status</div>");
    stringBuilder.append("<div class=\"status-bar\"></div>");
    stringBuilder.append("<div class=\"progress-bar\">");
    stringBuilder.append("<span class=\"writeFromDictation\" style=\"width: 0%\"></span>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<audio controls class=\"audioFile wfd\">");
    stringBuilder.append("<source class=\"audioFile\" src=\'../../"+writeFromDictation.getAudioFilePath()+"' type=\"audio/ogg\">");
    stringBuilder.append("</audio>");


    stringBuilder.append("<textarea class=\"common-writing-area writingArea-wfd\" onkeyup=\"writeFromDictation.getInputTextCount();\" rows=\"5\" cols=\"130\">");
    stringBuilder.append("</textarea>");

    stringBuilder.append("<div class=\"swt-counter\">");
    stringBuilder.append("<div class=\"swt-word-counter\">");
    stringBuilder.append("<span class=\"word-counter-header\">Total word count : </span>");
    stringBuilder.append("<span class=\"word-counter-content wfd-word-counter-content\"> </span>");
    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"swt-time-counter\">");
    stringBuilder.append("<span class=\"time-counter-header\">Timer : </span>");
    stringBuilder.append("<span class=\"time-counter-content wfd-time-counter-content\"> </span>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"basic-util\">");
    stringBuilder.append("<div class=\"common cut\">Cut</div>");
    stringBuilder.append("<div class=\"common copy\">Copy</div>");
    stringBuilder.append("<div class=\"common paste\">Paste</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"alert-message wfd-alertMessage\">");
    stringBuilder.append("<div class=\"close-icon wfd-close-icon\" style=\"color:rgba(0, 0, 0, 0.5);\">x</div>");
    stringBuilder.append("<div class=\"alert-header\">! Alert</div>");
    stringBuilder.append("<div class=\"alert-content\">Times Up!! The allocated time for finishing this task is finished!!</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"listening-answer-analysis wfd-listening-answer-analysis\">");
    stringBuilder.append("<div class=\"listening-answer-close wfd-your-answer-close\">x</div>");
    stringBuilder.append("<div class=\"listening-answer-see wfd-your-answer\">");
    stringBuilder.append("<div class=\"listening-your-answer-header\">Your words</div>");
    stringBuilder.append("<textarea rows=\"1\" cols=\"60\" readonly class=\"listening-answer-area wfd-listening-answer-area\"></textarea>");
    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"listening-sample-answer\">");
    stringBuilder.append("<div class=\"listening-sample-header\">Audio Script</div>");
    stringBuilder.append("<div class=\"common-answer wfd-audio-script\">"+
            writeFromDictation.getAudioScript()
            +"</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"listening-answer-see wfd-compare-answer\">");
    stringBuilder.append("<div class=\"listening-your-answer-header\">Compare</div>");
    stringBuilder.append("<div class=\"listening-answer-area wfd-listening-compare-area\"></div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"listening-answer-see wfd-progress-answer\">");
    stringBuilder.append("<div class=\"listening-your-answer-header\">Your score</div>");
    stringBuilder.append("<div class=\"score-area\">");
    stringBuilder.append("<div class=\"listening-answer-area wfd-listening-percentage-area\"></div>");
    stringBuilder.append("<div class=\"listening-answer-area wfd-listening-calculation-area\"></div>");
    stringBuilder.append("<div class=\"listening-answer-area wfd-listening-percentage-got-area\"></div>");
    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"listening-answer-area wfd-listening-progress-area\"></div>");

    stringBuilder.append("</div>");


    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"listening-control\">");
    stringBuilder.append("<div class=\"listening-try-again listening-try-again-wfd\">Try again</div>");
    stringBuilder.append("<div class=\"listening-check-answer listening-check-answer-wfd\">Check answer</div>");
    stringBuilder.append("<div class=\"listening-save-my-answer listening-save-my-answer-wfd\">Save answer</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"common-stop-button wfd-stop-my-answer\">Stop</div>");

    stringBuilder.append("</div>");
    /*End*/

      /*Pagination div*/
    stringBuilder.append("<div class=\"wfd-pagination-div\">");
    stringBuilder.append("<div id=\"cp-style-div\" class=\"wfd-pagination\">");
    stringBuilder.append("<div id=\"cp-style\"  class=\"wfd-previous\" style=\"visibility: hidden\" data-page=\"previous\" data-page-id=\"2\">Previous</div>");
    for(int i=1;i<=5;i++){
        if(i==1){
            stringBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"wfd-"+i+" active wfd-common-pagination\">"+i+"</div>");
        }else{
            stringBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"wfd-"+i+" wfd-common-pagination\">"+i+"</div>");
        }

    }
    stringBuilder.append("<div id=\"cp-style\" class=\"wfd-next\" data-page=\"next\" data-page-id=\"2\">Next</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");
    /*End*/



    jsonObject.addProperty("audioFileLength",writeFromDictation.getAudioFileLength());
    jsonObject.addProperty("writingTime",writeFromDictation.getWritingTime());
    jsonObject.addProperty("details",stringBuilder.toString());
    out.print(gson.toJson(jsonObject));
%>
