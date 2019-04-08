<%--
  Created by IntelliJ IDEA.
  User: cmsan
  Date: 2/24/2019
  Time: 10:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<div class="status-div">
    <div class="status-header">Record Answer</div>
    <div class="current-status-header">Current status:</div>
    <div class="current-status">status</div>
    <div clas="status-bar"></div>
    <div class="progress-bar">
        <span class="progress-bar-fill" style="width: 30%"></span>
    </div>

</div>

<span class="control-div">
    <div class="control-label reset">Try again</div>
    <div class="control-label download">Download</div>
    <div class="control-label play">Play</div>
    <div class="control-label stop">Stop</div>
</span>


<div class="ra-compare-module">
    <span class="answer-analysis">Answer analysis:</span>
    <div class="audio-script">
        <span class="audio-script-header">your answer:</span>
        <div  class="audio-script- ra-speechToTextArea"></div>
    </div>
    <div class="word-compare">
        <span class="word-compare-header">word compare:</span>
        <div  class="word-compare-content compare-section">test</div>
    </div>
</div>


<div class="footer-div">
        <span class="try-again">Try again</span>
        <span class="audio-compare">Audio compare</span>
</div>






</body>
</html>

<style>
    .repeatSenetnce-compare-module {
        width: 60%;
        border-left: 5px solid red;
        background-color: #077916;
        padding: 10px;
    }

    .answer-analysis {
        color: white;
        font-size: 18px;
        font-weight: 500;
    }
    .audio-script-header,.recorded-script-header,.word-compare-header{
        color: white;
        font-size:15px;
    }

    .audio-script-content,.recorded-script-content,.word-compare-content{
        margin-top: 5px;
        font-size:15px;
        background-color: white;
        padding:8px;
    }

    .audio-script {
        margin-top: 10px;
        margin-bottom: 10px;
    }

    .word-compare {
        margin-bottom: 3%;
    }






</style>