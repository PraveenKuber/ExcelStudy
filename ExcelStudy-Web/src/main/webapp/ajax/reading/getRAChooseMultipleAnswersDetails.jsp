<%@ page import="com.EStudy.manager.ReadingManager" %>
<%@ page import="com.EStudy.model.reading.ChooseMultipleAnswersRE" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 6/5/19
  Time: 5:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ReadingManager readingManager = new ReadingManager();
    ChooseMultipleAnswersRE chooseMultipleAnswersRE = readingManager.getChooseMultipleAnswersRE(0,1);
    String previouslyOccurred = chooseMultipleAnswersRE.getPreviouslyOccurred();
    StringBuilder stringBuilder = new StringBuilder();
    JsonObject jsonObject= new JsonObject();
    Gson gson = new Gson();

    stringBuilder.append("<div class=\"ra-cma-render-div\">");

    stringBuilder.append("<div class=\"header-data\">Choose multiple answers</div>");
    stringBuilder.append("<div class=\"difficulty-level\"></div>");
    stringBuilder.append("<div class=\"module-description\">");
    stringBuilder.append("Read the text and answer the multiple-choice question by selecting the correct response. More than one response is correct.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"repeated-question\">Previously repeated :");
    stringBuilder.append("<div class=\"repeated-question-number\">"+previouslyOccurred+"</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"common-timer\">");
    stringBuilder.append("<div class=\"listener-timer-header\">Timer: </div>");
    stringBuilder.append("<div class=\"listener-timer ra-cma-listener-timer\">10</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"col-md-12 reading-division ra-cma\">");
    stringBuilder.append("<div class=\"col-md-6 reading-division-question ra-cma-question\">");
    stringBuilder.append(chooseMultipleAnswersRE.getReadableScript());
    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"col-md-6 reading-division-choices ra-cma-question-choice\">");
    stringBuilder.append("<div class=\"ra-csa-select-answer multiple-answer\">");
    stringBuilder.append("<div class=\"select-answer-header multiple-answer-question\">"+chooseMultipleAnswersRE.getMainQuestion()+"</div>");

    List<String> questions =  chooseMultipleAnswersRE.getQuestions();
    List<String> answers = chooseMultipleAnswersRE.getAnswers();

    for(String question:questions){
        String className="";
        if(answers.contains(question)) className = "ra-cma-answer";

        stringBuilder.append("<div class=\"select-answer-choice multiple-answer-choice "+className+"\">");
        stringBuilder.append("<label class=\"choice-label\"><input class=\"checkBox\" type=\"checkbox\"  value=\"true\">"+question+"</label>");
        stringBuilder.append("</div>");
    }
    stringBuilder.append("</div>");



    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"test-div\">").append("test").append("</div>");





    stringBuilder.append("<div class=\"alert-message ra-cma-alertMessage\">");
    stringBuilder.append("<div class=\"close-icon ra-cma-close-icon\" style=\"color:rgba(0, 0, 0, 0.5);\">x</div>");
    stringBuilder.append("<div class=\"alert-header\">! Alert</div>");
    stringBuilder.append("<div class=\"alert-content\">Times Up!! The allocated time for finishing this task is finished!!</div>");
    stringBuilder.append("</div>");



    stringBuilder.append("<div class=\"answer-control-section\">");
    stringBuilder.append("<div class=\"try-again ra-cma-try-again\">Try Again</div>");
    stringBuilder.append("<div class=\"check-answer ra-cma-check-answer\">Check Answer</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"common-stop-button ra-cma-stop-my-answer\">Stop</div>");


    stringBuilder.append("</div>");
    stringBuilder.append("</div>");



      /*Pagination div*/
    stringBuilder.append("<div class=\"ra-cma-pagination-div\">");
    stringBuilder.append("<div id=\"cp-style-div\" class=\"ra-cma-pagination\">");
    stringBuilder.append("<div id=\"cp-style\"  class=\"ra-cma-previous\" style=\"visibility: hidden\" data-page=\"previous\" data-page-id=\"2\">Previous</div>");
    for(int i=1;i<=5;i++){
        if(i==1){
            stringBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"ra-cma-"+i+" active ra-cma-common-pagination\">"+i+"</div>");
        }else{
            stringBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"ra-cma-"+i+" ra-cma-common-pagination\">"+i+"</div>");
        }

    }
    stringBuilder.append("<div id=\"cp-style\" class=\"ra-cma-next\" data-page=\"next\" data-page-id=\"2\">Next</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");
    /*End*/

    jsonObject.addProperty("details",stringBuilder.toString());
    out.print(gson.toJson(jsonObject));

%>
