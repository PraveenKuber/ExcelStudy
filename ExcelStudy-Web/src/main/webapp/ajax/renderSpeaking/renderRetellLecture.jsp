<%@ page import="com.EStudy.manager.SpeakingManager" %>
<%@ page import="com.EStudy.model.RetellLecture" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 31/3/19
  Time: 11:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    SpeakingManager speakingManager = new SpeakingManager();
    int totalShortQuestionCount = speakingManager.getRetellLectureCount();
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

        if(nextPageEnd >= totalShortQuestionCount){
            limit = totalShortQuestionCount;
           /* display = "none"*/;
        }



        if(limit==totalShortQuestionCount) display ="hidden";

        paginationBuilder.append("<div class=\"pagination-div\">");
        paginationBuilder.append("<div class=\"rl-pagination\" data-sq-count="+totalShortQuestionCount+">");
        System.out.println("pageIdNumber:::::::::::"+pageIdNumber);
        if(pageIdNumber >=2 ){
            paginationBuilder.append("<div class=\"rl-previous\" data-page=\"previous\" style=\"visibility:"+previousDisplay+";\" data-page-id="+previousPageId+" >Previous</div>");
        }else{
            paginationBuilder.append("<div id=\"cp-style\"  class=\"ra-previous\" style=\"visibility: hidden\" data-page=\"previous\">Previous</div>");
        }

        for(int i=nextPageStart;i<=limit;i++){
            if(i==nextPageStart){
                paginationBuilder.append("<div data-page-number="+i+" class=\"rl-"+i+" active rl-common-pagination\">"+i+"</div>");
            }else{
                paginationBuilder.append("<div data-page-number="+i+" class=\"rl-"+i+" rl-common-pagination\">"+i+"</div>");
            }

        }
        paginationBuilder.append("<div class=\"rl-next\" data-page=\"next\" style=\"visibility:"+display+";\" data-page-id="+(pageIdNumber+1)+" >Next</div>");
        paginationBuilder.append("</div>");
        paginationBuilder.append("</div>");


        skip = (maxPerSize*(pageIdNumber-1))+1;

    }

    RetellLecture retellLecture = speakingManager.getRetellLectureDetails((skip-1),1);
    StringBuilder stringBuilder = new StringBuilder();
    Gson gson = new Gson();
    JsonObject jsonObject = new JsonObject();

    stringBuilder.append("<div class=\"rl-render-div\">");


    stringBuilder.append("<div class=\"header-data\">Retell Lecture</div>");
    stringBuilder.append("<div class=\"difficulty-level\"></div>");
    stringBuilder.append("<div class=\"module-description\">");
    stringBuilder.append(" You will hear a lecture. After listening to the lecture, in 10 seconds, please speak into" +
            " the microphon and retell what you have just heard from the lecture in your own words. You will have 40 seconds to give your response.\n");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"recordCounter-retellLecture\"></div>");

    stringBuilder.append("<audio controls id=\"retellLecture\" class=\"audioFile readLecture-audio\">");
    stringBuilder.append("<source class=\"audioFile\"  src='../../"+retellLecture.getAudioFilePath()+"' type=\"audio/ogg\">");
    stringBuilder.append("</audio>");

    stringBuilder.append("<div class=\"status-div\">");
    stringBuilder.append("<div class=\"status-header\">Record Answer</div>");
    stringBuilder.append("<div class=\"current-status-header\">Current status:</div>");
    stringBuilder.append("<div class=\"current-status retellLecture-status\">status</div>");
    stringBuilder.append("<div class=\"status-bar retellLecture-status-bar\"></div>");
    stringBuilder.append("<div class=\"progress-bar\">");
    stringBuilder.append("<span class=\"retellLecture\" style=\"width: 0%\"></span>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"alert-message rl-alertMessage\">");
    stringBuilder.append("<div class=\"close-icon\" style=\"color:rgba(0, 0, 0, 0.5);\">x</div>");
    stringBuilder.append("<div class=\"alert-header\">! Alert</div>");
    stringBuilder.append("<div class=\"alert-content\">Times Up!! The allocated time for finishing this task is finished!!</div>");
    stringBuilder.append("</div>");

    /*Compare*/
    stringBuilder.append("<div data-show=\"show\" class=\"show-rl-details\">");


    stringBuilder.append("<div class=\"display-rl-script\">");
    stringBuilder.append("<div class=\"rl-script-header\">Audio script:</div>");
    stringBuilder.append("<div class=\"rl-script-content\">");
    stringBuilder.append(retellLecture.getAudioScript());
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"display-rl-speech\">");
    stringBuilder.append("<div class=\"rl-speech-header\">Your words:</div>");
    stringBuilder.append(" <div class=\"rl-speech-content\">");
    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"rl-message\">Talk to recognize your speech!</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");




    /*End*/


    stringBuilder.append("<audio controls id=\"recorded-retellLecture\" class=\"audioFile recorded-rl\">");
    stringBuilder.append("<source class=\"audioFile\"  src=\"\" type=\"audio/ogg\">");
    stringBuilder.append("</audio>");


    stringBuilder.append("<div class=\"footer-div rl-footer\">");
    stringBuilder.append("<span class=\"try-again rl-try-again\">Try again</span>");
    stringBuilder.append("<span class=\"audio-compare audio-compare-rl\" data-status=\"show\" >Audio script analysis</span>");
    stringBuilder.append("<span class=\"audio-compare rl-play\" data-control=\"play\">Play</span>");
    stringBuilder.append("<span class=\"audio-compare rl-download\" data-control=\"download\">Download</span>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"record-retellLecture\">Record</div>");
    stringBuilder.append("<div class=\"stop-retellLecture\">Stop</div>");
    stringBuilder.append("<div class=\"record-audio-retellLecture\" record-time=\"40\">Record audio</div>");
    stringBuilder.append("<div class=\"stop-audio-retellLecture\">Stop audio</div>");

    stringBuilder.append("</div>");

    jsonObject.addProperty("details",stringBuilder.toString());
    jsonObject.addProperty("recordAbleTime",retellLecture.getRecordableTime());
    jsonObject.addProperty("audioFileLength",retellLecture.getAudioFileLength());
    jsonObject.addProperty("pagination",paginationBuilder.toString());
    out.print(gson.toJson(jsonObject));



%>
