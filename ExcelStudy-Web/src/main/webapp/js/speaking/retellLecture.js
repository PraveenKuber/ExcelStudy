/**
 * Created by praveen on 25/3/19.
 */

var relTellLecture = {};

var interVal;
var timeOut;

$('.retell_lecture').click(function (event) {
    clearTimeout(timeOut);
    clearInterval(interVal);
    clearInterval(processBarIdRL);
    clearInterval(intervalRL1);
    clearAll();
    /*ajax*/
    $.ajax({
        method: "POST",
        url: "../../ajax/speaking/getRetellLectureDetails.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.main-panel').html(json.details);
            var audioFileLengthJson = parseInt(json.audioFileLength);
            var recordTime = parseInt(json.recordAbleTime);
            console.log("::::::::::"+audioFileLengthJson+"::::::::::::::"+recordTime);
            $('.record-audio-retellLecture').attr('record-time',recordTime)
            var recordStartIn = 5, display = document.querySelector('.recordCounter-retellLecture'),
                recordAbleTime = recordTime, audioFileLength = audioFileLengthJson;
            //startTimerForRetellLecture(recordStartIn, display, recordAbleTime, audioFileLength);
            var displayNew =  document.querySelector('.current-status-one');
            newRepoRL(recordStartIn,displayNew,recordAbleTime,audioFileLength);
        }

    });

})



var intervalRL1;
function newRepoRL(duration, display,recordAbleTime,audioFileLength) {
    var timer = duration, seconds;
    intervalRL1 = setInterval(function () {
        seconds = /*parseInt(timer % 60, 10);*/  parseInt(timer);
        seconds = seconds < 10 ? "0" + seconds : seconds;
        display.textContent = "Beginning  in "+seconds;
        if (--timer < 0) {
            timer = duration;
        }
        if(seconds==0){
            clearInterval(intervalRL1);
            display.textContent = "Playing";
            //play
            //audio file will play
            $("#retellLecture").trigger('play');
            console.log("Playing :::::::::::")
            processProgressBarRL(audioFileLength,"retellLecture-one",display);
            recordBeginForRetellLecture(audioFileLength,document.querySelector('.retellLecture-status'),recordAbleTime);
        }
    }, 1000);
}


var processBarIdRL;
function  processProgressBarRL(audioFileLength,className,querySelector) {
    clearInterval(processBarIdRL);
    var progressBarWidth = 0;
    var processWidth = 103/audioFileLength;
    processBarIdRL = setInterval(moveProcessBar,1000);
    function moveProcessBar() {
        if (progressBarWidth >= 103) {
            clearInterval(processBarIdRL);
        } else {
            progressBarWidth = progressBarWidth + processWidth;
            $('.'+className).css({"width":progressBarWidth+"%"})
        }
    }
}

function  stopProcessBarRL() {
    clearInterval(processBarIdRL);
}




/*function startTimerForRetellLecture(duration, display,recordAbleTime,audioFileLength) {
    var timer = duration, seconds;
    interval = setInterval(function () {
        seconds = parseInt(timer % 60, 10);
        seconds = seconds < 10 ? "0" + seconds : seconds;
        console.log("Coming here RL ::::::::::::")
        display.textContent = "Record will begin in "+seconds;
        if (--timer < 0) {
            timer = duration;
        }
        if(seconds==0){
            display.textContent = "Record started";
            clearInterval(interval);
            //play
            $("#retellLecture").trigger('play');
            /!*added 1 sec extra*!/
            audioFileLength = audioFileLength+1;
            timeOut = setTimeout(function(){
                console.log("Start recording :::::::::::::::")
               recordBeginForRetellLecture(recordAbleTime,document.querySelector('.retellLecture-status'));
            },(audioFileLength*1000));

        }
    }, 1000);
}*/


function recordBeginForRetellLecture(duration, display,recordAbleTime) {
    var timer = duration+10, seconds;
    interval = setInterval(function () {
        seconds = /*parseInt(timer % 60, 10);*/ parseInt(timer);
        seconds = seconds < 10 ? "0" + seconds : seconds;
        display.textContent = "Recording will start in "+seconds;
        if (--timer < 0) {
            timer = duration;
        }
        console.log("Coming ::::::::::: RLS")
        if(seconds==0){
            clearInterval(interval);
            $('.retellLecture-status').text("In Progress");
           /* Record will start here*/
            $('.record-retellLecture').click();
            $(".loader").trigger('play');


           /* $('.retellLecture').delay(1000).queue(function () {
                $(this).css("transition","width "+duration+"s ease-in-out");
                $(this).css('width', '103%')
            });*/

            processProgressBarNewRL(recordAbleTime);
            /*Record will stop after given point of time*/
            
           timeOut = setTimeout(function () {
                $('.stop-retellLecture').click();
                $('.audio-compare-rl').click();
                $('.rl-alertMessage').show();
                $('.footer-div').show();
               $('.retellLecture-status').text("Completed");
            },(recordAbleTime*1000));

            /*Stopped*/
        }
    }, 1000);
}


