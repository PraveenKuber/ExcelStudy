/**
 * Created by praveen on 29/4/19.
 */

var selectMissingWord = {};

$(document).on('click','.select-missing-words',function () {
    clearAll();
    listening.clearListeningIntervals();
    $.ajax({
        method: "POST",
        url: "../../ajax/listening/getSelectMissingWordDetails.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.main-panel').html(json.details);
            var display = document.querySelector('.current-status');
            var duration = 8;
            //var audioLength = 69;
            var audioLength = parseInt(json.audioFileLength);
            console.log("audioLength:::::::::::"+audioLength)
            startTimerForSMW(duration,display,audioLength);
            var display = document.querySelector(".smw-listener-timer");
            selectMissingWord.countTimerForProcess(10,display);

        }
    })
})


function startTimerForSMW(duration, display,audioLength) {
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
            $(".smw").trigger('play');
            processProgressBarSMW(audioLength,"current-status");

        }
    }, 1000);
}

function  processProgressBarSMW(audioLength,className) {
    var progressBarWidth = 0;
    var processWidth = 103/audioLength;
    processBarIdForListening = setInterval(moveProcessBar,1000);
    function moveProcessBar() {
        if (progressBarWidth >= 103) {
            $('.'+className).text("Completed");
            clearInterval(processBarIdForListening);
        } else {
            progressBarWidth = progressBarWidth + processWidth;
            $('.selectMissingWord').css({"width":progressBarWidth+"%"})
        }
    }
}


$(document).on('click','.smw-checkBox',function () {
    $('.smw-checkBox').not(this).prop("checked", false);
    $('.choice-label').removeClass("color");
    $(this).closest(".choice-label").addClass("color");
});




$(document).on('click','.smw-check-answer',function () {
    $('.score-section').show();
    $('.smw-answer').css({"border":"2px solid green"});
})

$(document).on('click','.smw-close-score-section',function () {
    $('.smw-answer').css({"border":"none"});
    $('.score-section').hide();
})


$(document).on('click','.smw-close-icon',function () {
    $('.smw-alertMessage').hide();
})



$(document).on('click','.smw-stop-my-answer',function () {
    $('.score-section').show();
    $('.current-status').html("Completed");
    $('.smw').trigger('pause');
    listening.clearListeningIntervals();
    $('.smw-answer').css({"border":"2px solid green"});
    $('.answer-control-section').css({"visibility":"visible"});
    clearInterval(timingInterval);
})

selectMissingWord.countTimerForProcess = function (duration,display) {
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


$(document).on('click','.smw-common-pagination',function () {
    var pageNumber = $(this).attr('data-page-number');
    selectMissingWord.getRenderDetails(pageNumber,"","");
    $('.smw-common-pagination').removeClass('active');
    $(this).addClass('active');
});


selectMissingWord.getRenderDetails = function (pageNumber,page,pageId) {
    clearAll();
    listening.clearListeningIntervals();
    $.ajax({
        method: "POST",
        data:{
            pageNumber:pageNumber,
            pageId:pageId,
            page:page
        },
        url: "../../ajax/renderListening/renderSelectMissingWord.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.smw-render-div').html(json.details);
            if(json.pagination!=null && json.pagination != "" ){
                $('.smw-pagination-div').html(json.pagination);
            }
            var display = document.querySelector('.current-status');
            var duration = 8;
            //var audioLength = 69;
            var audioLength = parseInt(json.audioFileLength);
            startTimerForSMW(duration,display,audioLength);
            var display = document.querySelector(".smw-listener-timer");
            selectMissingWord.countTimerForProcess(10,display);

        }
    })
}

$(document).on('click','.smw-next',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.smw-next').attr('data-page');
    selectMissingWord.getRenderDetails("",page,pageId);
})

$(document).on('click','.smw-previous',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.smw-previous').attr('data-page');
    selectMissingWord.getRenderDetails("",page,pageId);
})


$(document).on('click','.smw-try-again',function () {
    var pageNumber = $('#cp-style.active.smw-common-pagination').attr('data-page-number');
    selectMissingWord.getRenderDetails(pageNumber,"","");
})

