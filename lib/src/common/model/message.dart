import 'dart:convert';
import 'dart:typed_data' as td;

import 'package:meta/meta.dart';
import 'package:protobuf/protobuf.dart' as pb;

import 'generated/apm.pb.dart' as generated;

/// Codec for messages
@internal
final $messagesCodec = MessageCodec();

/// Codec for messages
@internal
class MessageCodec extends Codec<pb.GeneratedMessage, td.Uint8List> {
  @override
  final Converter<td.Uint8List, pb.GeneratedMessage> decoder = const MessageDecoder();

  @override
  final Converter<pb.GeneratedMessage, td.Uint8List> encoder = const MessageEncoder();
}

/// Decoder for messages
@internal
class MessageDecoder extends Converter<td.Uint8List, pb.GeneratedMessage> {
  /// A decoder for messages
  const MessageDecoder();

  @override
  pb.GeneratedMessage convert(td.Uint8List input) {
    if (input.isEmpty) throw ArgumentError('Invalid message');
    final leadingLength = input[0];
    if (leadingLength > input.length) throw ArgumentError('Invalid message');
    final leading = input.sublist(0, leadingLength);
    if (leading[1] != 1) throw ArgumentError('Invalid encoded model');
    switch (leading[2]) {
      case 1:
        return generated.Log.fromBuffer(input.sublist(leadingLength));
      case 2:
        return generated.Transaction.fromBuffer(input.sublist(leadingLength));
      default:
        throw ArgumentError('Invalid message type');
    }
  }
}

/// An encoder for messages
@internal
class MessageEncoder extends Converter<pb.GeneratedMessage, td.Uint8List> {
  /// A encoder for messages
  const MessageEncoder();

  @override
  td.Uint8List convert(pb.GeneratedMessage input) {
    final writer = pb.CodedBufferWriter();
    final leading = td.Uint8List(16);
    leading[0] = 16; // Leading offset size (16 bytes)
    leading[1] = 1; // Encoded model (1)
    if (input is generated.Log) {
      leading[2] = 1; // Log (1)
    } else if (input is generated.Transaction) {
      leading[2] = 2; // Transaction (2)
    }
    writer.writeRawBytes(td.Uint8List.fromList(leading));
    input.writeToCodedBufferWriter(writer);
    return writer.toBuffer();
  }
}
