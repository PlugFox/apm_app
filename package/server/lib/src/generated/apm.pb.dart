///
//  Generated code. Do not modify.
//  source: apm.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Log extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Log', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'apm'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'project')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'span')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'event')
    ..a<$core.int>(30, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'time', $pb.PbFieldType.O3)
    ..aOS(31, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.int>(32, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'level', $pb.PbFieldType.O3)
    ..aOS(50, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stack')
    ..m<$core.String, $core.String>(100, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tags', entryClassName: 'Log.TagsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('apm'))
    ..pPS(200, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'breadcrumbs')
    ..hasRequiredFields = false
  ;

  Log._() : super();
  factory Log({
    $core.String? project,
    $core.String? span,
    $core.String? event,
    $core.int? time,
    $core.String? name,
    $core.int? level,
    $core.String? stack,
    $core.Map<$core.String, $core.String>? tags,
    $core.Iterable<$core.String>? breadcrumbs,
  }) {
    final _result = create();
    if (project != null) {
      _result.project = project;
    }
    if (span != null) {
      _result.span = span;
    }
    if (event != null) {
      _result.event = event;
    }
    if (time != null) {
      _result.time = time;
    }
    if (name != null) {
      _result.name = name;
    }
    if (level != null) {
      _result.level = level;
    }
    if (stack != null) {
      _result.stack = stack;
    }
    if (tags != null) {
      _result.tags.addAll(tags);
    }
    if (breadcrumbs != null) {
      _result.breadcrumbs.addAll(breadcrumbs);
    }
    return _result;
  }
  factory Log.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Log.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Log clone() => Log()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Log copyWith(void Function(Log) updates) => super.copyWith((message) => updates(message as Log)) as Log; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Log create() => Log._();
  Log createEmptyInstance() => create();
  static $pb.PbList<Log> createRepeated() => $pb.PbList<Log>();
  @$core.pragma('dart2js:noInline')
  static Log getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Log>(create);
  static Log? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get project => $_getSZ(0);
  @$pb.TagNumber(1)
  set project($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProject() => $_has(0);
  @$pb.TagNumber(1)
  void clearProject() => clearField(1);

  @$pb.TagNumber(10)
  $core.String get span => $_getSZ(1);
  @$pb.TagNumber(10)
  set span($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(10)
  $core.bool hasSpan() => $_has(1);
  @$pb.TagNumber(10)
  void clearSpan() => clearField(10);

  @$pb.TagNumber(20)
  $core.String get event => $_getSZ(2);
  @$pb.TagNumber(20)
  set event($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(20)
  $core.bool hasEvent() => $_has(2);
  @$pb.TagNumber(20)
  void clearEvent() => clearField(20);

  @$pb.TagNumber(30)
  $core.int get time => $_getIZ(3);
  @$pb.TagNumber(30)
  set time($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(30)
  $core.bool hasTime() => $_has(3);
  @$pb.TagNumber(30)
  void clearTime() => clearField(30);

  @$pb.TagNumber(31)
  $core.String get name => $_getSZ(4);
  @$pb.TagNumber(31)
  set name($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(31)
  $core.bool hasName() => $_has(4);
  @$pb.TagNumber(31)
  void clearName() => clearField(31);

  @$pb.TagNumber(32)
  $core.int get level => $_getIZ(5);
  @$pb.TagNumber(32)
  set level($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(32)
  $core.bool hasLevel() => $_has(5);
  @$pb.TagNumber(32)
  void clearLevel() => clearField(32);

  @$pb.TagNumber(50)
  $core.String get stack => $_getSZ(6);
  @$pb.TagNumber(50)
  set stack($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(50)
  $core.bool hasStack() => $_has(6);
  @$pb.TagNumber(50)
  void clearStack() => clearField(50);

  @$pb.TagNumber(100)
  $core.Map<$core.String, $core.String> get tags => $_getMap(7);

  @$pb.TagNumber(200)
  $core.List<$core.String> get breadcrumbs => $_getList(8);
}

class Transaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Transaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'apm'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'project')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(50, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'operation')
    ..aOS(100, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..hasRequiredFields = false
  ;

  Transaction._() : super();
  factory Transaction({
    $core.String? project,
    $core.String? id,
    $core.String? operation,
    $core.String? description,
  }) {
    final _result = create();
    if (project != null) {
      _result.project = project;
    }
    if (id != null) {
      _result.id = id;
    }
    if (operation != null) {
      _result.operation = operation;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory Transaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Transaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Transaction clone() => Transaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Transaction copyWith(void Function(Transaction) updates) => super.copyWith((message) => updates(message as Transaction)) as Transaction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Transaction create() => Transaction._();
  Transaction createEmptyInstance() => create();
  static $pb.PbList<Transaction> createRepeated() => $pb.PbList<Transaction>();
  @$core.pragma('dart2js:noInline')
  static Transaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Transaction>(create);
  static Transaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get project => $_getSZ(0);
  @$pb.TagNumber(1)
  set project($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProject() => $_has(0);
  @$pb.TagNumber(1)
  void clearProject() => clearField(1);

  @$pb.TagNumber(10)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(10)
  set id($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(10)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(10)
  void clearId() => clearField(10);

  @$pb.TagNumber(50)
  $core.String get operation => $_getSZ(2);
  @$pb.TagNumber(50)
  set operation($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(50)
  $core.bool hasOperation() => $_has(2);
  @$pb.TagNumber(50)
  void clearOperation() => clearField(50);

  @$pb.TagNumber(100)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(100)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(100)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(100)
  void clearDescription() => clearField(100);
}

