/**
 * Created by praveen on 19/3/19.
 */


var repeatSentence = {};
var speechRecognizerRS = new webkitSpeechRecognition();

var interval;
var timeOut;

$('.repeat_sentence').click(function (event) {
    clearInterval(interval);
    clearTimeout(timeOut);
    clearInterval(interval1);
    clearInterval(processBarIdRS);
    clearAll();
    /*ajax*/
    $.ajax({
        method: "POST",
        url: "../../ajax/speaking/repeatSentenceDetails.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            console.log("Speaking success ::::::::::"+json.details)
            var audioFilePath = json.audioFilePath;
            console.log("Audio file path::::::::: "+audioFilePath)
            $('.main-panel').html(json.details);
            var audioFileLengthJson = parseInt(json.audioFileLength);
            var recordTime = parseInt(json.recordableTime);
            
            var recordStartIn = 5,display = document.querySelector('.recordCounter'),recordAbleTime=recordTime,
                audioFileLength=audioFileLengthJson;
            //startTimerForRepeatSentence(recordStartIn,display,recordAbleTime,audioFileLength);
            var displayNew = document.querySelector('.current-status-one');
            newRepoRE(recordStartIn,displayNew,recordAbleTime,audioFileLength);
        }

    });

});


/*New changes */


var interval1;
function newRepoRE(duration, display,recordAbleTime,audioFileLength) {
    var timer = duration, seconds;
    interval1 = setInterval(function () {
        seconds = /*parseInt(timer % 60, 10);*/  parseInt(timer);
        seconds = seconds < 10 ? "0" + seconds : seconds;
        display.textContent = "Beginning  in "+seconds;
        if (--timer < 0) {
            timer = duration;
        }
        if(seconds==0){
            clearInterval(interval1);
            display.textContent = "Playing";
            //play
            //audio file will play
            $("#repeat-sentence").trigger('play');
            console.log("Playing :::::::::::")
            processProgressBarRE(audioFileLength,"repeatSentence-one",display);
            recordBeginForRepeatSenetnce(audioFileLength,document.querySelector('.repeat-sentence-status'),recordAbleTime);
        }
    }, 1000);
}


var processBarIdRS;
function  processProgressBarRE(audioFileLength,className,querySelector) {
    clearInterval(processBarIdRS);
    console.log("Playing inside :::::::::::recordableTime:::::::"+audioFileLength)
    console.log("Coming for RE ::::::::::::::::");
    var progressBarWidth = 0;
    var processWidth = 103/audioFileLength;
    processBarIdRS = setInterval(moveProcessBar,1000);
    function moveProcessBar() {
        if (progressBarWidth >= 103) {
            querySelector.textContent = "Completed";
            clearInterval(processBarIdRS);
        } else {
            progressBarWidth = progressBarWidth + processWidth;
            $('.'+className).css({"width":progressBarWidth+"%"})
        }
    }
}

function  stopProcessBarRE() {
    clearInterval(processBarIdRS);
}


/*End*/


function recordBeginForRepeatSenetnce(duration, display,recordAbleTime) {
    console.log("Recordable time :::::"+duration)
    var timer = duration, seconds;
    interval = setInterval(function () {
        seconds = /*parseInt(timer % 60, 10);*/ parseInt(timer);
        seconds = seconds < 10 ? "0" + seconds : seconds;
        display.textContent = "Recording will start in "+seconds;
        if (--timer < 0) {
            timer = duration;
        }
        if(seconds==0){
            clearInterval(interval);
            $('.repeat-sentence-status').text("In progress");
            /*Record will start here*/
            $('.record-repeat-sentence').click();

            $(".loader").trigger('play');
            processProgressBarNewRS(recordAbleTime);
            /*Record will stop after given point of time*/
           timeOut =  setTimeout(function () {
                $('.stop-repeat-sentence').click();
                $('.rp-alertMessage').show();
                $('.repeatSentence-footer-div').show();
                
            },(recordAbleTime*1000));

        }
    }, 1000);
}



/*New changes */


var processBarIdNew;
function  processProgressBarNewRS(recordableTime) {
    console.log("Coming for final ::::::::::::::::::");
    var progressBarWidth = 0;
    var processWidth = 103/recordableTime;
    processBarIdNew = setInterval(moveProcessBar,1000);
    function moveProcessBar() {
        $('.repeat-sentence-status').text("Completed");
        if (progressBarWidth >= 103) {
            clearInterval(processBarIdNew);
        } else {
            $('.repeat-sentence-status').text("In progress");
            progressBarWidth = progressBarWidth + processWidth;
            $('.repeatSentence').css({"width":progressBarWidth+"%"})
        }
    }
}

function  stopProcessProgressBarNewRS() {
    clearInterval(processBarIdNew);
    clearTimeout(timeOut);
    $('.stop-repeat-sentence').click();
    $('.repeatSentence-footer-div').show();
}

$(document).on('click', ".re-stop-my-answer", function () {
    stopProcessProgressBarNewRS();
    $('.repeat-sentence-status').html("Completed");
});

/*End*/




$(document).on("click", ".record-repeat-sentence", function () {
    console.log("Start ::::::::::")
    if('webkitSpeechRecognition' in window){
        console.log("Repeat sentence  :inside ::::::::::");
        //$('#recordForX').click();
        speechRecognizerRS.continuous = true;
        speechRecognizerRS.interimResults = true;
        speechRecognizerRS.lang = 'en-IN';
        speechRecognizerRS.start();
        var finalTranscripts = '';
        speechRecognizerRS.onresult = function(event){
            var interimTranscripts = '';
            for(var i = event.resultIndex; i < event.results.length; i++){
                var transcript = event.results[i][0].transcript;
                transcript.replace("\n", "<br>");
                if(event.results[i].isFinal){
                    finalTranscripts += transcript;
                }else{
                    interimTranscripts += transcript;
                }
            }
            /*r.innerHTML = finalTranscripts + '<span style="color:#999">' + interimTranscripts + '</span>';*/
            $('.audio-script-content').text(finalTranscripts + interimTranscripts);
        };
        speechRecognizerRS.onerror = function (event) {
        };


    }else{
        $('.audio-script-content').text("Your browser is not supported. If google chrome, please upgrade!");
    }
});

