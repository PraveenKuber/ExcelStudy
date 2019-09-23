<%@ page import="com.EStudy.manager.SpeakingManager" %>
<%@ page import="com.EStudy.model.ReadAloud" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 2/4/19
  Time: 10:18 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    SpeakingManager speakingManager = new SpeakingManager();
    int totalDescribeImageCount = speakingManager.getCollectionCount(ReadAloud.class.getSimpleName());
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

        paginationBuilder.append("<div class=\"ra-pagination-div\">");
        paginationBuilder.append("<div id=\"cp-style-div\" class=\"ra-pagination\">");
        if(pageIdNumber >=2 ){
            paginationBuilder.append("<div id=\"cp-style\"  class=\"ra-previous\" style='visibility:"+previousDisplay+"' data-page=\"previous\" data-page-id="+previousPageId+">Previous</div>");
        }else{
            paginationBuilder.append("<div id=\"cp-style\"  class=\"ra-previous\" style=\"visibility: hidden\" data-page=\"previous\">Previous</div>");
        }

        for(int i=nextPageStart;i<=limit;i++){
            if(i==nextPageStart){
                paginationBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"ra-"+i+" active ra-common-pagination\">"+i+"</div>");
            }else{
                paginationBuilder.append("<div id=\"cp-style\" data-page-number="+i+" class=\"di-"+i+" ra-common-pagination\">"+i+"</div>");
            }

        }
        paginationBuilder.append("<div id=\"cp-style\" class=\"ra-next\" style='visibility:"+display+"' data-page=\"next\" data-page-id="+(pageIdNumber+1)+">Next</div>");
        paginationBuilder.append("</div>");
        paginationBuilder.append("</div>");

        skip = (maxPerSize*(pageIdNumber-1))+1;

    }

    ReadAloud  readAloud = speakingManager.getReadAloudDetails((skip-1),1);
    StringBuilder stringBuilder = new StringBuilder();
    Gson gson = new Gson();
    JsonObject jsonObject = new JsonObject();

    String previouslyOccurred = "-";
    if(readAloud.getPreviouslyOccurred()!=null && !readAloud.getPreviouslyOccurred().isEmpty()){
        previouslyOccurred = readAloud.getPreviouslyOccurred();
    }


    stringBuilder.append("<div class=\"ra-render-div\">");

    stringBuilder.append("<div class=\"header-data\">Read aloud</div>");
    stringBuilder.append("<div class=\"difficulty-level\"></div>");
    stringBuilder.append("<div class=\"module-description\">");
    stringBuilder.append(" Look at the text below. In "+readAloud.getRecordableLength()+"seconds, you must read this text aloud as naturally and clearly as possible. You have "+readAloud.getRecordableLength()+" seconds to read aloud.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"repeated-question\">Previously repeated :");
    stringBuilder.append("<div class=\"repeated-question-number\">"+previouslyOccurred+"</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"status-div\">");
    stringBuilder.append("<div class=\"status-header\">Record Answer</div>");
    stringBuilder.append("<div class=\"current-status-header\">Current status:</div>");
    stringBuilder.append("<div class=\"current-status\">status</div>");
    stringBuilder.append("<div class=\"status-bar\"></div>");

    stringBuilder.append("<div class=\"progress-bar\">");
    stringBuilder.append("<span class=\"readAloud\" style=\"width: 0%\"></span>");
    stringBuilder.append(" </div>");

    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"speaking-description\">");
    stringBuilder.append(readAloud.getAudioScript());
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"alert-message ra-alertMessage\">");
    stringBuilder.append("<div class=\"close-icon ra-close-icon\" style=\"color:rgba(0, 0, 0, 0.5);\">x</div>");
    stringBuilder.append("<div class=\"alert-header\">! Alert</div>");
    stringBuilder.append("<div class=\"alert-content\">Times Up!! The allocated time for finishing this task is finished!!</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<audio controls id=\"audio\"></audio>");
    stringBuilder.append("<div class=\"recordingArea\">");
    stringBuilder.append("<a class=\"button recordButton\" id=\"recordForX\" data-number-of-seconds="+readAloud.getRecordableLength()+">Record For x Seconds</a>");
    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"loader\"><img class=\"loader-image\" src=\"../../images/loder.gif\"></div>");


    stringBuilder.append("<div class=\"ra-control-section\">");
    stringBuilder.append("<span class=\"control-div\" data-type=\"mp3\">");
    stringBuilder.append("<div class=\"control-label reset\">Try again</div>");
    stringBuilder.append("<a class=\"button disabled one control-label play\" id=\"play\">Play</a>");
    stringBuilder.append("<a class=\"button disabled one control-label download\" id=\"download\">Download</a>");
    stringBuilder.append("<div class=\"control-label stop stop-ra\">Stop</div>");
    stringBuilder.append("<div class=\"control-label record-speaking\" id=\"record-speaking-details\" data-number-of-seconds="+readAloud.getRecordableLength()+">Record</div>");
    stringBuilder.append("<div class=\"control-label compare\">compare</div>");
    stringBuilder.append("</span>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"ra-compare-module\">");
    stringBuilder.append("<span class=\"answer-analysis\">Answer analysis:</span>");
    stringBuilder.append("<span class=\"close-analysis-ra\">x</span>");
    stringBuilder.append("<div class=\"audio-script audio-script-ra\">");
    stringBuilder.append("<span class=\"audio-script-header\">your answer:</span>");
    stringBuilder.append("<div  class=\"audio-script- speechToTextArea\"></div>");
    stringBuilder.append("</div>");
    stringBuilder.append("<div class=\"word-compare\">");
    stringBuilder.append("<span class=\"word-compare-header\">word compare:</span>");
    stringBuilder.append("<div  class=\"word-compare-content compare-section\"></div>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"common-stop-button ra-stop-my-answer\">Stop</div>");

    stringBuilder.append("</div>");


    jsonObject.addProperty("pagination",paginationBuilder.toString());
    jsonObject.addProperty("recordableTime",readAloud.getRecordableLength());
    jsonObject.addProperty("details",stringBuilder.toString());
    out.print(gson.toJson(jsonObject));


%>
