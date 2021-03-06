<%@ page import="com.EStudy.manager.ListeningManager" %>
<%@ page import="com.EStudy.model.HighlightIncorrectWords" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.EStudy.model.FillInTheBlanks" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 30/4/19
  Time: 6:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ListeningManager listeningManager = new ListeningManager();
    FillInTheBlanks fillInTheBlanks = listeningManager.getFillInTheBlanks(0,1);
    String previouslyOccurred =  fillInTheBlanks.getPreviouslyOccurred();
    String audioFilePath = fillInTheBlanks.getAudioFilePath();
    String audioScript = fillInTheBlanks.getAudioScript();
    StringBuilder stringBuilder = new StringBuilder();

    stringBuilder.append("<div class=\"fib-render-div\">");

    stringBuilder.append("<div class=\"header-data\">Fill in the blanks</div>");
    stringBuilder.append("<div class=\"difficulty-level\"></div>");
    stringBuilder.append("<div class=\"module-description\">");
    stringBuilder.append("You will hear a recording. Below is a transcription of the recording. Some words in the transcription differ from what the speaker(s) said. Please click on the words that are different.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"repeated-question\">Previously repeated :");
    stringBuilder.append("<div class=\"repeated-question-number\">"+previouslyOccurred +"</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"common-timer\">");
    stringBuilder.append("<div class=\"listener-timer-header\">Timer: </div>");
    stringBuilder.append("<div class=\"listener-timer fib-listener-timer\">10</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"status-div\">");
    stringBuilder.append("<div class=\"status-header\">Record Answer</div>");
    stringBuilder.append("<div class=\"current-status-header\">Current status:</div>");
    stringBuilder.append("<div class=\"current-status\">status</div>");
    stringBuilder.append("<div class=\"status-bar\"></div>");
    stringBuilder.append("<div class=\"progress-bar\">");
    stringBuilder.append("<span class=\"fillInTheBlanks\" style=\"width: 0%\"></span>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<audio controls class=\"audioFile fib\">");
    stringBuilder.append("<source class=\"audioFile\" src=\'../../"+audioFilePath+"' type=\"audio/ogg\">");
    stringBuilder.append("</audio>");


    List<String> correctWords =  fillInTheBlanks.getCorrectWords();
    stringBuilder.append("<div class=\"selection-div\">");
    String[] splitedValues = audioScript.split(" ");
    int correctedCounter = 0;
    for(String value:splitedValues){
        value = value.replace(",","");
        value = value.replace(".","");
        if(value!=null&& !value.isEmpty()&&value!=""){
            if(correctWords.contains(value)){
                correctedCounter++;
                int index = correctWords.indexOf(value);
                String correctAnswer = correctWords.get(index);
                stringBuilder.append("<span>&nbsp;<input type=\"text\" class=\"common-fib fill-in-the-blanks-"+correctedCounter+"\">&nbsp;</span>");
                stringBuilder.append("<span data-color=\"false\" class=\"fib-normal fib-corrected corrected"+correctedCounter+"\">"+correctAnswer+"</span>");
            }else{
                stringBuilder.append("&nbsp;<span data-color=\"false\" class=\"fib-normal\">&nbsp;"+value+"</span>");
            }
        }
    }
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"alert-message fib-alertMessage\">");
    stringBuilder.append("<div class=\"close-icon fib-close-icon\" style=\"color:rgba(0, 0, 0, 0.5);\">x</div>");
    stringBuilder.append("<div class=\"alert-header\">! Alert</div>");
    stringBuilder.append("<div class=\"alert-content\">Times Up!! The allocated time for finishing this task is finished!!</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"score-section-fib\">");
    stringBuilder.append("<div class=\"fib-close-score-section\">x</div>");
    stringBuilder.append("<div class=\"score\">");
    stringBuilder.append("<div class=\"score-header\">Your score:</div>");
    stringBuilder.append("<div class=\"score-section-content\">");
    stringBuilder.append("<div class=\"score-section-header\">Fill in the blanks:</div>");
    stringBuilder.append("<div class=\"score-section-progress\"></div>");
    stringBuilder.append("<div class=\"score-total\">2/3</div>");
    stringBuilder.append("<div class=\"score-percentage\">[67%]</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"score-section-progress show-progress\"></div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"answer-control-section\">");
    stringBuilder.append("<div class=\"try-again fib-try-again\">Try Again</div>");
    stringBuilder.append("<div class=\"check-answer fib-check-answer\">Check Answer</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"common-stop-button fib-stop-my-answer\">Stop</div>");


    stringBuilder.append("</div>");

      /*Pagination div*/
    stringBuilder.append("<div class=\"fib-pagination-div\">");
    stringBuilder.append("<div id=\"cp-style-div\" class=\"fib-pagination\">");
    stringBuilder.append("<div id=\"cp-style\"  class=\"fib-previous\" style=\"visibility: hidden\" data-page=\"previous\" data-page-id=\"2\">Previous</div>");
    for(int i=1;i<=5;i++){
        if(i==1){
            stringBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"fib-"+i+" active fib-common-pagination\">"+i+"</div>");
        }else{
            stringBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"fib-"+i+" fib-common-pagination\">"+i+"</div>");
        }
    }
    stringBuilder.append("<div id=\"cp-style\" class=\"fib-next\" data-page=\"next\" data-page-id=\"2\">Next</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");
    /*End*/





    Gson gson = new Gson();
    JsonObject jsonObject = new JsonObject();
    jsonObject.addProperty("details",stringBuilder.toString());
    jsonObject.addProperty("totalCorrectWords",fillInTheBlanks.getCorrectWords().size());
    jsonObject.addProperty("audioFileLength",fillInTheBlanks.getAudioFileLength());
    out.print(gson.toJson(jsonObject));
%>



