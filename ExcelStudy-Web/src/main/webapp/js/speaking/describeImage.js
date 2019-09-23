/**
 * Created by praveen on 22/3/19.
 */

var describeImage = {};

var interval;
var timeOut;

$('.describe_image').click(function (event) {
    clearInterval(interval);
    clearTimeout(timeOut);
    clearInterval(processBarId);
    clearAll();
    /*ajax*/
    $.ajax({
        method: "POST",
        url: "../../ajax/speaking/getDescribeImageDetails.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.main-panel').html(json.details);
            //var descriptionTime = 400
            var descriptionTime = $('.record-di').attr('data-record-time');
            var numberOfSeconds = 25,
                display = document.querySelector('.di-status');
            startTimerForDescribeImage(numberOfSeconds, display,descriptionTime);
        }

    });

})



function startTimerForDescribeImage(duration, display,descriptionTime) {
    var timer = duration, seconds;
    interval = setInterval(function () {
        seconds = parseInt(timer/*timer % 60, 10*/);
        seconds = seconds < 10 ? "0" + seconds : seconds;
        display.textContent = "Record will start in "+seconds;
        if (--timer < 0) {
            timer = duration;
        }
        if(seconds==0){
            clearInterval(interval);
            $('.di-status').text("In progress");

            /*Recording initiation*/
            $('.record-di').click();

            $(".loader").trigger('play');
            
           /* $('.describeImage').delay(1000).queue(function () {
                $(this).css("transition","width "+descriptionTime+"s ease-in-out");
                $(this).css('width', '103%')
            });*/
            processProgressBar(descriptionTime);

            /*Show div after things done*/
            timeOut = setTimeout(function () {
                console.log("Complete after DI")
                $('.di-alertMessage').show();
                $('.footer-div').show();
            },(descriptionTime*1000));
            /*end*/
        }
    }, 1000);
}

/*New changes */


var processBarId;
function  processProgressBar(recordableTime) {
    console.log("Coming for DI ::::::::::::::::");
    var progressBarWidth = 0;
    var processWidth = 103/recordableTime;
    processBarId = setInterval(moveProcessBar,1000);
    function moveProcessBar() {
        if (progressBarWidth >= 103) {
            $('.di-status').text("Completed");
            clearInterval(processBarId);
        } else {
            $('.di-status').text("In progress");
            progressBarWidth = progressBarWidth + processWidth;
            $('.describeImage').css({"width":progressBarWidth+"%"})
        }
    }
}

function  stopProcessBar() {
    clearInterval(processBarId);
}

$(document).on('click','.di-stop-my-answer',function () {
    $('.di-footer').show();
    $('.di-status').html("Completed");
    
    clearInterval(interval);
    clearTimeout(timeOut);
    clearInterval(processBarId);
    clearAll();
    
});


/*End*/




$(document).on('click','.di-close-icon',function () {
    $('.di-alertMessage').hide();
    $('#stop').click();
})








/*Pagination*/

/*Pagination*/


$(document).on('click','.di-common-pagination',function () {
    console.log("Clicked here DI pg1 ::::::::::::::::::::")
    var pageNumber = $(this).attr('data-page-number');
    describeImage.getRenderDetails(pageNumber,"","");
    $('.di-common-pagination').removeClass('active');
    $(this).addClass('active');
});


describeImage.getRenderDetails = function (pageNumber,page,pageId) {
    console.log("Clicked here DI pg2 ::::::::::::::::::::")
    clearTimeout(timeOut);
    clearInterval(interval);
    clearInterval(processBarId);
    clearAll();
    $.ajax({
        method: "POST",
        data:{
            pageNumber:pageNumber,
            pageId:pageId,
            page:page
        },
        url: "../../ajax/renderSpeaking/renderDescribeImage.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            console.log("Data in DI ::::::::::"+json)
            var recordTime = parseInt(json.recordAbleTime);
            $('.di-render-div').html(json.details);
            if(json.pagination!=null && json.pagination != "" ){
                $('.di-pagination-div').html(json.pagination);
            }
            var descriptionTime = $('.record-di').attr('data-record-time');
            var numberOfSeconds = 25,
                display = document.querySelector('.di-status');
            startTimerForDescribeImage(numberOfSeconds, display,descriptionTime);
        }
    })
}

$(document).on('click','.di-next',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.di-next').attr('data-page');
    describeImage.getRenderDetails("",page,pageId);
})



$(document).on('click','.di-previous',function () {
    var pageId = $(this).attr('data-page-id');
    var page = $('.di-previous').attr('data-page');
    describeImage.getRenderDetails("",page,pageId);
})


$(document).on('click','.di-recorded-tryAgain',function () {
    var pageNumber = $('#cp-style.active').attr('data-page-number');
    describeImage.getRenderDetails(pageNumber,"","");
})







