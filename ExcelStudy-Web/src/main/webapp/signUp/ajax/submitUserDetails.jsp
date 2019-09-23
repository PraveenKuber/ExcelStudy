<%@ page import="com.EStudy.model.UserDetails" %>
<%@ page import="com.EStudy.manager.UserDetailsManager" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 5/9/19
  Time: 9:36 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    UserDetailsManager userDetailsManager = new UserDetailsManager();
    String userName = request.getParameter("userName");
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");

    Boolean status = false;
    if(!userDetailsManager.checkUserNameExists(userName)){
        UserDetails userDetail = new UserDetails();
        userDetail.setUserName(userName);
        userDetail.setPassword(password);
        userDetail.setEmailId(email);
        userDetail.setPhoneNumber(phone);
        userDetail.setGender("");
        userDetailsManager.insertUserDetails(userDetail);
        status = true;
    }

    out.print(status);

%>