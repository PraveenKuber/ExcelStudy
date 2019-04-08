/**
 * Created by praveen on 24/2/19.
 */


var listening = {};



$('.summarize_spoken_text').click(function () {
    /*ajax*/
    $.ajax({
        method: "POST",
        url: "../../ajax/listening/getSummarizeSpokenTextDetails.jsp",
        success: function (data) {
            var json = JSON.parse(data.trim());
            console.log("Log is ::::::::::"+json.details)
            $('.main-panel').html(json.details);
        }
    });
    
})