<%@ page import="com.EStudy.manager.SpeakingManager" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.EStudy.model.DescribeImage" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 22/3/19
  Time: 2:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    SpeakingManager speakingManager = new SpeakingManager();
    DescribeImage describeImage = speakingManager.getDescribeImageDetails(0,1);
    StringBuilder stringBuilder = new StringBuilder();
    Gson gson = new Gson();
    JsonObject jsonObject = new JsonObject();

    stringBuilder.append("<div class=\"di-render-div\">");

    stringBuilder.append("<div class=\"header-data\">Repeat sentence</div>");
    stringBuilder.append("<div class=\"difficulty-level\"></div>");
    stringBuilder.append("<div class=\"module-description\">");
    stringBuilder.append("  Look at the picture below. In 25 seconds, please speak into microphone " +
            "and describe in detail what the picture is showing. You will have 40 seconds to give your response.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"describe-image col-md-12\">");
    stringBuilder.append("<div class=\"describe-image-details col-md-7\">");
    stringBuilder.append("<img class=\"di-image-property\" src=\"../../"+describeImage.getImagePath()+"\">");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"col-md-5 describe-image-recording\">");

    stringBuilder.append("<div class=\"di-status-div\">");
    stringBuilder.append("<div class=\"status-header\">Record Answer</div>");
    stringBuilder.append("<div class=\"current-status-header\">Current status:</div>");
    stringBuilder.append("<div class=\"current-status di-status\">status</div>");
    stringBuilder.append("<div class=\"status-bar di-status-bar\"></div>");
    stringBuilder.append("<div class=\"progress-bar\">");
    stringBuilder.append("<span class=\"describeImage\" style=\"width: 0%\"></span>");
    stringBuilder.append(" </div>");
    stringBuilder.append("</div>");


    stringBuilder.append("</div>");

    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"alert-message di-alertMessage\">");
    stringBuilder.append("<div class=\"close-icon di-close-icon\" style=\"color:rgba(0, 0, 0, 0.5);\">x</div>");
    stringBuilder.append("<div class=\"alert-header\">! Alert</div>");
    stringBuilder.append("<div class=\"alert-content\">Times Up!! The allocated time for finishing this task is finished!!</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<audio controls src=\"\" id=\"di-audio\"></audio>");


    stringBuilder.append("<div class=\"footer-div di-footer\">");
    stringBuilder.append("<span class=\"di-analysis di-recorded-tryAgain\">Try again</span>");
    stringBuilder.append("<span class=\"di-analysis di-recorded-play\">Play</span>");
    stringBuilder.append("<span class=\"di-analysis di-recorded-download\">Download</span>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div data-record-time="+describeImage.getRecordableTime()+" class=\"record-di\">Record</div>");
    stringBuilder.append("<div class=\"stop-di\">Stop</div>");

    stringBuilder.append("</div>");

    /*End of render div*/



     /*Pagination div*/
    stringBuilder.append("<div class=\"di-pagination-div\">");
    stringBuilder.append("<div id=\"cp-style-div\" class=\"di-pagination\">");
    stringBuilder.append("<div id=\"cp-style\"  class=\"di-previous\" style=\"visibility: hidden\" data-page=\"previous\" data-page-id=\"2\">Previous</div>");
    for(int i=1;i<=5;i++){
        if(i==1){
            stringBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"di-"+i+" active di-common-pagination\">"+i+"</div>");
        }else{
            stringBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"di-"+i+" di-common-pagination\">"+i+"</div>");
        }

    }
    stringBuilder.append("<div id=\"cp-style\" class=\"di-next\" data-page=\"next\" data-page-id=\"2\">Next</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");
    /*End*/




    jsonObject.addProperty("details",stringBuilder.toString());
    out.print(gson.toJson(jsonObject));


%>








