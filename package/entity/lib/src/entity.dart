import 'package:meta/meta.dart';

/// Project entity
@sealed
@immutable
abstract class ProjectEntity {
  /// Project entity
  const ProjectEntity();

  /// Project ID
  abstract final ProjectID projectId;

  /// Map entity to one of the types
  R map<R>({
    required R Function(Project project) project,
    required R Function(Span span) span,
    required R Function(Log log) log,
  });

  /// Map entity to one of the types or else
  R maybeMap<R>({
    R Function(Project project)? project,
    R Function(Span span)? span,
    R Function(Log log)? log,
    required R Function() orElse,
  }) =>
      map<R>(
        project: (p) => project?.call(p) ?? orElse(),
        span: (s) => span?.call(s) ?? orElse(),
        log: (l) => log?.call(l) ?? orElse(),
      );

  /// Map entity to one of the types or null
  R? mapOrNull<R>({
    R Function(Project project)? project,
    R Function(Span span)? span,
    R Function(Log log)? log,
  }) =>
      maybeMap<R?>(
        project: project,
        span: span,
        log: log,
        orElse: () => null,
      );
}

/// Project ID
typedef ProjectID = String;

/// Project
@immutable
class Project extends ProjectEntity with Comparable<Project> {
  /// Project
  const Project({
    required this.projectId,
    required this.name,
    this.description,
  });

  /// Project ID
  @override
  final ProjectID projectId;

  /// Project name
  final String name;

  /// Description
  final String? description;

  /// Copy with
  Project copyWith({
    ProjectID? projectId,
    String? name,
    String? description,
  }) =>
      Project(
        projectId: projectId ?? this.projectId,
        name: name ?? this.name,
        description: description ?? this.description,
      );

  @override
  int compareTo(covariant Project other) => name.compareTo(other.name);

  @override
  R map<R>({
    required R Function(Project project) project,
    required R Function(Span span) span,
    required R Function(Log log) log,
  }) =>
      project(this);

  @override
  int get hashCode => projectId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Project && projectId == other.projectId;
}

/// Transaction ID
typedef SpanID = String;

/// Transaction span
@immutable
class Span extends ProjectEntity with Comparable<Span> {
  /// Transaction span
  const Span({
    required this.id,
    required this.projectId,
    required this.operation,
    this.description,
  });

  /// Unique identifier of the transaction
  final SpanID id;

  /// Project ID
  @override
  final ProjectID projectId;

  /// Short description of transaction type, like "pageload"
  final String operation;

  /// Description
  final String? description;

  /// Copy with
  Span copyWith({
    SpanID? id,
    ProjectID? projectId,
    String? operation,
    String? description,
  }) =>
      Span(
        id: id ?? this.id,
        projectId: projectId ?? this.projectId,
        operation: operation ?? this.operation,
        description: description ?? this.description,
      );

  @override
  int compareTo(covariant Span other) => id.compareTo(other.id);

  @override
  R map<R>({
    required R Function(Project project) project,
    required R Function(Span span) span,
    required R Function(Log log) log,
  }) =>
      span(this);

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Span && id == other.id;
}

/// Log ID
typedef LogID = int;

/// Log
@immutable
class Log extends ProjectEntity with Comparable<Log> {
  /// Log
  const Log({
    required this.id,
    required this.projectId,
    this.spanId,
    required this.event,
    required this.timestamp,
    this.name,
    required this.level,
    this.stackTrace,
    this.tags = const <String, String>{},
    this.breadcrumbs = const <String>[],
    this.characteristics,
  });

  /// Placeholder
  Log.placeholder() : this(id: -1, projectId: 'app', event: 'Placeholder', timestamp: DateTime.now(), level: 0);

  /// Unique identifier of the log
  final LogID id;

  /// Project ID
  @override
  final ProjectID projectId;

  /// Span is the transaction id of the log message
  final SpanID? spanId;

  /// Message is the log message or error associated with this log event
  final String event;

  /// Time is the timestamp of the log message
  final DateTime timestamp;

  /// Name is the name of the source of the log message
  final String? name;

  /// Level is the severity of the log message (a value between 0 and 2000)
  final int level;

  /// StackTrace a stack trace associated with this log event
  final String? stackTrace;

  /// Tags is a map of key/value pairs associated with this log event
  final Map<String, String> tags;

  /// Breadcrumbs is a list of breadcrumbs associated with this log event
  final List<String> breadcrumbs;

  /// Characteristics is a JSON Object associated with this log event
  final Map<String, Object?>? characteristics;

  /// Is this log starred?
  //bool get starred => characteristics?['starred'] == true;

  /// Is this log pinned?
  //final bool pinned;

  /// Extract lowercased words
  Set<String> extractWords() => _$extractWords(this);

  /// Copy with
  Log copyWith({
    LogID? id,
    ProjectID? projectId,
    SpanID? spanId,
    String? event,
    DateTime? timestamp,
    String? name,
    int? level,
    String? stackTrace,
    Map<String, String>? tags,
    List<String>? breadcrumbs,
    Map<String, Object?>? characteristics,
  }) =>
      Log(
        id: id ?? this.id,
        projectId: projectId ?? this.projectId,
        spanId: spanId ?? this.spanId,
        event: event ?? this.event,
        timestamp: timestamp ?? this.timestamp,
        name: name ?? this.name,
        level: level ?? this.level,
        stackTrace: stackTrace ?? this.stackTrace,
        tags: tags ?? this.tags,
        breadcrumbs: breadcrumbs ?? this.breadcrumbs,
        characteristics: characteristics ?? this.characteristics,
      );

  @override
  int compareTo(covariant Log other) => timestamp.compareTo(other.timestamp);

  @override
  R map<R>({
    required R Function(Project project) project,
    required R Function(Span span) span,
    required R Function(Log log) log,
  }) =>
      log(this);

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Log && id == other.id;
}

final _$RegExp = RegExp(r'\W+');
Set<String> _$extractWords(Log log) => <String>[
      ...log.event.split(_$RegExp),
      ...?log.name?.split(_$RegExp),
      ...log.tags.entries.expand<String>((e) sync* {
        yield* e.key.split(_$RegExp);
        yield* e.value.split(_$RegExp);
      }),
      ...log.projectId.split(_$RegExp),
      ...?log.spanId?.split(_$RegExp),
      if (log.level > 99) log.level.toString(),
      //...?log.stackTrace?.split(_$RegExp),
      //...log.breadcrumbs.expand((e) => e.split(_$RegExp)),
    ].map<String>((e) => e.trim()).where((e) => e.length > 2).map<String>((e) => e.toLowerCase()).toSet();
