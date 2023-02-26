import 'package:entity/entity.dart';

import '../model/log_filter.dart';
import 'logs_local_data_provider.dart';

abstract class ILogsRepository {
  /// Fetch logs
  Future<List<Log>> fetch({
    LogID? from,
    LogID? to,
    int? count,
    LogFilter? filter,
  });
}

class LogsRepositoryImpl implements ILogsRepository {
  LogsRepositoryImpl({required ILogsLocalDataProvider localDataProvider}) : _localDataProvider = localDataProvider;

  final ILogsLocalDataProvider _localDataProvider;

  @override
  Future<List<Log>> fetch({
    LogID? from,
    LogID? to,
    int? count,
    LogFilter? filter,
  }) =>
      _localDataProvider.fetch(
        from: from,
        to: to,
        count: count,
        filter: filter,
      );
}
