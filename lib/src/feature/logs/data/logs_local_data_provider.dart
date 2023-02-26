import 'package:database/database.dart' as db;
import 'package:entity/entity.dart';

import '../model/logs_chunk.dart';
import '../model/logs_filter.dart';

abstract class ILogsLocalDataProvider {
  Future<LogsChunk> fetch({
    LogID? from,
    LogID? to,
    int count,
    LogsFilter? filter,
  });
}

class LogsLocalDataProviderDatabaseImpl implements ILogsLocalDataProvider {
  LogsLocalDataProviderDatabaseImpl({required db.Database database}) : _database = database;

  final db.Database _database;

  @override
  Future<LogsChunk> fetch({
    LogID? from,
    LogID? to,
    int count = 1000,
    LogsFilter? filter,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 10));
    final logs = <Log>[];
    return LogsChunk(
      logs: logs,
      endOfList: logs.length < count,
    );
  }
}
