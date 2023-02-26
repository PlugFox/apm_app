import 'dart:async';
import 'dart:developer' as dev;

import 'package:database/database.dart' as db;
import 'package:entity/entity.dart';

void $handler(db.DriftIsolate connection, Stream<ProjectEntity> entities) async {
  final database = db.Database.connect(await connection.connect());
  final buffer = <ProjectEntity>[];

  Future<void> insertAll() async {
    final copy = buffer.toList();
    buffer.clear();
    await _$insert(database, copy);
  }

  Timer? timer;
  entities.listen(
    (event) {
      buffer.add(event);
      // Send data only once per second
      timer ??= Timer(const Duration(seconds: 1), () async {
        try {
          while (buffer.isNotEmpty) {
            await insertAll();
          }
        } on Object {
          // ignore
        } finally {
          timer = null;
        }
      });
    },
    cancelOnError: false,
  );
}

Future<void> _$insert(db.Database $, List<ProjectEntity> entities) async {
  final projectIds = <String>{};
  final logs = <Log>[];
  final spans = <db.SpanCompanion>[];
  for (final entity in entities) {
    projectIds.add(entity.projectId);
    entity.mapOrNull(
      log: (l) => logs.add(l),
      span: (s) => spans.add(
        db.SpanCompanion.insert(
          id: s.id,
          projectId: s.projectId,
          operation: s.operation,
          memo: db.Value.ofNullable(s.description),
        ),
      ),
    );
  }
  final projects = projectIds
      .where((id) => id.isNotEmpty)
      .map<db.ProjectCompanion>((e) => db.ProjectCompanion.insert(id: e))
      .toList();
  var count = projects.length + spans.length + logs.length;
  dev.log(
    'Start inserting $count entities to database',
    level: 300,
    name: 'db',
  );
  try {
    await $.transaction(() async {
      await $.batch((batch) {
        // Insert projects
        batch.insertAll($.project, projects, mode: db.InsertMode.insertOrIgnore);
        // Insert spans
        if (spans.isNotEmpty) batch.insertAll($.span, spans);
      });
      for (final l in logs) {
        // Insert log
        final logId = await $.into($.log).insert(
              db.LogCompanion.insert(
                projectId: l.projectId,
                event: l.event,
                time: l.timestamp.millisecondsSinceEpoch ~/ 1000,
                level: l.level,
                name: db.Value.ofNullable(l.name),
                stack: db.Value.ofNullable(l.stackTrace),
              ),
            );
        await $.batch((batch) {
          // Insert tags
          count += l.tags.length;
          if (l.tags.isNotEmpty) {
            batch.insertAll(
              $.tag,
              l.tags.entries.map<db.TagCompanion>((e) => db.TagCompanion.insert(logId: logId, k: e.key, v: e.value)),
            );
          }
          // Insert breadcrumbs
          count += l.breadcrumbs.length;
          if (l.breadcrumbs.isNotEmpty) {
            batch.insertAll(
              $.breadcrumb,
              l.breadcrumbs.map<db.BreadcrumbCompanion>((e) => db.BreadcrumbCompanion.insert(logId: logId, v: e)),
            );
          }
          // Insert search tokens
          final words = l.extractWords();
          count += words.length;
          if (words.isNotEmpty) {
            batch.insertAll(
              $.search,
              words
                  .map<db.SearchCompanion>((e) => db.SearchCompanion.insert(
                        suffix: e.substring(0, 3),
                        logId: logId,
                        len: e.length,
                        word: e,
                      ))
                  .toList(),
            );
          }
        });
      }
    });
  } on Object catch (error, stackTrace) {
    dev.log(
      'Failed to insert $count entities to database',
      level: 700,
      name: 'db',
      error: error,
      stackTrace: stackTrace,
    );
    rethrow;
  }
  dev.log('Inserted $count entities', name: 'db', level: 500);
}
