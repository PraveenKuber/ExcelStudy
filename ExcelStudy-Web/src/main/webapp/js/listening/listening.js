/**
 * Created by praveen on 24/2/19.
 */


var listening = {};

var listeningInterval;
var listeningTimeout;
var processBarIdForListening;
var timingInterval;


listening.clearListeningIntervals = function () {
    clearTimeout(listeningInterval);
    clearInterval(listeningTimeout);
    clearInterval(processBarIdForListening);
    clearInterval(timingInterval);
}

$('.summarize_spoken_text').click(function () {
    listening.clearListeningIntervals();
    clearAll();
    /*ajax*/
    $.ajax({
        method: "POST",
        url: "../../ajax/listening/getSummarizeSpokenTextDetails.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.main-panel').html(json.details);
            var display = document.querySelector('.current-status');
            var duration = 10;
            var audioLength = parseInt(json.audioFileLength);
            var maxTimeToWrite =  parseInt(json.writingTime);
            var timerDisplay = document.querySelector('.sst-time-counter-content');
            startTimerForSST(duration,display,audioLength);
            listening.countTimerForProcess(maxTimeToWrite,timerDisplay)
        }
    });
    
})


function startTimerForSST(duration, display,audioLength) {
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
            $(".sst").trigger('play');

            processProgressBarSST(audioLength,"current-status");

            /*Show after completion*/
           /* listeningTimeout  = setTimeout(function(){
                $('.sst-alertMessage').show();
                $('.listening-control').css({"visibility":"visible"});
                listening.clearListeningIntervals();
            },(audioLength*1000));*/
        }
    }, 1000);
}



function  processProgressBarSST(audioLength,className) {
    var progressBarWidth = 0;
    var processWidth = 102/(audioLength-1);
    processBarIdForListening = setInterval(moveProcessBar,1000);
    function moveProcessBar() {
        if (progressBarWidth >= 102) {
            $('.'+className).text("Completed");
            clearInterval(processBarIdForListening);
        } else {
            progressBarWidth = progressBarWidth + processWidth;
            $('.summarizeSpokenText').css({"width":progressBarWidth+"%"})
        }
    }
}


listening.getInputTextCount = function (e) {
    eventKeyCode = window.event ? event.keyCode : event.which;
    if(eventKeyCode == 32){
        var textValue = $('.writingArea-sst').val();
        var textValueCount = textValue.split(" ");
        var count = textValueCount.length;
        $('.sst-word-counter-content').text(count-1);
    }
}

listening.countTimerForProcess = function (duration,display) {
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
                $('.writingArea-sst').prop("readonly",true);
               /* $('.swt-check-answer').click();*/
                $('.swt-alertMessage').show();
                $('.listening-control').css({"visibility":"visible"});
            }
        }
    }, 1000);
}


$(document).on('click','.sst-close-icon',function () {
    $('.sst-alertMessage').hide();
});

$(document).on('click','.sst-your-answer-close',function () {
    $('.sst-listening-answer-analysis').hide();
});


$(document).on('click','.listening-check-answer-sst',function () {
    $('.sst-listening-answer-analysis').show();
});

$(document).on('click','.sst-stop-my-answer',function () {
    $('.listening-control').css({"visibility":"visible"});
    $('.writingArea-sst').prop("readonly",true);
    $(".sst").trigger('pause');
    $('.current-status').html("Completed");
    listening.clearListeningIntervals();
});

$(document).on('click','.listening-check-answer-sst',function () {
    var text = $('.writingArea-sst').val();
    $('.sst-listening-answer-area').html(text);
    $('.sst-listening-answer-analysis').show();
});



$(document).on('click','.listening-save-my-answer-sst',function () {
    var output = $('.sst-listening-answer-area').html();
    var textFileAsBlob = new Blob([output], {type:'text/plain'});
    var fileNameToSaveAs = "OCE-Summarize_Spoken_Text";

    var downloadLink = document.createElement("a");
    downloadLink.download = fileNameToSaveAs;
    downloadLink.innerHTML = "Download File";
    if (window.webkitURL != null) {
        downloadLink.href = window.webkitURL.createObjectURL(textFileAsBlob);
    }
    else {
        downloadLink.href = window.URL.createObjectURL(textFileAsBlob);
        downloadLink.onclick = destroyClickedElement;
        downloadLink.style.display = "none";
        document.body.appendChild(downloadLink);
    }
    downloadLink.click();
})



/*Pagination*/


$(document).on('click','.sst-common-pagination',function () {
    console.log("Clicked here SST pg1 ::::::::::::::::::::")
    var pageNumber = $(this).attr('data-page-number');
    listening.getRenderDetails(pageNumber,"","");
    $('.sst-common-pagination').removeClass('active');
    $(this).addClass('active');
});


listening.getRenderDetails = function (pageNumber,page,pageId) {
    console.log("Clicked here SST pg2 ::::::::::::::::::::"+pageNumber+":::page :::"+page+":::::page id ::"+pageId);
    clearAll();
    listening.clearListeningIntervals();
    $.ajax({
        method: "POST",
        data:{
            pageNumber:pageNumber,
            pageId:pageId,
            page:page
        },
        url: "../../ajax/renderListening/renderSummarizeSpokenText.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.sst-render-div').html(json.details);
            if(json.pagination!=null && json.pagination != "" ){
                $('.sst-pagination-div').html(json.pagination);
            }
            var display = document.querySelector('.current-status');
            var duration = 10;
            var audioLength = parseInt(json.audioFileLength);
            var maxTimeToWrite =  parseInt(json.writingTime);
            var timerDisplay = document.querySelector('.sst-time-counter-content');
            startTimerForSST(duration,display,audioLength);
            listening.countTimerForProcess(maxTimeToWrite,timerDisplay)

        }
    })
}

$(document).on('click','.sst-next',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.sst-next').attr('data-page');
    console.log("Next is :::::::::::::::::")
    listening.getRenderDetails("",page,pageId);
})



$(document).on('click','.sst-previous',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.sst-previous').attr('data-page');
    listening.getRenderDetails("",page,pageId);
})


$(document).on('click','.listening-try-again-sst',function () {
    var pageNumber = $('#cp-style.active.sst-common-pagination').attr('data-page-number');
    listening.getRenderDetails(pageNumber,"","");
})














