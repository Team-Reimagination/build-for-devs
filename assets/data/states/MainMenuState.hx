import sys.net.Socket;
//import openfl.net.Socket;
//var socket = new Socket();
function create() {
    //socket.connect("192.168.1.6", 5000);
    //socket.writeUTF("store;:iamanfnffan;:password=someonethatiusedtoknow;:encrypted");
    //socket.flush();
    //socket.writeUTF("checkencrypted;:iamanfnffan;:password=someonethatiusedtoknow");
}
function update(elapsed) {
    //if (socket.bytesAvailable != 0) trace(socket.readUTFBytes(socket.bytesAvailable));
    if (FlxG.keys.justPressed.D) FlxG.switchStates(new UIState());
}