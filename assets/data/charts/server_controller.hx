import sys.net.Socket;
import openfl.net.Socket;
import funkin.system.Controls;

var waitForOpponent = true;
var socket = new Socket();
function postCreate() {
    socket.connect("127.0.0.1", 5000);
    socket.writeUTF("Connected");
    camHUD.fade(0x85000000, 0.0001);
    for (i in strumLines)
        if (i.cpu){
            i.cpu = false;
            i.controls = new Controls();
        }
}
function postUpdate(elapsed) {
    if (socket.bytesAvailable != 0){
        if (!waitForOpponent) {
            var note = socket.readUTF().split(",");
            strumLines[Std.parseInt(note[0])].notes.forEach(function(noter) {
                if (noter.strumTime == Std.parseFloat(note[1])){
                    noter.strumTime = noter.strumTime + (Conductor.songPosition - note[2]);
                    goodNoteHit(strumLines[Std.parseInt(note[0])], noter); 
                }
            });  
        }
        else if (waitForOpponent && socket.readUTF() == "Connected") {
            waitForOpponent = false;
            socket.writeUTF("Connected");
            startCountdown();
            camHUD.fade(0x85000000, 0.1, true);
        }
        else if (socket.readUTF() == "Pause") pauseGame(); 
    }
}
function onGamePause(event) socket.writeUTF("Pause");
function onStartCountdown(event) if (waitForOpponent) event.cancel();

function onNoteHit(event) {
    socket.writeUTF(strumLines.indexOf(event.note.strumLine) + ',' + event.note.strumTime + ',' + Conductor.songPosition);
    socket.flush();
}