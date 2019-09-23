/**
 * Created by praveen on 21/4/19.
 */

var chooseMultipleAnswers = {};


$(document).on('click','.choose-multiple-answers',function () {
    clearAll();
    listening.clearListeningIntervals();
    $.ajax({
        method: "POST",
        url: "../../ajax/listening/getChooseMultipleAnswersDetails.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.main-panel').html(json.details);
            var display = document.querySelector('.current-status');
            var duration = 8;
            //var audioLength = 69;
            var audioLength = parseInt(json.audioFileLength);
            startTimerForCMA(duration,display,audioLength);
            var display = document.querySelector(".cma-listener-timer");
            chooseMultipleAnswers.countTimerForProcess(10,display);

        }
    })
})


function startTimerForCMA(duration, display,audioLength) {
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
            $(".cma").trigger('play');
            processProgressBarCMA(audioLength,"current-status");

        }
    }, 1000);
}

function  processProgressBarCMA(audioLength,className) {
    var progressBarWidth = 0;
    var processWidth = 103/audioLength;
    processBarIdForListening = setInterval(moveProcessBar,1000);
    function moveProcessBar() {
        if (progressBarWidth >= 103) {
            $('.'+className).text("Completed");
            clearInterval(processBarIdForListening);
        } else {
            progressBarWidth = progressBarWidth + processWidth;
            $('.chooseMultipleAnswers').css({"width":progressBarWidth+"%"})
        }
    }
}


$(document).on('click','.checkBox',function () {
    var clickStatus = $(this).is(":checked");
    if(clickStatus==true||clickStatus=="true"){
        $(this).closest(".choice-label").addClass("color");
    }else{
        $(this).closest(".choice-label").removeClass("color");
    }
})

$(document).on('click','.cma-check-answer',function () {
    $('.score-section').show();
    $('.cma-answer').css({"border":"2px solid green"});
})

$(document).on('click','.cma-close-score-section',function () {
    $('.cma-answer').css({"border":"none"});
    $('.score-section').hide();
})


$(document).on('click','.cma-close-icon',function () {
    $('.cma-alertMessage').hide();
})



$(document).on('click','.cma-stop-my-answer',function () {
    $('.score-section').show();
    $('.current-status').html("Completed");
    $('.cma').trigger('pause');
    listening.clearListeningIntervals();
    $('.cma-answer').css({"border":"2px solid green"});
    $('.answer-control-section').css({"visibility":"visible"});
    clearInterval(timingInterval);
})

chooseMultipleAnswers.countTimerForProcess = function (duration,display) {
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
                $('.score-section').show();
                $('.answer-control-section').show();
            }
        }
    }, 1000);
}


/*Pagination*/


$(document).on('click','.cma-common-pagination',function () {
    var pageNumber = $(this).attr('data-page-number');
    chooseMultipleAnswers.getRenderDetails(pageNumber,"","");
    $('.cma-common-pagination').removeClass('active');
    $(this).addClass('active');
});


chooseMultipleAnswers.getRenderDetails = function (pageNumber,page,pageId) {
    clearAll();
    listening.clearListeningIntervals();
    $.ajax({
        method: "POST",
        data:{
            pageNumber:pageNumber,
            pageId:pageId,
            page:page
        },
        url: "../../ajax/renderListening/renderChooseMultipleAnswers.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.cma-render-div').html(json.details);
            if(json.pagination!=null && json.pagination != "" ){
                $('.cma-pagination-div').html(json.pagination);
            }
            var display = document.querySelector('.current-status');
            var duration = 8;
            //var audioLength = 69;
            var audioLength = parseInt(json.audioFileLength);
            startTimerForCMA(duration,display,audioLength);
            var display = document.querySelector(".cma-listener-timer");
            chooseMultipleAnswers.countTimerForProcess(10,display);
            
        }
    })
}

$(document).on('click','.cma-next',function () {
    console.log("Click:::::::::::::::::::")
    var pageId = $(this).attr('data-page-id');
    var page = $('.cma-next').attr('data-page');
    chooseMultipleAnswers.getRenderDetails("",page,pageId);
})

$(document).on('click','.cma-previous',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.cma-previous').attr('data-page');
    chooseMultipleAnswers.getRenderDetails("",page,pageId);
})


$(document).on('click','.cma-try-again',function () {
    var pageNumber = $('#cp-style.active.cma-common-pagination').attr('data-page-number');
    chooseMultipleAnswers.getRenderDetails(pageNumber,"","");
})











