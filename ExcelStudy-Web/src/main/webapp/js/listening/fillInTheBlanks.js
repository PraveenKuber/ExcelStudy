/**
 * Created by praveen on 30/4/19.
 */

var fillInTheBlanks = {};

var totalCorrectedWords;

$(document).on('click','.fill-in-the-blanks',function () {
    clearAll();
    listening.clearListeningIntervals();
    $.ajax({
        method: "POST",
        url: "../../ajax/listening/getFillInTheBlanksDetails.jsp",
        success: function (data) {
            console.log("Data come::::::::::::::::::")
            var json = JSON.parse(data.trim());
            $('.main-panel').html(json.details);
            var display = document.querySelector('.current-status');
            var duration = 8;
            //var audioLength = 69;
            var audioLength = parseInt(json.audioFileLength);
            //totalIncorrectValues = 4;
            totalCorrectedWords = parseInt(json.totalCorrectWords);
            startTimerForFIB(duration,display,audioLength);
            var display = document.querySelector(".fib-listener-timer");
            fillInTheBlanks.countTimerForProcess(10,display);
        }
    })
})


function startTimerForFIB(duration, display,audioLength) {
    var timer = duration, seconds;
    listeningInterval = setInterval(function () {
        seconds = parseInt(timer % 60, 10);
        seconds = seconds < 10 ? "0" + seconds : seconds;
        display.textContent = "Beginning in "+seconds;
        if (--timer < 0) {
            timer = duration;
        }
        if(seconds==0){
            /*Recording started*/
            clearInterval(listeningInterval);
            $('.current-status').text("Playing");
            $(".loader").trigger('play');
            $(".fib").trigger('play');
            processProgressBarFIB(audioLength,"current-status");
        }
    }, 1000);
}

function  processProgressBarFIB(audioLength,className) {
    var progressBarWidth = 0;
    var processWidth = 103/audioLength;
    processBarIdForListening = setInterval(moveProcessBar,1000);
    function moveProcessBar() {
        if (progressBarWidth >= 103) {
            $('.'+className).text("Completed");
            clearInterval(processBarIdForListening);
        } else {
            progressBarWidth = progressBarWidth + processWidth;
            $('.fillInTheBlanks').css({"width":progressBarWidth+"%"})
        }
    }
}

fillInTheBlanks.countTimerForProcess = function (duration,display) {
    var next = new Date();
    next = next.setMinutes(next.getMinutes()+duration);
    timingInterval = setInterval(function () {
        var now = new Date();
        var distance = next - now;
        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((distance % (1000 * 60)) / 1000);
        var displaySec = seconds;
        if(seconds<10){
            displaySec = "0"+displaySec;
        }
        if(minutes >-1 && seconds > -1) display.textContent = minutes+":"+displaySec;
        if (distance < 0) {
            if(seconds == 0 || seconds < 0){
                clearInterval(timingInterval);
                $('.answer-control-section').css({"visibility":"visible"});
                $('.fib-alertMessage').show();
            }
        }
    }, 1000);
}



$(document).on('click','.fib-check-answer',function () {
    var correctedInput = 0;
    for(i=0;i<=totalCorrectedWords;i++){
        var inputTextVal = $('.fill-in-the-blanks-'+(i+1)).val();
        var correctAnswer = $('.corrected'+(i+1)).text();
        if(inputTextVal!=null && inputTextVal!=""){
            if(inputTextVal.toLowerCase()==correctAnswer.toLowerCase()){
                correctedInput ++;
                $('.fill-in-the-blanks-'+(i+1)).css({"background-color":"rgba(118, 239, 118, 0.45)"});
            }else{
                $('.fill-in-the-blanks-'+(i+1)).css({"background-color":"rgb(255, 195, 195)"});
            }
        }else{
            $('.fill-in-the-blanks-'+(i+1)).css({"background-color":"rgb(255, 195, 195)"});
        }
    }
    $('.fib-corrected').css({"display":"inline-flex"});
    var percentage = ( correctedInput / (totalCorrectedWords+1)  )*100;
    var width = 52;
    var cssWidth = (percentage / 100)*width;
    $('.score-section-progress.show-progress').css({"width":cssWidth+"%"});
    $('.score-total').html(correctedInput+"/"+(totalCorrectedWords+1));
    $('.score-percentage').html("["+Number(percentage).toFixed(2)+"%]");
    $('.score-section-fib').show();
})

$(document).on('click','.fib-close-icon',function () {
    $('.fib-alertMessage').hide();
})

$(document).on('click','.fib-close-score-section',function () {
    $('.common-fib').css({"background-color":"white"});
    $('.fib-corrected').css({"display":"none"});
    $('.score-section-fib').hide();
});

$(document).on('click','.fib-stop-my-answer',function () {
    $('.current-status').html("Completed");
    $('.fib').trigger('pause');
    listening.clearListeningIntervals();
    $('.answer-control-section').css({"visibility":"visible"});
    clearInterval(timingInterval);
});


/*Pagination*/


$(document).on('click','.fib-common-pagination',function () {
    var pageNumber = $(this).attr('data-page-number');
    fillInTheBlanks.getRenderDetails(pageNumber,"","");
    $('.fib-common-pagination').removeClass('active');
    $(this).addClass('active');
});


fillInTheBlanks.getRenderDetails = function (pageNumber,page,pageId) {
    clickedValues = [];
    inCorrectedValues = [];
    clearAll();
    listening.clearListeningIntervals();
    $.ajax({
        method: "POST",
        data:{
            pageNumber:pageNumber,
            pageId:pageId,
            page:page
        },
        url: "../../ajax/renderListening/renderFillInTheBlanks.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.fib-render-div').html(json.details);
            if(json.pagination!=null && json.pagination != "" ){
                $('.fib-pagination-div').html(json.pagination);
            }
            var display = document.querySelector('.current-status');
            var duration = 8;
            var audioLength = parseInt(json.audioFileLength);
            totalCorrectedWords = parseInt(json.totalCorrectWords);
            startTimerForFIB(duration,display,audioLength);
            var display = document.querySelector(".fib-listener-timer");
            fillInTheBlanks.countTimerForProcess(10,display);
        }
    })
}

$(document).on('click','.fib-next',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.fib-next').attr('data-page');
    fillInTheBlanks.getRenderDetails("",page,pageId);
})

$(document).on('click','.fib-previous',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.fib-previous').attr('data-page');
    fillInTheBlanks.getRenderDetails("",page,pageId);
})


$(document).on('click','.fib-try-again',function () {
    var pageNumber = $('#cp-style.active.fib-common-pagination').attr('data-page-number');
    fillInTheBlanks.getRenderDetails(pageNumber,"","");
})

