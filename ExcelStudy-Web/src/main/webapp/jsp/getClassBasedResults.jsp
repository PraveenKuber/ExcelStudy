<%@ page import="utils.Student" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mongodb.SchoolManager" %>
<%@ page import="com.google.gson.JsonObject" %><%--
  Created by IntelliJ IDEA.
  User: avanseus
  Date: 11/7/18
  Time: 4:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    SchoolManager schoolManager = new SchoolManager();
    StringBuilder stringBuilder = new StringBuilder();
    JsonObject jsonObject = new JsonObject();
    List<Student> students = new ArrayList<>();
    String standard = request.getParameter("standard");
    int skip = Integer.parseInt(request.getParameter("skip"));
    int limit = Integer.parseInt(request.getParameter("limit"));
    int pageId = Integer.parseInt(request.getParameter("pageId"));
    students = schoolManager.getStudentBasedOnClass(standard);


    int numberOfStudents = students.size();
    int noOfPages = (int)Math.ceil(numberOfStudents/(double)limit);
    if(pageId==-1){
        stringBuilder = new StringBuilder();
        for(int i=1;i<=noOfPages;i++)
            stringBuilder.append("<div class=\"pagination-element\" data-page-id="+i+">"+i+"</div>\n");
        jsonObject.addProperty("paginationValue",stringBuilder.toString());
        students = schoolManager.getStudentBasedOnClassLimited(standard,skip,limit);
        stringBuilder = new StringBuilder();
        for(Student student: students){
            stringBuilder.append("<tr>");
            stringBuilder.append("<td>"+student.getName()+"</td>");
            stringBuilder.append("<td>"+student.getStd()+"</td>");
            stringBuilder.append("<td>"+student.getAge()+"</td>");
            stringBuilder.append("<td>"+student.getGender()+"</td>");
            stringBuilder.append("<td>"+student.getMedium()+"</td>");
            stringBuilder.append("<td>"+student.getEmailId()+"</td>");
            stringBuilder.append("<td>"+student.getClassTeacher()+"</td>");
            stringBuilder.append("<td data-object-id="+student.getStudentId()+" class=\"deleteStudent\">\n<img class=\"deleteImage\" src=\"../images/delete.png\"></td>");
            stringBuilder.append("</tr>");
        }
        jsonObject.addProperty("tableValue",stringBuilder.toString());
        out.print(jsonObject);
    }
    else {
        stringBuilder = new StringBuilder();
        students = schoolManager.getStudentBasedOnClassLimited(standard,skip,limit);
        for( Student student: students) {
            stringBuilder.append("<tr>");
            stringBuilder.append("<td>"+student.getName()+"</td>");
            stringBuilder.append("<td>"+student.getStd()+"</td>");
            stringBuilder.append("<td>"+student.getAge()+"</td>");
            stringBuilder.append("<td>"+student.getGender()+"</td>");
            stringBuilder.append("<td>"+student.getMedium()+"</td>");
            stringBuilder.append("<td>"+student.getEmailId()+"</td>");
            stringBuilder.append("<td>"+student.getClassTeacher()+"</td>");
            stringBuilder.append("<td data-object-id="+student.getStudentId()+" class=\"deleteStudent\">\n<img class=\"deleteImage\" src=\"../images/delete.png\"></td>");
            stringBuilder.append("</tr>");
        }
        jsonObject.addProperty("tableValue",stringBuilder.toString());
        stringBuilder = new StringBuilder();
        if(noOfPages<=3){
            for (int i=1;i<=noOfPages;i++) {
                if (i == pageId)
                    stringBuilder.append("<div class=\"pagination-element active\" data-page-id=" + i + ">" + i + "</div>");
                else
                    stringBuilder.append("<div class=\"pagination-element\" data-page-id=" + i + ">" + i + "</div>");
            }
            jsonObject.addProperty("paginationValue",stringBuilder.toString());
        }
        else{

            if(pageId==1){
                stringBuilder = new StringBuilder();
                stringBuilder.append("<div class=\"pagination-element active\" data-page-id=1>1</div>");
                stringBuilder.append("<div class=\"pagination-element\" data-page-id=2>2</div>");
                stringBuilder.append("<div class=\"pagination-element\" data-page-id=3>3</div>");
                stringBuilder.append("<div class=\"pagination-element\" data-page-id=next>Next</div>");
                jsonObject.addProperty("paginationValue",stringBuilder.toString());
            }
            else if(pageId == ((int)Math.ceil(numberOfStudents/(double)limit))-2){
                stringBuilder = new StringBuilder();
                if(pageId!=2)
                    stringBuilder.append("<div class=\"pagination-element\" data-page-id=1>First</div>");
                stringBuilder.append("<div class=\"pagination-element\" data-page-id=previous>Prev</div>");
                stringBuilder.append("<div class=\"pagination-element active\" data-page-id="+(pageId)+">"+(pageId)+"</div>");
                stringBuilder.append("<div class=\"pagination-element\" data-page-id="+(pageId+1)+">"+(pageId+1)+"</div>");
                stringBuilder.append("<div class=\"pagination-element\" data-page-id="+(pageId+2)+">"+(pageId+2)+"</div>");
                jsonObject.addProperty("paginationValue",stringBuilder.toString());
            }
            else if(pageId == ((int)Math.ceil(numberOfStudents/(double)limit))-1){
                stringBuilder = new StringBuilder();
                if(pageId!=2)
                    stringBuilder.append("<div class=\"pagination-element\" data-page-id=1>First</div>");
                stringBuilder.append("<div class=\"pagination-element\" data-page-id=previous>Prev</div>");
                stringBuilder.append("<div class=\"pagination-element\" data-page-id="+(pageId-1)+">"+(pageId-1)+"</div>");
                stringBuilder.append("<div class=\"pagination-element active\" data-page-id="+(pageId)+">"+(pageId)+"</div>");
                stringBuilder.append("<div class=\"pagination-element\" data-page-id="+(pageId+1)+">"+(pageId+1)+"</div>");
                jsonObject.addProperty("paginationValue",stringBuilder.toString());
            }
            else if(pageId == (int) Math.ceil(numberOfStudents/(double)limit)){
                stringBuilder = new StringBuilder();
                if(pageId!=2)
                    stringBuilder.append("<div class=\"pagination-element\" data-page-id=1>First</div>");
                stringBuilder.append("<div class=\"pagination-element\" data-page-id=previous>Prev</div>");
                stringBuilder.append("<div class=\"pagination-element\" data-page-id="+(pageId-2)+">"+(pageId-2)+"</div>");
                stringBuilder.append("<div class=\"pagination-element\" data-page-id="+(pageId-1)+">"+(pageId-1)+"</div>");
                stringBuilder.append("<div class=\"pagination-element active\" data-page-id="+(pageId)+">"+(pageId)+"</div>");
                jsonObject.addProperty("paginationValue",stringBuilder.toString());
            }
            else {
                stringBuilder = new StringBuilder();
                if(pageId!=2)
                    stringBuilder.append("<div class=\"pagination-element\" data-page-id=1>First</div>");
                stringBuilder.append("<div class=\"pagination-element\" data-page-id=previous>Prev</div>");
                stringBuilder.append("<div class=\"pagination-element active\" data-page-id="+(pageId)+">"+(pageId)+"</div>");
                stringBuilder.append("<div class=\"pagination-element\" data-page-id="+(pageId+1)+">"+(pageId+1)+"</div>");
                stringBuilder.append("<div class=\"pagination-element\" data-page-id="+(pageId+2)+">"+(pageId+2)+"</div>");
                stringBuilder.append("<div class=\"pagination-element\" data-page-id=next>Next</div>");
                if(pageId < ((int)Math.ceil(numberOfStudents/(double)limit))-3)
                    stringBuilder.append("<div class=\"pagination-element\" data-page-id="+((int)Math.ceil(schoolManager.getNumberOfStudents()/(double)limit))+">Last</div>");
                jsonObject.addProperty("paginationValue",stringBuilder.toString());
            }

        }
        out.print(jsonObject);


    }

%>