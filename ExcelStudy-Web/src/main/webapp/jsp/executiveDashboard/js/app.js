function restore(){
  $("#record, #live").removeClass("disabled");
  $("#pause").replaceWith('<a class="button one" id="pause">Pause</a>');
  $(".one").addClass("disabled");
  Fr.voice.stop();
}

function makeWaveform(){
  var analyser = Fr.voice.recorder.analyser;

  var bufferLength = analyser.frequencyBinCount;
  var dataArray = new Uint8Array(bufferLength);

  /**
   * The Waveform canvas
   */
  var WIDTH = 500,
      HEIGHT = 200;

  var canvasCtx = $("#level")[0].getContext("2d");
  canvasCtx.clearRect(0, 0, WIDTH, HEIGHT);

  function draw() {
    var drawVisual = requestAnimationFrame(draw);

    analyser.getByteTimeDomainData(dataArray);

    canvasCtx.fillStyle = 'rgb(200, 200, 200)';
    canvasCtx.fillRect(0, 0, WIDTH, HEIGHT);
    canvasCtx.lineWidth = 2;
    canvasCtx.strokeStyle = 'rgb(0, 0, 0)';

    canvasCtx.beginPath();

    var sliceWidth = WIDTH * 1.0 / bufferLength;
    var x = 0;
    for(var i = 0; i < bufferLength; i++) {
      var v = dataArray[i] / 128.0;
      var y = v * HEIGHT/2;

      if(i === 0) {
        canvasCtx.moveTo(x, y);
      } else {
        canvasCtx.lineTo(x, y);
      }

      x += sliceWidth;
    }
    canvasCtx.lineTo(WIDTH, HEIGHT/2);
    canvasCtx.stroke();
  };
  draw();
}

/*Start*/






/*End*/

$(document).ready(function(){
  $(document).on("click", "#record:not(.disabled)", function(){
    Fr.voice.record($("#live").is(":checked"), function(){
      $(".recordButton").addClass("disabled");
      $("#live").addClass("disabled");
      $(".one").removeClass("disabled");

      makeWaveform();
    });
  });

  $(document).on("click", "#recordFor5:not(.disabled)", function(){
    Fr.voice.record($("#live").is(":checked"), function(){
      $(".recordButton").addClass("disabled");

      $("#live").addClass("disabled");
      $(".one").removeClass("disabled");

      makeWaveform();
    });

    Fr.voice.stopRecordingAfter(5000, function(){
      alert("Recording stopped after 5 seconds");
    });
  });


  $(document).on("click", "#recordForX:not(.disabled)", function(){
    console.log("Calling ::::::::::::::")
    var xValue = $('#recordForX').data('number-of-seconds');
    console.log("Number fo seconds in RA::::::"+xValue);
    Fr.voice.record($("#live").is(":checked"), function(){
      if(xValue != null || xValue != undefined){
        xValue = (xValue * 1000);
      }
      $(".recordButton").addClass("disabled");

      $("#live").addClass("disabled");
      $(".one").removeClass("disabled");
      makeWaveform();
    });
      
      xValue = parseInt(xValue*1000);  
      console.log("Calling :::::::::"+xValue);
       Fr.voice.stopRecordingAfter(xValue, function(){
        $('.stop-ra').click();
    });
  });

  


  
    


    $(document).on("click", "#recordVoice", function(){
        console.log("Calling ::::::::::::::")
        var xValue = $('#recordForX').data('number-of-seconds');
        Fr.voice.stopRecordingAfter(5000, function(){
        });
    });
    
    
    
  
  

  $(document).on("click", "#pause:not(.disabled)", function(){
    if($(this).hasClass("resume")){
      Fr.voice.resume();
      $(this).replaceWith('<a class="button one" id="pause">Pause</a>');
    }else{
      Fr.voice.pause();
      $(this).replaceWith('<a class="button one resume" id="pause">Resume</a>');
    }
  });

  $(document).on("click", "#stop:not(.disabled)", function(){
    restore();
  });

  $(document).on("click", "#stop", function(){
    console.log("Clicked ::::::::");
    restore();
  });

  
  $(document).on("click", "#play", function(){
    console.log("Clicked ::::::::::")
    $('#audio').show();
    $('#audio').css({"display":"block"});
    $("#play").css({"pointer-events":"none","cursor":"not-allowed"});
    $('.loader').css({"visibility":"visible"});
    if($(this).parent().data("type") === "mp3"){
      Fr.voice.exportMP3(function(url){
        $("#audio").attr("src", url);
        $("#audio")[0].play();
      }, "URL");
    }else{
      Fr.voice.export(function(url){
        $("#audio").attr("src", url);
        $("#audio")[0].play();
      }, "URL");
    }
    restore();
  });
    
    

  $(document).on("click", "#download", function(){
    if($(this).parent().data("type") === "mp3"){
      Fr.voice.exportMP3(function(url){
        $("<a href='" + url + "' download='MyRecording.mp3'></a>")[0].click();
      }, "URL");
    }else{
      Fr.voice.export(function(url){
        $("<a href='" + url + "' download='MyRecording.wav'></a>")[0].click();
      }, "URL");
    }
    restore();
  });

  $(document).on("click", "#base64:not(.disabled)", function(){
    if($(this).parent().data("type") === "mp3"){
      Fr.voice.exportMP3(function(url){
        console.log("Here is the base64 URL : " + url);
        alert("Check the web console for the URL");

        $("<a href='"+ url +"' target='_blank'></a>")[0].click();
      }, "base64");
    }else{
      Fr.voice.export(function(url){
        console.log("Here is the base64 URL : " + url);
        alert("Check the web console for the URL");

        $("<a href='"+ url +"' target='_blank'></a>")[0].click();
      }, "base64");
    }
    restore();
  });

  $(document).on("click", "#save:not(.disabled)", function(){
    function upload(blob){
      var formData = new FormData();
      formData.append('file', blob);

      $.ajax({
        url: "upload.php",
        type: 'POST',
        data: formData,
        contentType: false,
        processData: false,
        success: function(url) {
          $("#audio").attr("src", url);
          $("#audio")[0].play();
          alert("Saved In Server. See audio element's src for URL");
        }
      });
    }
    if($(this).parent().data("type") === "mp3"){
      Fr.voice.exportMP3(upload, "blob");
    }else{
      Fr.voice.export(upload, "blob");
    }
    restore();
  });
});


