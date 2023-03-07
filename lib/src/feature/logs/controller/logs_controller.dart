import 'dart:async';

import 'package:collection/collection.dart';
import 'package:entity/entity.dart';
import 'package:flutter/foundation.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../common/controller/state_controller.dart';
import '../../../common/util/error_util.dart';
import '../data/logs_repository.dart';
import '../model/logs_chunk.dart';
import '../model/logs_filter.dart';
import 'logs_state.dart';

/// Controller for the logs feature
abstract class ILogsController extends IStateController<LogsState> {
  /// Refresh and recent logs
  Future<void> refresh();

  /// Paginate and fetch more logs
  Future<void> paginate();

  /// Set filter
  Future<void> setFilter(LogsFilter filter);

  /// Change filter
  Future<void> changeFilter(LogsFilter Function(LogsFilter filter) change);
}

abstract class $LogsControllerBase extends StateController<LogsState> implements ILogsController {
  $LogsControllerBase({required ILogsRepository repository, LogsState? initialState})
      : _repository = repository,
        super(initialState ?? LogsState.$initial) {
    _onLogsChangedSubscription =
        _repository.onLogsChanged.throttle(const Duration(milliseconds: 1500), trailing: true).listen((_) => refresh());
  }

  final ILogsRepository _repository;
  late final StreamSubscription<void> _onLogsChangedSubscription;

  @override
  void dispose() {
    _onLogsChangedSubscription.cancel();
    super.dispose();
  }
}

class LogsController = $LogsControllerBase with _LogsRefreshMixin, _LogsPaginationMixin, _LogsSetFilterMixin;

mixin _LogsRefreshMixin on $LogsControllerBase {
  @override
  Future<void> refresh() {
    if (isProcessing) return SynchronousFuture<void>(null); // Already processing, refreshing or paginating
    return handle(() async {
      LogsChunk? chunk;
      final to = state.logs.firstOrNull?.id;
      try {
        // Do not set state to loading, because we want to keep the current logs
        chunk = await _repository.fetch(to: to, count: 1000, filter: state.filter);
      } on Object catch (error) {
        setState(LogsState.error(
          logs: state.logs,
          endOfList: state.endOfList,
          filter: state.filter,
          message: ErrorUtil.formatMessage(error),
        ));
        rethrow;
      } finally {
        setState(LogsState.idle(
          logs: <Log>[...?chunk?.logs, ...state.logs],
          endOfList: state.endOfList,
          filter: state.filter,
        ));
      }
    });
  }
}

mixin _LogsPaginationMixin on $LogsControllerBase {
  @override
  Future<void> paginate() {
    if (state.endOfList) return SynchronousFuture<void>(null); // Already at the end of the list
    return handle(() async {
      final from = state.logs.lastOrNull?.id;
      LogsChunk? chunk;
      try {
        setState(LogsState.loading(logs: state.logs, endOfList: state.endOfList, filter: state.filter));
        chunk = await _repository.fetch(from: from, count: 1000, filter: state.filter);
      } on Object catch (error) {
        setState(LogsState.error(
          logs: state.logs,
          endOfList: state.endOfList,
          filter: state.filter,
          message: ErrorUtil.formatMessage(error),
        ));
        rethrow;
      } finally {
        setState(LogsState.idle(
          // If from is null, then we are refreshing, so we want to replace the logs with the new ones
          logs: <Log>[if (from != null) ...state.logs, ...?chunk?.logs],
          endOfList: chunk?.endOfList ?? state.endOfList,
          filter: state.filter,
        ));
      }
    });
  }
}

mixin _LogsSetFilterMixin on $LogsControllerBase {
  @override
  Future<void> setFilter(LogsFilter filter) {
    if (filter == state.filter) return SynchronousFuture<void>(null); // Already filtering with this filter
    setState(LogsState.loading(logs: const <Log>[], endOfList: false, filter: filter));
    return paginate();
  }

  @override
  Future<void> changeFilter(LogsFilter Function(LogsFilter filter) change) => setFilter(change(state.filter));
}
