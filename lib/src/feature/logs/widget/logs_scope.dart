import 'package:collection/collection.dart';
import 'package:entity/entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../common/initialization/dependencies.dart';
import '../../../common/widget/state_builder.dart';
import '../controller/logs_controller.dart';
import '../controller/logs_state.dart';

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
  static ILogsController controllerOf(BuildContext context) =>
      _InheritedLogs.maybeOf(context, listen: false)?.controller ?? _notFoundInheritedWidgetOfExactType();

  /// Returns the List<Log> from closest [LogsScope] which encloses the given context.
  static List<Log> logsOf(BuildContext context, {bool listen = true}) =>
      _InheritedLogs.maybeOf(context, listen: listen)?.logs ?? _notFoundInheritedWidgetOfExactType();

  /// Returns the [Log] from closest [LogsScope] which encloses the given context.
  static Log getById(BuildContext context, LogID id, {bool listen = true}) =>
      _InheritedLogs.getById(context, id, listen: listen) ?? _notFoundInheritedWidgetOfExactType();

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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StateBuilder<LogsState>(
        controller: _controller,
        builder: (context, state) => _InheritedLogs(
          controller: _controller,
          logs: state.logs,
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
