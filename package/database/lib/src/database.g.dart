// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class Characteristic extends Table
    with TableInfo<Characteristic, CharacteristicData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Characteristic(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL CHECK (length(type) > 0 AND length(type) <= 255)');
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
      'data', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL CHECK (length(data) > 2 AND json_valid(data))');
  static const VerificationMeta _metaCreatedAtMeta =
      const VerificationMeta('metaCreatedAt');
  late final GeneratedColumn<int> metaCreatedAt = GeneratedColumn<int>(
      'meta_created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (strftime(\'%s\', \'now\'))',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  static const VerificationMeta _metaUpdatedAtMeta =
      const VerificationMeta('metaUpdatedAt');
  late final GeneratedColumn<int> metaUpdatedAt = GeneratedColumn<int>(
      'meta_updated_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints:
          'NOT NULL DEFAULT (strftime(\'%s\', \'now\')) CHECK (meta_updated_at >= meta_created_at)',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  @override
  List<GeneratedColumn> get $columns =>
      [type, id, data, metaCreatedAt, metaUpdatedAt];
  @override
  String get aliasedName => _alias ?? 'characteristic';
  @override
  String get actualTableName => 'characteristic';
  @override
  VerificationContext validateIntegrity(Insertable<CharacteristicData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('meta_created_at')) {
      context.handle(
          _metaCreatedAtMeta,
          metaCreatedAt.isAcceptableOrUnknown(
              data['meta_created_at']!, _metaCreatedAtMeta));
    }
    if (data.containsKey('meta_updated_at')) {
      context.handle(
          _metaUpdatedAtMeta,
          metaUpdatedAt.isAcceptableOrUnknown(
              data['meta_updated_at']!, _metaUpdatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {type, id};
  @override
  CharacteristicData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CharacteristicData(
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      data: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data'])!,
      metaCreatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}meta_created_at'])!,
      metaUpdatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}meta_updated_at'])!,
    );
  }

  @override
  Characteristic createAlias(String alias) {
    return Characteristic(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const ['PRIMARY KEY(type, id)'];
  @override
  bool get dontWriteConstraints => true;
}

class CharacteristicData extends DataClass
    implements Insertable<CharacteristicData> {
  final String type;
  final int id;
  final String data;
  final int metaCreatedAt;
  final int metaUpdatedAt;
  const CharacteristicData(
      {required this.type,
      required this.id,
      required this.data,
      required this.metaCreatedAt,
      required this.metaUpdatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['type'] = Variable<String>(type);
    map['id'] = Variable<int>(id);
    map['data'] = Variable<String>(data);
    map['meta_created_at'] = Variable<int>(metaCreatedAt);
    map['meta_updated_at'] = Variable<int>(metaUpdatedAt);
    return map;
  }

  CharacteristicCompanion toCompanion(bool nullToAbsent) {
    return CharacteristicCompanion(
      type: Value(type),
      id: Value(id),
      data: Value(data),
      metaCreatedAt: Value(metaCreatedAt),
      metaUpdatedAt: Value(metaUpdatedAt),
    );
  }

  factory CharacteristicData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CharacteristicData(
      type: serializer.fromJson<String>(json['type']),
      id: serializer.fromJson<int>(json['id']),
      data: serializer.fromJson<String>(json['data']),
      metaCreatedAt: serializer.fromJson<int>(json['meta_created_at']),
      metaUpdatedAt: serializer.fromJson<int>(json['meta_updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'type': serializer.toJson<String>(type),
      'id': serializer.toJson<int>(id),
      'data': serializer.toJson<String>(data),
      'meta_created_at': serializer.toJson<int>(metaCreatedAt),
      'meta_updated_at': serializer.toJson<int>(metaUpdatedAt),
    };
  }

  CharacteristicData copyWith(
          {String? type,
          int? id,
          String? data,
          int? metaCreatedAt,
          int? metaUpdatedAt}) =>
      CharacteristicData(
        type: type ?? this.type,
        id: id ?? this.id,
        data: data ?? this.data,
        metaCreatedAt: metaCreatedAt ?? this.metaCreatedAt,
        metaUpdatedAt: metaUpdatedAt ?? this.metaUpdatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('CharacteristicData(')
          ..write('type: $type, ')
          ..write('id: $id, ')
          ..write('data: $data, ')
          ..write('metaCreatedAt: $metaCreatedAt, ')
          ..write('metaUpdatedAt: $metaUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(type, id, data, metaCreatedAt, metaUpdatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharacteristicData &&
          other.type == this.type &&
          other.id == this.id &&
          other.data == this.data &&
          other.metaCreatedAt == this.metaCreatedAt &&
          other.metaUpdatedAt == this.metaUpdatedAt);
}

class CharacteristicCompanion extends UpdateCompanion<CharacteristicData> {
  final Value<String> type;
  final Value<int> id;
  final Value<String> data;
  final Value<int> metaCreatedAt;
  final Value<int> metaUpdatedAt;
  const CharacteristicCompanion({
    this.type = const Value.absent(),
    this.id = const Value.absent(),
    this.data = const Value.absent(),
    this.metaCreatedAt = const Value.absent(),
    this.metaUpdatedAt = const Value.absent(),
  });
  CharacteristicCompanion.insert({
    required String type,
    required int id,
    required String data,
    this.metaCreatedAt = const Value.absent(),
    this.metaUpdatedAt = const Value.absent(),
  })  : type = Value(type),
        id = Value(id),
        data = Value(data);
  static Insertable<CharacteristicData> custom({
    Expression<String>? type,
    Expression<int>? id,
    Expression<String>? data,
    Expression<int>? metaCreatedAt,
    Expression<int>? metaUpdatedAt,
  }) {
    return RawValuesInsertable({
      if (type != null) 'type': type,
      if (id != null) 'id': id,
      if (data != null) 'data': data,
      if (metaCreatedAt != null) 'meta_created_at': metaCreatedAt,
      if (metaUpdatedAt != null) 'meta_updated_at': metaUpdatedAt,
    });
  }

  CharacteristicCompanion copyWith(
      {Value<String>? type,
      Value<int>? id,
      Value<String>? data,
      Value<int>? metaCreatedAt,
      Value<int>? metaUpdatedAt}) {
    return CharacteristicCompanion(
      type: type ?? this.type,
      id: id ?? this.id,
      data: data ?? this.data,
      metaCreatedAt: metaCreatedAt ?? this.metaCreatedAt,
      metaUpdatedAt: metaUpdatedAt ?? this.metaUpdatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    if (metaCreatedAt.present) {
      map['meta_created_at'] = Variable<int>(metaCreatedAt.value);
    }
    if (metaUpdatedAt.present) {
      map['meta_updated_at'] = Variable<int>(metaUpdatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharacteristicCompanion(')
          ..write('type: $type, ')
          ..write('id: $id, ')
          ..write('data: $data, ')
          ..write('metaCreatedAt: $metaCreatedAt, ')
          ..write('metaUpdatedAt: $metaUpdatedAt')
          ..write(')'))
        .toString();
  }
}

class Project extends Table with TableInfo<Project, ProjectData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Project(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT \'\'',
      defaultValue: const CustomExpression('\'\''));
  static const VerificationMeta _memoMeta = const VerificationMeta('memo');
  late final GeneratedColumn<String> memo = GeneratedColumn<String>(
      'memo', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _metaCreatedAtMeta =
      const VerificationMeta('metaCreatedAt');
  late final GeneratedColumn<int> metaCreatedAt = GeneratedColumn<int>(
      'meta_created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (strftime(\'%s\', \'now\'))',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  static const VerificationMeta _metaUpdatedAtMeta =
      const VerificationMeta('metaUpdatedAt');
  late final GeneratedColumn<int> metaUpdatedAt = GeneratedColumn<int>(
      'meta_updated_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints:
          'NOT NULL DEFAULT (strftime(\'%s\', \'now\')) CHECK (meta_updated_at >= meta_created_at)',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, memo, metaCreatedAt, metaUpdatedAt];
  @override
  String get aliasedName => _alias ?? 'project';
  @override
  String get actualTableName => 'project';
  @override
  VerificationContext validateIntegrity(Insertable<ProjectData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('memo')) {
      context.handle(
          _memoMeta, memo.isAcceptableOrUnknown(data['memo']!, _memoMeta));
    }
    if (data.containsKey('meta_created_at')) {
      context.handle(
          _metaCreatedAtMeta,
          metaCreatedAt.isAcceptableOrUnknown(
              data['meta_created_at']!, _metaCreatedAtMeta));
    }
    if (data.containsKey('meta_updated_at')) {
      context.handle(
          _metaUpdatedAtMeta,
          metaUpdatedAt.isAcceptableOrUnknown(
              data['meta_updated_at']!, _metaUpdatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProjectData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProjectData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      memo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}memo']),
      metaCreatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}meta_created_at'])!,
      metaUpdatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}meta_updated_at'])!,
    );
  }

  @override
  Project createAlias(String alias) {
    return Project(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  bool get dontWriteConstraints => true;
}

class ProjectData extends DataClass implements Insertable<ProjectData> {
  final String id;
  final String name;
  final String? memo;
  final int metaCreatedAt;
  final int metaUpdatedAt;
  const ProjectData(
      {required this.id,
      required this.name,
      this.memo,
      required this.metaCreatedAt,
      required this.metaUpdatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || memo != null) {
      map['memo'] = Variable<String>(memo);
    }
    map['meta_created_at'] = Variable<int>(metaCreatedAt);
    map['meta_updated_at'] = Variable<int>(metaUpdatedAt);
    return map;
  }

  ProjectCompanion toCompanion(bool nullToAbsent) {
    return ProjectCompanion(
      id: Value(id),
      name: Value(name),
      memo: memo == null && nullToAbsent ? const Value.absent() : Value(memo),
      metaCreatedAt: Value(metaCreatedAt),
      metaUpdatedAt: Value(metaUpdatedAt),
    );
  }

  factory ProjectData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      memo: serializer.fromJson<String?>(json['memo']),
      metaCreatedAt: serializer.fromJson<int>(json['meta_created_at']),
      metaUpdatedAt: serializer.fromJson<int>(json['meta_updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'memo': serializer.toJson<String?>(memo),
      'meta_created_at': serializer.toJson<int>(metaCreatedAt),
      'meta_updated_at': serializer.toJson<int>(metaUpdatedAt),
    };
  }

  ProjectData copyWith(
          {String? id,
          String? name,
          Value<String?> memo = const Value.absent(),
          int? metaCreatedAt,
          int? metaUpdatedAt}) =>
      ProjectData(
        id: id ?? this.id,
        name: name ?? this.name,
        memo: memo.present ? memo.value : this.memo,
        metaCreatedAt: metaCreatedAt ?? this.metaCreatedAt,
        metaUpdatedAt: metaUpdatedAt ?? this.metaUpdatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('ProjectData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('memo: $memo, ')
          ..write('metaCreatedAt: $metaCreatedAt, ')
          ..write('metaUpdatedAt: $metaUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, memo, metaCreatedAt, metaUpdatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectData &&
          other.id == this.id &&
          other.name == this.name &&
          other.memo == this.memo &&
          other.metaCreatedAt == this.metaCreatedAt &&
          other.metaUpdatedAt == this.metaUpdatedAt);
}

class ProjectCompanion extends UpdateCompanion<ProjectData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> memo;
  final Value<int> metaCreatedAt;
  final Value<int> metaUpdatedAt;
  const ProjectCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.memo = const Value.absent(),
    this.metaCreatedAt = const Value.absent(),
    this.metaUpdatedAt = const Value.absent(),
  });
  ProjectCompanion.insert({
    required String id,
    this.name = const Value.absent(),
    this.memo = const Value.absent(),
    this.metaCreatedAt = const Value.absent(),
    this.metaUpdatedAt = const Value.absent(),
  }) : id = Value(id);
  static Insertable<ProjectData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? memo,
    Expression<int>? metaCreatedAt,
    Expression<int>? metaUpdatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (memo != null) 'memo': memo,
      if (metaCreatedAt != null) 'meta_created_at': metaCreatedAt,
      if (metaUpdatedAt != null) 'meta_updated_at': metaUpdatedAt,
    });
  }

  ProjectCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? memo,
      Value<int>? metaCreatedAt,
      Value<int>? metaUpdatedAt}) {
    return ProjectCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      memo: memo ?? this.memo,
      metaCreatedAt: metaCreatedAt ?? this.metaCreatedAt,
      metaUpdatedAt: metaUpdatedAt ?? this.metaUpdatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (memo.present) {
      map['memo'] = Variable<String>(memo.value);
    }
    if (metaCreatedAt.present) {
      map['meta_created_at'] = Variable<int>(metaCreatedAt.value);
    }
    if (metaUpdatedAt.present) {
      map['meta_updated_at'] = Variable<int>(metaUpdatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('memo: $memo, ')
          ..write('metaCreatedAt: $metaCreatedAt, ')
          ..write('metaUpdatedAt: $metaUpdatedAt')
          ..write(')'))
        .toString();
  }
}

class Span extends Table with TableInfo<Span, SpanData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Span(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
      'project_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _operationMeta =
      const VerificationMeta('operation');
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
      'operation', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _memoMeta = const VerificationMeta('memo');
  late final GeneratedColumn<String> memo = GeneratedColumn<String>(
      'memo', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _metaCreatedAtMeta =
      const VerificationMeta('metaCreatedAt');
  late final GeneratedColumn<int> metaCreatedAt = GeneratedColumn<int>(
      'meta_created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (strftime(\'%s\', \'now\'))',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  static const VerificationMeta _metaUpdatedAtMeta =
      const VerificationMeta('metaUpdatedAt');
  late final GeneratedColumn<int> metaUpdatedAt = GeneratedColumn<int>(
      'meta_updated_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints:
          'NOT NULL DEFAULT (strftime(\'%s\', \'now\')) CHECK (meta_updated_at >= meta_created_at)',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, projectId, operation, memo, metaCreatedAt, metaUpdatedAt];
  @override
  String get aliasedName => _alias ?? 'span';
  @override
  String get actualTableName => 'span';
  @override
  VerificationContext validateIntegrity(Insertable<SpanData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(_operationMeta,
          operation.isAcceptableOrUnknown(data['operation']!, _operationMeta));
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('memo')) {
      context.handle(
          _memoMeta, memo.isAcceptableOrUnknown(data['memo']!, _memoMeta));
    }
    if (data.containsKey('meta_created_at')) {
      context.handle(
          _metaCreatedAtMeta,
          metaCreatedAt.isAcceptableOrUnknown(
              data['meta_created_at']!, _metaCreatedAtMeta));
    }
    if (data.containsKey('meta_updated_at')) {
      context.handle(
          _metaUpdatedAtMeta,
          metaUpdatedAt.isAcceptableOrUnknown(
              data['meta_updated_at']!, _metaUpdatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SpanData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpanData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project_id'])!,
      operation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation'])!,
      memo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}memo']),
      metaCreatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}meta_created_at'])!,
      metaUpdatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}meta_updated_at'])!,
    );
  }

  @override
  Span createAlias(String alias) {
    return Span(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(project_id)REFERENCES project(id)ON UPDATE CASCADE ON DELETE CASCADE'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class SpanData extends DataClass implements Insertable<SpanData> {
  final String id;
  final String projectId;
  final String operation;
  final String? memo;
  final int metaCreatedAt;
  final int metaUpdatedAt;
  const SpanData(
      {required this.id,
      required this.projectId,
      required this.operation,
      this.memo,
      required this.metaCreatedAt,
      required this.metaUpdatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['project_id'] = Variable<String>(projectId);
    map['operation'] = Variable<String>(operation);
    if (!nullToAbsent || memo != null) {
      map['memo'] = Variable<String>(memo);
    }
    map['meta_created_at'] = Variable<int>(metaCreatedAt);
    map['meta_updated_at'] = Variable<int>(metaUpdatedAt);
    return map;
  }

  SpanCompanion toCompanion(bool nullToAbsent) {
    return SpanCompanion(
      id: Value(id),
      projectId: Value(projectId),
      operation: Value(operation),
      memo: memo == null && nullToAbsent ? const Value.absent() : Value(memo),
      metaCreatedAt: Value(metaCreatedAt),
      metaUpdatedAt: Value(metaUpdatedAt),
    );
  }

  factory SpanData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpanData(
      id: serializer.fromJson<String>(json['id']),
      projectId: serializer.fromJson<String>(json['project_id']),
      operation: serializer.fromJson<String>(json['operation']),
      memo: serializer.fromJson<String?>(json['memo']),
      metaCreatedAt: serializer.fromJson<int>(json['meta_created_at']),
      metaUpdatedAt: serializer.fromJson<int>(json['meta_updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'project_id': serializer.toJson<String>(projectId),
      'operation': serializer.toJson<String>(operation),
      'memo': serializer.toJson<String?>(memo),
      'meta_created_at': serializer.toJson<int>(metaCreatedAt),
      'meta_updated_at': serializer.toJson<int>(metaUpdatedAt),
    };
  }

  SpanData copyWith(
          {String? id,
          String? projectId,
          String? operation,
          Value<String?> memo = const Value.absent(),
          int? metaCreatedAt,
          int? metaUpdatedAt}) =>
      SpanData(
        id: id ?? this.id,
        projectId: projectId ?? this.projectId,
        operation: operation ?? this.operation,
        memo: memo.present ? memo.value : this.memo,
        metaCreatedAt: metaCreatedAt ?? this.metaCreatedAt,
        metaUpdatedAt: metaUpdatedAt ?? this.metaUpdatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('SpanData(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('operation: $operation, ')
          ..write('memo: $memo, ')
          ..write('metaCreatedAt: $metaCreatedAt, ')
          ..write('metaUpdatedAt: $metaUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, projectId, operation, memo, metaCreatedAt, metaUpdatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpanData &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.operation == this.operation &&
          other.memo == this.memo &&
          other.metaCreatedAt == this.metaCreatedAt &&
          other.metaUpdatedAt == this.metaUpdatedAt);
}

class SpanCompanion extends UpdateCompanion<SpanData> {
  final Value<String> id;
  final Value<String> projectId;
  final Value<String> operation;
  final Value<String?> memo;
  final Value<int> metaCreatedAt;
  final Value<int> metaUpdatedAt;
  const SpanCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.operation = const Value.absent(),
    this.memo = const Value.absent(),
    this.metaCreatedAt = const Value.absent(),
    this.metaUpdatedAt = const Value.absent(),
  });
  SpanCompanion.insert({
    required String id,
    required String projectId,
    required String operation,
    this.memo = const Value.absent(),
    this.metaCreatedAt = const Value.absent(),
    this.metaUpdatedAt = const Value.absent(),
  })  : id = Value(id),
        projectId = Value(projectId),
        operation = Value(operation);
  static Insertable<SpanData> custom({
    Expression<String>? id,
    Expression<String>? projectId,
    Expression<String>? operation,
    Expression<String>? memo,
    Expression<int>? metaCreatedAt,
    Expression<int>? metaUpdatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (operation != null) 'operation': operation,
      if (memo != null) 'memo': memo,
      if (metaCreatedAt != null) 'meta_created_at': metaCreatedAt,
      if (metaUpdatedAt != null) 'meta_updated_at': metaUpdatedAt,
    });
  }

  SpanCompanion copyWith(
      {Value<String>? id,
      Value<String>? projectId,
      Value<String>? operation,
      Value<String?>? memo,
      Value<int>? metaCreatedAt,
      Value<int>? metaUpdatedAt}) {
    return SpanCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      operation: operation ?? this.operation,
      memo: memo ?? this.memo,
      metaCreatedAt: metaCreatedAt ?? this.metaCreatedAt,
      metaUpdatedAt: metaUpdatedAt ?? this.metaUpdatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (memo.present) {
      map['memo'] = Variable<String>(memo.value);
    }
    if (metaCreatedAt.present) {
      map['meta_created_at'] = Variable<int>(metaCreatedAt.value);
    }
    if (metaUpdatedAt.present) {
      map['meta_updated_at'] = Variable<int>(metaUpdatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpanCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('operation: $operation, ')
          ..write('memo: $memo, ')
          ..write('metaCreatedAt: $metaCreatedAt, ')
          ..write('metaUpdatedAt: $metaUpdatedAt')
          ..write(')'))
        .toString();
  }
}

class Log extends Table with TableInfo<Log, LogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Log(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
      'project_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _spanIdMeta = const VerificationMeta('spanId');
  late final GeneratedColumn<String> spanId = GeneratedColumn<String>(
      'span_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _eventMeta = const VerificationMeta('event');
  late final GeneratedColumn<String> event = GeneratedColumn<String>(
      'event', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  late final GeneratedColumn<int> time = GeneratedColumn<int>(
      'time', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _stackMeta = const VerificationMeta('stack');
  late final GeneratedColumn<String> stack = GeneratedColumn<String>(
      'stack', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _metaCreatedAtMeta =
      const VerificationMeta('metaCreatedAt');
  late final GeneratedColumn<int> metaCreatedAt = GeneratedColumn<int>(
      'meta_created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (strftime(\'%s\', \'now\'))',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  static const VerificationMeta _metaUpdatedAtMeta =
      const VerificationMeta('metaUpdatedAt');
  late final GeneratedColumn<int> metaUpdatedAt = GeneratedColumn<int>(
      'meta_updated_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints:
          'NOT NULL DEFAULT (strftime(\'%s\', \'now\')) CHECK (meta_updated_at >= meta_created_at)',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        projectId,
        spanId,
        event,
        time,
        name,
        level,
        stack,
        metaCreatedAt,
        metaUpdatedAt
      ];
  @override
  String get aliasedName => _alias ?? 'log';
  @override
  String get actualTableName => 'log';
  @override
  VerificationContext validateIntegrity(Insertable<LogData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('span_id')) {
      context.handle(_spanIdMeta,
          spanId.isAcceptableOrUnknown(data['span_id']!, _spanIdMeta));
    }
    if (data.containsKey('event')) {
      context.handle(
          _eventMeta, event.isAcceptableOrUnknown(data['event']!, _eventMeta));
    } else if (isInserting) {
      context.missing(_eventMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('stack')) {
      context.handle(
          _stackMeta, stack.isAcceptableOrUnknown(data['stack']!, _stackMeta));
    }
    if (data.containsKey('meta_created_at')) {
      context.handle(
          _metaCreatedAtMeta,
          metaCreatedAt.isAcceptableOrUnknown(
              data['meta_created_at']!, _metaCreatedAtMeta));
    }
    if (data.containsKey('meta_updated_at')) {
      context.handle(
          _metaUpdatedAtMeta,
          metaUpdatedAt.isAcceptableOrUnknown(
              data['meta_updated_at']!, _metaUpdatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LogData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}project_id'])!,
      spanId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}span_id']),
      event: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}event'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}time'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      stack: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stack']),
      metaCreatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}meta_created_at'])!,
      metaUpdatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}meta_updated_at'])!,
    );
  }

  @override
  Log createAlias(String alias) {
    return Log(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(project_id)REFERENCES project(id)ON UPDATE CASCADE ON DELETE CASCADE',
        'FOREIGN KEY(span_id)REFERENCES span(id)ON UPDATE CASCADE ON DELETE SET NULL'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class LogData extends DataClass implements Insertable<LogData> {
  final int id;
  final String projectId;
  final String? spanId;
  final String event;
  final int time;
  final String? name;
  final int level;
  final String? stack;
  final int metaCreatedAt;
  final int metaUpdatedAt;
  const LogData(
      {required this.id,
      required this.projectId,
      this.spanId,
      required this.event,
      required this.time,
      this.name,
      required this.level,
      this.stack,
      required this.metaCreatedAt,
      required this.metaUpdatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['project_id'] = Variable<String>(projectId);
    if (!nullToAbsent || spanId != null) {
      map['span_id'] = Variable<String>(spanId);
    }
    map['event'] = Variable<String>(event);
    map['time'] = Variable<int>(time);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['level'] = Variable<int>(level);
    if (!nullToAbsent || stack != null) {
      map['stack'] = Variable<String>(stack);
    }
    map['meta_created_at'] = Variable<int>(metaCreatedAt);
    map['meta_updated_at'] = Variable<int>(metaUpdatedAt);
    return map;
  }

  LogCompanion toCompanion(bool nullToAbsent) {
    return LogCompanion(
      id: Value(id),
      projectId: Value(projectId),
      spanId:
          spanId == null && nullToAbsent ? const Value.absent() : Value(spanId),
      event: Value(event),
      time: Value(time),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      level: Value(level),
      stack:
          stack == null && nullToAbsent ? const Value.absent() : Value(stack),
      metaCreatedAt: Value(metaCreatedAt),
      metaUpdatedAt: Value(metaUpdatedAt),
    );
  }

  factory LogData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LogData(
      id: serializer.fromJson<int>(json['id']),
      projectId: serializer.fromJson<String>(json['project_id']),
      spanId: serializer.fromJson<String?>(json['span_id']),
      event: serializer.fromJson<String>(json['event']),
      time: serializer.fromJson<int>(json['time']),
      name: serializer.fromJson<String?>(json['name']),
      level: serializer.fromJson<int>(json['level']),
      stack: serializer.fromJson<String?>(json['stack']),
      metaCreatedAt: serializer.fromJson<int>(json['meta_created_at']),
      metaUpdatedAt: serializer.fromJson<int>(json['meta_updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'project_id': serializer.toJson<String>(projectId),
      'span_id': serializer.toJson<String?>(spanId),
      'event': serializer.toJson<String>(event),
      'time': serializer.toJson<int>(time),
      'name': serializer.toJson<String?>(name),
      'level': serializer.toJson<int>(level),
      'stack': serializer.toJson<String?>(stack),
      'meta_created_at': serializer.toJson<int>(metaCreatedAt),
      'meta_updated_at': serializer.toJson<int>(metaUpdatedAt),
    };
  }

  LogData copyWith(
          {int? id,
          String? projectId,
          Value<String?> spanId = const Value.absent(),
          String? event,
          int? time,
          Value<String?> name = const Value.absent(),
          int? level,
          Value<String?> stack = const Value.absent(),
          int? metaCreatedAt,
          int? metaUpdatedAt}) =>
      LogData(
        id: id ?? this.id,
        projectId: projectId ?? this.projectId,
        spanId: spanId.present ? spanId.value : this.spanId,
        event: event ?? this.event,
        time: time ?? this.time,
        name: name.present ? name.value : this.name,
        level: level ?? this.level,
        stack: stack.present ? stack.value : this.stack,
        metaCreatedAt: metaCreatedAt ?? this.metaCreatedAt,
        metaUpdatedAt: metaUpdatedAt ?? this.metaUpdatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('LogData(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('spanId: $spanId, ')
          ..write('event: $event, ')
          ..write('time: $time, ')
          ..write('name: $name, ')
          ..write('level: $level, ')
          ..write('stack: $stack, ')
          ..write('metaCreatedAt: $metaCreatedAt, ')
          ..write('metaUpdatedAt: $metaUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, projectId, spanId, event, time, name,
      level, stack, metaCreatedAt, metaUpdatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LogData &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.spanId == this.spanId &&
          other.event == this.event &&
          other.time == this.time &&
          other.name == this.name &&
          other.level == this.level &&
          other.stack == this.stack &&
          other.metaCreatedAt == this.metaCreatedAt &&
          other.metaUpdatedAt == this.metaUpdatedAt);
}

class LogCompanion extends UpdateCompanion<LogData> {
  final Value<int> id;
  final Value<String> projectId;
  final Value<String?> spanId;
  final Value<String> event;
  final Value<int> time;
  final Value<String?> name;
  final Value<int> level;
  final Value<String?> stack;
  final Value<int> metaCreatedAt;
  final Value<int> metaUpdatedAt;
  const LogCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.spanId = const Value.absent(),
    this.event = const Value.absent(),
    this.time = const Value.absent(),
    this.name = const Value.absent(),
    this.level = const Value.absent(),
    this.stack = const Value.absent(),
    this.metaCreatedAt = const Value.absent(),
    this.metaUpdatedAt = const Value.absent(),
  });
  LogCompanion.insert({
    this.id = const Value.absent(),
    required String projectId,
    this.spanId = const Value.absent(),
    required String event,
    required int time,
    this.name = const Value.absent(),
    required int level,
    this.stack = const Value.absent(),
    this.metaCreatedAt = const Value.absent(),
    this.metaUpdatedAt = const Value.absent(),
  })  : projectId = Value(projectId),
        event = Value(event),
        time = Value(time),
        level = Value(level);
  static Insertable<LogData> custom({
    Expression<int>? id,
    Expression<String>? projectId,
    Expression<String>? spanId,
    Expression<String>? event,
    Expression<int>? time,
    Expression<String>? name,
    Expression<int>? level,
    Expression<String>? stack,
    Expression<int>? metaCreatedAt,
    Expression<int>? metaUpdatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (spanId != null) 'span_id': spanId,
      if (event != null) 'event': event,
      if (time != null) 'time': time,
      if (name != null) 'name': name,
      if (level != null) 'level': level,
      if (stack != null) 'stack': stack,
      if (metaCreatedAt != null) 'meta_created_at': metaCreatedAt,
      if (metaUpdatedAt != null) 'meta_updated_at': metaUpdatedAt,
    });
  }

  LogCompanion copyWith(
      {Value<int>? id,
      Value<String>? projectId,
      Value<String?>? spanId,
      Value<String>? event,
      Value<int>? time,
      Value<String?>? name,
      Value<int>? level,
      Value<String?>? stack,
      Value<int>? metaCreatedAt,
      Value<int>? metaUpdatedAt}) {
    return LogCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      spanId: spanId ?? this.spanId,
      event: event ?? this.event,
      time: time ?? this.time,
      name: name ?? this.name,
      level: level ?? this.level,
      stack: stack ?? this.stack,
      metaCreatedAt: metaCreatedAt ?? this.metaCreatedAt,
      metaUpdatedAt: metaUpdatedAt ?? this.metaUpdatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (spanId.present) {
      map['span_id'] = Variable<String>(spanId.value);
    }
    if (event.present) {
      map['event'] = Variable<String>(event.value);
    }
    if (time.present) {
      map['time'] = Variable<int>(time.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (stack.present) {
      map['stack'] = Variable<String>(stack.value);
    }
    if (metaCreatedAt.present) {
      map['meta_created_at'] = Variable<int>(metaCreatedAt.value);
    }
    if (metaUpdatedAt.present) {
      map['meta_updated_at'] = Variable<int>(metaUpdatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('spanId: $spanId, ')
          ..write('event: $event, ')
          ..write('time: $time, ')
          ..write('name: $name, ')
          ..write('level: $level, ')
          ..write('stack: $stack, ')
          ..write('metaCreatedAt: $metaCreatedAt, ')
          ..write('metaUpdatedAt: $metaUpdatedAt')
          ..write(')'))
        .toString();
  }
}

class Tag extends Table with TableInfo<Tag, TagData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Tag(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _logIdMeta = const VerificationMeta('logId');
  late final GeneratedColumn<int> logId = GeneratedColumn<int>(
      'log_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _kMeta = const VerificationMeta('k');
  late final GeneratedColumn<String> k = GeneratedColumn<String>(
      'k', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _vMeta = const VerificationMeta('v');
  late final GeneratedColumn<String> v = GeneratedColumn<String>(
      'v', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, logId, k, v];
  @override
  String get aliasedName => _alias ?? 'tag';
  @override
  String get actualTableName => 'tag';
  @override
  VerificationContext validateIntegrity(Insertable<TagData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('log_id')) {
      context.handle(
          _logIdMeta, logId.isAcceptableOrUnknown(data['log_id']!, _logIdMeta));
    } else if (isInserting) {
      context.missing(_logIdMeta);
    }
    if (data.containsKey('k')) {
      context.handle(_kMeta, k.isAcceptableOrUnknown(data['k']!, _kMeta));
    } else if (isInserting) {
      context.missing(_kMeta);
    }
    if (data.containsKey('v')) {
      context.handle(_vMeta, v.isAcceptableOrUnknown(data['v']!, _vMeta));
    } else if (isInserting) {
      context.missing(_vMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TagData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TagData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      logId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}log_id'])!,
      k: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}k'])!,
      v: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}v'])!,
    );
  }

  @override
  Tag createAlias(String alias) {
    return Tag(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(log_id)REFERENCES log(id)ON UPDATE CASCADE ON DELETE CASCADE'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class TagData extends DataClass implements Insertable<TagData> {
  final int id;
  final int logId;
  final String k;
  final String v;
  const TagData(
      {required this.id,
      required this.logId,
      required this.k,
      required this.v});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['log_id'] = Variable<int>(logId);
    map['k'] = Variable<String>(k);
    map['v'] = Variable<String>(v);
    return map;
  }

  TagCompanion toCompanion(bool nullToAbsent) {
    return TagCompanion(
      id: Value(id),
      logId: Value(logId),
      k: Value(k),
      v: Value(v),
    );
  }

  factory TagData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TagData(
      id: serializer.fromJson<int>(json['id']),
      logId: serializer.fromJson<int>(json['log_id']),
      k: serializer.fromJson<String>(json['k']),
      v: serializer.fromJson<String>(json['v']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'log_id': serializer.toJson<int>(logId),
      'k': serializer.toJson<String>(k),
      'v': serializer.toJson<String>(v),
    };
  }

  TagData copyWith({int? id, int? logId, String? k, String? v}) => TagData(
        id: id ?? this.id,
        logId: logId ?? this.logId,
        k: k ?? this.k,
        v: v ?? this.v,
      );
  @override
  String toString() {
    return (StringBuffer('TagData(')
          ..write('id: $id, ')
          ..write('logId: $logId, ')
          ..write('k: $k, ')
          ..write('v: $v')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, logId, k, v);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagData &&
          other.id == this.id &&
          other.logId == this.logId &&
          other.k == this.k &&
          other.v == this.v);
}

class TagCompanion extends UpdateCompanion<TagData> {
  final Value<int> id;
  final Value<int> logId;
  final Value<String> k;
  final Value<String> v;
  const TagCompanion({
    this.id = const Value.absent(),
    this.logId = const Value.absent(),
    this.k = const Value.absent(),
    this.v = const Value.absent(),
  });
  TagCompanion.insert({
    this.id = const Value.absent(),
    required int logId,
    required String k,
    required String v,
  })  : logId = Value(logId),
        k = Value(k),
        v = Value(v);
  static Insertable<TagData> custom({
    Expression<int>? id,
    Expression<int>? logId,
    Expression<String>? k,
    Expression<String>? v,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (logId != null) 'log_id': logId,
      if (k != null) 'k': k,
      if (v != null) 'v': v,
    });
  }

  TagCompanion copyWith(
      {Value<int>? id, Value<int>? logId, Value<String>? k, Value<String>? v}) {
    return TagCompanion(
      id: id ?? this.id,
      logId: logId ?? this.logId,
      k: k ?? this.k,
      v: v ?? this.v,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (logId.present) {
      map['log_id'] = Variable<int>(logId.value);
    }
    if (k.present) {
      map['k'] = Variable<String>(k.value);
    }
    if (v.present) {
      map['v'] = Variable<String>(v.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagCompanion(')
          ..write('id: $id, ')
          ..write('logId: $logId, ')
          ..write('k: $k, ')
          ..write('v: $v')
          ..write(')'))
        .toString();
  }
}

class Breadcrumb extends Table with TableInfo<Breadcrumb, BreadcrumbData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Breadcrumb(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _logIdMeta = const VerificationMeta('logId');
  late final GeneratedColumn<int> logId = GeneratedColumn<int>(
      'log_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _vMeta = const VerificationMeta('v');
  late final GeneratedColumn<String> v = GeneratedColumn<String>(
      'v', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, logId, v];
  @override
  String get aliasedName => _alias ?? 'breadcrumb';
  @override
  String get actualTableName => 'breadcrumb';
  @override
  VerificationContext validateIntegrity(Insertable<BreadcrumbData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('log_id')) {
      context.handle(
          _logIdMeta, logId.isAcceptableOrUnknown(data['log_id']!, _logIdMeta));
    } else if (isInserting) {
      context.missing(_logIdMeta);
    }
    if (data.containsKey('v')) {
      context.handle(_vMeta, v.isAcceptableOrUnknown(data['v']!, _vMeta));
    } else if (isInserting) {
      context.missing(_vMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BreadcrumbData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BreadcrumbData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      logId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}log_id'])!,
      v: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}v'])!,
    );
  }

  @override
  Breadcrumb createAlias(String alias) {
    return Breadcrumb(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(log_id)REFERENCES log(id)ON UPDATE CASCADE ON DELETE CASCADE'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class BreadcrumbData extends DataClass implements Insertable<BreadcrumbData> {
  final int id;
  final int logId;
  final String v;
  const BreadcrumbData(
      {required this.id, required this.logId, required this.v});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['log_id'] = Variable<int>(logId);
    map['v'] = Variable<String>(v);
    return map;
  }

  BreadcrumbCompanion toCompanion(bool nullToAbsent) {
    return BreadcrumbCompanion(
      id: Value(id),
      logId: Value(logId),
      v: Value(v),
    );
  }

  factory BreadcrumbData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BreadcrumbData(
      id: serializer.fromJson<int>(json['id']),
      logId: serializer.fromJson<int>(json['log_id']),
      v: serializer.fromJson<String>(json['v']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'log_id': serializer.toJson<int>(logId),
      'v': serializer.toJson<String>(v),
    };
  }

  BreadcrumbData copyWith({int? id, int? logId, String? v}) => BreadcrumbData(
        id: id ?? this.id,
        logId: logId ?? this.logId,
        v: v ?? this.v,
      );
  @override
  String toString() {
    return (StringBuffer('BreadcrumbData(')
          ..write('id: $id, ')
          ..write('logId: $logId, ')
          ..write('v: $v')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, logId, v);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BreadcrumbData &&
          other.id == this.id &&
          other.logId == this.logId &&
          other.v == this.v);
}

class BreadcrumbCompanion extends UpdateCompanion<BreadcrumbData> {
  final Value<int> id;
  final Value<int> logId;
  final Value<String> v;
  const BreadcrumbCompanion({
    this.id = const Value.absent(),
    this.logId = const Value.absent(),
    this.v = const Value.absent(),
  });
  BreadcrumbCompanion.insert({
    this.id = const Value.absent(),
    required int logId,
    required String v,
  })  : logId = Value(logId),
        v = Value(v);
  static Insertable<BreadcrumbData> custom({
    Expression<int>? id,
    Expression<int>? logId,
    Expression<String>? v,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (logId != null) 'log_id': logId,
      if (v != null) 'v': v,
    });
  }

  BreadcrumbCompanion copyWith(
      {Value<int>? id, Value<int>? logId, Value<String>? v}) {
    return BreadcrumbCompanion(
      id: id ?? this.id,
      logId: logId ?? this.logId,
      v: v ?? this.v,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (logId.present) {
      map['log_id'] = Variable<int>(logId.value);
    }
    if (v.present) {
      map['v'] = Variable<String>(v.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BreadcrumbCompanion(')
          ..write('id: $id, ')
          ..write('logId: $logId, ')
          ..write('v: $v')
          ..write(')'))
        .toString();
  }
}

class Pinned extends Table with TableInfo<Pinned, PinnedData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Pinned(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  @override
  List<GeneratedColumn> get $columns => [id];
  @override
  String get aliasedName => _alias ?? 'pinned';
  @override
  String get actualTableName => 'pinned';
  @override
  VerificationContext validateIntegrity(Insertable<PinnedData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PinnedData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PinnedData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
    );
  }

  @override
  Pinned createAlias(String alias) {
    return Pinned(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(id)REFERENCES log(id)ON UPDATE CASCADE ON DELETE CASCADE'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class PinnedData extends DataClass implements Insertable<PinnedData> {
  final int id;
  const PinnedData({required this.id});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    return map;
  }

  PinnedCompanion toCompanion(bool nullToAbsent) {
    return PinnedCompanion(
      id: Value(id),
    );
  }

  factory PinnedData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PinnedData(
      id: serializer.fromJson<int>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
    };
  }

  PinnedData copyWith({int? id}) => PinnedData(
        id: id ?? this.id,
      );
  @override
  String toString() {
    return (StringBuffer('PinnedData(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => id.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is PinnedData && other.id == this.id);
}

class PinnedCompanion extends UpdateCompanion<PinnedData> {
  final Value<int> id;
  const PinnedCompanion({
    this.id = const Value.absent(),
  });
  PinnedCompanion.insert({
    this.id = const Value.absent(),
  });
  static Insertable<PinnedData> custom({
    Expression<int>? id,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
    });
  }

  PinnedCompanion copyWith({Value<int>? id}) {
    return PinnedCompanion(
      id: id ?? this.id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PinnedCompanion(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

class Starred extends Table with TableInfo<Starred, StarredData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Starred(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  @override
  List<GeneratedColumn> get $columns => [id];
  @override
  String get aliasedName => _alias ?? 'starred';
  @override
  String get actualTableName => 'starred';
  @override
  VerificationContext validateIntegrity(Insertable<StarredData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StarredData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StarredData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
    );
  }

  @override
  Starred createAlias(String alias) {
    return Starred(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(id)REFERENCES log(id)ON UPDATE CASCADE ON DELETE CASCADE'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class StarredData extends DataClass implements Insertable<StarredData> {
  final int id;
  const StarredData({required this.id});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    return map;
  }

  StarredCompanion toCompanion(bool nullToAbsent) {
    return StarredCompanion(
      id: Value(id),
    );
  }

  factory StarredData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StarredData(
      id: serializer.fromJson<int>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
    };
  }

  StarredData copyWith({int? id}) => StarredData(
        id: id ?? this.id,
      );
  @override
  String toString() {
    return (StringBuffer('StarredData(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => id.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is StarredData && other.id == this.id);
}

class StarredCompanion extends UpdateCompanion<StarredData> {
  final Value<int> id;
  const StarredCompanion({
    this.id = const Value.absent(),
  });
  StarredCompanion.insert({
    this.id = const Value.absent(),
  });
  static Insertable<StarredData> custom({
    Expression<int>? id,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
    });
  }

  StarredCompanion copyWith({Value<int>? id}) {
    return StarredCompanion(
      id: id ?? this.id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StarredCompanion(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

class Search extends Table with TableInfo<Search, SearchData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Search(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _suffixMeta = const VerificationMeta('suffix');
  late final GeneratedColumn<String> suffix = GeneratedColumn<String>(
      'suffix', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _logIdMeta = const VerificationMeta('logId');
  late final GeneratedColumn<int> logId = GeneratedColumn<int>(
      'log_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
      'word', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _lenMeta = const VerificationMeta('len');
  late final GeneratedColumn<int> len = GeneratedColumn<int>(
      'len', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [suffix, logId, word, len];
  @override
  String get aliasedName => _alias ?? 'search';
  @override
  String get actualTableName => 'search';
  @override
  VerificationContext validateIntegrity(Insertable<SearchData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('suffix')) {
      context.handle(_suffixMeta,
          suffix.isAcceptableOrUnknown(data['suffix']!, _suffixMeta));
    } else if (isInserting) {
      context.missing(_suffixMeta);
    }
    if (data.containsKey('log_id')) {
      context.handle(
          _logIdMeta, logId.isAcceptableOrUnknown(data['log_id']!, _logIdMeta));
    } else if (isInserting) {
      context.missing(_logIdMeta);
    }
    if (data.containsKey('word')) {
      context.handle(
          _wordMeta, word.isAcceptableOrUnknown(data['word']!, _wordMeta));
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('len')) {
      context.handle(
          _lenMeta, len.isAcceptableOrUnknown(data['len']!, _lenMeta));
    } else if (isInserting) {
      context.missing(_lenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {suffix, logId, word};
  @override
  SearchData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SearchData(
      suffix: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}suffix'])!,
      logId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}log_id'])!,
      word: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}word'])!,
      len: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}len'])!,
    );
  }

  @override
  Search createAlias(String alias) {
    return Search(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
        'PRIMARY KEY(suffix, log_id, word)',
        'FOREIGN KEY(log_id)REFERENCES log(id)ON UPDATE CASCADE ON DELETE CASCADE'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class SearchData extends DataClass implements Insertable<SearchData> {
  final String suffix;
  final int logId;
  final String word;
  final int len;
  const SearchData(
      {required this.suffix,
      required this.logId,
      required this.word,
      required this.len});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['suffix'] = Variable<String>(suffix);
    map['log_id'] = Variable<int>(logId);
    map['word'] = Variable<String>(word);
    map['len'] = Variable<int>(len);
    return map;
  }

  SearchCompanion toCompanion(bool nullToAbsent) {
    return SearchCompanion(
      suffix: Value(suffix),
      logId: Value(logId),
      word: Value(word),
      len: Value(len),
    );
  }

  factory SearchData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchData(
      suffix: serializer.fromJson<String>(json['suffix']),
      logId: serializer.fromJson<int>(json['log_id']),
      word: serializer.fromJson<String>(json['word']),
      len: serializer.fromJson<int>(json['len']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'suffix': serializer.toJson<String>(suffix),
      'log_id': serializer.toJson<int>(logId),
      'word': serializer.toJson<String>(word),
      'len': serializer.toJson<int>(len),
    };
  }

  SearchData copyWith({String? suffix, int? logId, String? word, int? len}) =>
      SearchData(
        suffix: suffix ?? this.suffix,
        logId: logId ?? this.logId,
        word: word ?? this.word,
        len: len ?? this.len,
      );
  @override
  String toString() {
    return (StringBuffer('SearchData(')
          ..write('suffix: $suffix, ')
          ..write('logId: $logId, ')
          ..write('word: $word, ')
          ..write('len: $len')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(suffix, logId, word, len);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchData &&
          other.suffix == this.suffix &&
          other.logId == this.logId &&
          other.word == this.word &&
          other.len == this.len);
}

class SearchCompanion extends UpdateCompanion<SearchData> {
  final Value<String> suffix;
  final Value<int> logId;
  final Value<String> word;
  final Value<int> len;
  const SearchCompanion({
    this.suffix = const Value.absent(),
    this.logId = const Value.absent(),
    this.word = const Value.absent(),
    this.len = const Value.absent(),
  });
  SearchCompanion.insert({
    required String suffix,
    required int logId,
    required String word,
    required int len,
  })  : suffix = Value(suffix),
        logId = Value(logId),
        word = Value(word),
        len = Value(len);
  static Insertable<SearchData> custom({
    Expression<String>? suffix,
    Expression<int>? logId,
    Expression<String>? word,
    Expression<int>? len,
  }) {
    return RawValuesInsertable({
      if (suffix != null) 'suffix': suffix,
      if (logId != null) 'log_id': logId,
      if (word != null) 'word': word,
      if (len != null) 'len': len,
    });
  }

  SearchCompanion copyWith(
      {Value<String>? suffix,
      Value<int>? logId,
      Value<String>? word,
      Value<int>? len}) {
    return SearchCompanion(
      suffix: suffix ?? this.suffix,
      logId: logId ?? this.logId,
      word: word ?? this.word,
      len: len ?? this.len,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (suffix.present) {
      map['suffix'] = Variable<String>(suffix.value);
    }
    if (logId.present) {
      map['log_id'] = Variable<int>(logId.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (len.present) {
      map['len'] = Variable<int>(len.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchCompanion(')
          ..write('suffix: $suffix, ')
          ..write('logId: $logId, ')
          ..write('word: $word, ')
          ..write('len: $len')
          ..write(')'))
        .toString();
  }
}

class Kv extends Table with TableInfo<Kv, KvData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Kv(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _kMeta = const VerificationMeta('k');
  late final GeneratedColumn<String> k = GeneratedColumn<String>(
      'k', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _vMeta = const VerificationMeta('v');
  late final GeneratedColumn<String> v = GeneratedColumn<String>(
      'v', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _metaCreatedAtMeta =
      const VerificationMeta('metaCreatedAt');
  late final GeneratedColumn<int> metaCreatedAt = GeneratedColumn<int>(
      'meta_created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (strftime(\'%s\', \'now\'))',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  static const VerificationMeta _metaUpdatedAtMeta =
      const VerificationMeta('metaUpdatedAt');
  late final GeneratedColumn<int> metaUpdatedAt = GeneratedColumn<int>(
      'meta_updated_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints:
          'NOT NULL DEFAULT (strftime(\'%s\', \'now\')) CHECK (meta_updated_at >= meta_created_at)',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  @override
  List<GeneratedColumn> get $columns => [k, v, metaCreatedAt, metaUpdatedAt];
  @override
  String get aliasedName => _alias ?? 'kv';
  @override
  String get actualTableName => 'kv';
  @override
  VerificationContext validateIntegrity(Insertable<KvData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('k')) {
      context.handle(_kMeta, k.isAcceptableOrUnknown(data['k']!, _kMeta));
    } else if (isInserting) {
      context.missing(_kMeta);
    }
    if (data.containsKey('v')) {
      context.handle(_vMeta, v.isAcceptableOrUnknown(data['v']!, _vMeta));
    } else if (isInserting) {
      context.missing(_vMeta);
    }
    if (data.containsKey('meta_created_at')) {
      context.handle(
          _metaCreatedAtMeta,
          metaCreatedAt.isAcceptableOrUnknown(
              data['meta_created_at']!, _metaCreatedAtMeta));
    }
    if (data.containsKey('meta_updated_at')) {
      context.handle(
          _metaUpdatedAtMeta,
          metaUpdatedAt.isAcceptableOrUnknown(
              data['meta_updated_at']!, _metaUpdatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {k};
  @override
  KvData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KvData(
      k: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}k'])!,
      v: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}v'])!,
      metaCreatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}meta_created_at'])!,
      metaUpdatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}meta_updated_at'])!,
    );
  }

  @override
  Kv createAlias(String alias) {
    return Kv(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  bool get dontWriteConstraints => true;
}

class KvData extends DataClass implements Insertable<KvData> {
  final String k;
  final String v;
  final int metaCreatedAt;
  final int metaUpdatedAt;
  const KvData(
      {required this.k,
      required this.v,
      required this.metaCreatedAt,
      required this.metaUpdatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['k'] = Variable<String>(k);
    map['v'] = Variable<String>(v);
    map['meta_created_at'] = Variable<int>(metaCreatedAt);
    map['meta_updated_at'] = Variable<int>(metaUpdatedAt);
    return map;
  }

  KvCompanion toCompanion(bool nullToAbsent) {
    return KvCompanion(
      k: Value(k),
      v: Value(v),
      metaCreatedAt: Value(metaCreatedAt),
      metaUpdatedAt: Value(metaUpdatedAt),
    );
  }

  factory KvData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KvData(
      k: serializer.fromJson<String>(json['k']),
      v: serializer.fromJson<String>(json['v']),
      metaCreatedAt: serializer.fromJson<int>(json['meta_created_at']),
      metaUpdatedAt: serializer.fromJson<int>(json['meta_updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'k': serializer.toJson<String>(k),
      'v': serializer.toJson<String>(v),
      'meta_created_at': serializer.toJson<int>(metaCreatedAt),
      'meta_updated_at': serializer.toJson<int>(metaUpdatedAt),
    };
  }

  KvData copyWith(
          {String? k, String? v, int? metaCreatedAt, int? metaUpdatedAt}) =>
      KvData(
        k: k ?? this.k,
        v: v ?? this.v,
        metaCreatedAt: metaCreatedAt ?? this.metaCreatedAt,
        metaUpdatedAt: metaUpdatedAt ?? this.metaUpdatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('KvData(')
          ..write('k: $k, ')
          ..write('v: $v, ')
          ..write('metaCreatedAt: $metaCreatedAt, ')
          ..write('metaUpdatedAt: $metaUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(k, v, metaCreatedAt, metaUpdatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KvData &&
          other.k == this.k &&
          other.v == this.v &&
          other.metaCreatedAt == this.metaCreatedAt &&
          other.metaUpdatedAt == this.metaUpdatedAt);
}

class KvCompanion extends UpdateCompanion<KvData> {
  final Value<String> k;
  final Value<String> v;
  final Value<int> metaCreatedAt;
  final Value<int> metaUpdatedAt;
  const KvCompanion({
    this.k = const Value.absent(),
    this.v = const Value.absent(),
    this.metaCreatedAt = const Value.absent(),
    this.metaUpdatedAt = const Value.absent(),
  });
  KvCompanion.insert({
    required String k,
    required String v,
    this.metaCreatedAt = const Value.absent(),
    this.metaUpdatedAt = const Value.absent(),
  })  : k = Value(k),
        v = Value(v);
  static Insertable<KvData> custom({
    Expression<String>? k,
    Expression<String>? v,
    Expression<int>? metaCreatedAt,
    Expression<int>? metaUpdatedAt,
  }) {
    return RawValuesInsertable({
      if (k != null) 'k': k,
      if (v != null) 'v': v,
      if (metaCreatedAt != null) 'meta_created_at': metaCreatedAt,
      if (metaUpdatedAt != null) 'meta_updated_at': metaUpdatedAt,
    });
  }

  KvCompanion copyWith(
      {Value<String>? k,
      Value<String>? v,
      Value<int>? metaCreatedAt,
      Value<int>? metaUpdatedAt}) {
    return KvCompanion(
      k: k ?? this.k,
      v: v ?? this.v,
      metaCreatedAt: metaCreatedAt ?? this.metaCreatedAt,
      metaUpdatedAt: metaUpdatedAt ?? this.metaUpdatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (k.present) {
      map['k'] = Variable<String>(k.value);
    }
    if (v.present) {
      map['v'] = Variable<String>(v.value);
    }
    if (metaCreatedAt.present) {
      map['meta_created_at'] = Variable<int>(metaCreatedAt.value);
    }
    if (metaUpdatedAt.present) {
      map['meta_updated_at'] = Variable<int>(metaUpdatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KvCompanion(')
          ..write('k: $k, ')
          ..write('v: $v, ')
          ..write('metaCreatedAt: $metaCreatedAt, ')
          ..write('metaUpdatedAt: $metaUpdatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final Characteristic characteristic = Characteristic(this);
  late final Index characteristicMetaCreatedAtIdx = Index(
      'characteristic_meta_created_at_idx',
      'CREATE INDEX IF NOT EXISTS characteristic_meta_created_at_idx ON characteristic (meta_created_at)');
  late final Index characteristicMetaUpdatedAtIdx = Index(
      'characteristic_meta_updated_at_idx',
      'CREATE INDEX IF NOT EXISTS characteristic_meta_updated_at_idx ON characteristic (meta_updated_at)');
  late final Trigger characteristicMetaUpdatedAtTrig = Trigger(
      'CREATE TRIGGER IF NOT EXISTS characteristic_meta_updated_at_trig AFTER UPDATE ON characteristic BEGIN UPDATE characteristic SET meta_updated_at = strftime(\'%s\', \'now\') WHERE type = NEW.type AND id = NEW.id;END',
      'characteristic_meta_updated_at_trig');
  late final Project project = Project(this);
  late final Index projectNameIdx = Index('project_name_idx',
      'CREATE INDEX IF NOT EXISTS project_name_idx ON project (name)');
  late final Index projectMetaCreatedAtIdx = Index(
      'project_meta_created_at_idx',
      'CREATE INDEX IF NOT EXISTS project_meta_created_at_idx ON project (meta_created_at)');
  late final Index projectMetaUpdatedAtIdx = Index(
      'project_meta_updated_at_idx',
      'CREATE INDEX IF NOT EXISTS project_meta_updated_at_idx ON project (meta_updated_at)');
  late final Trigger projectMetaUpdatedAtTrig = Trigger(
      'CREATE TRIGGER IF NOT EXISTS project_meta_updated_at_trig AFTER UPDATE ON project BEGIN UPDATE project SET meta_updated_at = strftime(\'%s\', \'now\') WHERE id = NEW.id;END',
      'project_meta_updated_at_trig');
  late final Trigger projectEmptyNameTrig = Trigger(
      'CREATE TRIGGER IF NOT EXISTS project_empty_name_trig AFTER INSERT ON project WHEN coalesce(NEW.name, \'\') = \'\' BEGIN UPDATE project SET name = NEW.id WHERE id = NEW.id;END',
      'project_empty_name_trig');
  late final Span span = Span(this);
  late final Index spanProjectIdIdx = Index('span_project_id_idx',
      'CREATE INDEX IF NOT EXISTS span_project_id_idx ON span (project_id)');
  late final Index spanOperationIdx = Index('span_operation_idx',
      'CREATE INDEX IF NOT EXISTS span_operation_idx ON span (operation)');
  late final Index spanMetaCreatedAtIdx = Index('span_meta_created_at_idx',
      'CREATE INDEX IF NOT EXISTS span_meta_created_at_idx ON span (meta_created_at)');
  late final Index spanMetaUpdatedAtIdx = Index('span_meta_updated_at_idx',
      'CREATE INDEX IF NOT EXISTS span_meta_updated_at_idx ON span (meta_updated_at)');
  late final Trigger spanMetaUpdatedAtTrig = Trigger(
      'CREATE TRIGGER IF NOT EXISTS span_meta_updated_at_trig AFTER UPDATE ON span BEGIN UPDATE span SET meta_updated_at = strftime(\'%s\', \'now\') WHERE id = NEW.id;END',
      'span_meta_updated_at_trig');
  late final Log log = Log(this);
  late final Index logProjectIdIdx = Index('log_project_id_idx',
      'CREATE INDEX IF NOT EXISTS log_project_id_idx ON log (project_id)');
  late final Index logSpanIdIdx = Index('log_span_id_idx',
      'CREATE INDEX IF NOT EXISTS log_span_id_idx ON log (span_id)');
  late final Index logNameIdx = Index(
      'log_name_idx', 'CREATE INDEX IF NOT EXISTS log_name_idx ON log (name)');
  late final Index logTimeIdx = Index(
      'log_time_idx', 'CREATE INDEX IF NOT EXISTS log_time_idx ON log (time)');
  late final Index logLevelIdx = Index('log_level_idx',
      'CREATE INDEX IF NOT EXISTS log_level_idx ON log (level)');
  late final Index logMetaCreatedAtIdx = Index('log_meta_created_at_idx',
      'CREATE INDEX IF NOT EXISTS log_meta_created_at_idx ON log (meta_created_at)');
  late final Index logMetaUpdatedAtIdx = Index('log_meta_updated_at_idx',
      'CREATE INDEX IF NOT EXISTS log_meta_updated_at_idx ON log (meta_updated_at)');
  late final Trigger logMetaUpdatedAtTrig = Trigger(
      'CREATE TRIGGER IF NOT EXISTS log_meta_updated_at_trig AFTER UPDATE ON log BEGIN UPDATE log SET meta_updated_at = strftime(\'%s\', \'now\') WHERE id = NEW.id;END',
      'log_meta_updated_at_trig');
  late final Tag tag = Tag(this);
  late final Index tagLogIdIdx = Index('tag_log_id_idx',
      'CREATE INDEX IF NOT EXISTS tag_log_id_idx ON tag (log_id)');
  late final Index tagKIdx =
      Index('tag_k_idx', 'CREATE INDEX IF NOT EXISTS tag_k_idx ON tag (k)');
  late final Index tagVIdx =
      Index('tag_v_idx', 'CREATE INDEX IF NOT EXISTS tag_v_idx ON tag (v)');
  late final Breadcrumb breadcrumb = Breadcrumb(this);
  late final Index breadcrumbLogIdIdx = Index('breadcrumb_log_id_idx',
      'CREATE INDEX IF NOT EXISTS breadcrumb_log_id_idx ON breadcrumb (log_id)');
  late final Pinned pinned = Pinned(this);
  late final Starred starred = Starred(this);
  late final Search search = Search(this);
  late final Index searchSuffixIdx = Index('search_suffix_idx',
      'CREATE INDEX IF NOT EXISTS search_suffix_idx ON search (suffix)');
  late final Index searchLogIdIdx = Index('search_log_id_idx',
      'CREATE INDEX IF NOT EXISTS search_log_id_idx ON search (log_id)');
  late final Index searchLenIdx = Index('search_len_idx',
      'CREATE INDEX IF NOT EXISTS search_len_idx ON search (len)');
  late final Kv kv = Kv(this);
  late final Index kvMetaCreatedAtIdx = Index('kv_meta_created_at_idx',
      'CREATE INDEX IF NOT EXISTS kv_meta_created_at_idx ON kv (meta_created_at)');
  late final Index kvMetaUpdatedAtIdx = Index('kv_meta_updated_at_idx',
      'CREATE INDEX IF NOT EXISTS kv_meta_updated_at_idx ON kv (meta_updated_at)');
  late final Trigger kvMetaUpdatedAtTrig = Trigger(
      'CREATE TRIGGER IF NOT EXISTS kv_meta_updated_at_trig AFTER UPDATE ON kv BEGIN UPDATE kv SET meta_updated_at = strftime(\'%s\', \'now\') WHERE k = NEW.k;END',
      'kv_meta_updated_at_trig');
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        characteristic,
        characteristicMetaCreatedAtIdx,
        characteristicMetaUpdatedAtIdx,
        characteristicMetaUpdatedAtTrig,
        project,
        projectNameIdx,
        projectMetaCreatedAtIdx,
        projectMetaUpdatedAtIdx,
        projectMetaUpdatedAtTrig,
        projectEmptyNameTrig,
        span,
        spanProjectIdIdx,
        spanOperationIdx,
        spanMetaCreatedAtIdx,
        spanMetaUpdatedAtIdx,
        spanMetaUpdatedAtTrig,
        log,
        logProjectIdIdx,
        logSpanIdIdx,
        logNameIdx,
        logTimeIdx,
        logLevelIdx,
        logMetaCreatedAtIdx,
        logMetaUpdatedAtIdx,
        logMetaUpdatedAtTrig,
        tag,
        tagLogIdIdx,
        tagKIdx,
        tagVIdx,
        breadcrumb,
        breadcrumbLogIdIdx,
        pinned,
        starred,
        search,
        searchSuffixIdx,
        searchLogIdIdx,
        searchLenIdx,
        kv,
        kvMetaCreatedAtIdx,
        kvMetaUpdatedAtIdx,
        kvMetaUpdatedAtTrig
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('characteristic',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('characteristic', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('project',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('project', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('project',
                limitUpdateKind: UpdateKind.insert),
            result: [
              TableUpdate('project', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('project',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('span', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('project',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('span', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('span',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('span', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('project',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('log', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('project',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('log', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('span',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('log', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('span',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('log', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('log',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('log', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('log',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('tag', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('log',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('tag', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('log',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('breadcrumb', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('log',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('breadcrumb', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('log',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('pinned', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('log',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('pinned', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('log',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('starred', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('log',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('starred', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('log',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('search', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('log',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('search', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('kv',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('kv', kind: UpdateKind.update),
            ],
          ),
        ],
      );
}
