import 'package:database/database.dart';
import 'package:meta/meta.dart';

/// Dependencies
@sealed
abstract class Dependencies {
  Dependencies._();

  /// Database
  late final Database database = Database.lazy();
}
