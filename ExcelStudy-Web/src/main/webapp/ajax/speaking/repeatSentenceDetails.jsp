<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.EStudy.manager.SpeakingManager" %>
<%@ page import="com.EStudy.model.RepeatSentence" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 19/3/19
  Time: 7:40 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    SpeakingManager speakingManager = new SpeakingManager();
    RepeatSentence repeatSentence = speakingManager.getRepeatSentenceDetails(0,1);
    StringBuilder stringBuilder = new StringBuilder();
    Gson gson = new Gson();
    JsonObject jsonObject = new JsonObject();

    /*Render*/
    stringBuilder.append("<div class=\"rp-render-div\">");
    stringBuilder.append("<div class=\"header-data\">Repeat sentence</div>");
    stringBuilder.append("<div class=\"difficulty-level\"></div>");
    stringBuilder.append("<div class=\"module-description\">");
    stringBuilder.append("You will hear a sentence. Please repeat the sentence exactly as you hear it." +
            "You will hear the sentence only once.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"recordCounter\"></div>");

    stringBuilder.append("<audio controls id=\"repeat-sentence\" class=\"audioFile repeatSentence-audio\">");
    stringBuilder.append("<source class=\"audioFile\"  src=\'../../"+repeatSentence.getAudioPath()+"\' type=\"audio/ogg\">");
    stringBuilder.append("</audio>");

    stringBuilder.append("<div class=\"status-div\">");
    stringBuilder.append("<div class=\"status-header\">Record Answer</div>");
    stringBuilder.append("<div class=\"current-status-header\">Current status:</div>");
    stringBuilder.append("<div class=\"current-status repeat-sentence-status\">status</div>");
    stringBuilder.append("<div class=\"status-bar repeat-sentence-status-bar\"></div>");
    stringBuilder.append("<div class=\"progress-bar\">");
    stringBuilder.append("<span class=\"repeatSentence\" style=\"width: 0%\"></span>");
    stringBuilder.append(" </div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"alert-message rp-alertMessage\">");
    stringBuilder.append("<div class=\"close-icon\" style=\"color:rgba(0, 0, 0, 0.5);\">x</div>");
    stringBuilder.append("<div class=\"alert-header\">! Alert</div>");
    stringBuilder.append("<div class=\"alert-content\">Times Up!! The allocated time for finishing this task is finished!!</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"footer-div repeatSentence-footer-div\">");
    stringBuilder.append("<span class=\"try-again rp-try-again\">Try again</span>");
    stringBuilder.append("<span class=\"audio-compare\">Audio compare</span>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"record-repeat-sentence\">Record</div>");
    stringBuilder.append("<div class=\"stop-repeat-sentence\">Stop</div>");

    stringBuilder.append("<div class=\"repeatSentence-compare-module\">");
    stringBuilder.append("<span class=\"answer-analysis\">Answer analysis:</span> <span class=\"close-answer-analysis\" style=\"color:black;\">x</span>");
    stringBuilder.append("<div class=\"audio-script\">");
    stringBuilder.append("<span class=\"audio-script-header\">your answer:</span>");
    stringBuilder.append("<div  class=\"audio-script-content\"></div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"recorded-script\">");
    stringBuilder.append("<span class=\"recorded-script-header\">correct answer:</span>");
    stringBuilder.append("<div  class=\"recorded-script-content\">"+repeatSentence.getAudioScript()+"</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"word-compare\">");
    stringBuilder.append("<span class=\"word-compare-header\">word compare:</span>");
    stringBuilder.append("<div  class=\"word-compare-content\"></div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("</div>");

    /*End*/


      /*Pagination div*/
    stringBuilder.append("<div class=\"rp-pagination-div\">");
    stringBuilder.append("<div id=\"cp-style-div\" class=\"rp-pagination\">");
    stringBuilder.append("<div id=\"cp-style\"  class=\"rp-previous\" style=\"visibility: hidden\" data-page=\"previous\" data-page-id=\"2\">Previous</div>");
    for(int i=1;i<=5;i++){
        if(i==1){
            stringBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"rp-"+i+" active rp-common-pagination\">"+i+"</div>");
        }else{
            stringBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"rp-"+i+" rp-common-pagination\">"+i+"</div>");
        }

    }
    stringBuilder.append("<div id=\"cp-style\" class=\"rp-next\" data-page=\"next\" data-page-id=\"2\">Next</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");
    /*End*/

    jsonObject.addProperty("details",stringBuilder.toString());
    jsonObject.addProperty("audioFileLength",repeatSentence.getAudioFileLength());
    jsonObject.addProperty("recordableTime",repeatSentence.getRecordableTime());
    out.print(gson.toJson(jsonObject));

%>



