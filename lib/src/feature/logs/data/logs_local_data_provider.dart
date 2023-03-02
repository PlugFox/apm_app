import 'package:database/database.dart' as db;
import 'package:entity/entity.dart';
import 'package:multiline/multiline.dart';

import '../model/log_dto.dart';
import '../model/logs_chunk.dart';
import '../model/logs_filter.dart';

abstract class ILogsLocalDataProvider {
  /// Stream of logs changes
  Stream<void> get onLogsChanged;

  /// Fetch logs
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
  Stream<void> get onLogsChanged => _database.select(_database.log).watch();

  @override
  Future<LogsChunk> fetch({
    LogID? from,
    LogID? to,
    int count = 1000,
    LogsFilter? filter,
  }) async {
    final searchTokens = _sanitizeSearchText(filter?.search);
    final logs = await _database.transaction(() async {
      List<LogID>? ids;
      if (searchTokens.isNotEmpty) {
        // Search logs by text and get their ids
        ids = await _database
            .customSelect('''
              |-- This query is used to search logs by text
              |WITH _tokens (token) AS (
              |	VALUES ${searchTokens.map<String>((e) => "('$e')").join(', ')}  -- e.g. ("some"),("new")
              |),
              |tokens (suffix, len, token) AS (
              |	SELECT DISTINCT
              |		substr(token, 1, 3),
              |		length(token),
              |		token
              |	FROM _tokens
              |)
              |SELECT DISTINCT
              |	s.log_id AS id
              |FROM tokens AS t
              |	INNER JOIN "search" AS s
              |	ON t.suffix = s.suffix AND t.len <= s.len AND t.token = substr(s.word, 1, t.len)
              |GROUP BY s.log_id
              |HAVING COUNT(1) = ${searchTokens.length}
              |ORDER BY s.log_id DESC
              |LIMIT 10000
              '''
                .multiline()
                .trim())
            .get()
            .then<List<LogID>>((rows) => rows.map((e) => e.data['id']! as LogID).toSet().toList());
      }
      return await (_database.select(_database.log)
            ..where(_buildWhere(
              ids: ids,
              from: from,
              to: to,
              projectId: filter?.projectId,
              spanId: filter?.spanId,
              name: filter?.name,
              level: filter?.level,
              dateFrom: filter?.dateFrom,
              dateTo: filter?.dateTo,
            ))
            ..orderBy([(tbl) => db.OrderingTerm(expression: tbl.id, mode: db.OrderingMode.desc)])
            ..limit(count))
          .get()
          .then<List<Log>>((list) => list.map(const LogDTO().fromDatabase).toList());
    });
    return LogsChunk(
      logs: logs,
      endOfList: logs.length < count,
    );
  }

  Set<String> _sanitizeSearchText(String? text) =>
      text?.split(RegExp(r'\W+')).map<String>((e) => e.trim().toLowerCase()).where((e) => e.length > 2).toSet() ??
      <String>{};

  db.Expression<bool> Function(db.Log tbl) _buildWhere({
    List<LogID>? ids,
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
        if (ids != null) add(tbl.id.isIn(ids));
        if (from != null) add(tbl.id.isSmallerThanValue(from));
        if (to != null) add(tbl.id.isBiggerThanValue(to));
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
