import 'dart:async';

import 'package:database/database.dart' as db;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:server/server.dart' as srv;

import '../util/error_util.dart';
import 'dependencies.dart';
import 'handler.dart';

Future<void>? _$initializeApp;

/// Initializes the app and prepares it for use.
FutureOr<void> $initializeApp({
  Future<void> Function()? onSuccess,
  Future<void> Function(Object error, StackTrace stackTrace)? onError,
}) =>
    _$initializeApp ??= Future<void>(() async {
      late final WidgetsBinding binding;
      final stopwatch = Stopwatch()..start();
      try {
        binding = WidgetsFlutterBinding.ensureInitialized()..deferFirstFrame();
        {
          /* await SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]); */
          await _catchExceptions();
          await Dependencies.database.refresh();
          await _$startServer();
          /* Analytics.logAppOpen();
          Analytics.logInitialized(elapsedMilliseconds: stopwatch.elapsedMilliseconds); */
        }
      } on Object catch (error, stackTrace) {
        onError?.call(error, stackTrace).ignore();
        ErrorUtil.logError(error, stackTrace, hint: 'Failed to initialize app').ignore();
        rethrow;
      } finally {
        stopwatch.stop();
        onSuccess?.call().ignore();
        binding.addPostFrameCallback((_) {
          // Closes splash screen, and show the app layout.
          binding.allowFirstFrame();
          //final context = binding.renderViewElement;
        });
      }
    });

/// Resets the app to its initial state.
@visibleForTesting
Future<void> $resetApp() async {}

/// Disposes the app and releases all resources.
@visibleForTesting
Future<void> $disposeApp() async {}

Future<void> _catchExceptions() async {
  try {
    PlatformDispatcher.instance.onError = (error, stackTrace) {
      ErrorUtil.logError(
        error,
        stackTrace,
        hint: 'TOP LEVEL EXCEPTION\r\n${Error.safeToString(error)}',
      ).ignore();
      return true;
    };

    final sourceFlutterError = FlutterError.onError;
    FlutterError.onError = (final details) {
      ErrorUtil.logError(
        details.exception,
        details.stack ?? StackTrace.current,
        hint: 'FLUTTER ERROR\r\n$details',
      ).ignore();
      // FlutterError.presentError(details);
      sourceFlutterError?.call(details);
    };
  } on Object catch (error, stackTrace) {
    ErrorUtil.logError(error, stackTrace).ignore();
  }
}

Future<void> _$startServer() => Dependencies.database.serializableConnection().then<void>(
      (connection) => Dependencies.server.start(
        options: srv.ServerOptions(
          payload: connection,
          handler: $handler,
        ),
      ),
    );
