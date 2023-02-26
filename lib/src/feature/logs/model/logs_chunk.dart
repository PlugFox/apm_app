import 'package:entity/entity.dart';
import 'package:meta/meta.dart';

@immutable
class LogsChunk {
  const LogsChunk({
    required this.logs,
    required this.endOfList,
  });

  /// Logs
  final List<Log> logs;

  /// Whether the list is ended
  final bool endOfList;

  /// Whether the list has more
  bool get hasMore => !endOfList;
}
