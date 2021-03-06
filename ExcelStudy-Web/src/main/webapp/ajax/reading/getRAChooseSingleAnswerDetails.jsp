<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="java.util.List" %>
<%@ page import="com.EStudy.model.reading.ChooseSingleAnswerRE" %>
<%@ page import="com.EStudy.manager.ReadingManager" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 2/5/19
  Time: 5:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ReadingManager readingManager = new ReadingManager();
    ChooseSingleAnswerRE chooseSingleAnswer= readingManager.getChooseSingleAnswerRE(0,1);
    String previouslyOccurred = chooseSingleAnswer.getPreviouslyOccurred();
    StringBuilder stringBuilder = new StringBuilder();
    JsonObject jsonObject= new JsonObject();
    Gson gson = new Gson();

    stringBuilder.append("<div class=\"ra-csa-render-div\">");

    stringBuilder.append("<div class=\"header-data\">Choose single answer</div>");
    stringBuilder.append("<div class=\"difficulty-level\"></div>");
    stringBuilder.append("<div class=\"module-description\">");
    stringBuilder.append("Read the text and answer the multiple-choice question by selecting the correct response. Only one response is correct.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"repeated-question\">Previously repeated :");
    stringBuilder.append("<div class=\"repeated-question-number\">"+previouslyOccurred+"</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"common-timer\">");
    stringBuilder.append("<div class=\"listener-timer-header\">Timer: </div>");
    stringBuilder.append("<div class=\"listener-timer ra-csa-listener-timer\">10</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"col-md-12 reading-division ra-csa\">");
    stringBuilder.append("<div class=\"col-md-6 reading-division-question ra-csa-question\">");
    stringBuilder.append(chooseSingleAnswer.getReadableScript());
    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"col-md-6 reading-division-choices ra-csa-question-choice\">");
    stringBuilder.append("<div class=\"ra-csa-select-answer multiple-answer\">");
    stringBuilder.append("<div class=\"select-answer-header multiple-answer-question\">"+chooseSingleAnswer.getMainQuestion()+"</div>");
    List<String> questions =  chooseSingleAnswer.getQuestions();
    String answer = chooseSingleAnswer.getAnswer();
    for(String question:questions){
        String className="";
        if(question.equals(answer)) className = "ra-csa-answer";

        stringBuilder.append("<div class=\"select-answer-choice multiple-answer-choice "+className+"\">");
        stringBuilder.append("<label class=\"choice-label\"><input class=\"checkBox-common csa-checkBox\" type=\"checkbox\"  value=\"true\">"+question+"</label>");
        stringBuilder.append("</div>");
    }
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"test-div\">").append("test").append("</div>");





    stringBuilder.append("<div class=\"ra-csa-alertMessage\">");
    stringBuilder.append("<div class=\"close-icon-re ra-csa-close-icon\" style=\"color:rgba(0, 0, 0, 0.5);\">x</div>");
    stringBuilder.append("<div class=\"alert-header\">! Alert</div>");
    stringBuilder.append("<div class=\"alert-content\">Times Up!! The allocated time for finishing this task is finished!!</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"col-md-10 score-section score-section-ra\">");
    stringBuilder.append("<div class=\"close-score-section ra-csa-close-score-section\">x</div>");
    stringBuilder.append("<div class=\"audio-script-section\">");
    stringBuilder.append("<div class=\"audio-script-header\">Comment:</div>");
    stringBuilder.append("<div class=\"audio-script-content\">");
    stringBuilder.append(chooseSingleAnswer.getDescription());
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"answer-control-section\">");
    stringBuilder.append("<div class=\"try-again ra-csa-try-again\">Try Again</div>");
    stringBuilder.append("<div class=\"check-answer ra-csa-check-answer\">Check Answer</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"common-stop-button ra-csa-stop-my-answer\">Stop</div>");


    stringBuilder.append("</div>");


      /*Pagination div*/
    stringBuilder.append("<div class=\"ra-csa-pagination-div\">");
    stringBuilder.append("<div id=\"cp-style-div\" class=\"ra-csa-pagination\">");
    stringBuilder.append("<div id=\"cp-style\"  class=\"ra-csa-previous\" style=\"visibility: hidden\" data-page=\"previous\" data-page-id=\"2\">Previous</div>");
    for(int i=1;i<=5;i++){
        if(i==1){
            stringBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"ra-csa-"+i+" active ra-csa-common-pagination\">"+i+"</div>");
        }else{
            stringBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"ra-csa-"+i+" ra-csa-common-pagination\">"+i+"</div>");
        }

    }
    stringBuilder.append("<div id=\"cp-style\" class=\"ra-csa-next\" data-page=\"next\" data-page-id=\"2\">Next</div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");
    /*End*/



    jsonObject.addProperty("details",stringBuilder.toString());
    out.print(gson.toJson(jsonObject));
%>

