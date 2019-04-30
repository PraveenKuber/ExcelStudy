<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.EStudy.manager.SpeakingManager" %>
<%@ page import="com.EStudy.model.ShortQuestion" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 28/3/19
  Time: 11:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    SpeakingManager speakingManager = new SpeakingManager();
    int totalShortQuestionCount = speakingManager.getShortQuestionCount();
    ShortQuestion shortQuestion = speakingManager.getShortQuestionDetails(0,1);
    StringBuilder stringBuilder = new StringBuilder();
    Gson gson = new Gson();
    JsonObject jsonObject = new JsonObject();
    String previouslyOccurred = "-";
    if(shortQuestion.getPreviouslyOccurred()!=null && !shortQuestion.getPreviouslyOccurred().isEmpty()){
        previouslyOccurred = shortQuestion.getPreviouslyOccurred();
    }

    /*Render div start*/

    stringBuilder.append("<div class=\"render-div\">");


    stringBuilder.append("<div class=\"header-data\">Answer short question</div>");
    stringBuilder.append("<div class=\"difficulty-level\"></div>");
    stringBuilder.append("<div class=\"module-description\">");
    stringBuilder.append("You will hear a question. Please give a simple and short answer. Often just one or a few words is enough.");
    stringBuilder.append("</div>");

    System.out.println("shortQuestion.getAudioFilePath():::::::"+shortQuestion.getAudioFilePath());

    stringBuilder.append("<div class=\"repeated-question\">Previously repeated :");
    stringBuilder.append("<div class=\"repeated-question-number\">"+previouslyOccurred+"</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"status-div-one\">");
    stringBuilder.append("<div class=\"status-header-one\"></div>");
    stringBuilder.append("<div class=\"current-status-header-one\">Current status:</div>");
    stringBuilder.append("<div class=\"current-status-one short-question-status-one\">completed</div>");
    stringBuilder.append("<div class=\"status-bar-one short-question-status-bar\"></div>");
    stringBuilder.append("<div class=\"progress-bar-one\">");
    stringBuilder.append("<span class=\"shortQuestion-one\"></span>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"recordCounter-sq\">test</div>");


    /*resource/shortQuestion/001.mp3*/
    stringBuilder.append("<audio controls id=\"short-question\" class=\"audioFile shortQuestion-audio\">");
    stringBuilder.append("<source class=\"audioFile\"  src='../../"+shortQuestion.getAudioFilePath()+"'   type=\"audio/ogg\">");
    stringBuilder.append("</audio>");

    stringBuilder.append("<div class=\"status-div\">");
    stringBuilder.append("<div class=\"status-header\">Record Answer</div>");
    stringBuilder.append("<div class=\"current-status-header\">Current status:</div>");
    stringBuilder.append("<div class=\"current-status short-question-status\">status</div>");
    stringBuilder.append("<div class=\"status-bar short-question-status-bar\"></div>");
    stringBuilder.append("<div class=\"progress-bar\">");
    stringBuilder.append("<span class=\"shortQuestion\" style=\"width: 0%\"></span>");
    stringBuilder.append(" </div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"alert-message sq-alertMessage\">");
    stringBuilder.append("<div class=\"close-icon\" style=\"color:rgba(0, 0, 0, 0.5);\">x</div>");
    stringBuilder.append("<div class=\"alert-header\">! Alert</div>");
    stringBuilder.append("<div class=\"alert-content\">Times Up!! The allocated time for finishing this task is finished!!</div>");
    stringBuilder.append("</div>");


    /*Comapre */

    stringBuilder.append("<div class=\"sq-compare-module\">");
    stringBuilder.append("<span class=\"answer-analysis-sq\">Answer analysis:</span>");
    stringBuilder.append("<span class=\"close-analysis-sq\">x</span>");
    stringBuilder.append("<div class=\"audio-script-sq\">");
    stringBuilder.append("<div class=\"audio-script-header-sq\">Audio script:</div>");
    stringBuilder.append("<div  class=\"audio-script-content-sq\">"+shortQuestion.getAudioScriptQuestion()+"</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"recorded-script-sq\">");
    stringBuilder.append("<div class=\"recorded-script-header-sq\">Correct answer:</div>");
    stringBuilder.append("<div  class=\"recorded-script-content-sq\">"+shortQuestion.getAudioScriptAnswer()+"</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"word-compare-sq\">");
    stringBuilder.append("<div class=\"word-compare-header-sq\">Your answer :</div>");
    stringBuilder.append("<div  class=\"word-compare-content-sq\"></div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");



    stringBuilder.append("<div class=\"footer-div\">");
    stringBuilder.append("<span class=\"try-again sq-try-again\">Try again</span>");
    stringBuilder.append("<span class=\"audio-compare sq-audio-compare\">Audio compare</span>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"record-short-question\">Record</div>");
    stringBuilder.append("<div class=\"stop-short-question\">Stop</div>");

    stringBuilder.append("<div class=\"common-stop-button sq-stop-my-answer\">Stop</div>");

    stringBuilder.append("</div>");
    /*End render div*/


    /*Pagination div*/
    stringBuilder.append("<div class=\"pagination-div\">");
    stringBuilder.append("<div class=\"sq-pagination\" data-sq-count="+totalShortQuestionCount+">");
    stringBuilder.append("<div class=\"sq-previous\" style=\"visibility: hidden\" data-page=\"previous\" data-page-id=\"2\">previosu</div>");
    for(int i=1;i<=5;i++){
        if(i==1){
            stringBuilder.append("<div data-page-number="+i+" class=\"sq-"+i+" active common-pagination\">"+i+"</div>");
        }else{
            stringBuilder.append("<div data-page-number="+i+" class=\"sq-"+i+" common-pagination\">"+i+"</div>");
        }

    }
    stringBuilder.append("<div class=\"sq-next\" data-page=\"next\" data-page-id=\"2\">Next</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");




    jsonObject.addProperty("details",stringBuilder.toString());
    jsonObject.addProperty("recordAbleTime",shortQuestion.getRecordableTime());
    jsonObject.addProperty("audioFileLength",shortQuestion.getAudioFileLength());
    out.print(gson.toJson(jsonObject));

%>




