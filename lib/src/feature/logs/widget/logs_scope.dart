import 'package:collection/collection.dart';
import 'package:entity/entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../common/controller/change_notifier_selector.dart';
import '../../../common/initialization/dependencies.dart';
import '../controller/logs_controller.dart';

/// {@template logs_scope}
/// LogsScope widget.
/// {@endtemplate}
class LogsScope extends StatefulWidget {
  /// {@macro logs_scope}
  const LogsScope({
    required this.child,
    super.key,
  });

  /// Returns the [ILogsController] from closest [LogsScope] which encloses the given context.
  ILogsController controllerOf(BuildContext context) =>
      _InheritedLogs.maybeOf(context, listen: false)?.controller ?? _notFoundInheritedWidgetOfExactType();

  /// Returns the List<Log> from closest [LogsScope] which encloses the given context.
  List<Log> logsOf(BuildContext context, {bool listen = true}) =>
      _InheritedLogs.maybeOf(context, listen: listen)?.logs ?? _notFoundInheritedWidgetOfExactType();

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a LogsScope of the exact type',
        'out_of_scope',
      );

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  State<LogsScope> createState() => _LogsScopeState();
}

/// State for widget LogsScope.
class _LogsScopeState extends State<LogsScope> {
  final ILogsController _controller = LogsController(
    repository: Dependencies.logsRepository,
  );

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    // Initial state initialization
  }

  @override
  void didUpdateWidget(LogsScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Widget configuration changed
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The configuration of InheritedWidgets has changed
    // Also called after initState but before build
  }

  @override
  void dispose() {
    // Permanent removal of a tree stent
    super.dispose();
  }

  /* #endregion */

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<List<Log>>(
        valueListenable: _controller.select<List<Log>>(
          (controller) => controller.state.logs,
        ),
        builder: (context, logs, child) => _InheritedLogs(
          controller: _controller,
          logs: logs,
          child: widget.child,
        ),
      );
}

class _InheritedLogs extends InheritedModel<LogID> {
  const _InheritedLogs({
    required this.controller,
    required this.logs,
    required super.child,
  });

  final ILogsController controller;
  final List<Log> logs;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  /// e.g. `_InheritedLogs.maybeOf(context)`.
  static _InheritedLogs? maybeOf(BuildContext context, {bool listen = true}) => listen
      ? context.dependOnInheritedWidgetOfExactType<_InheritedLogs>()
      : context.getElementForInheritedWidgetOfExactType<_InheritedLogs>()?.widget as _InheritedLogs?;

  /// Get [Log] by [LogID]
  static Log? getById(BuildContext context, LogID id, {bool listen = true}) =>
      (listen ? InheritedModel.inheritFrom<_InheritedLogs>(context, aspect: id) : maybeOf(context, listen: false))
          ?.logs
          .firstWhereOrNull((e) => e.id == id);

  @override
  bool updateShouldNotify(covariant _InheritedLogs oldWidget) => !listEquals<Log>(logs, oldWidget.logs);

  @override
  bool updateShouldNotifyDependent(covariant _InheritedLogs oldWidget, Set<LogID> aspects) {
    Log? getAspect(List<Log> list, LogID id) => list.firstWhereOrNull((e) => e.id == id);
    for (final id in aspects) {
      if (getAspect(logs, id) != getAspect(oldWidget.logs, id)) return true;
    }
    return false;
  }
}
