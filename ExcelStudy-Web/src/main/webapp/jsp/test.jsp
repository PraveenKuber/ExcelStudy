<%@ page import="com.EStudy.manager.MongoPersistenceManager" %>
<%@ page import="com.mongodb.BasicDBObject" %><%--
  Created by IntelliJ IDEA.
  User: praveen
  Date: 24/2/19
  Time: 3:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>




<%--<div class="alert-message rp-alertMessage">
    <div class="close-icon" style="color:rgba(0, 0, 0, 0.5);">x</div>
    <div class="alert-header">! Alert</div>
    <div class="alert-content">Times Up!! The allocated time for finishing this task is finished!!</div>
</div>--%>

<%--<div class="show-rl-details">

    <div class="display-rl-script">
        <div class="rl-script-header">Audio script:</div>
        <div class="rl-script-content">
            By the 1950s air pollution was very visible with frequent thick black folks notice smokes in many large cities around the
            world. The main source of this pollution was from factories and it causes severe health problems. For example, the particularly severe smog in London in 1952 caused over four thousand deaths. Obviously, something had to be done, and in 1956 at Clean Air Act was introduced in Britain. This addressed the pollution from factories and the smokes soon disappeared. However, as you know these days air pollution is still a big issue. The main difference between now and 1950s is that you can see it’s invisible. Also, the main source of pollution now is from cars and lorries, and although these produce visible signs they said pollution is still a significant risk to health, and one of the key factors in the rise of this type of pollution is that we will become much more vehicle dependent. There are far more cars and lorries,
            trains, planes than in the 1950s, and this is now the main source of air pollution around the world.
        </div>

    </div>
    <div class="display-rl-speech">
        <div class="rl-speech-header">Your words:</div>
        <div class="rl-speech-content">

        </div>
        <div class="rl-message">Talk to recognize your speech!</div>
    </div>


</div>--%>

<%--<audio class="test" src="../resource/retellLecture/001.mp3" ></audio>--%>



<%--<audio class="testAudio" controls>
    <source class="audioFile" src="../resource/retellLecture/001.mp3" type="audio/ogg">
</audio>--%>

<%--<div class="control-section">
    <button class="control-play" data-control="play">Play</button>
    <button class="download-record">Download</button>
</div>--%>


<%--<div class="sq-compare-module">
    <span class="answer-analysis-sq">Answer analysis:</span>
    <span class="close-analysis-sq">x</span>
    <div class="audio-script-sq">
        <div class="audio-script-header-sq">Audio script:</div>
        <div  class="audio-script-content-sq"></div>
    </div>
    <div class="recorded-script-sq">
        <div class="recorded-script-header-sq">Correct answer:</div>
        <div  class="recorded-script-content-sq">Ice</div>
    </div>
    <div class="word-compare-sq">
        <div class="word-compare-header-sq">Your answer :</div>
        <div  class="word-compare-content-sq">test</div>
    </div>
</div>--%>

<%--<div class="sq-pagination" data-sq-count="">
    <div class="sq-1 common-pagination">1</div>
    <div class="sq-2 common-pagination">2</div>
    <div class="sq-3 common-pagination">3</div>
    <div class="sq-4 common-pagination">4</div>
    <div class="sq-5 common-pagination">5</div>
    <div class="sq-next common-pagination" data-page-id="2">Next</div>
</div>--%>

<%--
<audio controls autoplay>
    <source class="audioFile" src="../resource/test.mp3" type="audio/ogg">
</audio>--%>

<%
    StringBuilder stringBuilder = new StringBuilder();
    stringBuilder.append("<div class=\"status-div-one\">");
    stringBuilder.append("<div class=\"status-header-one\">Record Answer</div>");
    stringBuilder.append("<div class=\"current-status-header-one\">Current status:</div>");
    stringBuilder.append("<div class=\"current-status-one repeat-sentence-status-one\">completed</div>");
    stringBuilder.append("<div class=\"status-bar-one repeat-sentence-status-bar\"></div>");
    stringBuilder.append("<div class=\"progress-bar-one\">");
    stringBuilder.append("<span class=\"repeatSentence-one\"></span>");
    stringBuilder.append("</div>");
    stringBuilder.append("</div>");


    stringBuilder.append("<div class=\"repeated-question\">Previously repeated :");
    stringBuilder.append("<div class=\"repeated-question-number\">10</div>");
    stringBuilder.append("</div>");



%>

<%--<div class="status-div-one">
    <div class="status-header-one">Record Answer</div>
    <div class="current-status-header-one">Current status:</div>
    <div class="current-status-one repeat-sentence-status-one">completed</div>
    <div class="status-bar-one repeat-sentence-status-bar"></div>
    <div class="progress-bar-one">
        <span class="repeatSentence-one"></span>
    </div>
</div>--%>

