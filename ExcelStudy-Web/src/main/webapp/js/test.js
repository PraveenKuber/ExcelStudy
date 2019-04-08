/**
 * Created by praveen on 25/2/19.
 */


var test = {};

test.testSpeechToText = function () {
    var speechtext=$("#speech").val();
    var elem = document.getElementById("test");
    elem.value = speechtext;
    var notification="\"<span style=\"color:#F00; text-transform:uppercase;\">"+  speechtext + "</span>\" <br />*Is this what you said???";
    notify(notification);
}