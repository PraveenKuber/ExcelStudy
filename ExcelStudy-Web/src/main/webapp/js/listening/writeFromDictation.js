/**
 * Created by praveen on 20/4/19.
 */

var writeFromDictation   = {};

listening.clearListeningIntervals = function () {
    clearTimeout(listeningInterval);
    clearInterval(listeningTimeout);
    clearInterval(processBarIdForListening);
    clearInterval(timingInterval);
}

$('.write-from-dictation').click(function () {
    listening.clearListeningIntervals();
    clearAll();
    /*ajax*/
    $.ajax({
        method: "POST",
        url: "../../ajax/listening/getWriteFromDictationDetails.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.main-panel').html(json.details);
            var display = document.querySelector('.current-status');
            var duration = 8;
            var audioLength = parseInt(json.audioFileLength);
            var maxTimeToWrite =  parseInt(json.writingTime);
            var timerDisplay = document.querySelector('.wfd-time-counter-content');
            startTimerForWFD(duration,display,audioLength);
            writeFromDictation.countTimerForProcess(maxTimeToWrite,timerDisplay)
        }
    });

})


function startTimerForWFD(duration, display,audioLength) {
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
            $(".wfd").trigger('play');

            processProgressBarWFD(audioLength,"current-status");

        }
    }, 1000);
}



function  processProgressBarWFD(audioLength,className) {
    var progressBarWidth = 0;
    var processWidth = 103/audioLength;
    processBarIdForListening = setInterval(moveProcessBar,1000);
    function moveProcessBar() {
        if (progressBarWidth >= 103) {
            $('.'+className).text("Completed");
            clearInterval(processBarIdForListening);
        } else {
            progressBarWidth = progressBarWidth + processWidth;
            $('.writeFromDictation').css({"width":progressBarWidth+"%"})
        }
    }
}


writeFromDictation.getInputTextCount = function (e) {
    eventKeyCode = window.event ? event.keyCode : event.which;
    if(eventKeyCode == 32){
        var textValue = $('.writingArea-wfd').val();
        var textValueCount = textValue.split(" ");
        var count = textValueCount.length;
        $('.wfd-word-counter-content').text(count-1);
    }
}

writeFromDictation.countTimerForProcess = function (duration,display) {
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
                $('.writingArea-wfd').prop("readonly",true);
                /* $('.swt-check-answer').click();*/
                $('.wfd-alertMessage').show();
                $('.listening-control').css({"visibility":"visible"});
            }
        }
    }, 1000);
}


$(document).on('click','.wfd-close-icon',function () {
    $('.wfd-alertMessage').hide();
});

$(document).on('click','.wfd-your-answer-close',function () {
    $('.wfd-listening-answer-analysis').hide();
});


$(document).on('click','.listening-check-answer-wfd',function () {
    $('.wfd-listening-answer-analysis').show();
});

$(document).on('click','.wfd-stop-my-answer',function () {
    $('.listening-control').css({"visibility":"visible"});
    $('.writingArea-wfd').prop("readonly",true);
    $(".wfd").trigger('pause');
    $('.current-status').html("Completed");
    listening.clearListeningIntervals();
});

$(document).on('click','.listening-check-answer-wfd',function () {
    var text = $('.writingArea-wfd').val();
    $('.wfd-listening-answer-area').html(text);
    var audioScript = $('.wfd-audio-script').html();
    writeFromDictation.compareSentence(audioScript,text);
    $('.wfd-listening-answer-analysis').show();
});



$(document).on('click','.listening-save-my-answer-wfd',function () {
    var script = $('.wfd-audio-script').html();;
    script = script + "\n\n";
    var output = $('.wfd-listening-answer-area').html();
    output = script + output;
    var textFileAsBlob = new Blob([output], {type:'text/plain'});
    var fileNameToSaveAs = "OCE-Write_From_Dictation";

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

writeFromDictation.compareSentence = function (audioScript,writtenText) {
    var inputText = audioScript;
    var counter = 0;
    console.log("Input text ::::::::::"+inputText);
    var inputList = getFormattedListForMatching(inputText);
    var totalWordCount = inputList.length;
    var writtenTextList = getFormattedListForMatching(writtenText);
    var finalText;
    var mainDiv = document.createElement("div");
    mainDiv.setAttribute("class","test");
    var testMain = " ";
    for(var i=0;i<inputList.length;i++){
        if(writtenTextList[i]!= undefined){
            var innerHtmlBuilder;
            if(inputList[i].toLowerCase() != writtenTextList[i].toLowerCase()){
                innerHtmlBuilder = document.createElement("span");
                innerHtmlBuilder.setAttribute("class","color");
                mainDiv.appendChild(innerHtmlBuilder);
                testMain = testMain + "<span class='not-matched'>"+writtenTextList[i]+"</span>"+" ";
                console.log("Not matched ::::::::::"+inputList[i]+"::::::::;"+writtenTextList[i]);
            }else{
                counter++;
                testMain = testMain + "<span class='matched'>"+inputList[i]+"</span>"+" ";
                innerHtmlBuilder = document.createElement("span");
                innerHtmlBuilder.setAttribute("class","color-not");
                mainDiv.appendChild(innerHtmlBuilder);
                console.log("Matched ::::::::"+inputList[i]+":::::::"+writtenTextList[i])
            }
        }
    }
    var displayScore = totalWordCount+"/"+counter;
    var percentage = (counter/totalWordCount)*100;
    percentage = percentage.toFixed(2);
    var width = (percentage*78)/100;
    $('.wfd-listening-calculation-area').html(displayScore);
    $('.wfd-listening-percentage-got-area').html("["+percentage+"%]");
    $('.wfd-listening-progress-area').css({"width":width+"%"});
    $('.wfd-listening-compare-area').append(testMain)
}




/*Pagination*/


$(document).on('click','.wfd-common-pagination',function () {
    var pageNumber = $(this).attr('data-page-number');
    writeFromDictation.getRenderDetails(pageNumber,"","");
    $('.wfd-common-pagination').removeClass('active');
    $(this).addClass('active');
});


writeFromDictation.getRenderDetails = function (pageNumber,page,pageId) {
    clearAll();
    listening.clearListeningIntervals();
    $.ajax({
        method: "POST",
        data:{
            pageNumber:pageNumber,
            pageId:pageId,
            page:page
        },
        url: "../../ajax/renderListening/renderWriteFromDictation.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.wfd-render-div').html(json.details);
            if(json.pagination!=null && json.pagination != "" ){
                $('.wfd-pagination-div').html(json.pagination);
            }
            var display = document.querySelector('.current-status');
            var duration = 8;
            var audioLength = parseInt(json.audioFileLength);
            var maxTimeToWrite =  parseInt(json.writingTime);
            var timerDisplay = document.querySelector('.wfd-time-counter-content');
            startTimerForWFD(duration,display,audioLength);
            writeFromDictation.countTimerForProcess(maxTimeToWrite,timerDisplay)

        }
    })
}

$(document).on('click','.wfd-next',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.wfd-next').attr('data-page');
    writeFromDictation.getRenderDetails("",page,pageId);
})



$(document).on('click','.wfd-previous',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.wfd-previous').attr('data-page');
    writeFromDictation.getRenderDetails("",page,pageId);
})


$(document).on('click','.listening-try-again-wfd',function () {
    var pageNumber = $('#cp-style.active.wfd-common-pagination').attr('data-page-number');
    writeFromDictation.getRenderDetails(pageNumber,"","");
})