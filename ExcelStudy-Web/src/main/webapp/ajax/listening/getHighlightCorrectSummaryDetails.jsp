<%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 28/4/19
  Time: 9:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.EStudy.manager.ListeningManager" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="java.util.List" %>
<%@ page import="com.EStudy.model.HighlightCorrectSummary" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 21/4/19
  Time: 6:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ListeningManager listeningManager = new ListeningManager();
    HighlightCorrectSummary highlightCorrectSummary = listeningManager.getHighlightCorrectSummary(0,1);
    String audioFilePath = highlightCorrectSummary.getAudioFilePath();
    String previouslyOccurred = highlightCorrectSummary.getPreviouslyOccurred();
    StringBuilder stringBuilder = new StringBuilder();
    JsonObject jsonObject= new JsonObject();
    Gson gson = new Gson();

    stringBuilder.append("<div class=\"hcs-render-div\">");

    stringBuilder.append("<div class=\"header-data\">Highlight correct summary</div>");
    stringBuilder.append("<div class=\"difficulty-level\"></div>");
    stringBuilder.append("<div class=\"module-description\">");
    stringBuilder.append("You will hear a recording. Click on the paragraph that best relates to the recording.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"repeated-question\">Previously repeated :");
    stringBuilder.append("<div class=\"repeated-question-number\">"+previouslyOccurred+"</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"common-timer\">");
    stringBuilder.append("<div class=\"listener-timer-header\">Timer: </div>");
    stringBuilder.append("<div class=\"listener-timer hcs-listener-timer\">10</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"status-div\">");
    stringBuilder.append("<div class=\"status-header\">Record Answer</div>");
    stringBuilder.append("<div class=\"current-status-header\">Current status:</div>");
    stringBuilder.append("<div class=\"current-status\">status</div>");
    stringBuilder.append("<div class=\"status-bar\"></div>");
    stringBuilder.append("<div class=\"progress-bar\">");
    stringBuilder.append("<span class=\"highlightCorrectSummary\" style=\"width: 0%\"></span>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<audio controls class=\"audioFile hcs\">");
    stringBuilder.append("<source class=\"audioFile\" src=\'../../"+audioFilePath+"' type=\"audio/ogg\">");
    stringBuilder.append("</audio>");

    stringBuilder.append("<div class=\"select-answer multiple-answer\">");
    //stringBuilder.append("<div class=\"select-answer-header multiple-answer-question\">Which of the following is said by the speaker of the recording you just heard?</div>");


    List<String> questions =  highlightCorrectSummary.getQuestions();
    String answer = highlightCorrectSummary.getAnswer();

    for(String question:questions){
        String className="";
        if(question.equals(answer)) className = "hcs-answer";

        stringBuilder.append("<div class=\"select-answer-choice multiple-answer-choice "+className+"\">");
        stringBuilder.append("<label class=\"choice-label\"><input class=\"checkBox-common hcs-checkBox\" type=\"checkbox\"  value=\"true\">"+question+"</label>");
        stringBuilder.append("</div>");
    }

    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"alert-message hcs-alertMessage\">");
    stringBuilder.append("<div class=\"close-icon hcs-close-icon\" style=\"color:rgba(0, 0, 0, 0.5);\">x</div>");
    stringBuilder.append("<div class=\"alert-header\">! Alert</div>");
    stringBuilder.append("<div class=\"alert-content\">Times Up!! The allocated time for finishing this task is finished!!</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"score-section\">");
    stringBuilder.append("<div class=\"close-score-section hcs-close-score-section\">x</div>");
    stringBuilder.append("<div class=\"audio-script-section\">");
    stringBuilder.append("<div class=\"audio-script-header\">Audio script:</div>");
    stringBuilder.append("<div class=\"audio-script-content\">");
    stringBuilder.append(highlightCorrectSummary.getAudioScript());
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"answer-control-section\">");
    stringBuilder.append("<div class=\"try-again hcs-try-again\">Try Again</div>");
    stringBuilder.append("<div class=\"check-answer hcs-check-answer\">Check Answer</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"common-stop-button hcs-stop-my-answer\">Stop</div>");


    stringBuilder.append("</div>");


      /*Pagination div*/
    stringBuilder.append("<div class=\"hcs-pagination-div\">");
    stringBuilder.append("<div id=\"cp-style-div\" class=\"hcs-pagination\">");
    stringBuilder.append("<div id=\"cp-style\"  class=\"hcs-previous\" style=\"visibility: hidden\" data-page=\"previous\" data-page-id=\"2\">Previous</div>");
    for(int i=1;i<=5;i++){
        if(i==1){
            stringBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"hcs-"+i+" active hcs-common-pagination\">"+i+"</div>");
        }else{
            stringBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"hcs-"+i+" hcs-common-pagination\">"+i+"</div>");
        }

    }
    stringBuilder.append("<div id=\"cp-style\" class=\"hcs-next\" data-page=\"next\" data-page-id=\"2\">Next</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");
    /*End*/


    jsonObject.addProperty("details",stringBuilder.toString());
    jsonObject.addProperty("audioFileLength",highlightCorrectSummary.getAudioFileLength());
    out.print(gson.toJson(jsonObject));
%>
