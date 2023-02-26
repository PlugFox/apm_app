import 'package:flutter/foundation.dart';

import 'controller.dart';

mixin DroppableControllerConcurrency on Controller {
  @override
  Future<void> handle(Future<void> Function() handler) {
    // For throttling handle calls
    if (isProcessing) return SynchronousFuture<void>(null);
    return super.handle(handler);
  }
}
