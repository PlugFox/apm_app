import 'package:entity/entity.dart';
import 'package:meta/meta.dart';

@immutable
class LogsFilter {
  const LogsFilter({
    this.search,
    this.projectId,
    this.spanId,
    this.name,
    this.levelFrom,
    this.levelTo,
    this.dateFrom,
    this.dateTo,
  });

  const LogsFilter.empty() : this();

  final String? search;
  final ProjectID? projectId;
  final SpanID? spanId;
  final String? name;

  /// Level range (inclusive)
  final int? levelFrom, levelTo;

  /// Date range (inclusive)
  final DateTime? dateFrom, dateTo;

  LogsFilter copyWith({
    String? search,
    ProjectID? projectId,
    SpanID? spanId,
    String? name,
    int? levelFrom,
    int? levelTo,
    DateTime? dateFrom,
    DateTime? dateTo,
  }) =>
      LogsFilter(
        search: search ?? this.search,
        projectId: projectId ?? this.projectId,
        spanId: spanId ?? this.spanId,
        name: name ?? this.name,
        levelFrom: levelFrom ?? this.levelFrom,
        levelTo: levelTo ?? this.levelTo,
        dateFrom: dateFrom ?? this.dateFrom,
        dateTo: dateTo ?? this.dateTo,
      );

  LogsFilter clearLevelRange() => LogsFilter(
        search: search,
        projectId: projectId,
        spanId: spanId,
        name: name,
        levelFrom: null,
        levelTo: null,
        dateFrom: dateFrom,
        dateTo: dateTo,
      );

  LogsFilter clearDateRange() => LogsFilter(
        search: search,
        projectId: projectId,
        spanId: spanId,
        name: name,
        levelFrom: levelFrom,
        levelTo: levelTo,
        dateFrom: null,
        dateTo: null,
      );

  @override
  int get hashCode => Object.hashAll([
        search,
        projectId,
        spanId,
        name,
        levelFrom,
        levelTo,
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
          levelFrom == other.levelFrom &&
          levelTo == other.levelTo &&
          dateFrom == other.dateFrom &&
          dateTo == other.dateTo;
}
