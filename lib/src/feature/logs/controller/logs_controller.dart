import 'package:entity/entity.dart';

import '../../../common/controller/state_controller.dart';
import '../data/logs_repository.dart';
import '../model/log_filter.dart';
import 'logs_state.dart';

/// Controller for the logs feature
abstract class ILogsController extends IStateController<LogsState> {
  /// Refresh and recent logs
  Future<void> refresh();

  /// Paginate and fetch more logs
  Future<void> paginate();

  /// Set filter
  Future<void> setFilter(LogFilter filter);
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
        List<Log>? chunk;
        try {
          setState(LogsState.loading(logs: state.logs, filter: state.filter));
          chunk = await _repository.fetch(to: state.logs.first.id, count: 1000, filter: state.filter);
        } on Object {
          setState(LogsState.error(logs: state.logs, filter: state.filter));
        } finally {
          setState(LogsState.idle(logs: <Log>[...?chunk, ...state.logs], filter: state.filter));
        }
      });
}

mixin _LogsPaginationMixin on $LogsControllerBase {
  @override
  Future<void> paginate() => handle(() async {
        List<Log>? chunk;
        try {
          setState(LogsState.loading(logs: state.logs, filter: state.filter));
          chunk = await _repository.fetch(from: state.logs.last.id, count: 1000, filter: state.filter);
        } on Object {
          setState(LogsState.error(logs: state.logs, filter: state.filter));
        } finally {
          setState(LogsState.idle(logs: [...state.logs, ...?chunk], filter: state.filter));
        }
      });
}

mixin _LogsSetFilterMixin on $LogsControllerBase {
  @override
  Future<void> setFilter(LogFilter filter) {
    setState(LogsState.loading(logs: const <Log>[], filter: filter));
    return paginate();
  }
}
