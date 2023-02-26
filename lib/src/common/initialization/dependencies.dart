import 'package:database/database.dart';
import 'package:meta/meta.dart';
import 'package:server/server.dart';

import '../../feature/logs/data/logs_local_data_provider.dart';
import '../../feature/logs/data/logs_repository.dart';

/// Dependencies
@sealed
abstract class Dependencies {
  Dependencies._();

  /// Database
  static final Database database = Database.lazy(logStatements: false, dropDatabase: false);

  /// Server
  static final Server server = Server();

  /// Logs repository factory
  static ILogsRepository get logsRepository =>
      LogsRepositoryImpl(localDataProvider: LogsLocalDataProviderDatabaseImpl(database: database));
}
