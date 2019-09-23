/**
 * Created by praveen on 2/5/19.
 */


var reading = {};
var readingChooseSingleAnswer = {};

var readingInterval;
var readingTimeout;
var processBarIdForReading;
var timingIntervalReading;


reading.clearListeningIntervals = function () {
    clearTimeout(readingInterval);
    clearInterval(readingTimeout);
    clearInterval(processBarIdForReading);
    clearInterval(timingIntervalReading);
}


$('.ra-choose-single-answer').on('click',function () {
    listening.clearListeningIntervals();
    clearAll();
    reading.clearListeningIntervals();
    /*ajax*/
    $.ajax({
        method: "POST",
        url: "../../ajax/reading/getRAChooseSingleAnswerDetails.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.main-panel').html(json.details);
            var display = document.querySelector('.current-status');
            var duration = 10;
            //var audioLength = 69;
            var display = document.querySelector(".ra-csa-listener-timer");
            readingChooseSingleAnswer.countTimerForProcess(10,display);

        }
    });
})





$(document).on('click','.ra-csa-checkBox',function () {
    $('.ra-csa-checkBox').not(this).prop("checked", false);
    $('.choice-label').removeClass("color");
    $(this).closest(".choice-label").addClass("color");
});




$(document).on('click','.ra-csa-check-answer',function () {
    $('.score-section').show();
    $('.ra-csa-answer').css({"border":"2px solid green"});
})

$(document).on('click','.ra-csa-close-score-section',function () {
    $('.ra-csa-answer').css({"border":"none"});
    $('.score-section').hide();
})


$(document).on('click','.ra-csa-close-icon',function () {
    $('.ra-csa-alertMessage').hide();
})



$(document).on('click','.ra-csa-stop-my-answer',function () {
    //$('.score-section').show();
    $('.current-status').html("Completed");
    reading.clearListeningIntervals();
    //$('.ra-csa-answer').css({"border":"2px solid green"});
    $('.answer-control-section').css({"visibility":"visible"});
    clearInterval(timingIntervalReading);
})

readingChooseSingleAnswer.countTimerForProcess = function (duration,display) {
    var next = new Date();
    next = next.setMinutes(next.getMinutes()+duration);
    timingIntervalReading = setInterval(function () {
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
                $('.ra-csa-alertMessage').show();
            }
        }
    }, 1000);
}


/*Pagination*/


$(document).on('click','.ra-csa-common-pagination',function () {
    var pageNumber = $(this).attr('data-page-number');
    readingChooseSingleAnswer.getRenderDetails(pageNumber,"","");
    $('.ra-csa-common-pagination').removeClass('active');
    $(this).addClass('active');
});


readingChooseSingleAnswer.getRenderDetails = function (pageNumber,page,pageId) {
    clearAll();
    listening.clearListeningIntervals();
    reading.clearListeningIntervals();
    $.ajax({
        method: "POST",
        data:{
            pageNumber:pageNumber,
            pageId:pageId,
            page:page
        },
        url: "../../ajax/renderReading/renderReadingChooseSingleAnswer.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.ra-csa-render-div').html(json.details);
            if(json.pagination!=null && json.pagination != "" ){
                $('.ra-csa-pagination-div').html(json.pagination);
            }
            var display = document.querySelector('.current-status');
            var duration = 10;
            //var audioLength = 69;
            var display = document.querySelector(".ra-csa-listener-timer");
            readingChooseSingleAnswer.countTimerForProcess(10,display);
        }
    })
}

$(document).on('click','.ra-csa-next',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.ra-csa-next').attr('data-page');
    readingChooseSingleAnswer.getRenderDetails("",page,pageId);
})

$(document).on('click','.ra-csa-previous',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.ra-csa-previous').attr('data-page');
    readingChooseSingleAnswer.getRenderDetails("",page,pageId);
})


$(document).on('click','.ra-csa-try-again',function () {
    var pageNumber = $('#cp-style.active.ra-csa-common-pagination').attr('data-page-number');
    readingChooseSingleAnswer.getRenderDetails(pageNumber,"","");
});









