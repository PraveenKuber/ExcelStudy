/**
 * Created by praveen on 29/4/19.
 */

var highLightIncorrectWords = {};
var totalIncorrectValues;

$(document).on('click','.highlight-incorrect-words',function () {
    clearAll();
    listening.clearListeningIntervals();
    $.ajax({
        method: "POST",
        url: "../../ajax/listening/getHighlightIncorrectWordsDetails.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.main-panel').html(json.details);
            var display = document.querySelector('.current-status');
            var duration = 8;
            //var audioLength = 69;
            var audioLength = parseInt(json.audioFileLength);
            //totalIncorrectValues = 4;
            totalIncorrectValues = parseInt(json.totalIncorrectWords);
            startTimerForHIW(duration,display,audioLength);
            var display = document.querySelector(".hiw-listener-timer");
            highLightIncorrectWords.countTimerForProcess(10,display);

        }
    })
})


function startTimerForHIW(duration, display,audioLength) {
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
            $(".hiw").trigger('play');
            processProgressBarHIW(audioLength,"current-status");
        }
    }, 1000);
}

function  processProgressBarHIW(audioLength,className) {
    var progressBarWidth = 0;
    var processWidth = 103/audioLength;
    processBarIdForListening = setInterval(moveProcessBar,1000);
    function moveProcessBar() {
        if (progressBarWidth >= 103) {
            $('.'+className).text("Completed");
            clearInterval(processBarIdForListening);
        } else {
            progressBarWidth = progressBarWidth + processWidth;
            $('.highlightIncorrectWords').css({"width":progressBarWidth+"%"})
        }
    }
}

highLightIncorrectWords.countTimerForProcess = function (duration,display) {
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
                $('.hiw-alertMessage').show();
                //$('.score-section').show();
                //$('.answer-control-section').show();
            }
        }
    }, 1000);
}


var clickedValues = [];
var inCorrectedValues = [];

$(document).on('click','.normal',function () {
    var status = $(this).attr("data-color");
    var value = $(this).text();
    var inCorrectedValue  = $(this).filter(".inCorrected").text();
     if(status=="false"){
         $(this).removeAttr("data-color");
         $(this).attr("data-color","true");
         $(this).css({"background-color":"rgba(255, 255, 0, 0.5)"});
         clickedValues.push(value);
         if(inCorrectedValue!= undefined && inCorrectedValue!=null  && inCorrectedValue!=""){
             inCorrectedValues.push(inCorrectedValue);
         }
         
     }
    if(status=="true"){
         $(this).removeAttr("data-color");
         $(this).attr("data-color","false");
         $(this).css({"background-color":"white"});
         var index = clickedValues.indexOf(value);
        if(index>-1) clickedValues.pop(value);
        var incorrectIndex = inCorrectedValues.indexOf(inCorrectedValue);
        if(incorrectIndex>-1) inCorrectedValues.pop(inCorrectedValue);
     }
});


$(document).on('click','.hiw-check-answer',function () {
     $('.inCorrected').css({"border-bottom":"2px solid red"});
     var percentage = ( inCorrectedValues.length / totalIncorrectValues )*100;
     var width = 52;
     var cssWidth = (percentage / 100)*width;
     $('.score-section-progress.show-progress').css({"width":cssWidth+"%"});
     $('.score-total').html(inCorrectedValues.length+"/"+totalIncorrectValues);
     $('.score-percentage').html("["+Number(percentage).toFixed(2)+"%]");
     $('.score-section-hiw').show();
     $('.corrected').show();
})

$(document).on('click','.hiw-close-icon',function () {
    $('.hiw-alertMessage').hide();
})

$(document).on('click','.hiw-close-score-section',function () {
    $('.corrected').hide();
    $('.inCorrected').css({"border-bottom":"none"});
    $('.score-section-hiw').hide();
});

$(document).on('click','.hiw-stop-my-answer',function () {
    $('.current-status').html("Completed");
    $('.hiw').trigger('pause');
    listening.clearListeningIntervals();
    $('.answer-control-section').css({"visibility":"visible"});
    clearInterval(timingInterval);
});


/*Pagination*/


$(document).on('click','.hiw-common-pagination',function () {
    var pageNumber = $(this).attr('data-page-number');
    highLightIncorrectWords.getRenderDetails(pageNumber,"","");
    $('.hiw-common-pagination').removeClass('active');
    $(this).addClass('active');
});


highLightIncorrectWords.getRenderDetails = function (pageNumber,page,pageId) {
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
        url: "../../ajax/renderListening/renderHightlightIncorrectWords.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.hiw-render-div').html(json.details);
            if(json.pagination!=null && json.pagination != "" ){
                $('.hiw-pagination-div').html(json.pagination);
            }
            var display = document.querySelector('.current-status');
            var duration = 8;
            //var audioLength = 69;
            var audioLength = parseInt(json.audioFileLength);
            //totalIncorrectValues = 4;
            totalIncorrectValues = parseInt(json.totalIncorrectWords);
            startTimerForHIW(duration,display,audioLength);
            var display = document.querySelector(".hiw-listener-timer");
            highLightIncorrectWords.countTimerForProcess(10,display);
        }
    })
}

$(document).on('click','.hiw-next',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.hiw-next').attr('data-page');
    highLightIncorrectWords.getRenderDetails("",page,pageId);
})

$(document).on('click','.hiw-previous',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.hiw-previous').attr('data-page');
    highLightIncorrectWords.getRenderDetails("",page,pageId);
})


$(document).on('click','.hiw-try-again',function () {
    var pageNumber = $('#cp-style.active.hiw-common-pagination').attr('data-page-number');
    highLightIncorrectWords.getRenderDetails(pageNumber,"","");
})






