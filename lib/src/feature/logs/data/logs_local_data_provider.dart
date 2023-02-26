import 'package:database/database.dart' as db;
import 'package:entity/entity.dart';

import '../model/log_filter.dart';

abstract class ILogsLocalDataProvider {
  Future<List<Log>> fetch({
    LogID? from,
    LogID? to,
    int? count,
    LogFilter? filter,
  });
}

class LogsLocalDataProviderDatabaseImpl implements ILogsLocalDataProvider {
  LogsLocalDataProviderDatabaseImpl({required db.Database database}) : _database = database;

  final db.Database _database;

  @override
  Future<List<Log>> fetch({
    LogID? from,
    LogID? to,
    int? count,
    LogFilter? filter,
  }) async {
    return [];
  }
}
