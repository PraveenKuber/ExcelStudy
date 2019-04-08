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

<div class="sq-pagination" data-sq-count="">
    <div class="sq-1 common-pagination">1</div>
    <div class="sq-2 common-pagination">2</div>
    <div class="sq-3 common-pagination">3</div>
    <div class="sq-4 common-pagination">4</div>
    <div class="sq-5 common-pagination">5</div>
    <div class="sq-next common-pagination" data-page-id="2">Next</div>
</div>

<%--
<audio controls autoplay>
    <source class="audioFile" src="../resource/test.mp3" type="audio/ogg">
</audio>--%>

<style>
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

