/**
 * Created by praveen on 8/4/19.
 */

var writeEssay = {};
var interval ;
var timeOut;
var numberOfMinutes = 20;


$('.writeEssay').click(function (event) {
    clearInterval(interval);
    clearTimeout(timeOut);
    clearAll();
    /*ajax*/
    $.ajax({
        method: "POST",
        url: "../../ajax/writing/getWriteEssayDetails.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.main-panel').html(json.details);
            var display = document.querySelector('.we-time-counter-content');
            recordBeginForWriteEssay(numberOfMinutes,display);
        }

    });

})


writeEssay.getInputTextCount = function (e) {
    eventKeyCode = window.event ? event.keyCode : event.which;
    if(eventKeyCode == 32){
        var textValue = $('.write-essay-output').val();
        var textValueCount = textValue.split(" ");
        var count = textValueCount.length;
        $('.we-word-counter-content').text(count-1);
    }
}

function recordBeginForWriteEssay(duration, display) {
    var next = new Date();
    next = next.setMinutes(next.getMinutes()+duration);
    interval = setInterval(function () {
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
                $('.write-essay-output').prop("readonly",true);
                $('.we-alertMessage').show();
                $('.we-check-answer').click();
                //$('.we-answer-analysis').show();
                $('.we-control').css({"visibility":"visible"});
                
            }
        }
    }, 1000);
}



$(document).on('click','.we-closeIcon',function () {
    $('.we-alertMessage').hide();
});


$(document).on('click','.we-your-answer-close',function () {
    $('.we-answer-analysis').hide();
});



$(document).on('click','.we-check-answer',function () {
    var text = $('.write-essay-output').val();
    $('.we-your-answer-content').html(text);
    $('.we-answer-analysis').show();
});




$(document).on('click','.we-save-my-answer',function () {
    var question = $('.writeEssayDescription').html();
    var textToWrite = $('.write-essay-output').val();
    textToWrite = question + "\n\n\n\n"+textToWrite;
    var textFileAsBlob = new Blob([textToWrite], {type:'text/plain'});
    var fileNameToSaveAs = "OCE-Write_Essay";

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

$(document).on('click','.we-stop-my-answer', function () {
    clearInterval(interval);
    $('.write-essay-output').prop("readonly",true);
    $('.we-control').css({"visibility":"visible"});
})


/*Pagination*/


$(document).on('click','.we-common-pagination',function () {
    console.log("Clicked here WE pg1 ::::::::::::::::::::")
    var pageNumber = $(this).attr('data-page-number');
    writeEssay.getRenderDetails(pageNumber,"","");
    $('.we-common-pagination').removeClass('active');
    $(this).addClass('active');
});


writeEssay.getRenderDetails = function (pageNumber,page,pageId) {
    console.log("Clicked here WE pg2 ::::::::::::::::::::"+pageNumber+":::page :::"+page+":::::page id ::"+pageId);
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
        url: "../../ajax/renderWriting/renderWriteEssay.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.we-render-div').html(json.details);
            if(json.pagination!=null && json.pagination != "" ){
                $('.we-pagination-div').html(json.pagination);
            }
            var display = document.querySelector('.we-time-counter-content');
            recordBeginForWriteEssay(numberOfMinutes,display);

        }
    })
}

$(document).on('click','.we-next',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.we-next').attr('data-page');
    writeEssay.getRenderDetails("",page,pageId);
})



$(document).on('click','.we-previous',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.we-previous').attr('data-page');
    writeEssay.getRenderDetails("",page,pageId);
})


$(document).on('click','.we-try-again',function () {
    var pageNumber = $('#cp-style.active.we-common-pagination').attr('data-page-number');
    writeEssay.getRenderDetails(pageNumber,"","");
})





















