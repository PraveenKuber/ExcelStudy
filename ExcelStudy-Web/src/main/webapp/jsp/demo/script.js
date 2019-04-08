/**
 * Created by praveen on 26/2/19.
 */



var mic, recorder, soundFile;
//setup2();
function setup() {
    // create an audio in
    mic = new p5.AudioIn();

    // users must manually enable their browser microphone for recording to work properly!
    mic.start();

    // create a sound recorder
    recorder = new p5.SoundRecorder();

    // connect the mic to the recorder
    recorder.setInput(mic);

    // create an empty sound file that we will use to playback the recording
    soundFile = new p5.SoundFile();
}

function recordvoice() {
    // use the '.enabled' boolean to make sure user enabled the mic (otherwise we'd record silence)
    if (mic.enabled) {

        // Tell recorder to record to a p5.SoundFile which we will use for playback
        recorder.record(soundFile);
        console.log('recording...');

    }

}
function recordstop() {

    recorder.stop(); // stop recorder, and send the result to soundFile
    console.log('record stop');

}
function playrecord() {
    if ( soundFile.isPlaying() ) { // .isPlaying() returns a boolean
        soundFile.stop();
        $("#playmyrecordbutton").text("My record \u25B6");//play
    } else {
        soundFile.play();
        $("#playmyrecordbutton").text("My record \u25fc");//stop
    }

    //soundFile.play(); // play the result!

    console.log('record play');
}
function saverecord() {
    var myrecordname="ptestudy_net_ra_1.wav";
    saveSound(soundFile, myrecordname); //'mySound.wav' save file
    console.log('record save');
}

