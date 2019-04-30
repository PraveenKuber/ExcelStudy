/**
 * Created by praveen on 28/4/19.
 */

/**
 * Created by praveen on 21/4/19.
 */

var highlightCorrectAnswer = {};


$(document).on('click','.highlight-correct-summary',function () {
    clearAll();
    listening.clearListeningIntervals();
    $.ajax({
        method: "POST",
        url: "../../ajax/listening/getHighlightCorrectSummaryDetails.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.main-panel').html(json.details);
            var display = document.querySelector('.current-status');
            var duration = 8;
            //var audioLength = 69;
            var audioLength = parseInt(json.audioFileLength);
            console.log("audioLength:::::::::::"+audioLength)
            startTimerForHCS(duration,display,audioLength);
            var display = document.querySelector(".hcs-listener-timer");
            highlightCorrectAnswer.countTimerForProcess(10,display);

        }
    })
})


function startTimerForHCS(duration, display,audioLength) {
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
            $(".hcs").trigger('play');
            processProgressBarHCS(audioLength,"current-status");

        }
    }, 1000);
}

function  processProgressBarHCS(audioLength,className) {
    var progressBarWidth = 0;
    var processWidth = 103/audioLength;
    processBarIdForListening = setInterval(moveProcessBar,1000);
    function moveProcessBar() {
        if (progressBarWidth >= 103) {
            $('.'+className).text("Completed");
            clearInterval(processBarIdForListening);
        } else {
            progressBarWidth = progressBarWidth + processWidth;
            $('.highlightCorrectSummary').css({"width":progressBarWidth+"%"})
        }
    }
}


$(document).on('click','.hcs-checkBox',function () {
    $('.hcs-checkBox').not(this).prop("checked", false);
    $('.choice-label').removeClass("color");
    $(this).closest(".choice-label").addClass("color");
});




$(document).on('click','.hcs-check-answer',function () {
    $('.score-section').show();
    $('.hcs-answer').css({"border":"2px solid green"});
})

$(document).on('click','.hcs-close-score-section',function () {
    $('.hcs-answer').css({"border":"none"});
    $('.score-section').hide();
})


$(document).on('click','.hcs-close-icon',function () {
    $('.hcs-alertMessage').hide();
})



$(document).on('click','.hcs-stop-my-answer',function () {
    $('.score-section').show();
    $('.current-status').html("Completed");
    $('.hcs').trigger('pause');
    listening.clearListeningIntervals();
    $('.hcs-answer').css({"border":"2px solid green"});
    $('.answer-control-section').css({"visibility":"visible"});
    clearInterval(timingInterval);
})

highlightCorrectAnswer.countTimerForProcess = function (duration,display) {
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


$(document).on('click','.hcs-common-pagination',function () {
    var pageNumber = $(this).attr('data-page-number');
    highlightCorrectAnswer.getRenderDetails(pageNumber,"","");
    $('.hcs-common-pagination').removeClass('active');
    $(this).addClass('active');
});


highlightCorrectAnswer.getRenderDetails = function (pageNumber,page,pageId) {
    clearAll();
    listening.clearListeningIntervals();
    $.ajax({
        method: "POST",
        data:{
            pageNumber:pageNumber,
            pageId:pageId,
            page:page
        },
        url: "../../ajax/renderListening/renderHighlightCorrectSummary.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.hcs-render-div').html(json.details);
            if(json.pagination!=null && json.pagination != "" ){
                $('.hcs-pagination-div').html(json.pagination);
            }
            var display = document.querySelector('.current-status');
            var duration = 8;
            //var audioLength = 69;
            var audioLength = parseInt(json.audioFileLength);
            startTimerForHCS(duration,display,audioLength);
            var display = document.querySelector(".hcs-listener-timer");
            highlightCorrectAnswer.countTimerForProcess(10,display);

        }
    })
}

$(document).on('click','.hcs-next',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.hcs-next').attr('data-page');
    highlightCorrectAnswer.getRenderDetails("",page,pageId);
})

$(document).on('click','.hcs-previous',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.hcs-previous').attr('data-page');
    highlightCorrectAnswer.getRenderDetails("",page,pageId);
})


$(document).on('click','.hcs-try-again',function () {
    var pageNumber = $('#cp-style.active.hcs-common-pagination').attr('data-page-number');
    highlightCorrectAnswer.getRenderDetails(pageNumber,"","");
})












