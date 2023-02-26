import 'package:collection/collection.dart';
import 'package:entity/entity.dart';

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
}

abstract class $LogsControllerBase extends StateController<LogsState> implements ILogsController {
  $LogsControllerBase({required ILogsRepository repository, LogsState? initialState})
      : _repository = repository,
        super(initialState ?? LogsState.$initial);

  final ILogsRepository _repository;
}

class LogsController = $LogsControllerBase with _LogsRefreshMixin, _LogsPaginationMixin, _LogsSetFilterMixin;

mixin _LogsRefreshMixin on $LogsControllerBase {
  @override
  Future<void> refresh() => handle(() async {
        if (isProcessing) return; // Already processing, refreshing or paginating
        LogsChunk? chunk;
        try {
          // Do not set state to loading, because we want to keep the current logs
          chunk = await _repository.fetch(to: state.logs.firstOrNull?.id, count: 1000, filter: state.filter);
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

mixin _LogsPaginationMixin on $LogsControllerBase {
  @override
  Future<void> paginate() => handle(() async {
        if (state.endOfList) return; // Already at the end of the list
        LogsChunk? chunk;
        try {
          setState(LogsState.loading(logs: state.logs, endOfList: state.endOfList, filter: state.filter));
          chunk = await _repository.fetch(from: state.logs.lastOrNull?.id, count: 1000, filter: state.filter);
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
            logs: [...state.logs, ...?chunk?.logs],
            endOfList: chunk?.endOfList ?? state.endOfList,
            filter: state.filter,
          ));
        }
      });
}

mixin _LogsSetFilterMixin on $LogsControllerBase {
  @override
  Future<void> setFilter(LogsFilter filter) {
    setState(LogsState.loading(logs: const <Log>[], endOfList: false, filter: filter));
    return paginate();
  }
}
