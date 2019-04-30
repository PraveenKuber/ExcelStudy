<%@ page import="com.EStudy.manager.ListeningManager" %>
<%@ page import="com.EStudy.model.ChooseMultipleAnswers" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 28/4/19
  Time: 8:15 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ListeningManager listeningManger = new ListeningManager();
    int totalDescribeImageCount = listeningManger.getCollectionCount(ChooseMultipleAnswers.class.getSimpleName());
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

        paginationBuilder.append("<div class=\"cma-pagination-div\">");
        paginationBuilder.append("<div id=\"cp-style-div\" class=\"cma-pagination\">");
        if (pageIdNumber >= 2) {
            paginationBuilder.append("<div id=\"cp-style\"  class=\"cma-previous\" style='visibility:" + previousDisplay + "' data-page=\"previous\" data-page-id=" + previousPageId + ">Previous</div>");
        } else {
            paginationBuilder.append("<div id=\"cp-style\"  class=\"cma-previous\" style=\"visibility: hidden\" data-page=\"previous\">Previous</div>");
        }

        for (int i = nextPageStart; i <= limit; i++) {
            if (i == nextPageStart) {
                paginationBuilder.append("<div id=\"cp-style\" data-page-number=" + i + " class=\"cma-" + i + " active cma-common-pagination\">" + i + "</div>");
            } else {
                paginationBuilder.append("<div id=\"cp-style\" data-page-number=" + i + " class=\"cma-" + i + " cma-common-pagination\">" + i + "</div>");
            }

        }
        paginationBuilder.append("<div id=\"cp-style\" class=\"cma-next\" style='visibility:" + display + "' data-page=\"next\" data-page-id=" + (pageIdNumber + 1) + ">Next</div>");
        paginationBuilder.append("</div>");
        paginationBuilder.append("</div>");

        skip = (maxPerSize * (pageIdNumber - 1)) + 1;
    }
    System.out.println("Skip is :::::::::::::::::" + skip);

    ListeningManager listeningManager = new ListeningManager();
    ChooseMultipleAnswers chooseMultipleAnswers = listeningManager.getChooseMultipleAnswers((skip-1),1);
    String audioFilePath = chooseMultipleAnswers.getAudioFilePath();
    String previouslyOccurred = chooseMultipleAnswers.getPreviouslyOccurred();
    StringBuilder stringBuilder = new StringBuilder();
    JsonObject jsonObject= new JsonObject();
    Gson gson = new Gson();

    stringBuilder.append("<div class=\"cma-render-div\">");

    stringBuilder.append("<div class=\"header-data\">Choose multiple answers</div>");
    stringBuilder.append("<div class=\"difficulty-level\"></div>");
    stringBuilder.append("<div class=\"module-description\">");
    stringBuilder.append("Listen to the recording and answer the question by selecting all the correct responses. You will need to select more than one response.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"repeated-question\">Previously repeated :");
    stringBuilder.append("<div class=\"repeated-question-number\">"+previouslyOccurred+"</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"common-timer\">");
    stringBuilder.append("<div class=\"listener-timer-header\">Timer: </div>");
    stringBuilder.append("<div class=\"listener-timer cma-listener-timer\">10</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"status-div\">");
    stringBuilder.append("<div class=\"status-header\">Record Answer</div>");
    stringBuilder.append("<div class=\"current-status-header\">Current status:</div>");
    stringBuilder.append("<div class=\"current-status\">status</div>");
    stringBuilder.append("<div class=\"status-bar\"></div>");
    stringBuilder.append("<div class=\"progress-bar\">");
    stringBuilder.append("<span class=\"chooseMultipleAnswers\" style=\"width: 0%\"></span>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<audio controls class=\"audioFile cma\">");
    stringBuilder.append("<source class=\"audioFile\" src=\'../../"+audioFilePath+"' type=\"audio/ogg\">");
    stringBuilder.append("</audio>");

    stringBuilder.append("<div class=\"select-answer multiple-answer\">");
    stringBuilder.append("<div class=\"select-answer-header multiple-answer-question\">"+chooseMultipleAnswers.getMainQuestion()+"</div>");


    List<String> questions =  chooseMultipleAnswers.getQuestions();
    List<String> answers = chooseMultipleAnswers.getAnswers();

    for(String question:questions){
        String className="";
        if(answers.contains(question)) className = "cma-answer";

        stringBuilder.append("<div class=\"select-answer-choice multiple-answer-choice "+className+"\">");
        stringBuilder.append("<label class=\"choice-label\"><input class=\"checkBox\" type=\"checkbox\"  value=\"true\">"+question+"</label>");
        stringBuilder.append("</div>");
    }

    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"alert-message cma-alertMessage\">");
    stringBuilder.append("<div class=\"close-icon cma-close-icon\" style=\"color:rgba(0, 0, 0, 0.5);\">x</div>");
    stringBuilder.append("<div class=\"alert-header\">! Alert</div>");
    stringBuilder.append("<div class=\"alert-content\">Times Up!! The allocated time for finishing this task is finished!!</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"score-section\">");
    stringBuilder.append("<div class=\"close-score-section cma-close-score-section\">x</div>");
    stringBuilder.append("<div class=\"audio-script-section\">");
    stringBuilder.append("<div class=\"audio-script-header\">Audio script:</div>");
    stringBuilder.append("<div class=\"audio-script-content\">");
    stringBuilder.append("We’re going to go on a dive to the deep sea, and anyone that’s had that lovely opportunity knows that for about two and half hours on the way down, it’s a perfectly positively pitch-black world. And we used to see the most strange animals out the window that you couldn’t describe: these alternating lights — a world of bio-luminescence, like fireflies. Dr. Elvis Walter — she’s now at the Indian Ocean Research Organization , she was able to come up with a camera that could capture some of these unbelievable animals, and that’s what you’re seeing here on the screen. That’s all bio-luminescence.");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"answer-control-section\">");
    stringBuilder.append("<div class=\"try-again cma-try-again\">Try Again</div>");
    stringBuilder.append("<div class=\"check-answer cma-check-answer\">Check Answer</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"common-stop-button cma-stop-my-answer\">Stop</div>");


    stringBuilder.append("</div>");

    jsonObject.addProperty("audioFileLength",chooseMultipleAnswers.getAudioFileLength());
    jsonObject.addProperty("pagination",paginationBuilder.toString());
    jsonObject.addProperty("details",stringBuilder.toString());
    out.print(gson.toJson(jsonObject));

%>
