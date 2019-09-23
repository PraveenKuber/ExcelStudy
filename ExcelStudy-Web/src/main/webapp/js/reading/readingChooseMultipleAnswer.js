/**
 * Created by praveen on 7/5/19.
 */


var readingChooseMultipleAnswer = {};



$('.ra-choose-multiple-answer').on('click',function () {
    listening.clearListeningIntervals();
    clearAll();
    reading.clearListeningIntervals();
    /*ajax*/
    $.ajax({
        method: "POST",
        url: "../../ajax/reading/getRAChooseMultipleAnswersDetails.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.main-panel').html(json.details);
            var display = document.querySelector('.current-status');
            var duration = 10;
            //var audioLength = 69;
            var display = document.querySelector(".ra-cma-listener-timer");
            readingChooseMultipleAnswer.countTimerForProcess(10,display);

        }
    });
})


$(document).on('click','.checkBox',function () {
    var clickStatus = $(this).is(":checked");
    if(clickStatus==true||clickStatus=="true"){
        $(this).closest(".choice-label").addClass("color");
    }else{
        $(this).closest(".choice-label").removeClass("color");
    }
})





$(document).on('click','.ra-cma-check-answer',function () {
    $('.ra-cma-answer').css({"border":"2px solid green"});
})



$(document).on('click','.ra-cma-close-score-section',function () {
    $('.ra-cma-answer').css({"border":"none"});
})


$(document).on('click','.ra-cma-close-icon',function () {
    $('.ra-cma-alertMessage').hide();
})



$(document).on('click','.ra-cma-stop-my-answer',function () {
    $('.current-status').html("Completed");
    reading.clearListeningIntervals();
    //$('.ra-cma-answer').css({"border":"2px solid green"});
    $('.answer-control-section').css({"visibility":"visible"});
    clearInterval(timingIntervalReading);
})

readingChooseMultipleAnswer.countTimerForProcess = function (duration,display) {
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
                $('.answer-control-section').show();
                $('.ra-cma-alertMessage').show();
            }
        }
    }, 1000);
}


/*Pagination*/


$(document).on('click','.ra-cma-common-pagination',function () {
    var pageNumber = $(this).attr('data-page-number');
    console.log("pageNumber::::::::::::::"+pageNumber)
    readingChooseMultipleAnswer.getRenderDetails(pageNumber,"","");
    $('.ra-cma-common-pagination').removeClass('active');
    $(this).addClass('active');
});


readingChooseMultipleAnswer.getRenderDetails = function (pageNumber,page,pageId) {
    console.log("pageNumber:::::::::::"+pageNumber)
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
        url: "../../ajax/renderReading/renderReadingChooseMultipleAnswer.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.ra-cma-render-div').html(json.details);
            if(json.pagination!=null && json.pagination != "" ){
                $('.ra-cma-pagination-div').html(json.pagination);
            }
            var display = document.querySelector('.current-status');
            var duration = 10;
            //var audioLength = 69;
            var display = document.querySelector(".ra-cma-listener-timer");
            readingChooseMultipleAnswer.countTimerForProcess(10,display);
        }
    })
}

$(document).on('click','.ra-cma-next',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.ra-cma-next').attr('data-page');
    console.log("pageId:::::::::"+pageId+"::: page::::"+page)
    readingChooseMultipleAnswer.getRenderDetails("",page,pageId);
})

$(document).on('click','.ra-cma-previous',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.ra-cma-previous').attr('data-page');
    readingChooseMultipleAnswer.getRenderDetails("",page,pageId);
})


$(document).on('click','.ra-cma-try-again',function () {
    var pageNumber = $('#cp-style.active.ra-cma-common-pagination').attr('data-page-number');
    readingChooseMultipleAnswer.getRenderDetails(pageNumber,"","");
});









