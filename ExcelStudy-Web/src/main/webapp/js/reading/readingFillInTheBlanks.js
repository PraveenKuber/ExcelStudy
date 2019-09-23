/**
 * Created by praveen on 8/5/19.
 */

var readingFillInTheBlanks = {};

var lengthCounter = 0;

$('.read-and-write-fill-in-the-blanks').on('click',function () {
    listening.clearListeningIntervals();
    clearAll();
    reading.clearListeningIntervals();
    /*ajax*/
    $.ajax({
        method: "POST",
        url: "../../ajax/reading/getRAFillInTheBlanks.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.main-panel').html(json.details);
            lengthCounter = json.counter;
            var duration = 10;
            var display = document.querySelector(".ra-fib-listener-timer");
            readingFillInTheBlanks.countTimerForProcess(10,display);
        }
    });
})





$(document).on('click','.ra-fib-check-answer',function () {
    $('.fib').css({"pointer-events":"none"});
    $('.fib-re-correct').show();
    var correctAnswerCounter = 0;
    var input;
    var answer;
    for(i=1;i<=lengthCounter;i++){
        input = $('.fid-re-'+i).find(":selected").val();
        answer = $('.fib-re-corrected-'+i).text();
        if(input==answer){
            correctAnswerCounter++;
        }else{
            $('.fid-re-'+i).css({"background-color":"rgba(255, 0, 0, 0.62)"});
        }
    }

    $('.score-section-fibr').show();
    
    var width = $('.score-section-progress').width();
    width = ( width / lengthCounter)*correctAnswerCounter;
    if(correctAnswerCounter==0){
        width = 0;
    }
    $('.fibr-score-section-progress').css({"background-color":"rgb(91, 245, 238)" , "width":width+"px"});
    var text = correctAnswerCounter+"/"+lengthCounter;
    $('.score-total').text(text);
    var percentage = (correctAnswerCounter/lengthCounter)*100;
    percentage = percentage.toFixed(2);
    percentage = "["+percentage+"%]";
    $('.score-percentage').text(percentage);
    
    
});


$(document).on('click','.ra-fib-close-score-section',function () {
    $('.ra-fib-answer').css({"border":"none"});
})

$(document).on('click','.fibr-close-score-section',function () {
    $('.fib').css({"background-color":"#d3d3d37a"});
    $('.fib-re-correct').hide();
    $('.score-section-fibr').hide();
})


$(document).on('click','.ra-fib-close-icon',function () {
    $('.ra-fib-alertMessage').hide();
})



$(document).on('click','.ra-fib-stop-my-answer',function () {
    $('.current-status').html("Completed");
    reading.clearListeningIntervals();
    $('.ra-fib-answer').css({"border":"2px solid green"});
    $('.answer-control-section').css({"visibility":"visible"});
    clearInterval(timingIntervalReading);
})

readingFillInTheBlanks.countTimerForProcess = function (duration,display) {
    var next = new Date();
    next = next.setMinutes(next.getMinutes()+duration);
    console.log("display::::::::::::::"+display);
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
                $('.ra-fib-alertMessage').show();
            }
        }
    }, 1000);
}


/*Pagination*/


$(document).on('click','.ra-fib-common-pagination',function () {
    var pageNumber = $(this).attr('data-page-number');
    readingFillInTheBlanks.getRenderDetails(pageNumber,"","");
    $('.ra-fib-common-pagination').removeClass('active');
    $(this).addClass('active');
});


readingFillInTheBlanks.getRenderDetails = function (pageNumber,page,pageId) {
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
        url: "../../ajax/renderReading/renderReadingFillInTheBlanks.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.ra-fib-render-div').html(json.details);
            if(json.pagination!=null && json.pagination != "" ){
                $('.ra-fib-pagination-div').html(json.pagination);
            }
            lengthCounter = json.counter;
            var duration = 10;
            var display = document.querySelector(".ra-fib-listener-timer");
            readingFillInTheBlanks.countTimerForProcess(10,display);
            console.log("Display :::::::::::::::"+display);
        }
    })
}

$(document).on('click','.ra-fib-next',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.ra-fib-next').attr('data-page');
    readingFillInTheBlanks.getRenderDetails("",page,pageId);
})

$(document).on('click','.ra-fib-previous',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.ra-fib-previous').attr('data-page');
    readingFillInTheBlanks.getRenderDetails("",page,pageId);
})


$(document).on('click','.ra-fib-try-again',function () {
    var pageNumber = $('#cp-style.active.ra-fib-common-pagination').attr('data-page-number');
    readingFillInTheBlanks.getRenderDetails(pageNumber,"","");
});

