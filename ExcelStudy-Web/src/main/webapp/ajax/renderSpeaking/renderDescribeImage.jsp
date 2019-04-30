<%@ page import="com.EStudy.manager.SpeakingManager" %>
<%@ page import="com.EStudy.model.DescribeImage" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 1/4/19
  Time: 11:09 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    SpeakingManager speakingManager = new SpeakingManager();
    int totalDescribeImageCount = speakingManager.getCollectionCount(DescribeImage.class.getSimpleName());
    int  skip;
    int maxPerSize = 5;
    String pageId = request.getParameter("pageId");
    StringBuilder paginationBuilder = new StringBuilder();
    pageId = pageId.trim();
    System.out.println("PageID  is ::::::::::"+pageId);
    if(pageId == null || pageId.isEmpty()){
        skip  = Integer.parseInt(request.getParameter("pageNumber"));
    }else{
        String pageType = request.getParameter("page");
        int pageIdNumber = Integer.parseInt(pageId);
        int nextPageStart = ((pageIdNumber-1)*maxPerSize)+1;
        int nextPageEnd = nextPageStart + (maxPerSize-1);
        int limit = nextPageEnd;
        int  previousPageId=pageIdNumber -1;;
        String previousDisplay = "visible";
        String display = "visible";
        if(pageType.equals("previous")){
            nextPageStart = ((pageIdNumber-1)*maxPerSize)+1;
            nextPageEnd = nextPageStart + (maxPerSize-1);
            limit = nextPageEnd;
            if(previousPageId !=1 ) previousDisplay = "visible";
        }

        if(nextPageEnd >= totalDescribeImageCount){
            limit = totalDescribeImageCount;
           /* display = "none"*/;
        }



        if(limit== totalDescribeImageCount) display ="hidden";

        paginationBuilder.append("<div class=\"di-pagination-div\">");
        paginationBuilder.append("<div id=\"cp-style-div\" class=\"di-pagination\">");
        if(pageIdNumber >=2 ){
            paginationBuilder.append("<div id=\"cp-style\"  class=\"di-previous\" style='visibility:"+previousDisplay+"' data-page=\"previous\" data-page-id="+previousPageId+">Previous</div>");
        }else{
            paginationBuilder.append("<div id=\"cp-style\"  class=\"ra-previous\" style=\"visibility: hidden\" data-page=\"previous\">Previous</div>");
        }

        for(int i=nextPageStart;i<=limit;i++){
            if(i==nextPageStart){
                paginationBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"di-"+i+" active di-common-pagination\">"+i+"</div>");
            }else{
                paginationBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"di-"+i+" di-common-pagination\">"+i+"</div>");
            }

        }
        paginationBuilder.append("<div id=\"cp-style\" class=\"di-next\" style='visibility:"+display+"' data-page=\"next\" data-page-id="+(pageIdNumber+1)+">Next</div>");
        paginationBuilder.append("</div>");
        paginationBuilder.append("</div>");

        skip = (maxPerSize*(pageIdNumber-1))+1;

    }

    DescribeImage describeImage = speakingManager.getDescribeImageDetails((skip-1),1);
    StringBuilder stringBuilder = new StringBuilder();
    Gson gson = new Gson();
    JsonObject jsonObject = new JsonObject();

    String previouslyOccurred = "-";
    if(describeImage.getPreviouslyOccurred()!=null && !describeImage.getPreviouslyOccurred().isEmpty()){
        previouslyOccurred = describeImage.getPreviouslyOccurred();
    }



    stringBuilder.append("<div class=\"di-render-div\">");

    stringBuilder.append("<div class=\"header-data\">Repeat sentence</div>");
    stringBuilder.append("<div class=\"difficulty-level\"></div>");
    stringBuilder.append("<div class=\"module-description\">");
    stringBuilder.append("  Look at the picture below. In 25 seconds, please speak into microphone " +
            "and describe in detail what the picture is showing. You will have 40 seconds to give your response.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"repeated-question\">Previously repeated :");
    stringBuilder.append("<div class=\"repeated-question-number\">"+previouslyOccurred+"</div>");
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
    stringBuilder.append("<div class=\"di-loader loader\"><img class=\"loader-image\" src=\"../../images/loder.gif\"></div>");


    stringBuilder.append("<div class=\"footer-div di-footer\">");
    stringBuilder.append("<span class=\"di-analysis di-recorded-tryAgain\">Try again</span>");
    stringBuilder.append("<span class=\"di-analysis di-recorded-play\">Play</span>");
    stringBuilder.append("<span class=\"di-analysis di-recorded-download\">Download</span>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div data-record-time="+describeImage.getRecordableTime()+" class=\"record-di\">Record</div>");
    stringBuilder.append("<div class=\"stop-di\">Stop</div>");


     /*Stop button*/
    stringBuilder.append("<div class=\"stop-di-button\">");
    stringBuilder.append("<div class=\"di-stop-my-answer\">Stop</div>");
    stringBuilder.append("</div>");
    /*end*/



    stringBuilder.append("</div>");

    /*End of render div*/


    jsonObject.addProperty("details",stringBuilder.toString());
    jsonObject.addProperty("recordAbleTime",describeImage.getRecordableTime());
    jsonObject.addProperty("pagination",paginationBuilder.toString());
    out.print(gson.toJson(jsonObject));

%>
