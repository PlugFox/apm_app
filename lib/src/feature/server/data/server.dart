import 'package:crypto/crypto.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Server {
  Future<void> start() async {
    var handler = webSocketHandler((WebSocketChannel webSocket) {
      webSocket.stream.listen((message) {
        if (message is! List<int>) return;
        final hash = sha1.convert(message).bytes;
        webSocket.sink.add(hash);
        print('Hashed ${message.length} bytes to ${hash.length} bytes');
      });
    });

    await shelf_io.serve(handler, 'localhost', 38383).then<void>((server) {
      print('Serving at ws://${server.address.host}:${server.port}');
    });
  }
}
