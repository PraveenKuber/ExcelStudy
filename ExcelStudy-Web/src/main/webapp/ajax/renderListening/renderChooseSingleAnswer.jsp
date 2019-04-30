<%@ page import="com.EStudy.manager.ListeningManager" %>
<%@ page import="com.EStudy.model.ChooseSingleAnswer" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 29/4/19
  Time: 11:40 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ListeningManager listeningManger = new ListeningManager();
    int totalDescribeImageCount = listeningManger.getCollectionCount(ChooseSingleAnswer.class.getSimpleName());
    int skip;
    int maxPerSize = 5;
    String pageId = request.getParameter("pageId");
    StringBuilder paginationBuilder = new StringBuilder();
    pageId = pageId.trim();
    System.out.println("PageID  in SST is ::::::::::" + pageId);
    if (pageId == null || pageId.isEmpty()) {
        skip = Integer.parseInt(request.getParameter("pageNumber"));
    } else {
        String pageType = request.getParameter("page");
        int pageIdNumber = Integer.parseInt(pageId);
        int nextPageStart = ((pageIdNumber - 1) * maxPerSize) + 1;
        int nextPageEnd = nextPageStart + (maxPerSize - 1);
        int limit = nextPageEnd;
        int previousPageId = pageIdNumber - 1;
        String previousDisplay = "visible";
        String display = "visible";
        if (pageType.equals("previous")) {
            nextPageStart = ((pageIdNumber - 1) * maxPerSize) + 1;
            nextPageEnd = nextPageStart + (maxPerSize - 1);
            limit = nextPageEnd;
            if (previousPageId != 1) previousDisplay = "visible";
        }

        if (nextPageEnd >= totalDescribeImageCount) {
            limit = totalDescribeImageCount;
           /* display = "none"*/
        }


        if (limit == totalDescribeImageCount) display = "hidden";

        paginationBuilder.append("<div class=\"csa-pagination-div\">");
        paginationBuilder.append("<div id=\"cp-style-div\" class=\"csa-pagination\">");
        if (pageIdNumber >= 2) {
            paginationBuilder.append("<div id=\"cp-style\"  class=\"csa-previous\" style='visibility:" + previousDisplay + "' data-page=\"previous\" data-page-id=" + previousPageId + ">Previous</div>");
        } else {
            paginationBuilder.append("<div id=\"cp-style\"  class=\"csa-previous\" style=\"visibility: hidden\" data-page=\"previous\">Previous</div>");
        }

        for (int i = nextPageStart; i <= limit; i++) {
            if (i == nextPageStart) {
                paginationBuilder.append("<div id=\"cp-style\" data-page-number=" + i + " class=\"csa-" + i + " active csa-common-pagination\">" + i + "</div>");
            } else {
                paginationBuilder.append("<div id=\"cp-style\" data-page-number=" + i + " class=\"csa-" + i + " csa-common-pagination\">" + i + "</div>");
            }

        }
        paginationBuilder.append("<div id=\"cp-style\" class=\"csa-next\" style='visibility:" + display + "' data-page=\"next\" data-page-id=" + (pageIdNumber + 1) + ">Next</div>");
        paginationBuilder.append("</div>");
        paginationBuilder.append("</div>");

        skip = (maxPerSize * (pageIdNumber - 1)) + 1;
    }
    System.out.println("Skip is :::::::::::::::::" + skip);

    ListeningManager listeningManager = new ListeningManager();
    ChooseSingleAnswer chooseSingleAnswer = listeningManager.getChooseSingleAnswer((skip-1),1);
    String audioFilePath = chooseSingleAnswer.getAudioFilePath();
    String previouslyOccurred = chooseSingleAnswer.getPreviouslyOccurred();
    StringBuilder stringBuilder = new StringBuilder();
    JsonObject jsonObject= new JsonObject();
    Gson gson = new Gson();

    stringBuilder.append("<div class=\"csa-render-div\">");

    stringBuilder.append("<div class=\"header-data\">Choose single answer</div>");
    stringBuilder.append("<div class=\"difficulty-level\"></div>");
    stringBuilder.append("<div class=\"module-description\">");
    stringBuilder.append("Listen to the recording and answer the multiple-choice question by selecting the correct response. Only one response is correct.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"repeated-question\">Previously repeated :");
    stringBuilder.append("<div class=\"repeated-question-number\">"+previouslyOccurred+"</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"common-timer\">");
    stringBuilder.append("<div class=\"listener-timer-header\">Timer: </div>");
    stringBuilder.append("<div class=\"listener-timer csa-listener-timer\">10</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"status-div\">");
    stringBuilder.append("<div class=\"status-header\">Record Answer</div>");
    stringBuilder.append("<div class=\"current-status-header\">Current status:</div>");
    stringBuilder.append("<div class=\"current-status\">status</div>");
    stringBuilder.append("<div class=\"status-bar\"></div>");
    stringBuilder.append("<div class=\"progress-bar\">");
    stringBuilder.append("<span class=\"chooseSingleAnswer\" style=\"width: 0%\"></span>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<audio controls class=\"audioFile csa\">");
    stringBuilder.append("<source class=\"audioFile\" src=\'../../"+audioFilePath+"' type=\"audio/ogg\">");
    stringBuilder.append("</audio>");

    stringBuilder.append("<div class=\"select-answer multiple-answer\">");
    stringBuilder.append("<div class=\"select-answer-header multiple-answer-question\">"+chooseSingleAnswer.getMainQuestion()+"</div>");


    List<String> questions =  chooseSingleAnswer.getQuestions();
    String answer = chooseSingleAnswer.getAnswer();

    for(String question:questions){
        String className="";
        if(question.equals(answer)) className = "csa-answer";

        stringBuilder.append("<div class=\"select-answer-choice multiple-answer-choice "+className+"\">");
        stringBuilder.append("<label class=\"choice-label\"><input class=\"checkBox-common csa-checkBox\" type=\"checkbox\"  value=\"true\">"+question+"</label>");
        stringBuilder.append("</div>");
    }

    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"alert-message csa-alertMessage\">");
    stringBuilder.append("<div class=\"close-icon csa-close-icon\" style=\"color:rgba(0, 0, 0, 0.5);\">x</div>");
    stringBuilder.append("<div class=\"alert-header\">! Alert</div>");
    stringBuilder.append("<div class=\"alert-content\">Times Up!! The allocated time for finishing this task is finished!!</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"score-section\">");
    stringBuilder.append("<div class=\"close-score-section csa-close-score-section\">x</div>");
    stringBuilder.append("<div class=\"audio-script-section\">");
    stringBuilder.append("<div class=\"audio-script-header\">Audio script:</div>");
    stringBuilder.append("<div class=\"audio-script-content\">");
    stringBuilder.append(chooseSingleAnswer.getAudioScript());
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"answer-control-section\">");
    stringBuilder.append("<div class=\"try-again csa-try-again\">Try Again</div>");
    stringBuilder.append("<div class=\"check-answer csa-check-answer\">Check Answer</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"common-stop-button csa-stop-my-answer\">Stop</div>");


    stringBuilder.append("</div>");

    jsonObject.addProperty("audioFileLength",chooseSingleAnswer.getAudioFileLength());
    jsonObject.addProperty("pagination",paginationBuilder.toString());
    jsonObject.addProperty("details",stringBuilder.toString());
    out.print(gson.toJson(jsonObject));

%>