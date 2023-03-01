import 'dart:io' as io;

import 'package:app/src/common/initialization/initialization.dart';
import 'package:app/src/common/widget/app.dart';
import 'package:app/src/feature/logs/widget/logs_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'src/util/async_finder.dart';
import 'src/util/screenshot.dart';

void main() {
  // ignore: unused_local_variable
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-end_tests', () {
    setUp(() async {
      await $initializeApp();
    });

    tearDown(() async {
      await $disposeApp();
    });

    testWidgets('App', (tester) async {
      // Prepare for screenshot.
      final shot = screenshot(tester);
      io.Directory('integration_test/screenshots').createSync(recursive: true);

      // Build our app and trigger a frame.
      await tester.pumpWidget(const App());
      await asyncFinder(tester: tester, finder: () => find.byType(App));

      // Check initial state.
      expect(find.byType(App), findsOneWidget);
      expect(find.byType(LogsScreen), findsOneWidget);
      expect(find.text('Events'), findsAtLeastNWidgets(1));

      final appScreenshot = await shot();
      io.File('integration_test/screenshots/app.png').writeAsBytesSync(appScreenshot);
    });
  });
}
