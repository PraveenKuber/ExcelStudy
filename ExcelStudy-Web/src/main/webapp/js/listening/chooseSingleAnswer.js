/**
 * Created by praveen on 29/4/19.
 */

var chooseSingleAnswer = {};

$(document).on('click','.choose-single-answer',function () {
    clearAll();
    listening.clearListeningIntervals();
    $.ajax({
        method: "POST",
        url: "../../ajax/listening/getChooseSingleAnswerDetails.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.main-panel').html(json.details);
            var display = document.querySelector('.current-status');
            var duration = 10;
            //var audioLength = 69;
            var audioLength = parseInt(json.audioFileLength);
            startTimerForCSA(duration,display,audioLength);
            var display = document.querySelector(".csa-listener-timer");
            chooseSingleAnswer.countTimerForProcess(10,display);

        }
    })
})


function startTimerForCSA(duration, display,audioLength) {
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
            $(".csa").trigger('play');
            processProgressBarCSA(audioLength,"current-status");

        }
    }, 1000);
}

function  processProgressBarCSA(audioLength,className) {
    var progressBarWidth = 0;
    var processWidth = 103/audioLength;
    processBarIdForListening = setInterval(moveProcessBar,1000);
    function moveProcessBar() {
        if (progressBarWidth >= 103) {
            $('.'+className).text("Completed");
            clearInterval(processBarIdForListening);
        } else {
            progressBarWidth = progressBarWidth + processWidth;
            $('.chooseSingleAnswer').css({"width":progressBarWidth+"%"})
        }
    }
}


$(document).on('click','.csa-checkBox',function () {
    $('.csa-checkBox').not(this).prop("checked", false);
    $('.choice-label').removeClass("color");
    $(this).closest(".choice-label").addClass("color");
});




$(document).on('click','.csa-check-answer',function () {
    $('.score-section').show();
    $('.csa-answer').css({"border":"2px solid green"});
})

$(document).on('click','.csa-close-score-section',function () {
    $('.csa-answer').css({"border":"none"});
    $('.score-section').hide();
})


$(document).on('click','.csa-close-icon',function () {
    $('.csa-alertMessage').hide();
})



$(document).on('click','.csa-stop-my-answer',function () {
    $('.score-section').show();
    $('.current-status').html("Completed");
    $('.csa').trigger('pause');
    listening.clearListeningIntervals();
    $('.csa-answer').css({"border":"2px solid green"});
    $('.answer-control-section').css({"visibility":"visible"});
    clearInterval(timingInterval);
})

chooseSingleAnswer.countTimerForProcess = function (duration,display) {
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


$(document).on('click','.csa-common-pagination',function () {
    var pageNumber = $(this).attr('data-page-number');
    chooseSingleAnswer.getRenderDetails(pageNumber,"","");
    $('.csa-common-pagination').removeClass('active');
    $(this).addClass('active');
});


chooseSingleAnswer.getRenderDetails = function (pageNumber,page,pageId) {
    clearAll();
    listening.clearListeningIntervals();
    $.ajax({
        method: "POST",
        data:{
            pageNumber:pageNumber,
            pageId:pageId,
            page:page
        },
        url: "../../ajax/renderListening/renderChooseSingleAnswer.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.csa-render-div').html(json.details);
            if(json.pagination!=null && json.pagination != "" ){
                $('.csa-pagination-div').html(json.pagination);
            }
            var display = document.querySelector('.current-status');
            var duration = 8;
            //var audioLength = 69;
            var audioLength = parseInt(json.audioFileLength);
            startTimerForCSA(duration,display,audioLength);
            var display = document.querySelector(".csa-listener-timer");
            chooseSingleAnswer.countTimerForProcess(10,display);

        }
    })
}

$(document).on('click','.csa-next',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.csa-next').attr('data-page');
    chooseSingleAnswer.getRenderDetails("",page,pageId);
})

$(document).on('click','.csa-previous',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.csa-previous').attr('data-page');
    chooseSingleAnswer.getRenderDetails("",page,pageId);
})


$(document).on('click','.csa-try-again',function () {
    var pageNumber = $('#cp-style.active.csa-common-pagination').attr('data-page-number');
    chooseSingleAnswer.getRenderDetails(pageNumber,"","");
})
