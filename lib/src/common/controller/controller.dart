import 'package:flutter/foundation.dart' show Listenable, ChangeNotifier;
import 'package:meta/meta.dart';

import '../util/logging.dart' as logging;

/// {@template controller}
/// The controller responsible for processing the logic,
/// the connection of widgets and the date of the layer.
/// {@endtemplate}
abstract class IController implements Listenable {
  /// Whether the controller is currently handling a requests
  bool get isProcessing;

  /// Discards any resources used by the object.
  ///
  /// This method should only be called by the object's owner.
  void dispose();
}

/// {@template controller}
abstract class Controller with ChangeNotifier implements IController {
  @override
  @nonVirtual
  bool get isProcessing => _$processingCalls > 0;
  int _$processingCalls = 0;
  bool get isDisposed => _$isDisposed;
  bool _$isDisposed = false;

  @protected
  @mustCallSuper
  Future<void> handle(Future<void> Function() handler) async {
    if (isDisposed) return;
    _$processingCalls++;
    notifyListeners();
    try {
      await handler();
    } on Object catch (error, stackTrace) {
      // TODO(plugfox): raise all errors to global observer,
      // instead of logging them
      logging.severe(
        error,
        stackTrace,
        'Error "$error" while handling controller $runtimeType',
      );
    } finally {
      _$processingCalls--;
      notifyListeners();
    }
  }

  @override
  @mustCallSuper
  void dispose() {
    _$isDisposed = true;
    super.dispose();
  }

  @protected
  @nonVirtual
  @override
  void notifyListeners() => super.notifyListeners();
}
