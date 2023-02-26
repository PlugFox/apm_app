import 'package:app/src/common/model/generated/apm.pb.dart' as generated;
import 'package:app/src/common/model/message.dart';
import 'package:flutter_test/flutter_test.dart';

void main() => group('message', () {
      test('convert_log', () {
        const project = 'project';
        const event = 'hello-world';
        final time = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        const name = 'name';
        const level = 700;
        final stackTrace = StackTrace.current;
        final tags = <String, String>{'key': 'value'};
        final breadcrumbs = <String>['1', '2', '3'];
        const transactionId = 'transactionId';
        final log = generated.Log(
          project: project,
          event: event,
          time: time,
          name: name,
          level: level,
          stack: stackTrace.toString(),
          tags: tags,
          breadcrumbs: breadcrumbs,
          span: transactionId,
        );
        final bytes = $messagesCodec.encode(log);
        expect(
            $messagesCodec.decode(bytes),
            isA<generated.Log>().having(
              (l) => l.level,
              'log.level',
              equals(level),
            ));
      });

      test('convert_transaction', () {
        const project = 'project';
        const operation = 'operation';
        const id = 'id';
        const description = 'description';
        final transaction = generated.Transaction(
          project: project,
          operation: operation,
          id: id,
          description: description,
        );
        final bytes = $messagesCodec.encode(transaction);
        final result = $messagesCodec.decode(bytes);
        expect(
            result,
            isA<generated.Transaction>().having(
              (t) => t.id,
              'transaction.id',
              equals(id),
            ));
      });
    });
