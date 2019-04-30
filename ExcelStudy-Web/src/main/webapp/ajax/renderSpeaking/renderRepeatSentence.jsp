<%@ page import="com.EStudy.manager.SpeakingManager" %>
<%@ page import="com.EStudy.model.RepeatSentence" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 1/4/19
  Time: 10:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    SpeakingManager speakingManager = new SpeakingManager();
    int totalDescribeImageCount = speakingManager.getCollectionCount(RepeatSentence.class.getSimpleName());
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

        paginationBuilder.append("<div class=\"rp-pagination-div\">");
        paginationBuilder.append("<div id=\"cp-style-div\" class=\"rp-pagination\">");
        if(pageIdNumber >=2 ){
            paginationBuilder.append("<div id=\"cp-style\"  class=\"rp-previous\" style='visibility:"+previousDisplay+"' data-page=\"previous\" data-page-id="+previousPageId+">Previous</div>");
        }else{
            paginationBuilder.append("<div id=\"cp-style\"  class=\"ra-previous\" style=\"visibility: hidden\" data-page=\"previous\">Previous</div>");
        }

        for(int i=nextPageStart;i<=limit;i++){
            if(i==nextPageStart){
                paginationBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"di-"+i+" active rp-common-pagination\">"+i+"</div>");
            }else{
                paginationBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"di-"+i+" rp-common-pagination\">"+i+"</div>");
            }

        }
        paginationBuilder.append("<div id=\"cp-style\" class=\"rp-next\" style='visibility:"+display+"' data-page=\"next\" data-page-id="+(pageIdNumber+1)+">Next</div>");
        paginationBuilder.append("</div>");
        paginationBuilder.append("</div>");

        skip = (maxPerSize*(pageIdNumber-1))+1;

    }

    RepeatSentence repeatSentence = speakingManager.getRepeatSentenceDetails((skip-1),1);
    StringBuilder stringBuilder = new StringBuilder();
    Gson gson = new Gson();
    JsonObject jsonObject = new JsonObject();
    String previouslyOccurred = "-";
    if(repeatSentence.getPreviouslyOccurred()!=null && !repeatSentence.getPreviouslyOccurred().isEmpty()){
        previouslyOccurred = repeatSentence.getPreviouslyOccurred();
    }

    /*start*/

    stringBuilder.append("<div class=\"rp-render-div\">");
    stringBuilder.append("<div class=\"header-data\">Repeat sentence</div>");
    stringBuilder.append("<div class=\"difficulty-level\"></div>");
    stringBuilder.append("<div class=\"module-description\">");
    stringBuilder.append("You will hear a sentence. Please repeat the sentence exactly as you hear it." +
            "You will hear the sentence only once.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"repeated-question\">Previously repeated :");
    stringBuilder.append("<div class=\"repeated-question-number\">"+previouslyOccurred+"</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"status-div-one\">");
    stringBuilder.append("<div class=\"status-header-one\"></div>");
    stringBuilder.append("<div class=\"current-status-header-one\">Current status:</div>");
    stringBuilder.append("<div class=\"current-status-one repeat-sentence-status-one\">completed</div>");
    stringBuilder.append("<div class=\"status-bar-one repeat-sentence-status-bar\"></div>");
    stringBuilder.append("<div class=\"progress-bar-one\">");
    stringBuilder.append("<span class=\"repeatSentence-one\"></span>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"recordCounter\"></div>");

    stringBuilder.append("<audio controls id=\"repeat-sentence\" class=\"audioFile repeatSentence-audio\">");
    stringBuilder.append("<source class=\"audioFile\"  src=\'../../"+repeatSentence.getAudioPath()+"\' type=\"audio/ogg\">");
    stringBuilder.append("</audio>");

    stringBuilder.append("<div class=\"status-div\">");
    stringBuilder.append("<div class=\"status-header\">Record Answer</div>");
    stringBuilder.append("<div class=\"current-status-header\">Current status:</div>");
    stringBuilder.append("<div class=\"current-status repeat-sentence-status\">status</div>");
    stringBuilder.append("<div class=\"status-bar repeat-sentence-status-bar\"></div>");
    stringBuilder.append("<div class=\"progress-bar\">");
    stringBuilder.append("<span class=\"repeatSentence\" style=\"width: 0%\"></span>");
    stringBuilder.append(" </div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"alert-message rp-alertMessage\">");
    stringBuilder.append("<div class=\"close-icon\" style=\"color:rgba(0, 0, 0, 0.5);\">x</div>");
    stringBuilder.append("<div class=\"alert-header\">! Alert</div>");
    stringBuilder.append("<div class=\"alert-content\">Times Up!! The allocated time for finishing this task is finished!!</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"footer-div repeatSentence-footer-div\">");
    stringBuilder.append("<span class=\"try-again rp-try-again\">Try again</span>");
    stringBuilder.append("<span class=\"audio-compare\">Audio compare</span>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"record-repeat-sentence\">Record</div>");
    stringBuilder.append("<div class=\"stop-repeat-sentence\">Stop</div>");

    stringBuilder.append("<div class=\"repeatSentence-compare-module\">");
    stringBuilder.append("<span class=\"answer-analysis\">Answer analysis:</span> <span class=\"close-answer-analysis\" style=\"color:black;\">x</span>");
    stringBuilder.append("<div class=\"audio-script\">");
    stringBuilder.append("<span class=\"audio-script-header\">your answer:</span>");
    stringBuilder.append("<div  class=\"audio-script-content\"></div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"recorded-script\">");
    stringBuilder.append("<span class=\"recorded-script-header\">correct answer:</span>");
    stringBuilder.append("<div  class=\"recorded-script-content\">"+repeatSentence.getAudioScript()+"</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"word-compare\">");
    stringBuilder.append("<span class=\"word-compare-header\">word compare:</span>");
    stringBuilder.append("<div  class=\"word-compare-content\"></div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"common-stop-button re-stop-my-answer\">Stop</div>");

    stringBuilder.append("</div>");

    /*End*/


    jsonObject.addProperty("details",stringBuilder.toString());
    jsonObject.addProperty("pagination",paginationBuilder.toString());
    jsonObject.addProperty("audioFileLength",repeatSentence.getAudioFileLength());
    jsonObject.addProperty("recordableTime",repeatSentence.getRecordableTime());
    out.print(gson.toJson(jsonObject));


%>
