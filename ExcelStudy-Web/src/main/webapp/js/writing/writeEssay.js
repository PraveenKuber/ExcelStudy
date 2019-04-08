/**
 * Created by praveen on 8/4/19.
 */

var writeEssay = {};
var interval ;
var timeOut;


$('.writeEssay').click(function (event) {
    clearInterval(interval);
    clearTimeout(timeOut);
    /*ajax*/
    $.ajax({
        method: "POST",
        url: "../../ajax/writing/getWriteEssayDetails.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            $('.main-panel').html(json.details);
            //var display = document.querySelector('.time-counter-content');
            //var numberOfMinutes = 1;
            //recordBeginForSummarizeSpokenText(numberOfMinutes,display);
        }

    });

})


writeEssay.getInputTextCount = function (e) {
    eventKeyCode = window.event ? event.keyCode : event.which;
    if(eventKeyCode == 32){
        var textValue = $('.write-essay-output').val();
        var textValueCount = textValue.split(" ");
        var count = textValueCount.length;
        $('.we-word-counter').text(count-1);
    }
}
