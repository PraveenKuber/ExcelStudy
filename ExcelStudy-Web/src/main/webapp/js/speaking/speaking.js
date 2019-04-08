/**
 * Created by praveen on 27/2/19.
 */

var speaking  = {};

var interval;
var timeOut;

$('.read_aloud').click(function (event) {
    clearTimeout(timeOut);
    clearInterval(interval);
    /*ajax*/
    $.ajax({
        method: "POST",
        url: "../../ajax/speaking/getReadAloudDetails.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            console.log("Speaking success ::::::::::"+json.details)
            $('.main-panel').html(json.details);
            var recordableTime = parseInt(json.recordableTime);
            //speaking.countDownDiv(10);
             var numberOfSeconds = 10,
                display = document.querySelector('.current-status');
                startTimerForReadAloud(numberOfSeconds, display,recordableTime);
        }
    });

})


function startTimerForReadAloud(duration, display,recordableTime) {
    var timer = duration, seconds;
    interval = setInterval(function () {
        seconds = parseInt(timer % 60, 10);
        seconds = seconds < 10 ? "0" + seconds : seconds;
        display.textContent = "Record will start in "+seconds;
        if (--timer < 0) {
            timer = duration;
        }
        console.log("Coming :::::::::::")
        if(seconds==0){

            /*Recording started*/
            $('#record-speaking-details').click();

            clearInterval(interval);
            $('.current-status').text("completed");

            $(".loader").trigger('play');
            $('.readAloud').delay(1000).queue(function () {
                $(this).css("transition","width "+recordableTime+"s ease-in-out");
                $(this).css('width', '103%')
            });

            /*Show after completion*/
           timeOut  = setTimeout(function(){
                $('.ra-alertMessage').show();
                $('.ra-control-section').show();
            },(recordableTime*1000));
            
            
        }
    }, 1000);
}

var speechRecognizer = new webkitSpeechRecognition();
speechRecognizer.continuous = true;
speechRecognizer.interimResults = true;
speechRecognizer.lang = 'en-IN';


$(document).on("click", "#record-speaking-details", function () {
    console.log("Start ::::::::::")
    if('webkitSpeechRecognition' in window){
        console.log("inside ::::::::::")
        $('#recordForX').click();
        var speechRecognizer = new webkitSpeechRecognition();
        speechRecognizer.continuous = true;
        speechRecognizer.interimResults = true;
        speechRecognizer.lang = 'en-IN';
        speechRecognizer.start();

        var finalTranscripts = '';

        speechRecognizer.onresult = function(event){
            var interimTranscripts = '';
            for(var i = event.resultIndex; i < event.results.length; i++){
                var transcript = event.results[i][0].transcript;
                transcript.replace("\n", "<br>");
                if(event.results[i].isFinal){
                    finalTranscripts += transcript;
                }else{
                    interimTranscripts += transcript;
                }
            }
            /*r.innerHTML = finalTranscripts + '<span style="color:#999">' + interimTranscripts + '</span>';*/
            $('.speechToTextArea').text(finalTranscripts + interimTranscripts);
        };
        speechRecognizer.onerror = function (event) {
        };
        

    }else{
        $('.speechToTextArea').text("Your browser is not supported. If google chrome, please upgrade!");
    }
})


$(document).on('click', ".stop-ra", function () {
    console.log("Clicked for stop in RA");
    speechRecognizerRS.abort();
});




function getFormattedListForMatching(input){
    var list1 = input.split(/(\s+)/);
    var formatedList = [];
    for(i=0;i<list1.length;i++){
        var trimmedData  = list1[i];
        trimmedData = trimmedData.trim();
        trimmedData = trimmedData.replace(/,|\./ig,"");
        if(trimmedData.length != 0){
            formatedList.push(trimmedData);

        }
    }
    return formatedList;
}




$(document).on('click','.compare', function(){
    $('.ra-compare-module').show();
    $('.compare-section').html("");
    var inputText = $('.speaking-description').text();
    console.log("Input text ::::::::::"+inputText);
    var inputList = getFormattedListForMatching(inputText);
    //var speechText = "Domestication was an evolutionary, rater than a political developmnt";
    var speechText = $('.speechToTextArea').text();
    var speechTextList = getFormattedListForMatching(speechText);
    console.log("Data is ::::::::::::::"+inputList.length+":::::::::: Speech text length ::::::::"+speechTextList.length);
    var finalText;
    var mainDiv = document.createElement("div");
    mainDiv.setAttribute("class","test");
    var testMain = " ";
    for(var i=0;i<inputList.length;i++){
        if(speechTextList[i]!= undefined){
            var innerHtmlBuilder;
            if(inputList[i].toLowerCase() != speechTextList[i].toLowerCase() ){
                innerHtmlBuilder = document.createElement("span");
                innerHtmlBuilder.setAttribute("class","color");
                mainDiv.appendChild(innerHtmlBuilder);
                testMain = testMain + "<span class='not-matched'>"+speechTextList[i]+"</span>"+" ";
                console.log("Not matched ::::::::::"+inputList[i]+"::::::::;"+speechTextList[i]);
            }else{
                testMain = testMain + "<span class='matched'>"+inputList[i]+"</span>"+" ";
                innerHtmlBuilder = document.createElement("span");
                innerHtmlBuilder.setAttribute("class","color-not");
                mainDiv.appendChild(innerHtmlBuilder);
                console.log("Matched ::::::::"+inputList[i]+":::::::"+speechTextList[i])
            }
        }
    }
    $('.compare-section').append(testMain)
    console.log("Main div is :::::::"+testMain)
});


$(document).on('click', ".stop", function () {
    console.log("Clicked ::::::::::");
    speechRecognizer.abort();
});



$(document).on('click','.ra-close-icon',function () {
    console.log("Clicked ::::::::: in RA")
    $('.ra-alertMessage').hide();
})



$(document).on('click','.close-analysis-ra',function () {
    console.log("Clicked ::::::::: in RA")
    $('.ra-compare-module').hide();
})



/*Pagination*/


$(document).on('click','.ra-common-pagination',function () {
    console.log("Clicked here RA pg1 ::::::::::::::::::::")
    var pageNumber = $(this).attr('data-page-number');
    speaking.getRenderDetails(pageNumber,"","");
    $('.ra-common-pagination').removeClass('active');
    $(this).addClass('active');
});


speaking.getRenderDetails = function (pageNumber,page,pageId) {
    console.log("Clicked here RA pg2 ::::::::::::::::::::");
    clearTimeout(timeOut);
    clearInterval(interval);
    $.ajax({
        method: "POST",
        data:{
            pageNumber:pageNumber,
            pageId:pageId,
            page:page
        },
        url: "../../ajax/renderSpeaking/renderReadAloudDetails.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            var recordTime = parseInt(json.recordableTime);
            $('.ra-render-div').html(json.details);
            if(json.pagination!=null && json.pagination != "" ){
                $('.ra-pagination-div').html(json.pagination);
            }
            var numberOfSeconds = 10,
                display = document.querySelector('.current-status');
            startTimerForReadAloud(numberOfSeconds, display,recordTime);
        }
    })
}

$(document).on('click','.ra-next',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.ra-next').attr('data-page');
    speaking.getRenderDetails("",page,pageId);
})



$(document).on('click','.ra-previous',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.ra-previous').attr('data-page');
    speaking.getRenderDetails("",page,pageId);
})


$(document).on('click','.reset',function () {
    var pageNumber = $('#cp-style.active').attr('data-page-number');
    speaking.getRenderDetails(pageNumber,"","");
})








