<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.EStudy.manager.ListeningManager" %>
<%@ page import="com.EStudy.model.HighlightIncorrectWords" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 29/4/19
  Time: 3:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ListeningManager listeningManager = new ListeningManager();
    HighlightIncorrectWords highlightIncorrectWords = listeningManager.getHighlightIncorrectWords(0,1);
    String previouslyOccurred =  highlightIncorrectWords.getPreviouslyOccurred();
    String audioFilePath = highlightIncorrectWords.getAudioFilePath();
    String audioScript = highlightIncorrectWords.getAudioScript();
    StringBuilder stringBuilder = new StringBuilder();
    stringBuilder.append("<div class=\"hiw-render-div\">");

    stringBuilder.append("<div class=\"header-data\">Highlight incorrect words</div>");
    stringBuilder.append("<div class=\"difficulty-level\"></div>");
    stringBuilder.append("<div class=\"module-description\">");
    stringBuilder.append("You will hear a recording. Below is a transcription of the recording. Some words in the transcription differ from what the speaker(s) said. Please click on the words that are different.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"repeated-question\">Previously repeated :");
    stringBuilder.append("<div class=\"repeated-question-number\">"+previouslyOccurred +"</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"common-timer\">");
    stringBuilder.append("<div class=\"listener-timer-header\">Timer: </div>");
    stringBuilder.append("<div class=\"listener-timer hiw-listener-timer\">10</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"status-div\">");
    stringBuilder.append("<div class=\"status-header\">Record Answer</div>");
    stringBuilder.append("<div class=\"current-status-header\">Current status:</div>");
    stringBuilder.append("<div class=\"current-status\">status</div>");
    stringBuilder.append("<div class=\"status-bar\"></div>");
    stringBuilder.append("<div class=\"progress-bar\">");
    stringBuilder.append("<span class=\"highlightIncorrectWords\" style=\"width: 0%\"></span>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<audio controls class=\"audioFile hiw\">");
    stringBuilder.append("<source class=\"audioFile\" src=\'../../"+audioFilePath+"' type=\"audio/ogg\">");
    stringBuilder.append("</audio>");


    List<String> incorrectWords =  new ArrayList<>();
    incorrectWords = highlightIncorrectWords.getIncorrectWords();
    /*incorrectWords.add("roll");
    incorrectWords.add("ice");
    incorrectWords.add("stack");
    incorrectWords.add("tracks");*/
    List<String> correctWords =  new ArrayList<>();
    correctWords = highlightIncorrectWords.getCorrectWords();
    /*correctWords.add("role");
    correctWords.add("nice");
    correctWords.add("stock");
    correctWords.add("track");*/

    stringBuilder.append("<div class=\"selection-div\">");
    String[] splitedValues = audioScript.split(" ");
    for(String value:splitedValues){
        value = value.replace(",","");
        value = value.replace(".","");
        if(value!=null&& !value.isEmpty()&&value!=""){
            if(incorrectWords.contains(value)){
                int index = incorrectWords.indexOf(value);
                String correctAnswer = correctWords.get(index);
                stringBuilder.append("&nbsp;<span data-color=\"false\" class=\"normal inCorrected\">"+value+"</span>&nbsp;");
                stringBuilder.append("<span data-color=\"false\" class=\"corrected\">"+correctAnswer+"</span>");
            }else{
                stringBuilder.append("&nbsp;<span data-color=\"false\" class=\"normal\">&nbsp;"+value+"</span>");
            }
        }
    }
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"alert-message hiw-alertMessage\">");
    stringBuilder.append("<div class=\"close-icon hiw-close-icon\" style=\"color:rgba(0, 0, 0, 0.5);\">x</div>");
    stringBuilder.append("<div class=\"alert-header\">! Alert</div>");
    stringBuilder.append("<div class=\"alert-content\">Times Up!! The allocated time for finishing this task is finished!!</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"score-section-hiw\">");
    stringBuilder.append("<div class=\"close-score-section\">x</div>");
    stringBuilder.append("<div class=\"score\">");
    stringBuilder.append("<div class=\"score-header\">Your score:</div>");
    stringBuilder.append("<div class=\"score-section-content\">");
    stringBuilder.append("<div class=\"score-section-header\">Highlight incorrect words:</div>");
    stringBuilder.append("<div class=\"score-section-progress\"></div>");
    stringBuilder.append("<div class=\"score-total\">2/3</div>");
    stringBuilder.append("<div class=\"score-percentage\">[67%]</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"score-section-progress show-progress\"></div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"answer-control-section\">");
    stringBuilder.append("<div class=\"try-again hiw-try-again\">Try Again</div>");
    stringBuilder.append("<div class=\"check-answer hiw-check-answer\">Check Answer</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"common-stop-button hiw-stop-my-answer\">Stop</div>");


    stringBuilder.append("</div>");

      /*Pagination div*/
    stringBuilder.append("<div class=\"hiw-pagination-div\">");
    stringBuilder.append("<div id=\"cp-style-div\" class=\"hiw-pagination\">");
    stringBuilder.append("<div id=\"cp-style\"  class=\"hiw-previous\" style=\"visibility: hidden\" data-page=\"previous\" data-page-id=\"2\">Previous</div>");
    for(int i=1;i<=5;i++){
        if(i==1){
            stringBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"hiw-"+i+" active hiw-common-pagination\">"+i+"</div>");
        }else{
            stringBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"hiw-"+i+" hiw-common-pagination\">"+i+"</div>");
        }

    }
    stringBuilder.append("<div id=\"cp-style\" class=\"hiw-next\" data-page=\"next\" data-page-id=\"2\">Next</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");
    /*End*/





    Gson gson = new Gson();
    JsonObject jsonObject = new JsonObject();
    jsonObject.addProperty("details",stringBuilder.toString());
    jsonObject.addProperty("totalIncorrectWords",highlightIncorrectWords.getIncorrectWords().size());
    jsonObject.addProperty("audioFileLength",highlightIncorrectWords.getAudioFileLength());
    out.print(gson.toJson(jsonObject));

%>

