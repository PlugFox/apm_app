import 'dart:async';
import 'dart:developer';
import 'dart:isolate';
import 'dart:typed_data' as td;

import 'package:crypto/crypto.dart';
import 'package:entity/entity.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'generated/apm.pb.dart' as generated;
import 'message.dart';

class Server {
  Server();

  Isolate? _isolate;
  Future<void> start<Payload>({required ServerOptions<Payload> options}) async {
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = await Isolate.spawn<ServerOptions<Payload>>(
      _worker,
      options,
      errorsAreFatal: false,
      debugName: 'server',
    );
  }
}

class ServerOptions<Payload> {
  ServerOptions({
    required this.payload,
    required this.handler,
    this.address = 'localhost',
    this.port = 38383,
  });

  final String address;
  final int port;
  final Payload payload;
  final void Function(Payload payload, Stream<ProjectEntity> entities) handler;
}

void _worker<Payload>(ServerOptions<Payload> options) => runZonedGuarded<void>(
      () async {
        final controller = StreamController<ProjectEntity>();
        options.handler(options.payload, controller.stream);
        final handler = webSocketHandler((WebSocketChannel webSocket) {
          webSocket.stream.listen(
            (message) {
              if (message is! td.Uint8List) return; // Ignore non-Uint8List messages
              final hash = sha1.convert(message).bytes; // Hash message to confirm receipt
              webSocket.sink.add(hash); // Confirm receipt of message by sending hash back to client
              final entity = _decodeEntity(message);
              if (entity == null) return;
              controller.add(entity);
            },
            cancelOnError: false,
          );
        });

        await shelf_io.serve(handler, options.address, options.port).then<void>((server) {
          log(
            'Serving at ws://${server.address.host}:${server.port}',
            level: 100,
            name: 'server',
          );
        }).onError((error, stackTrace) {
          log(
            'Fatal error in server isolate',
            level: 1000,
            name: 'server',
            error: error,
            stackTrace: stackTrace,
          );
          Isolate.current.kill();
        });
      },
      (error, stack) => log(
        'Error in server isolate',
        level: 700,
        name: 'server',
        error: error,
        stackTrace: stack,
      ),
    );

ProjectEntity? _decodeEntity(td.Uint8List bytes) {
  try {
    final message = const MessageDecoder().convert(bytes);
    if (message is generated.Log) {
      return Log(
        id: -1,
        projectId: message.project,
        spanId: message.span,
        event: message.event,
        timestamp: DateTime.fromMillisecondsSinceEpoch(message.time * 1000),
        name: message.name,
        level: message.level,
        stackTrace: message.stack,
        tags: message.tags,
        breadcrumbs: message.breadcrumbs,
      );
    } else if (message is generated.Transaction) {
      return Span(
        id: message.id,
        projectId: message.project,
        operation: message.operation,
      );
    } else {
      return null;
    }
  } catch (error, stackTrace) {
    log(
      'Error decoding message',
      level: 600,
      name: 'server',
      error: error,
      stackTrace: stackTrace,
    );
    return null;
  }
}
