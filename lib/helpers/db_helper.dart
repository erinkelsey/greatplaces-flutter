import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

/// [DBHelper] is a helper class for connecting to a
/// local SQLite database on Android and iOS devices.
///
/// Use [DBHelper.database()] to get the database connection.
///
///
class DBHelper {
  /// Returns a database connection to the local SQLite database.
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)');
      },
      version: 1,
    );
  }

  /// Executes an insert statement in the local SQLite database.
  ///
  /// Inserts [data] to local SQLite [table].
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  /// Executes a select statement in the local SQLite database.
  ///
  /// Returns all of the mapped data in [table]
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
