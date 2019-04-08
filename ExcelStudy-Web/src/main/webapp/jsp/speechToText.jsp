<%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 25/2/19
  Time: 5:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script src="../js/test.js"></script>
<input id="speech" type="text" speech="speech" x-webkit-speech="x-webkit-speech"
       onspeechchange="test.testSpeechToText();" onwebkitspeechchange="test.testSpeechToText()" />

<textarea id="test"></textarea>



