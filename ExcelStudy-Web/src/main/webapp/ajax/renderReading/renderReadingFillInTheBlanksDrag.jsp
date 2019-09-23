<%@ page import="com.EStudy.manager.ReadingManager" %>
<%@ page import="com.EStudy.model.reading.FillInTheBlanksDrag" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 29/8/19
  Time: 1:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ReadingManager readingManager = new ReadingManager();
    int totalDescribeImageCount = readingManager.getCollectionCount("FillInTheBlanksDrag");
    int skip;
    int maxPerSize = 5;
    String pageId = request.getParameter("pageId");
    StringBuilder paginationBuilder = new StringBuilder();
    pageId = pageId.trim();
    System.out.println("PageID  in FIBD is ::::::::::" + pageId);
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

        paginationBuilder.append("<div class=\"ra-fibd-pagination-div\">");
        paginationBuilder.append("<div id=\"cp-style-div\" class=\"ra-fibd-pagination\">");
        if (pageIdNumber >= 2) {
            paginationBuilder.append("<div id=\"cp-style\"  class=\"ra-fibd-previous\" style='visibility:" + previousDisplay + "' data-page=\"previous\" data-page-id=" + previousPageId + ">Previous</div>");
        } else {
            paginationBuilder.append("<div id=\"cp-style\"  class=\"ra-fibd-previous\" style=\"visibility: hidden\" data-page=\"previous\">Previous</div>");
        }

        for (int i = nextPageStart; i <= limit; i++) {
            if (i == nextPageStart) {
                paginationBuilder.append("<div id=\"cp-style\" data-page-number=" + i + " class=\"ra-fibd-" + i + " active ra-fibd-common-pagination\">" + i + "</div>");
            } else {
                paginationBuilder.append("<div id=\"cp-style\" data-page-number=" + i + " class=\"ra-fibd-" + i + " ra-fibd-common-pagination\">" + i + "</div>");
            }

        }
        paginationBuilder.append("<div id=\"cp-style\" class=\"ra-fibd-next\" style='visibility:" + display + "' data-page=\"next\" data-page-id=" + (pageIdNumber + 1) + ">Next</div>");
        paginationBuilder.append("</div>");
        paginationBuilder.append("</div>");

        skip = (maxPerSize * (pageIdNumber - 1)) + 1;
    }
    System.out.println("Skip is :::::::::::::::::" + skip);


    FillInTheBlanksDrag fillInTheBlanksRE = readingManager.getFillInTheBlanksDrag((skip-1), 1);
    String previouslyOccurred = fillInTheBlanksRE.getPreviouslyOccurred();
    StringBuilder stringBuilder = new StringBuilder();
    JsonObject jsonObject = new JsonObject();
    Gson gson = new Gson();


    stringBuilder.append("<div class=\"ra-fibd-render-div\">");

    stringBuilder.append("<div class=\"header-data\">Reading - Fill in the blanks</div>");
    stringBuilder.append("<div class=\"difficulty-level\"></div>");
    stringBuilder.append("<div class=\"module-description\">");
    stringBuilder.append(" Below is a text with blanks. Click on each blank, a list of choice will appear. Select the appropriate answer choice for each blank.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"repeated-question\">Previously repeated :");
    stringBuilder.append("<div class=\"repeated-question-number\">" + previouslyOccurred + "</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"common-timer\">");
    stringBuilder.append("<div class=\"listener-timer-header\">Timer: </div>");
    stringBuilder.append("<div class=\"listener-timer ra-fibd-listener-timer\">10</div>");
    stringBuilder.append("</div>");

    String audioScript = fillInTheBlanksRE.getScript();
    List<String> correctWords = fillInTheBlanksRE.getCorrectWords();
    List<String> hints = fillInTheBlanksRE.getHints();
    stringBuilder.append("<div class=\"selection-div fill-in-the-blanks-drag fbox \">");
    String[] splitedValues = audioScript.split(" ");
    int counter = 0;
    for (String value : splitedValues) {
        value = value.replace(",", "");
        value = value.replace(".", "");
        if (value != null && !value.isEmpty() && value != "") {
            if (correctWords.contains(value)) {
                counter++;
                int index = correctWords.indexOf(value);
                String correctAnswer = correctWords.get(index);
                stringBuilder.append("<span class=\"answer-area drop\"></span>");
                stringBuilder.append("<span data-color=\"false\" class=\"corrected drag-"+counter+"\">" + correctAnswer + "</span>");
            } else {
                stringBuilder.append("&nbsp;<span data-color=\"false\" class=\"normal\">&nbsp;" + value + "</span>");
            }
        }
    }
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"answer-pick-area fbox\">");
    for(String hint:hints){
        stringBuilder.append("<span class=\"draggable color answer-part\" data-option=\""+hint+"\">"+hint+"</span>");
    }
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"test-div\">").append("test").append("</div>");


    stringBuilder.append("<div class=\"alert-message ra-fibd-alertMessage\">");
    stringBuilder.append("<div class=\"close-icon ra-fibd-close-icon\" style=\"color:rgba(0, 0, 0, 0.5);\">x</div>");
    stringBuilder.append("<div class=\"alert-header\">! Alert</div>");
    stringBuilder.append("<div class=\"alert-content\">Times Up!! The allocated time for finishing this task is finished!!</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"answer-control-section\">");
    stringBuilder.append("<div class=\"try-again ra-fibd-try-again\">Try Again</div>");
    stringBuilder.append("<div class=\"check-answer ra-fibd-check-answer\">Check Answer</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"score-section-fibd\">");
    stringBuilder.append("<div class=\"fibd-close-score-section\">x</div>");
    stringBuilder.append("<div class=\"score-fibd\">");
    stringBuilder.append("<div class=\"score-header\">Your score:</div>");
    stringBuilder.append("<div class=\"score-section-content\">");
    stringBuilder.append("<div class=\"score-section-header\">Fill in the blanks:</div>");
    stringBuilder.append("<div class=\"score-section-progress\"></div>");
    stringBuilder.append("<div class=\"score-total\">2/3</div>");
    stringBuilder.append("<div class=\"score-percentage\">[67%]</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"fibd-score-section-progress fibd-show-progress\"></div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");



    stringBuilder.append("<div class=\"common-stop-button ra-fibd-stop-my-answer\">Stop</div>");


    stringBuilder.append("</div>");


    jsonObject.addProperty("details",stringBuilder.toString());
    jsonObject.addProperty("pagination",paginationBuilder.toString());
    jsonObject.addProperty("counter",String.valueOf(counter));
    out.print(gson.toJson(jsonObject));


%>
