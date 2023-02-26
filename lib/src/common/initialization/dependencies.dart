import 'package:database/database.dart';
import 'package:meta/meta.dart';
import 'package:server/server.dart';

/// Dependencies
@sealed
abstract class Dependencies {
  Dependencies._();

  /// Database
  static final Database database = Database.lazy(logStatements: false, dropDatabase: false);

  /// Server
  static final Server server = Server();
}
