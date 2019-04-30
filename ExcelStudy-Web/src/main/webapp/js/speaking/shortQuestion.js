/**
 * Created by praveen on 28/3/19.
 */



var shortQuestion = {};


var interval;
var timeOut;

/**/



$('.short-question').click(function (event) {
    clearInterval(interval);
    clearTimeout(timeOut);
    clearInterval(processBarIdNewSQ);
    clearInterval(interval1ForSQ);
    clearAll();
    /*ajax*/
    $.ajax({
        method: "POST",
        url: "../../ajax/speaking/getShortQuestionDetails.jsp",
        success: function (data) {
           
            var json = JSON.parse(data.trim());
            var audioFileLengthJson = parseInt(json.audioFileLength);
            var recordTime = parseInt(json.recordAbleTime);
            console.log(":::::::::"+recordTime+":::::::::::"+audioFileLengthJson)
            $('.main-panel').html(json.details);
            var recordStartIn = 5,display = document.querySelector('.recordCounter-sq'),recordAbleTime=recordTime,
                audioFileLength=audioFileLengthJson;
            //startTimerForShortQuestion(recordStartIn,display,recordAbleTime,audioFileLength);
            var displayNew = document.querySelector('.current-status-one');
            newRepoSQ(recordStartIn,displayNew,recordAbleTime,audioFileLength);

            
        }

    });

})





var interval1ForSQ;
function newRepoSQ(duration, display,recordAbleTime,audioFileLength) {
    var timer = duration, seconds;
    interval1ForSQ = setInterval(function () {
        seconds = parseInt(timer % 60, 10);
        seconds = seconds < 10 ? "0" + seconds : seconds;
        display.textContent = "Beginning  in "+seconds;
        if (--timer < 0) {
            timer = duration;
        }
        if(seconds==0){
            clearInterval(interval1ForSQ);
            display.textContent = "Playing";
            //play
            //audio file will play
            $("#short-question").trigger('play');
            console.log("Playing :::::::::::")
            processProgressBarSQ(audioFileLength,"shortQuestion-one",display);
            recordBeginForShortQuestion(audioFileLength,document.querySelector('.short-question-status'),recordAbleTime);
        }
    }, 1000);
}


var processBarIdSQ;
function  processProgressBarSQ(audioFileLength,className,querySelector) {
    clearInterval(processBarIdSQ);
    console.log("Coming for SQ ::::::::::::::::");
    var progressBarWidth = 0;
    var processWidth = 103/audioFileLength;
    processBarIdSQ = setInterval(moveProcessBar,1000);
    function moveProcessBar() {
        if (progressBarWidth >= 103) {
            querySelector.textContent = "Completed";
            clearInterval(processBarIdSQ);
        } else {
            progressBarWidth = progressBarWidth + processWidth;
            $('.'+className).css({"width":progressBarWidth+"%"})
        }
    }
}

function  stopProcessBarRE() {
    clearInterval(processBarIdSQ);
}


function startTimerForShortQuestion(duration, display,recordAbleTime,audioFileLength) {
    var timer = duration, seconds;
    interval = setInterval(function () {
        seconds = parseInt(timer % 60, 10);
        seconds = seconds < 10 ? "0" + seconds : seconds;
        display.textContent = "Record will begin in "+seconds;
        $('.recordCounter-sq').css("color","black");
        if (--timer < 0) {
            timer = duration;
        }
        if(seconds==0){
            clearInterval(interval);
            //play
            $("#short-question").trigger('play');
            /*added 1 sec extra*/
            audioFileLength = audioFileLength+1;
            timeOut = setTimeout(function(){
                console.log("Start recording :::::::::::::::")
                recordBeginForShortQuestion(recordAbleTime,document.querySelector('.short-question-status'));
            },(audioFileLength*1000));


        }
    }, 1000);
    
}


function recordBeginForShortQuestion(duration, display,recordAbleTime) {
    var timer = duration, seconds;
     interval = setInterval(function () {
        seconds = parseInt(timer % 60, 10);
        seconds = seconds < 10 ? "0" + seconds : seconds;
        display.textContent = "Recording will start in "+seconds;
        if (--timer < 0) {
            timer = duration;
        }
        console.log("Coming :::::::::::")
        if(seconds==0){
            clearInterval(interval);

            $('.short-question-status').text("In Progress");

            /*Record will start here*/
            $('.record-short-question').click();
            $(".loader").trigger('play');


            /*$('.shortQuestion').delay(1000).queue(function () {
                $(this).css("transition","width "+duration+"s ease-in-out");
                $(this).css('width', '103%')
            });*/

            processProgressBarNewSQ(recordAbleTime);
            /*Record will stop after given point of time*/
            timeOut = setTimeout(function () {
                $('.stop-short-question').click();
                $('.footer-div,.sq-compare-module,.sq-alertMessage').show();
                $('.short-question-status').text("Completed");
            },(recordAbleTime*1000));
        }
    }, 1000);
}


