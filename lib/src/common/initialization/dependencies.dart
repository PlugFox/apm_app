import 'package:database/database.dart';
import 'package:server/server.dart';

import '../../feature/logs/data/logs_local_data_provider.dart';
import '../../feature/logs/data/logs_repository.dart';

/// Dependencies
class Dependencies {
  Dependencies._internal();
  static final Dependencies _internalSingleton = Dependencies._internal();
  static Dependencies get instance => _internalSingleton;
  static Dependencies get I => _internalSingleton;

  /// Database
  final Database database = Database.lazy(logStatements: false, dropDatabase: false);

  /// Server
  final Server server = Server();

  /// Logs repository factory
  ILogsRepository get logsRepository =>
      LogsRepositoryImpl(localDataProvider: LogsLocalDataProviderDatabaseImpl(database: database));
}
