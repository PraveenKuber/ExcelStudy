/**
 * Created by praveen on 23/8/19.
 */


/**
 * Created by praveen on 8/5/19.
 */

var readingFillInTheBlanksDrag = {};
var counter = 0;
var correctAnswer = 0;


$('.read-fill-in-the-blanks').on('click', function () {
    listening.clearListeningIntervals();
    clearAll();
    reading.clearListeningIntervals();
    /*ajax*/
    $.ajax({
        method: "POST",
        url: "../../ajax/reading/getRAFillInTheBlanksDrag.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            counter = json.counter;
            $('.main-panel').html(json.details);
            var duration = 10;
            var display = document.querySelector(".ra-fibd-listener-timer");
            readingFillInTheBlanksDrag.countTimerForProcess(duration, display);
            readingFillInTheBlanksDrag.performBasics();
            correctAnswer = 0;
            
        }
    });
})


$(document).on('click', '.ra-fibd-close-score-section', function () {
    $('.ra-fibd-answer').css({"border": "none"});
})


$(document).on('click', '.ra-fibd-close-icon', function () {
    $('.ra-fibd-alertMessage').hide();
});



$(document).on('click', '.ra-fibd-check-answer', function () {
         correctAnswer = 0;
         for(i=1;i<=counter;i++){
             var input = $('.drag-'+i).prev('.answer-area').find('.answer-part').text();
             var answer = $('.drag-'+i).text();
             if(input==answer){
                 correctAnswer++;
                 $('.drag-'+i).prev('.answer-area').find('.answer-part').css({"background-color":"bisque"});
                 $('.drag-'+i).prev('.answer-area').css({"background-color":"bisque"});
             }
             $('.corrected').css({"display":"inline"});
         }
    $('.score-section-fibd').show();
    readingFillInTheBlanksDrag.performResults();
});


$(document).on('click','.fibd-close-score-section' , function () {
    $('.score-section-fibd').hide();
    $('.answer-area').find('.answer-part').css({"background-color":"white"});
    $('.answer-area').css({"background-color":"white"});
    $('.corrected').css({"display":"none"});
});


readingFillInTheBlanksDrag.performResults = function () {
    var width = $('.score-section-progress').width();
    width = ( width / counter)*correctAnswer;
    if(correctAnswer==0){
        width = 0;
    }
    $('.fibd-score-section-progress').css({"background-color":"rgb(91, 245, 238)" , "width":width+"px"});
    var text = correctAnswer+"/"+counter;
    $('.score-total').text(text);
    var percentage = (correctAnswer/counter)*100;
    percentage = percentage.toFixed(2);
    percentage = "["+percentage+"%]";
    $('.score-percentage').text(percentage);
}





$(document).on('click', '.ra-fibd-stop-my-answer', function () {
    reading.clearListeningIntervals();
    $('.ra-fibd-answer').css({"border": "2px solid green"});
    $('.answer-control-section').css({"visibility": "visible"});
    clearInterval(timingIntervalReading);
    $('.answer-part').css({"pointer-events":"none"});
})

readingFillInTheBlanksDrag.countTimerForProcess = function (duration, display) {
    var next = new Date();
    next = next.setMinutes(next.getMinutes() + duration);
    timingIntervalReading = setInterval(function () {
        var now = new Date();
        var distance = next - now;
        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((distance % (1000 * 60)) / 1000);
        var displaySec = seconds;
        if (seconds < 10) {
            displaySec = "0" + displaySec;
        }
        if (minutes > -1 && seconds > -1) display.textContent = minutes + ":" + displaySec;
        if (distance < 0) {
            if (seconds == 0 || seconds < 0) {
                clearInterval(timingInterval);
                $('.answer-control-section').show();
                $('.ra-fib-alertMessage').show();
            }
        }
    }, 1000);
}




/*Pagination*/


$(document).on('click', '.ra-fibd-common-pagination', function () {
    var pageNumber = $(this).attr('data-page-number');
    readingFillInTheBlanksDrag.getRenderDetails(pageNumber, "", "");
    $('.ra-fibd-common-pagination').removeClass('active');
    $(this).addClass('active');
});


readingFillInTheBlanksDrag.getRenderDetails = function (pageNumber, page, pageId) {
    counter = 0;
    clearAll();
    listening.clearListeningIntervals();
    reading.clearListeningIntervals();
    $.ajax({
        method: "POST",
        data: {
            pageNumber: pageNumber,
            pageId: pageId,
            page: page
        },
        url: "../../ajax/renderReading/renderReadingFillInTheBlanksDrag.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.ra-fibd-render-div').html(json.details);
            if (json.pagination != null && json.pagination != "") {
                $('.ra-fibd-pagination-div').html(json.pagination);
            }
            var display = document.querySelector(".ra-fibd-listener-timer");
            var duration = 10;
            counter = json.counter;
            readingFillInTheBlanksDrag.countTimerForProcess(duration, display);
            readingFillInTheBlanksDrag.performBasics();
            correctAnswer = 0;
        }
    })
}

$(document).on('click', '.ra-fibd-next', function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.ra-fibd-next').attr('data-page');
    readingFillInTheBlanksDrag.getRenderDetails("", page, pageId);
})

$(document).on('click', '.ra-fibd-previous', function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.ra-fibd-previous').attr('data-page');
    readingFillInTheBlanksDrag.getRenderDetails("", page, pageId);
})


readingFillInTheBlanksDrag.performBasics = function () {
    $i(".answer-pick-area").sortable({
        connectWith: ".answer-area"
    });
    
    $i(".answer-area").sortable({
        connectWith: ".answer-pick-area"
    });
}


$(document).on('click', '.ra-fibd-try-again', function () {
    var pageNumber = $('#cp-style.active.ra-fibd-common-pagination').attr('data-page-number');
    readingFillInTheBlanksDrag.getRenderDetails(pageNumber, "", "");
});


$(document).ready(function () {
    readingFillInTheBlanksDrag.performBasics();
});

