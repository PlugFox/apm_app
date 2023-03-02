import 'package:database/database.dart' as db;
import 'package:flutter_test/flutter_test.dart';

void main() => group('drift', () {
      test('select_from_values', () {
        final databae = db.Database.memory();
        final values = ['1', '2', '3'];
        final result = databae
            .customSelect(
              'SELECT * FROM (VALUES ${values.map<String>((e) => '("$e")').join(', ')}) AS t',
            )
            .get();
        expectLater(
          result,
          completion(
            isA<List<db.QueryRow>>().having(
              (e) => e.map<Map<String, Object?>>((e) => e.data).toList(),
              'rows',
              allOf(
                isList,
                isNotEmpty,
                hasLength(values.length),
              ),
            ),
          ),
        );
      });
    });
