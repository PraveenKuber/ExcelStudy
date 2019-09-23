/**
 * Created by praveen on 18/5/19.
 */


var reOrderParagraph = {};
var positionListLength = 0;

var correctAnswerCount = 0;
var totalAnswers = 0;


$('.re-order-paragarph').on('click',function () {
    listening.clearListeningIntervals();
    clearAll();
    reading.clearListeningIntervals();
    /*ajax*/
    $.ajax({
        method: "POST",
        url: "../../ajax/reading/getReOrderParagraphDetails.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.main-panel').html(json.details);
            var display = document.querySelector('.current-status');
            var duration = 10;
            positionListLength = json.length;
            totalAnswers = positionListLength;
            var display = document.querySelector(".ra-rop-listener-timer");
            reOrderParagraph.countTimerForProcess(10,display);
            reOrderParagraph.performBasics();
        }
    });
});




reOrderParagraph.countTimerForProcess = function (duration,display) {
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
                $('.ra-rop-alertMessage').show();
            }
        }
    }, 1000);
}


reOrderParagraph.checkAnswer = function () {
    correctAnswerCount = 0;
    var status = false;
    for(i=1;i<=positionListLength;i++) {
        var parentClasses = $('.position-'+i).parent().attr('class').split(' ');
        var swapDiv = "swapped-text";
        for (j = 0; j < parentClasses.length; j++) {
            if (parentClasses[j] == swapDiv) {
                status = true;
                break;
            }
        }
    }
    for(i=1;i<=positionListLength;i++){
        if(!status){
            var index = $('.position-'+i).index();
            index = index+1;
            if(index==i){
                $('.position-'+i).css({"background-color":"rgba(121, 230, 121, 0.72)"});
                correctAnswerCount = correctAnswerCount + 1;
            }else{
                $('.position-'+i).css({"background-color":"rgba(220, 88, 88, 0.74)"});
            }
        }else{
            $('.position-'+i).css({"background-color":"white"});
        }

    }

    $('.score-section-rop').show();
    reOrderParagraph.performResults();
   
};


$(document).on('click','.rop-close-score-section' , function () {
    $('.score-section-rop').hide();
})



$(document).on('click','.ra-rop-stop-my-answer',function () {
    $('.current-status').html("Completed");
    reading.clearListeningIntervals();
    $('.answer-control-section').css({"visibility":"visible"});
    clearInterval(timingIntervalReading);
    $('.paragraph').css({"pointer-events":"none"});
});



$(document).on('click','.ra-rop-check-answer',function () {
    reOrderParagraph.checkAnswer();
});


reOrderParagraph.performBasics = function () {
    var height = $('.swapped-text').height();
    $('.swapped-text').css({"min-height":(height+"px")});
    $('.order-paragraph').css({"min-height":(height+"px")});

    $i(".re-order-paragraph").sortable({connectWith: ".drop"});

    $i(".drop").sortable({connectWith: ".re-order-paragraph"});
    
};


$(document).on('click','.ra-rop-close-icon',function () {
    $('.ra-rop-alertMessage').hide();
});


/*Pagination*/


$(document).on('click','.ra-rop-common-pagination',function () {
    var pageNumber = $(this).attr('data-page-number');
    reOrderParagraph.getRenderDetails(pageNumber,"","");
    $('.ra-rop-common-pagination').removeClass('active');
    $(this).addClass('active');
});


reOrderParagraph.getRenderDetails = function (pageNumber,page,pageId) {
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
        url: "../../ajax/renderReading/renderReOrderParagraphDetails.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.ra-rop-render-div').html(json.details);
            var display = document.querySelector('.current-status');
            var duration = 10;
            if(json.pagination!=null && json.pagination != "" ){
                $('.ra-rop-pagination-div').html(json.pagination);
            }
            positionListLength = json.length;
            totalAnswers = positionListLength;
            var display = document.querySelector(".ra-rop-listener-timer");
            reOrderParagraph.countTimerForProcess(10,display);
            reOrderParagraph.performBasics();
        }
    })
}

$(document).on('click','.ra-rop-next',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.ra-rop-next').attr('data-page');
    reOrderParagraph.getRenderDetails("",page,pageId);
})

$(document).on('click','.ra-rop-previous',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.ra-rop-previous').attr('data-page');
    reOrderParagraph.getRenderDetails("",page,pageId);
})


$(document).on('click','.ra-rop-try-again',function () {
    var pageNumber = $('#cp-style.active.ra-rop-common-pagination').attr('data-page-number');
    reOrderParagraph.getRenderDetails(pageNumber,"","");
});

reOrderParagraph.performResults = function () {
     var width = $('.score-section-progress').width();
     width = ( width / totalAnswers)*correctAnswerCount;
     if(correctAnswerCount==0){
         width = 0;
     }
    
     $('.rop-score-section-progress').css({"background-color":"rgb(91, 245, 238)" , "width":width+"px"});
     var text = correctAnswerCount+"/"+totalAnswers;
     $('.score-total').text(text);
     var percentage = (correctAnswerCount/totalAnswers)*100;
    percentage = percentage.toFixed(2);
     percentage = "["+percentage+"%]";
     $('.score-percentage').text(percentage);
}
    









$(document).ready(function () {
    
    
    reOrderParagraph.performBasics();
   
});




    