/*New changes */


var processBarIdNewRL;
function  processProgressBarNewRL(recordableTime) {
    console.log("Coming for final RL ::::::::::::::::::");
    var progressBarWidth = 0;
    var processWidth = 103/recordableTime;
    processBarIdNewRL = setInterval(moveProcessBar,1000);
    function moveProcessBar() {
        if (progressBarWidth >= 103) {
            clearInterval(processBarIdNewRL);
        } else {
            progressBarWidth = progressBarWidth + processWidth;
            $('.retellLecture').css({"width":progressBarWidth+"%"})
        }
    }
}

function  stopProcessProgressBarNewRL() {
    clearInterval(processBarIdNewRL);
    clearTimeout(timeOut);
    clearInterval(interval);

    clearInterval(processBarIdRL);
    clearInterval(intervalRL1);
    
    $('#stop').click(); //stop audio record
    $('.stop-retellLecture').click(); // stop speech 
    $('.stop-audio-retellLecture').click();
    $('.footer-div').show();
}




$(document).on('click', ".rl-stop-my-answer", function () {
    stopProcessProgressBarNewRL();
    $('.retellLecture-status').html("Completed");
});

/*End*/



var speechRecognizerRS = new webkitSpeechRecognition();


$(document).on("click", ".record-retellLecture", function () {
    console.log("Start in RL ::::::::::")
    if('webkitSpeechRecognition' in window){
        console.log("RL inside :::::::::: and started to record ");
        $('.record-audio-retellLecture').click();
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
            $('.rl-speech-content').text(finalTranscripts + interimTranscripts);
        };
        speechRecognizerRS.onerror = function (event) {
        };


    }else{
        $('.rl-speech-content').text("Your browser is not supported. If google chrome, please upgrade!");
    }
});

$(document).on('click', ".stop-retellLecture", function () {
    console.log("Clicked for stop in RL");
    speechRecognizerRS.abort();
});


$(document).on('click','.close-icon',function () {
    console.log("Clicked :::::::::")
    $('.rl-alertMessage').hide();
})

$(document).on('click','.audio-compare-rl',function () {
    var status = $(this).attr("data-status");
    console.log("status :::::::::: called "+status)
    if(status=="show"){
        $('.show-rl-details').show();
        $(this).attr("data-status","hide");
    }else{
        $('.show-rl-details').hide();
        $(this).attr("data-status","show");
    }
    
})




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


/*Pagination*/


$(document).on('click','.rl-common-pagination',function () {
    console.log("Clicked here RL pg1 ::::::::::::::::::::")
    var pageNumber = $(this).attr('data-page-number');
    relTellLecture.getRenderDetails(pageNumber,"","");
    $('.rl-common-pagination').removeClass('active');
    $(this).addClass('active');
});


relTellLecture.getRenderDetails = function (pageNumber,page,pageId) {
    console.log("Clicked here RL pg2 ::::::::::::::::::::");
    clearTimeout(timeOut);
    clearInterval(interval);
    clearInterval(processBarIdRL);
    clearInterval(intervalRL1);
    clearAll();
    $.ajax({
        method: "POST",
        data:{
            pageNumber:pageNumber,
            pageId:pageId,
            page:page
        },
        url: "../../ajax/renderSpeaking/renderRetellLecture.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            console.log("Data ::::::::::"+json)
            var audioFileLengthJson = parseInt(json.audioFileLength);
            var recordTime = parseInt(json.recordAbleTime);
            console.log("::::::::::::::time is ::::::::::"+recordTime)
            $('.record-audio-retellLecture').removeAttr('record-time');
            $('.record-audio-retellLecture').attr('record-time',recordTime);

            $('.rl-render-div').html(json.details);
            if(json.pagination!=null && json.pagination != "" ){
                $('.pagination-div').html(json.pagination);
            }
            console.log("")
            var recordStartIn = 5,display = document.querySelector('.recordCounter-retellLecture'),recordAbleTime=recordTime,
                audioFileLength=audioFileLengthJson;
            //startTimerForRetellLecture(recordStartIn,display,recordAbleTime,audioFileLength);
            var displayNew =  document.querySelector('.current-status-one');
            newRepoRL(recordStartIn,displayNew,recordAbleTime,audioFileLength);
        }
    })
}

$(document).on('click','.rl-next',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.rl-next').attr('data-page');
    relTellLecture.getRenderDetails("",page,pageId);
})



$(document).on('click','.rl-previous',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.rl-previous').attr('data-page');
    relTellLecture.getRenderDetails("",page,pageId);
})


$(document).on('click','.rl-try-again',function () {
    var pageNumber = $('.rl-common-pagination').attr('data-page-number');
    relTellLecture.getRenderDetails(pageNumber,"","");
})






