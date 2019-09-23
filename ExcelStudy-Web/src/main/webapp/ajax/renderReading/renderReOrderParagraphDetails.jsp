<%@ page import="com.EStudy.manager.ReadingManager" %>
<%@ page import="com.EStudy.model.reading.REOrderParagraph" %>
<%@ page import="com.EStudy.model.reading.ReorderQuestion" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 23/8/19
  Time: 5:24 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ReadingManager readingManager = new ReadingManager();
    int totalDescribeImageCount = readingManager.getCollectionCount("ReOrderParagraph");
    int skip;
    int maxPerSize = 5;
    String pageId = request.getParameter("pageId");
    StringBuilder paginationBuilder = new StringBuilder();
    pageId = pageId.trim();
    System.out.println("PageID  in ROP is ::::::::::" + pageId);
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

        paginationBuilder.append("<div class=\"ra-rop-pagination-div\">");
        paginationBuilder.append("<div id=\"cp-style-div\" class=\"ra-rop-pagination\">");
        if (pageIdNumber >= 2) {
            paginationBuilder.append("<div id=\"cp-style\"  class=\"ra-rop-previous\" style='visibility:" + previousDisplay + "' data-page=\"previous\" data-page-id=" + previousPageId + ">Previous</div>");
        } else {
            paginationBuilder.append("<div id=\"cp-style\"  class=\"ra-rop-previous\" style=\"visibility: hidden\" data-page=\"previous\">Previous</div>");
        }

        for (int i = nextPageStart; i <= limit; i++) {
            if (i == nextPageStart) {
                paginationBuilder.append("<div id=\"cp-style\" data-page-number=" + i + " class=\"ra-rop-" + i + " active ra-rop-common-pagination\">" + i + "</div>");
            } else {
                paginationBuilder.append("<div id=\"cp-style\" data-page-number=" + i + " class=\"ra-rop-" + i + " ra-rop-common-pagination\">" + i + "</div>");
            }

        }
        paginationBuilder.append("<div id=\"cp-style\" class=\"ra-rop-next\" style='visibility:" + display + "' data-page=\"next\" data-page-id=" + (pageIdNumber + 1) + ">Next</div>");
        paginationBuilder.append("</div>");
        paginationBuilder.append("</div>");

        skip = (maxPerSize * (pageIdNumber - 1)) + 1;
    }
    System.out.println("Skip is :::::::::::::::::" + skip);


    REOrderParagraph reOrderParagraph = readingManager.getReOrderParagraphRE((skip-1),1);
    List<ReorderQuestion> reOrderQuestions = reOrderParagraph.getReOrderQuestions();
    int questionsLength = reOrderQuestions.size();
    String previouslyOccurred = reOrderParagraph.getPreviouslyOccurred();
    StringBuilder stringBuilder = new StringBuilder();
    JsonObject jsonObject= new JsonObject();
    Gson gson = new Gson();


    stringBuilder.append("<div class=\"ra-rop-render-div\">");

    stringBuilder.append("<div class=\"header-data\">Re-order paragraphs</div>");
    stringBuilder.append("<div class=\"difficulty-level\"></div>");
    stringBuilder.append("<div class=\"module-description\">");
    stringBuilder.append("The text boxes in the left panel have been placed in a random order. Restore the original order by dragging the text boxes from the left panel to the right panel.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"repeated-question\">Previously repeated :");
    stringBuilder.append("<div class=\"repeated-question-number\">"+previouslyOccurred+"</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"common-timer\">");
    stringBuilder.append("<div class=\"listener-timer-header\">Timer: </div>");
    stringBuilder.append("<div class=\"listener-timer ra-rop-listener-timer\">10</div>");
    stringBuilder.append("</div>");



    stringBuilder.append("<div class=\"drag-and-drop col-md-12\">");
    stringBuilder.append("<div class=\"fbox swapped-text re-order-paragraph col-md-6\">");

    for(ReorderQuestion reOrderQuestion:reOrderQuestions){
        int order = reOrderQuestion.getOrder();
        String question = reOrderQuestion.getQuestion();
        stringBuilder.append("<div class=\"draggable paragraph position-"+order+"\" data-input=\'"+order+"\'>"+question+"</div>");
    }

    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"fbox order-paragraph col-md-6 drop\"></div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"test-div\">").append("test").append("</div>");






    stringBuilder.append("<div class=\"alert-message ra-rop-alertMessage\">");
    stringBuilder.append("<div class=\"close-icon ra-rop-close-icon\" style=\"color:rgba(0, 0, 0, 0.5);\">x</div>");
    stringBuilder.append("<div class=\"alert-header\">! Alert</div>");
    stringBuilder.append("<div class=\"alert-content\">Times Up!! The allocated time for finishing this task is finished!!</div>");
    stringBuilder.append("</div>");



    stringBuilder.append("<div class=\"answer-control-section\">");
    stringBuilder.append("<div class=\"try-again ra-rop-try-again\">Try Again</div>");
    stringBuilder.append("<div class=\"check-answer ra-rop-check-answer\">Check Answer</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"score-section-rop\">");
    stringBuilder.append("<div class=\"rop-close-score-section\">x</div>");
    stringBuilder.append("<div class=\"score-rop\">");
    stringBuilder.append("<div class=\"score-header\">Your score:</div>");
    stringBuilder.append("<div class=\"score-section-content\">");
    stringBuilder.append("<div class=\"score-section-header\">Re-order paragraph:</div>");
    stringBuilder.append("<div class=\"score-section-progress\"></div>");
    stringBuilder.append("<div class=\"score-total\">2/3</div>");
    stringBuilder.append("<div class=\"score-percentage\">[67%]</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"rop-score-section-progress rop-show-progress\"></div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"common-stop-button ra-rop-stop-my-answer\">Stop</div>");

    stringBuilder.append("</div>");




    jsonObject.addProperty("length",questionsLength);
    jsonObject.addProperty("details",stringBuilder.toString());
    jsonObject.addProperty("pagination",paginationBuilder.toString());
    out.print(gson.toJson(jsonObject));


%>
