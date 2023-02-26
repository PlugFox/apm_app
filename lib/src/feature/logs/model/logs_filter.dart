import 'package:entity/entity.dart';
import 'package:meta/meta.dart';

@immutable
class LogsFilter {
  const LogsFilter({
    this.search,
    this.projectId,
    this.spanId,
    this.name,
    this.level,
    this.dateFrom,
    this.dateTo,
  });

  const LogsFilter.empty() : this();

  final String? search;
  final ProjectID? projectId;
  final SpanID? spanId;
  final String? name;
  final int? level;
  final DateTime? dateFrom;
  final DateTime? dateTo;

  @override
  int get hashCode => Object.hashAll([
        search,
        projectId,
        spanId,
        name,
        level,
        dateFrom,
        dateTo,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogsFilter &&
          runtimeType == other.runtimeType &&
          search == other.search &&
          projectId == other.projectId &&
          spanId == other.spanId &&
          name == other.name &&
          level == other.level &&
          dateFrom == other.dateFrom &&
          dateTo == other.dateTo;
}
