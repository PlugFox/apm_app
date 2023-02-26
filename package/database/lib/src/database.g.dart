// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
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
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [kv, kvMetaCreatedAtIdx, kvMetaUpdatedAtIdx, kvMetaUpdatedAtTrig];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
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