/*New changes */


var processBarIdNewSQ;
function  processProgressBarNewSQ(recordableTime) {
    var progressBarWidth = 0;
    var processWidth = 103/recordableTime;
    processBarIdNewSQ = setInterval(moveProcessBar,1000);
    function moveProcessBar() {
        if (progressBarWidth >= 103) {
            clearInterval(processBarIdNewSQ);
        } else {
            progressBarWidth = progressBarWidth + processWidth;
            $('.shortQuestion').css({"width":progressBarWidth+"%"})
        }
    }
}

function  stopProcessProgressBarNewSQ() {
    clearInterval(processBarIdNewSQ);
    clearTimeout(timeOut);
    $('.stop-short-question').click();
    $('.footer-div,.sq-compare-module').show();
}

$(document).on('click', ".sq-stop-my-answer", function () {
    stopProcessProgressBarNewSQ();
    $('.short-question-status').text("Completed");
});

/*End*/


var speechRecognizerRS = new webkitSpeechRecognition();


$(document).on("click", ".record-short-question", function () {
    console.log("Start ::::::::::")
    if('webkitSpeechRecognition' in window){
        console.log("SQ  :inside ::::::::::");
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
            $('.word-compare-content-sq').text(finalTranscripts + interimTranscripts);
        };
        speechRecognizerRS.onerror = function (event) {
        };


    }else{
        $('.word-compare-content-sq').text("Your browser is not supported. If google chrome, please upgrade!");
    }
});

$(document).on('click','.close-icon',function () {
    $('.sq-alertMessage').hide();
})


$(document).on('click', ".stop-short-question", function () {
    console.log("Clicked for stop");
    speechRecognizerRS.abort();
});




$(document).on('click','.close-analysis-sq',function () {
    $('.sq-compare-module').hide();
})



$(document).on('click','.sq-audio-compare',function () {
    $('.sq-compare-module').show();
})




/*Pagination*/


$(document).on('click','.common-pagination',function () {
    var pageNumber = $(this).attr('data-page-number');
    shortQuestion.getRenderDetails(pageNumber,"","");
    $('.common-pagination').removeClass('active');
    $(this).addClass('active');
})

shortQuestion.getRenderDetails = function (pageNumber,page,pageId) {
    clearInterval(interval);
    clearTimeout(timeOut);
    clearInterval(processBarIdNewSQ);
    clearInterval(interval1ForSQ);
    clearAll();
   $.ajax({
       method: "POST",
       data:{
           pageNumber:pageNumber,
           pageId:pageId,
           page:page
       },
       url: "../../ajax/renderSpeaking/renderShortQuestion.jsp",
       success: function (data) {
           var json = JSON.parse(data.trim());
           console.log("Data ::::::::::"+json)
           var audioFileLengthJson = parseInt(json.audioFileLength);
           var recordTime = parseInt(json.recordAbleTime);
           console.log(":::::::::"+recordTime+":::::::::::"+audioFileLengthJson)
           $('.render-div').html(json.details);
           if(json.pagination!=null && json.pagination != "" ){
               $('.pagination-div').html(json.pagination);
           }
           var recordStartIn = 5,display = document.querySelector('.recordCounter-sq'),recordAbleTime=recordTime,
               audioFileLength=audioFileLengthJson;
           //startTimerForShortQuestion(recordStartIn,display,recordAbleTime,audioFileLength);
           var displayNew = document.querySelector('.current-status-one');
           newRepoSQ(recordStartIn,displayNew,recordAbleTime,audioFileLength);
       }
   })
}

$(document).on('click','.sq-next',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.sq-next').attr('data-page');
    shortQuestion.getRenderDetails("",page,pageId);
})



$(document).on('click','.sq-previous',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.sq-previous').attr('data-page');
    shortQuestion.getRenderDetails("",page,pageId);
})


$(document).on('click','.sq-try-again',function () {
    var pageNumber = $('.common-pagination.active').attr('data-page-number');
    shortQuestion.getRenderDetails(pageNumber,"","");
})









