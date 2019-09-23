<%@ page import="com.EStudy.manager.ReadingManager" %>
<%@ page import="com.EStudy.model.reading.FillInTheBlanksRE" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="java.util.List" %>
<%@ page import="com.EStudy.GUI.FillInTheBlanksGUI" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 8/5/19
  Time: 2:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ReadingManager readingManager = new ReadingManager();
    FillInTheBlanksRE fillInTheBlanksRE = readingManager.getFillInTheBlanksRE(0,1);
    String previouslyOccurred = fillInTheBlanksRE.getPreviouslyOccurred();
    StringBuilder stringBuilder = new StringBuilder();
    JsonObject jsonObject= new JsonObject();
    Gson gson = new Gson();

    stringBuilder.append("<div class=\"ra-fib-render-div\">");

    stringBuilder.append("<div class=\"header-data\">Fill in the blanks</div>");
    stringBuilder.append("<div class=\"difficulty-level\"></div>");
    stringBuilder.append("<div class=\"module-description\">");
    stringBuilder.append(" Below is a text with blanks. Click on each blank, a list of choice will appear. Select the appropriate answer choice for each blank.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"repeated-question\">Previously repeated :");
    stringBuilder.append("<div class=\"repeated-question-number\">"+previouslyOccurred+"</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"common-timer\">");
    stringBuilder.append("<div class=\"listener-timer-header\">Timer: </div>");
    stringBuilder.append("<div class=\"listener-timer ra-fib-listener-timer\">10</div>");
    stringBuilder.append("</div>");


    String audioScript = fillInTheBlanksRE.getQuestion();
    String[] splitedValues = audioScript.split(" ");
    stringBuilder.append("<div class=\"selection-div col-md-10  fill-in-the-blanks-re fbox \">");
    int counter = 0;
    List<FillInTheBlanksGUI> fillInTheBlanksGUIList = fillInTheBlanksRE.getFillInTheBlanks();
    for (String value : splitedValues) {
        value = value.replace(",", "");
        value = value.replace(".", "");
        if (value != null && !value.isEmpty() && value != "") {
            FillInTheBlanksGUI result  = readingManager.getValueForFillInTheBlanksList(fillInTheBlanksGUIList,value);
            if(result!=null){
                counter++;
                List<String> choices = result.getChoices();
                stringBuilder.append("&nbsp;<select class=\"fib fid-re-"+counter+"\">");
                stringBuilder.append("<option value=\"\"></option>");
                  for(String choice:choices){
                      stringBuilder.append("<option value="+choice+">"+choice+"</option>");
                  }
                stringBuilder.append("</select>");
                stringBuilder.append("&nbsp; <span data-color=\"false\" class=\"fib-re-answer  fib-re-correct fib-re-corrected-"+counter+"\">" + value + "</span>");
            }
            else {
                stringBuilder.append("&nbsp; <span data-color=\"false\" class=\"fib-re-answer fib-re-normal\">" + value + "</span>");
            }
        }
    }
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"test-div\">").append("test").append("</div>");




    stringBuilder.append("<div class=\"alert-message ra-fib-alertMessage\">");
    stringBuilder.append("<div class=\"close-icon ra-fib-close-icon\" style=\"color:rgba(0, 0, 0, 0.5);\">x</div>");
    stringBuilder.append("<div class=\"alert-header\">! Alert</div>");
    stringBuilder.append("<div class=\"alert-content\">Times Up!! The allocated time for finishing this task is finished!!</div>");
    stringBuilder.append("</div>");



    stringBuilder.append("<div class=\"answer-control-section\">");
    stringBuilder.append("<div class=\"try-again ra-fib-try-again\">Try Again</div>");
    stringBuilder.append("<div class=\"check-answer ra-fib-check-answer\">Check Answer</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"score-section-fibr\">");
    stringBuilder.append("<div class=\"fibr-close-score-section\">x</div>");
    stringBuilder.append("<div class=\"score-fibr\">");
    stringBuilder.append("<div class=\"score-header\">Your score:</div>");
    stringBuilder.append("<div class=\"score-section-content\">");
    stringBuilder.append("<div class=\"score-section-header\">Fill in the blanks:</div>");
    stringBuilder.append("<div class=\"score-section-progress\"></div>");
    stringBuilder.append("<div class=\"score-total\">2/3</div>");
    stringBuilder.append("<div class=\"score-percentage\">[67%]</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"fibr-score-section-progress fibr-show-progress\"></div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");



    stringBuilder.append("<div class=\"common-stop-button ra-fib-stop-my-answer\">Stop</div>");


    stringBuilder.append("</div>");


      /*Pagination div*/
    stringBuilder.append("<div class=\"ra-fib-pagination-div\">");
    stringBuilder.append("<div id=\"cp-style-div\" class=\"ra-fib-pagination\">");
    stringBuilder.append("<div id=\"cp-style\"  class=\"ra-fib-previous\" style=\"visibility: hidden\" data-page=\"previous\" data-page-id=\"2\">Previous</div>");
    for(int i=1;i<=5;i++){
        if(i==1){
            stringBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"ra-fib-"+i+" active ra-fib-common-pagination\">"+i+"</div>");
        }else{
            stringBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"ra-fib-"+i+" ra-fib-common-pagination\">"+i+"</div>");
        }

    }
    stringBuilder.append("<div id=\"cp-style\" class=\"ra-fib-next\" data-page=\"next\" data-page-id=\"2\">Next</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");
    /*End*/

    jsonObject.addProperty("counter",fillInTheBlanksGUIList.size());
    jsonObject.addProperty("details",stringBuilder.toString());
    out.print(gson.toJson(jsonObject));




%>




