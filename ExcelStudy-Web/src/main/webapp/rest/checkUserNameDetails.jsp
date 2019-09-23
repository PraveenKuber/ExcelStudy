<%@ page import="com.EStudy.manager.UserDetailsManager" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 11/9/19
  Time: 2:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    UserDetailsManager manager = new UserDetailsManager();
    String userName = request.getParameter("userName");
    Boolean userNameExistsStatus = manager.checkUserNameExists(userName);
    out.print(userNameExistsStatus);

%>
