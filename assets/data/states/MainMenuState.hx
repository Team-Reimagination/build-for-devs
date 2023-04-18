import sys.net.Socket;
import openfl.net.Socket;
var socket = new Socket();
function create() {
    socket.connect("127.0.0.1", 5000);
    socket.writeUTF("hi its me codename engine!");
    socket.flush();
}
function update(elapsed) {
    if (socket.bytesAvailable != 0) trace(socket.readUTF());
}