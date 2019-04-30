<%@ page import="com.EStudy.manager.WritingManager" %>
<%@ page import="com.EStudy.model.WriteEssay" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 9/4/19
  Time: 12:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    WritingManager writingManager = new WritingManager();
    int totalDescribeImageCount = writingManager.getCollectionCount(WriteEssay.class.getSimpleName());
    int skip;
    int maxPerSize = 5;
    String pageId = request.getParameter("pageId");
    StringBuilder paginationBuilder = new StringBuilder();
    pageId = pageId.trim();
    System.out.println("PageID  in SWT is ::::::::::" + pageId);
    if (pageId == null || pageId.isEmpty()) {
        skip = Integer.parseInt(request.getParameter("pageNumber"));
        System.out.println("Skip is ::::::" + skip);
    } else {
        String pageType = request.getParameter("page");
        int pageIdNumber = Integer.parseInt(pageId);
        int nextPageStart = ((pageIdNumber - 1) * maxPerSize) + 1;
        int nextPageEnd = nextPageStart + (maxPerSize - 1);
        int limit = nextPageEnd;
        int previousPageId = pageIdNumber - 1;
        ;
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
            ;
        }

        if (limit == totalDescribeImageCount) display = "hidden";

        paginationBuilder.append("<div class=\"we-pagination-div\">");
        paginationBuilder.append("<div id=\"cp-style-div\" class=\"we-pagination\">");
        if (pageIdNumber >= 2) {
            paginationBuilder.append("<div id=\"cp-style\"  class=\"we-previous\" style='visibility:" + previousDisplay + "' data-page=\"previous\" data-page-id=" + previousPageId + ">Previous</div>");
        } else {
            paginationBuilder.append("<div id=\"cp-style\"  class=\"we-previous\" style=\"visibility: hidden\" data-page=\"previous\">Previous</div>");
        }

        for (int i = nextPageStart; i <= limit; i++) {
            if (i == nextPageStart) {
                paginationBuilder.append("<div id=\"cp-style\" data-page-number=" + i + " class=\"we-" + i + " active we-common-pagination\">" + i + "</div>");
            } else {
                paginationBuilder.append("<div id=\"cp-style\" data-page-number=" + i + " class=\"we-" + i + " we-common-pagination\">" + i + "</div>");
            }

        }
        paginationBuilder.append("<div id=\"cp-style\" class=\"we-next\" style='visibility:" + display + "' data-page=\"next\" data-page-id=" + (pageIdNumber + 1) + ">Next</div>");
        paginationBuilder.append("</div>");
        paginationBuilder.append("</div>");


        skip = (maxPerSize * (pageIdNumber - 1)) + 1;
    }
    System.out.println("Skip is :::::::::::::::::" + skip);

    WriteEssay writeEssay = writingManager.getWriteEssayDetails((skip-1), 1);
    StringBuilder stringBuilder = new StringBuilder();
    Gson gson = new Gson();
    JsonObject jsonObject = new JsonObject();
    String previouslyOccurred = "-";
    if(writeEssay.getPreviouslyOccurred()!=null && !writeEssay.getPreviouslyOccurred().isEmpty()){
        previouslyOccurred = writeEssay.getPreviouslyOccurred();
    }


    stringBuilder.append("<div class=\"we-render-div\">");
    stringBuilder.append("<div class=\"header-data\">Write essay</div>");
    stringBuilder.append("<div class=\"difficulty-level\"></div>");
    stringBuilder.append("<div class=\"module-description\">");
    stringBuilder.append("&nbsp;&nbsp;&nbsp;You will have 20 minutes to plan, write and revise an essay about the topic below. Your response will be judged on how well you develop a position, organize your ideas, " +
            "present supporting details, and control the elements of standard written English. You should write 200-300 words.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"repeated-question\">Previously repeated :");
    stringBuilder.append("<div class=\"repeated-question-number\">"+previouslyOccurred+"</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"writeEssayDescription\">");
    stringBuilder.append(writeEssay.getEssayQuestion());
    stringBuilder.append("</div>");


    stringBuilder.append("<textarea rows=\"14\" cols=\"130\" class=\"write-essay-output\" onkeyup=\"writeEssay.getInputTextCount()\">");
    stringBuilder.append("</textarea>");

    stringBuilder.append("<div class=\"basic-util\">");
    stringBuilder.append("<div class=\"common cut\">Cut</div>");
    stringBuilder.append("<div class=\"common copy\">Copy</div>");
    stringBuilder.append("<div class=\"common paste\">Paste</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"we-counter\">");
    stringBuilder.append("<div class=\"we-word-counter\">");
    stringBuilder.append("<span class=\"word-counter-header\">Total word count : </span>");
    stringBuilder.append("<span class=\"we-word-counter-content word-counter-content\"> </span>");
    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"we-time-counter\">");
    stringBuilder.append("<span class=\"time-counter-header\">Timer : </span>");
    stringBuilder.append("<span class=\"we-time-counter-content time-counter-content\"> </span>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"alert-message we-alertMessage\">");
    stringBuilder.append("<div class=\"close-icon we-closeIcon\" style=\"color:rgba(0, 0, 0, 0.5);\">x</div>");
    stringBuilder.append("<div class=\"alert-header\">! Alert</div>");
    stringBuilder.append("<div class=\"alert-content\">Times Up! The allocated time for finishing this task is finished!</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"we-answer-analysis\">");
    stringBuilder.append("<div class=\"we-your-answer-close\">x</div>");
    stringBuilder.append("<div class=\"we-your-answer\">");
    stringBuilder.append("<div class=\"we-your-answer-header\">Your words :</div>");
    stringBuilder.append("<textarea rows=\"6\" cols=\"60\" readonly class=\"we-your-answer-content\"></textarea>");
    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"we-sample-answer\">");
    stringBuilder.append("<div class=\"we-sample-header\">Theme</div>");
    stringBuilder.append("<div class=\"we-theme-name\">"+writeEssay.getThemeName()+"</div>");
    stringBuilder.append("<div class=\"swt-sample-suggestion-header\">Suggested Key Points:</div>");
    stringBuilder.append("<div class=\"suggestion-list\">");
    if(writeEssay.getSuggestedPoints().size()>0){
        for(String suggestion:writeEssay.getSuggestedPoints()){
            stringBuilder.append("<div class=\"suggestion-list-number\">"+suggestion+"</div>");
        }
    }
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"we-control\">");
    stringBuilder.append("<div class=\"we-try-again\">Try again</div>");
    stringBuilder.append("<div class=\"we-check-answer\">Check answer</div>");
    stringBuilder.append("<div class=\"we-save-my-answer\">Save answer</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"we-stop-my-answer\">Stop</div>");

    stringBuilder.append("</div>");

    jsonObject.addProperty("details", stringBuilder.toString());
    jsonObject.addProperty("pagination", paginationBuilder.toString());
    out.print(gson.toJson(jsonObject));

%>