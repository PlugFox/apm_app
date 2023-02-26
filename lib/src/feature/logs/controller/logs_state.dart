import 'package:entity/entity.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../model/logs_filter.dart';

@sealed
@immutable
abstract class LogsState {
  const LogsState({required this.logs, required this.endOfList, required this.filter});

  /// State of the controller when it is idle
  const factory LogsState.idle({
    required List<Log> logs,
    required bool endOfList,
    required LogsFilter filter,
  }) = LogsState$Idle;

  /// State of the controller when it is processing
  const factory LogsState.loading({
    required List<Log> logs,
    required bool endOfList,
    required LogsFilter filter,
  }) = LogsState$Loading;

  const factory LogsState.error({
    required List<Log> logs,
    required bool endOfList,
    required LogsFilter filter,
    String message,
  }) = LogsState$Error;

  /// Initial state of the controller
  static const LogsState $initial = LogsState.idle(logs: <Log>[], endOfList: false, filter: LogsFilter.empty());

  /// The tree of files
  final List<Log> logs;

  /// Whether the list is ended
  final bool endOfList;

  /// Whether the list has more
  bool get hasMore => !endOfList;

  /// Filter
  final LogsFilter filter;

  /// Message
  abstract final String message;

  /// Whether the controller is processing
  abstract final bool isProcessing;

  /// Copy with
  LogsState copyWith({
    List<Log>? logs,
    bool? endOfList,
    LogsFilter? filter,
  });

  R map<R>({
    required R Function(LogsState$Idle value) idle,
    required R Function(LogsState$Loading value) loading,
    required R Function(LogsState$Error value) error,
  });

  R maybeMap<R>({
    R Function(LogsState$Idle value)? idle,
    R Function(LogsState$Loading value)? loading,
    R Function(LogsState$Error value)? error,
    required R Function() orElse,
  }) =>
      map<R>(
        idle: (v) => idle?.call(v) ?? orElse(),
        loading: (v) => loading?.call(v) ?? orElse(),
        error: (v) => error?.call(v) ?? orElse(),
      );

  R? mapOrNull<R>({
    R Function(LogsState$Idle value)? idle,
    R Function(LogsState$Loading value)? loading,
    R Function(LogsState$Error value)? error,
  }) =>
      maybeMap<R?>(
        idle: idle,
        loading: loading,
        error: error,
        orElse: () => null,
      );

  @override
  int get hashCode => logs.hashCode ^ filter.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogsState &&
          runtimeType == other.runtimeType &&
          filter == other.filter &&
          listEquals<Log>(logs, other.logs) &&
          endOfList == other.endOfList;

  @override
  String toString() => message;
}

class LogsState$Idle extends LogsState {
  const LogsState$Idle({required super.logs, required super.endOfList, required super.filter});

  @override
  String get message => 'Idle';

  @override
  bool get isProcessing => false;

  @override
  LogsState copyWith({List<Log>? logs, bool? endOfList, LogsFilter? filter}) => LogsState$Idle(
        logs: logs ?? this.logs,
        endOfList: endOfList ?? this.endOfList,
        filter: filter ?? this.filter,
      );

  @override
  R map<R>(
          {required R Function(LogsState$Idle value) idle,
          required R Function(LogsState$Loading value) loading,
          required R Function(LogsState$Error value) error}) =>
      idle(this);
}

class LogsState$Loading extends LogsState {
  const LogsState$Loading({required super.logs, required super.endOfList, required super.filter});

  @override
  String get message => 'Loading...';

  @override
  bool get isProcessing => true;

  @override
  LogsState copyWith({List<Log>? logs, bool? endOfList, LogsFilter? filter}) => LogsState$Loading(
        logs: logs ?? this.logs,
        endOfList: endOfList ?? this.endOfList,
        filter: filter ?? this.filter,
      );

  @override
  R map<R>(
          {required R Function(LogsState$Idle value) idle,
          required R Function(LogsState$Loading value) loading,
          required R Function(LogsState$Error value) error}) =>
      loading(this);
}

class LogsState$Error extends LogsState {
  const LogsState$Error(
      {required super.logs, required super.endOfList, required super.filter, this.message = 'An error occurred'});

  @override
  final String message;

  @override
  bool get isProcessing => true;

  @override
  LogsState copyWith({List<Log>? logs, bool? endOfList, LogsFilter? filter, String? message}) => LogsState$Error(
        logs: logs ?? this.logs,
        endOfList: endOfList ?? this.endOfList,
        filter: filter ?? this.filter,
        message: message ?? this.message,
      );

  @override
  R map<R>(
          {required R Function(LogsState$Idle value) idle,
          required R Function(LogsState$Loading value) loading,
          required R Function(LogsState$Error value) error}) =>
      error(this);
}