<%--<div class="repeated-question">Previously repeated :
    <div class="repeated-question-number">10</div>
</div>--%>

<%--<%
    stringBuilder.append("<div class=\"basic-util\">");
    stringBuilder.append("<div class=\"common cut\">Cut</div>");
    stringBuilder.append("<div class=\"common copy\">Copy</div>");
    stringBuilder.append("<div class=\"common paste\">Paste</div>");
    stringBuilder.append("</div>");
%>--%>

<%
    stringBuilder.append("<div class=\"select-answer multiple-answer\">");
    stringBuilder.append("<div class=\"select-answer-header multiple-answer-question\">Which of the following is said by the speaker of the recording you just heard?</div>");
    stringBuilder.append("<div class=\"select-answer-choice multiple-answer-choice\">");
    stringBuilder.append("<input type=\"checkbox\"  value=\"true\">The speaker is showing animals in deep sea captured by Dr.Elvis Walter.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"select-answer-choice multiple-answer-choice\">");
    stringBuilder.append("<input type=\"checkbox\"  value=\"false\">The speaker is an underwater diver.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"select-answer-choice multiple-answer-choice\">");
    stringBuilder.append("<input type=\"checkbox\"  value=\"false\">The speaker is a geologist.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"select-answer-choice multiple-answer-choice\">");
    stringBuilder.append("<input type=\"checkbox\"  value=\"false\">He says that the deep water has bio-luminescence.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"select-answer-choice multiple-answer-choice\">");
    stringBuilder.append("<input type=\"checkbox\"  value=\"true\">Most creatures under water are familiar.");
    stringBuilder.append("</div>");

    stringBuilder.append("<div class=\"select-answer-choice multiple-answer-choice\">");
    stringBuilder.append("<input type=\"checkbox\"  value=\"true\">The base of the ocean is clear and we can see everything clearly.");
    stringBuilder.append("</div>");

    stringBuilder.append("</div>");

%>

<%--<div class="select-answer multiple-answer">
    <div class="select-answer-header multiple-answer-question">Which of the following is said by the speaker of the recording you just heard?</div>
    <div class="select-answer-choice multiple-answer-choice">
        <input type="checkbox"  value="true">The speaker is showing animals in deep sea captured by Dr.Elvis Walter.
    </div>
    <div class="select-answer-choice multiple-answer-choice">
        <input type="checkbox"  value="false">The speaker is an underwater diver.
    </div>
    <div class="select-answer-choice multiple-answer-choice">
        <input type="checkbox"  value="false">The speaker is a geologist.
    </div>
    <div class="select-answer-choice multiple-answer-choice">
        <input type="checkbox"  value="true">He says that the deep water has bio-luminescence.
    </div>
    <div class="select-answer-choice multiple-answer-choice">
        <input type="checkbox"  value="false"> Most creatures under water are familiar.
    </div>
    <div class="select-answer-choice multiple-answer-choice">
        <input type="checkbox"  value="true">The base of the ocean is clear and we can see everything clearly.
    </div>
</div>--%>

<div class="score-section">
    <div class="close-score-section">x</div>
      <div class="audio-script-section">
          <div class="audio-script-header">Audio script:</div>
          <div class="audio-script-content">
              We’re going to go on a dive to the deep sea, and anyone that’s had that lovely opportunity knows that for about two and half hours on the way down, it’s a perfectly positively pitch-black world. And we used to see the most strange animals out the window that you couldn’t describe: these alternating lights — a world of bio-luminescence, like fireflies. Dr. Elvis Walter — she’s now at the Indian Ocean Research Organization , she was able to come up with a camera that could capture some of these unbelievable animals, and that’s what you’re seeing here on the screen. That’s all bio-luminescence.
          </div>
      </div>
     <div class="score">
          <div class="score-header">Your score:</div>
          <div class="score-section-content">
              <div class="score-section-header">Multiple choice, choose multiple answers</div>
              <div class="score-section-progress"></div>
              <div class="score-total">2/3</div>
              <div class="score-percentage">[67%]</div>
          </div>
         <div class="score-section-progress show-progress"></div>
     </div>


</div>


<div class="answer-control-section">
    <div class="try-again cma-try-again">Try Again</div>
    <div class="check-answer cma-check-answer">Check Answer</div>
</div>

<div class="common-timer">
    <div class="listener-timer-header">Timer: </div>
    <div class="listener-timer cma-listener-timer">10</div>
</div>






