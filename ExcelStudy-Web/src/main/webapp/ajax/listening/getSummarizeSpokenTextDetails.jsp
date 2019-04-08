<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 25/2/19
  Time: 11:26 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    StringBuilder stringBuilder = new StringBuilder();
    Gson gson = new Gson();
    JsonObject jsonObject = new JsonObject();
    stringBuilder.append("<div class=\"header-data\">Summarize spoken text </div>");
    stringBuilder.append("<div class=\"difficulty-level\"></div>");
    stringBuilder.append("<div class=\"module-description\">");
    stringBuilder.append("You will hear a short lecture. Write a summary for a fellow student who was not present at the lecture. You should write 50-70 words. You have 10 minutes to finish this task. Your response will be judged on the Quality " +
            "of Your writing and on how well your response presents the key points presented in the lecture.");
    stringBuilder.append("</div>");
    stringBuilder.append("<audio controls class=\"audioFile\">");
    stringBuilder.append("<source class=\"audioFile\" src=\"../../resource/test.mp3\" type=\"audio/ogg\">");
    stringBuilder.append("</audio>");
    stringBuilder.append("<textarea class=\"writingArea\" rows=\"5\" cols=\"130\">");
    stringBuilder.append("</textarea>");
    jsonObject.addProperty("details",stringBuilder.toString());
    out.print(gson.toJson(jsonObject));
%>





