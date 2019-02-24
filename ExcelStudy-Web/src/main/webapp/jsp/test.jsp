<%@ page import="com.EStudy.manager.MongoPersistenceManager" %>
<%@ page import="com.mongodb.BasicDBObject" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 24/2/19
  Time: 3:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    MongoPersistenceManager pm = MongoPersistenceManager.getInstance();
    System.out.println("Connected :::::::::::::::::::");
    BasicDBObject basicDBObject = new BasicDBObject("name","Estudy");
    pm.insertBasicDBObject("Test",basicDBObject);
%>