<style>



    .answer-control-section {
        width: 60%;
        display: inline-flex;
    }

    .answer-control-section {
        width: 60%;
        display: inline-flex;
    }



    .close-score-section {
        width: 2%;
        position: absolute;
        margin-left: 86%;
    }

    .audio-script-section {
        width: 90%;
        border: 1px solid black;
    }

    .score {
        border: 1px solid;
        width: 90%;
        border-top: none;
    }

    .score-section-content {
        display: inline-flex;
        width: 100%;
        padding-bottom: 2%;
    }

    .score-section-header {
        width: 20%;
    }

    .score-section-progress {
        width: 60%;
        height: 25px;
        background-color: rgba(211, 211, 211, 0.25);
    }

    .score-section-progress.show-progress {
        width: 10%;
        margin-left: 241px;
        position: absolute;
        background-color: rgba(91, 245, 209, 0.52);
        margin-top: -61px;
    }

    .score-total,.score-percentage {
        width: 10%;
        text-align: center;
        margin-top: 4px;
    }

    .audio-script-header {
        width: 20%;
        margin-top: 1%;
        margin-bottom: 1%;
    }

    .score-header {
        width: 20%;
        margin-bottom: 1%;
        padding-top: 1%;
    }

    .audio-script-content {
        margin-bottom: 2%;
    }






    .select-answer {
        width: 80%;
        margin-left: 5%;
    }

    .select-answer-choice {
        margin-top: 11px;
        margin-bottom: 1px;
    }



    .common {
        width: 15%;
        border: 1px solid black;
        text-align: center;
        margin-right: 11%;
        padding: 6px;
        border-radius: 6px;
        background-color: lightgray;
        cursor: pointer;
    }

    .basic-util {
        display: inline-flex;
        width: 60%;
    }



    .repeated-question {
        width: 14%;
        display: inline-flex;
        color: whitesmoke;
        background-color: brown;
        padding: 3px;
    }

    .repeated-question-number {
        margin-left: 6%;
        font-size: 17px;
        border-left: 10px solid #3fc73f;
    }


    .status-div-one{
        border: 2px solid rgba(80, 64, 140, 0.51);
        width: 22%;
        padding: 8px;
        padding-bottom: 2%;
        background-color: rgba(220, 239, 245, 0.41);
        font-size: 13px;
        font-family: sans-serif;
        margin-left: 40%;
        margin-top: 2%;
        margin-bottom: 2%;
    }

    .status-header-one {
        text-align: center;
        font-weight: 600;
    }

    .current-status-header-one {
        margin-top: 10px;
        font-weight: 500;
    }

    .current-status-one, .status-bar-one {
        margin-top: 10px;
    }

    .progress-bar-one{
        margin-top: -7px;
        width: calc(100% - 6px);
        height: 20px;
        background: rgba(122, 158, 159, 0.31) !important;
        padding: 3px;
        border-radius: 3px;
        box-shadow: inset 0 1px 3px rgba(0, 0, 0, .2);
    }





    .alert-message {
        padding-top: 1%;
        padding-bottom: 1%;
        padding-right: 1%;
        padding-left: 1%;
        width: 20%;
        border: 1px solid;
        background-color: rgba(255, 0, 0, 0.8);
        color: white;
    }
    .close-icon {
        cursor: pointer;
        position: absolute;
        margin-left: 256px;
        margin-top: -1%;
    }

    .alert-content {
        font-size: 13px;
        margin-top: 15px;
        margin-bottom: 15px;
    }
    .alert-header {
        font-weight: 600;
    }



    .rl-script-content,.rl-speech-content {
        font-size: 15px;
    }

    .rl-script-header,.rl-speech-header{
        font-size: 16px;
    }

    .rl-speech-content {
        margin-bottom: 20px;
    }

    .rl-message {
        width: 60%;
        padding: 15px;
        border-top: 1px solid;
    }



    /*SQ*/

    .sq-compare-module {
        border-left: 5px solid #ff2f2f;
        padding-left: 1%;
        background-color: rgba(0, 16, 100, 0.61);
        color: white;
        padding-top: 1%;
        padding-bottom: 1%;
    }

    .audio-script-sq,.audio-script-header-sq,.audio-script-content-sq,
    .recorded-script-content-sq,.recorded-script-header-sq,
    .word-compare-header-sq,.word-compare-content-sq{
        margin-top: 1%;
    }


    .sq-pagination {
        width: 50%;
        display: inline-flex;
        margin-left: 1%;
    }

    .common-pagination {
        padding-left: 4px;
        padding-right: 4px;
        border: 1px solid black;
        margin-left: 2%;
        cursor: pointer;
        background-color: lightgray;
        border-radius: 2px;
        font-size: 12px;
    }


</style>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
<script type="text/javascript">


    $(document).on('click','.control-play',function () {
        var status = $('.control-play').attr('data-control');
        if(status=='play'){
            $('.control-play').attr('data-control','pause');
            $('.control-play').html('Pause');
            $('.testAudio').trigger('play');
        }else{
            $('.control-play').attr('data-control','play');
            $('.control-play').html('Play');
            $('.testAudio').trigger('pause');
        }
    });
    
</script>

