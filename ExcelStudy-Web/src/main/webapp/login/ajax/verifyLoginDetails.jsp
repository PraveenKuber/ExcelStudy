<%@ page import="com.EStudy.manager.UserDetailsManager" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 14/4/19
  Time: 9:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    UserDetailsManager userDetailsManager = new UserDetailsManager();
    String userName = request.getParameter("userName");
    String password = request.getParameter("password");
    Boolean existsStatus = userDetailsManager.checkUserDetails(userName,password);
    out.print(existsStatus);
%>
