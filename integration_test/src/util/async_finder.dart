import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

Future<Finder> asyncFinder({
  required WidgetTester tester,
  required Finder Function() finder,
  Duration limit = const Duration(milliseconds: 15000),
}) async {
  final stopwatch = Stopwatch()..start();
  var result = finder();
  try {
    while (stopwatch.elapsed <= limit) {
      await tester.pump(const Duration(milliseconds: 100)).timeout(limit - stopwatch.elapsed);
      result = finder();
      if (result.evaluate().isNotEmpty) return result;
    }
    return result;
  } on TimeoutException {
    return result;
  } on Object {
    rethrow;
  } finally {
    stopwatch.stop();
  }
}