/*DI*/


$(document).on("click", ".record-di", function(){
  console.log("Calling  through DI ::::::::::::::")
  var xValue = $('.record-di').data('record-time');
  xValue = parseInt(xValue*1000);
  console.log("Calling :::::::::"+xValue);
  /*record*/
  Fr.voice.record($("#live").is(":checked"), function(){
    if(xValue != null || xValue != undefined){
      xValue = (xValue * 1000);
    }
  });
  /*Stop*/
  Fr.voice.stopRecordingAfter(xValue, function(){
    $('.di-alertMessage').hide();
    $('.stop-di').click();
  });
});



$(document).on("click", ".di-recorded-play", function(){
  $('#di-audio').show();
  $("#di-audio").css({"display":"block"});
  /*,"pointer-events":"none"*/
  $('.di-recorded-play').css({"pointer-events":"none","cursor":"not-allowed"});
  $('.loader').css({"visibility":"visible"});
    Fr.voice.exportMP3(function(url){
      $("#di-audio").attr("src", url);
      $("#di-audio")[0].play();
    }, "URL");
  restore();
});


$(document).on("click", ".di-recorded-download", function(){
    Fr.voice.exportMP3(function(url){
      $("<a href='" + url + "' download='MyRecording_DI.mp3'></a>")[0].click();
    }, "URL");
  restore();
});



/*RL*/


$(document).on("click", ".record-audio-retellLecture", function(){
  console.log("Calling  through RL ::::::::::::::")
  var xValue = $('.record-audio-retellLecture').attr('record-time');
  xValue = parseInt(xValue*1000);
  console.log("Calling :::::::::"+xValue);
  /*record*/
  Fr.voice.record($("#live").is(":checked"), function(){
    if(xValue != null || xValue != undefined){
      xValue = (xValue * 1000);
    }
  });
  /*Stop*/
  Fr.voice.stopRecordingAfter(xValue, function(){
    console.log("Stopped in RL :::::");
    $('.stop-audio-retellLecture').click();
  });
});





$(document).on("click", ".rl-play", function(){
  $('#recorded-retellLecture').show();
  $("#recorded-retellLecture").css({"display":"block"});
  /*,"pointer-events":"none"*/
  $('.rl-play').css({"pointer-events":"none","cursor":"not-allowed"})
  $('.loader').css({"visibility":"visible"});
  Fr.voice.exportMP3(function(url){
    $("#recorded-retellLecture").attr("src", url);
    $("#recorded-retellLecture")[0].play();
  }, "URL");
  restore();
});

$(document).on("click", ".rl-download", function(){
  Fr.voice.exportMP3(function(url){
    $("<a href='" + url + "' download='MyRecording_RL.mp3'></a>")[0].click();
  }, "URL");
  restore();
});


/*End of RL*/