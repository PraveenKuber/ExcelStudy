/**
 * Created by praveen on 4/4/19.
 */


var summarizeWrittenText = {};
var interval ;
var timeOut;
var numberOfMinutesSWT = 10;


$('.summarizeWrittenText').click(function (event) {
    clearAll();
    clearInterval(interval);
    clearTimeout(timeOut);
    /*ajax*/
    $.ajax({
        method: "POST",
        url: "../../ajax/writing/getSummarizedTextDetails.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.main-panel').html(json.details);
            var display = document.querySelector('.time-counter-content');
            
            recordBeginForSummarizeSpokenText(numberOfMinutesSWT,display);
        }

    });

})



summarizeWrittenText.getInputTextCount = function (e) {
    eventKeyCode = window.event ? event.keyCode : event.which;
    if(eventKeyCode == 32){
        var textValue = $('.summarizeTextDescription-output').val();
        var textValueCount = textValue.split(" ");
        var count = textValueCount.length;
        $('.word-counter-content').text(count-1);
    }
}



function recordBeginForSummarizeSpokenText(duration, display) {
    var next = new Date();
    next = next.setMinutes(next.getMinutes()+duration);
    interval = setInterval(function () {
        console.log("duration:::::::"+duration);
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
                clearInterval(interval);
                $('.summarizeTextDescription-output').prop("readonly",true);
                $('.swt-check-answer').click();
                $('.swt-alertMessage').show();
                //$('.swt-answer-analysis').show();
                $('.swt-control').css({"visibility":"visible"});
            }
        }
    }, 1000);
}


$(document).on('click','.swt-closeIcon',function () {
    $('.swt-alertMessage').hide();
});


$(document).on('click','.swt-your-answer-close',function () {
    $('.swt-answer-analysis').hide();
});


$(document).on('click','.swt-check-answer',function () {
    var text = $('.summarizeTextDescription-output').val();
    $('.swt-your-answer-content').html(text);
    $('.swt-answer-analysis').show();
});


$(document).on('click','.swt-save-my-answer',function () {
    var question  = $('.summarizeTextDescription').html();
    var textToWrite = $('.summarizeTextDescription-output').val();
    textToWrite = question + "\n\n\n\n" + textToWrite 
    var textFileAsBlob = new Blob([textToWrite], {type:'text/plain'});
    var fileNameToSaveAs = "OCE-Summarize_Written_Text";

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


$(document).on('click','.swt-stop-my-answer', function () {
     clearInterval(interval);
     $('.summarizeTextDescription-output').prop("readonly",true);
     $('.swt-check-answer').click();
     $('.swt-control').css({"visibility":"visible"});
})



/*Pagination*/


$(document).on('click','.swt-common-pagination',function () {
    console.log("Clicked here SWT pg1 ::::::::::::::::::::")
    var pageNumber = $(this).attr('data-page-number');
    summarizeWrittenText.getRenderDetails(pageNumber,"","");
    $('.swt-common-pagination').removeClass('active');
    $(this).addClass('active');
});


summarizeWrittenText.getRenderDetails = function (pageNumber,page,pageId) {
    console.log("Clicked here SWT pg2 ::::::::::::::::::::"+pageNumber+":::page :::"+page+":::::page id ::"+pageId);
    clearTimeout(timeOut);
    clearInterval(interval);
    clearAll();
    $.ajax({
        method: "POST",
        data:{
            pageNumber:pageNumber,
            pageId:pageId,
            page:page
        },
        url: "../../ajax/renderWriting/renderSummarizeWrittenText.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.swt-render-div').html(json.details);
            if(json.pagination!=null && json.pagination != "" ){
                $('.swt-pagination-div').html(json.pagination);
            }
            var display = document.querySelector('.time-counter-content');
            recordBeginForSummarizeSpokenText(numberOfMinutesSWT,display);

        }
    })
}

$(document).on('click','.swt-next',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.swt-next').attr('data-page');
    summarizeWrittenText.getRenderDetails("",page,pageId);
})



$(document).on('click','.swt-previous',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.swt-previous').attr('data-page');
    summarizeWrittenText.getRenderDetails("",page,pageId);
})


$(document).on('click','.swt-try-again',function () {
    var pageNumber = $('#cp-style.active.swt-common-pagination').attr('data-page-number');
    summarizeWrittenText.getRenderDetails(pageNumber,"","");
})






