import 'package:database/database.dart' as db;
import 'package:entity/entity.dart';
import 'package:meta/meta.dart';

@immutable
class LogDTO {
  const LogDTO();

  Log fromDatabase(db.LogData log) => Log(
        id: log.id,
        projectId: log.projectId,
        spanId: log.spanId,
        event: log.event,
        timestamp: DateTime.fromMillisecondsSinceEpoch(log.time * 1000),
        name: log.name,
        level: log.level,
        stackTrace: log.stack,
        // TODO(plugfox): Add tags, breadcrumbs, characteristics
      );
}
