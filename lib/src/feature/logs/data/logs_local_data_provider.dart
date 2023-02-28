import 'package:database/database.dart' as db;
import 'package:entity/entity.dart';

import '../model/log_dto.dart';
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
    final logs = await (_database.select(_database.log)
          ..where(_buildWhere(
            from: from,
            to: to,
            projectId: filter?.projectId,
            spanId: filter?.spanId,
            name: filter?.name,
            level: filter?.level,
            dateFrom: filter?.dateFrom,
            dateTo: filter?.dateTo,
          ))
          ..limit(count))
        .get()
        .then<List<Log>>((list) => list.map(const LogDTO().fromDatabase).toList());
    return LogsChunk(
      logs: logs,
      endOfList: logs.length < count,
    );
  }

  db.Expression<bool> Function(db.Log tbl) _buildWhere({
    LogID? from,
    LogID? to,
    ProjectID? projectId,
    SpanID? spanId,
    String? name,
    int? level,
    DateTime? dateFrom,
    DateTime? dateTo,
  }) =>
      (db.Log tbl) {
        db.Expression<bool>? predicate;
        void add(db.Expression<bool> exp) => predicate = (predicate != null) ? predicate! & exp : exp;
        if (from != null) add(tbl.id.isBiggerThanValue(from));
        if (to != null) add(tbl.id.isSmallerThanValue(to));
        if (projectId != null) add(tbl.projectId.equals(projectId));
        if (spanId != null) add(tbl.spanId.equals(spanId));
        if (name != null) add(tbl.name.equals(name));
        if (level != null) add(tbl.level.equals(level));

        int? seconds(DateTime? dt) => dt != null ? dt.millisecondsSinceEpoch ~/ 1000 : null;
        final timeFrom = seconds(dateFrom);
        final timeTo = seconds(dateTo);
        if (timeFrom != null && timeTo != null) {
          add(tbl.time.isBetweenValues(timeFrom, timeTo));
        } else if (timeFrom != null) {
          add(tbl.time.isBiggerThanValue(timeFrom));
        } else if (timeTo != null) {
          add(tbl.time.isSmallerThanValue(timeTo));
        }

        return predicate ?? const db.Constant(true);
      };
}
