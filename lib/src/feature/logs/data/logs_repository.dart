import 'package:entity/entity.dart';

import '../model/logs_chunk.dart';
import '../model/logs_filter.dart';
import 'logs_local_data_provider.dart';

abstract class ILogsRepository {
  /// Fetch logs
  Future<LogsChunk> fetch({
    LogID? from,
    LogID? to,
    int? count,
    LogsFilter? filter,
  });
}

class LogsRepositoryImpl implements ILogsRepository {
  LogsRepositoryImpl({required ILogsLocalDataProvider localDataProvider}) : _localDataProvider = localDataProvider;

  final ILogsLocalDataProvider _localDataProvider;

  @override
  Future<LogsChunk> fetch({
    LogID? from,
    LogID? to,
    int? count,
    LogsFilter? filter,
  }) =>
      _localDataProvider.fetch(
        from: from,
        to: to,
        count: count ?? 1000,
        filter: filter,
      );
}