$(document).on('click','.close-icon',function () {
    $('.rp-alertMessage').hide();
})


$(document).on('click', ".stop-repeat-sentence", function () {
    console.log("Clicked for stop");
    speechRecognizerRS.abort();
    clearInterval(interval);
    clearTimeout(timeOut);
    clearInterval(interval1);
    clearInterval(processBarIdRS);
    clearAll();
});




$(document).on('click','.close-answer-analysis',function () {
    $('.repeatSentence-compare-module').hide();
})


$(document).on('click','.audio-compare', function(){
    $('.word-compare-content').html("");
    var inputText = $('.recorded-script-content').text();
    console.log("Input text ::::::::::"+inputText);
    var inputList = getFormattedListForMatching(inputText);
    //var speechText = "Domestication was an evolutionary, rater than a political developmnt";
    var speechText = $('.audio-script-content').text();
    var speechTextList = getFormattedListForMatching(speechText);
    console.log("Data is ::::::::::::::"+inputList.length+":::::::::: Speech text length ::::::::"+speechTextList.length);
    var finalText;
    var mainDiv = document.createElement("div");
    mainDiv.setAttribute("class","test");
    var testMain = " ";
    for(var i=0;i<inputList.length;i++){
        if(speechTextList[i]!= undefined){
            var innerHtmlBuilder;
            if(inputList[i] != speechTextList[i]){
                innerHtmlBuilder = document.createElement("span");
                innerHtmlBuilder.setAttribute("class","color");
                mainDiv.appendChild(innerHtmlBuilder);
                testMain = testMain + "<span class='not-matched'>"+speechTextList[i]+"</span>"+" ";
                console.log("Not matched ::::::::::"+inputList[i]+"::::::::;"+speechTextList[i]);
            }else{
                testMain = testMain + "<span class='matched'>"+inputList[i]+"</span>"+" ";
                innerHtmlBuilder = document.createElement("span");
                innerHtmlBuilder.setAttribute("class","color-not");
                mainDiv.appendChild(innerHtmlBuilder);
                console.log("Matched ::::::::"+inputList[i]+":::::::"+speechTextList[i])
            }
        }
    }
    $('.word-compare-content').append(testMain)
    console.log("Main div is :::::::"+testMain)

    /*show matching content*/
    $('.repeatSentence-compare-module').show();
});


/*Pagination*/


$(document).on('click','.rp-common-pagination',function () {
    console.log("Clicked here RP pg1 ::::::::::::::::::::")
    var pageNumber = $(this).attr('data-page-number');
    repeatSentence.getRenderDetails(pageNumber,"","");
    $('.rp-common-pagination').removeClass('active');
    $(this).addClass('active');
});


repeatSentence.getRenderDetails = function (pageNumber,page,pageId) {
    console.log("Clicked here RP pg2 ::::::::::::::::::::");
    clearTimeout(timeOut);
    clearInterval(interval);
    clearInterval(processBarIdRS);
    clearAll();
    $.ajax({
        method: "POST",
        data:{
            pageNumber:pageNumber,
            pageId:pageId,
            page:page
        },
        url: "../../ajax/renderSpeaking/renderRepeatSentence.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.rp-render-div').html(json.details);
            if(json.pagination!=null && json.pagination != "" ){
                $('.rp-pagination-div').html(json.pagination);
            }
            var audioFileLengthJson = parseInt(json.audioFileLength);
            var recordTime = parseInt(json.recordableTime);
            var recordStartIn = 5,display = document.querySelector('.recordCounter'),recordAbleTime=recordTime,
                audioFileLength=audioFileLengthJson;
            //startTimerForRepeatSentence(recordStartIn,display,recordAbleTime,audioFileLength);

            var displayNew = document.querySelector('.current-status-one');
            newRepoRE(recordStartIn,displayNew,recordAbleTime,audioFileLength);
            //startTimerForRepeatSentence(recordStartIn,display,recordAbleTime,audioFileLength);

        }
    })
}

$(document).on('click','.rp-next',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.rp-next').attr('data-page');
    repeatSentence.getRenderDetails("",page,pageId);
})



$(document).on('click','.rp-previous',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.rp-previous').attr('data-page');
    repeatSentence.getRenderDetails("",page,pageId);
})


$(document).on('click','.rp-try-again',function () {
    var pageNumber = $('#cp-style.active.rp-common-pagination').attr('data-page-number');
    repeatSentence.getRenderDetails(pageNumber,"","");
})



/*function startTimerForRepeatSentence(duration, display,recordAbleTime,audioFileLength) {
 var timer = duration, seconds;
 interval = setInterval(function () {
 seconds = parseInt(timer % 60, 10);
 seconds = seconds < 10 ? "0" + seconds : seconds;
 display.textContent = "Record will begin in "+seconds;
 if (--timer < 0) {
 timer = duration;
 }
 if(seconds==0){
 clearInterval(interval);
 //play
 $("#repeat-sentence").trigger('play');

 /!*added 1 sec extra*!/
 audioFileLength = audioFileLength+1;
 timeOut =  setTimeout(function(){
 recordBeginForRepeatSenetnce(audioFileLength,document.querySelector('.repeat-sentence-status'));
 },(audioFileLength*1000));
 /!*changed here take care*!/

 }
 }, 1000);
 }*/





