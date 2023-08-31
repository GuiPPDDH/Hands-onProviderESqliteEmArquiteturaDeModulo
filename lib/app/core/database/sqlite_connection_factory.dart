import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:todo_list_provider/app/core/database/sqlite_migration_factory.dart';

class SqliteConnectionFactory {
  static SqliteConnectionFactory? _instanceConnection;
  static const _VERSION = 1;
  static const _DATABASE_NAME = 'Todo List Provider';
  Database? _db;
  final _lock = Lock();

  SqliteConnectionFactory._();

  factory SqliteConnectionFactory() {
    if (_instanceConnection == null) {
      _instanceConnection = SqliteConnectionFactory._();
    }

    return _instanceConnection!;
  }

  Future<Database> openConnection() async {
    var databasePath = await getDatabasesPath();
    var finalDatabasePath = join(
      databasePath,
      _DATABASE_NAME,
    );

    if (_db == null) {
      await _lock.synchronized(() async {
        if (_db == null) {
          return _db = await openDatabase(
            finalDatabasePath,
            version: _VERSION,
            onConfigure: _onConfigure,
            onCreate: _onCreate,
            onUpgrade: _onUpgrade,
            onDowngrade: _onDowngrade,
          );
        }
      });
    }
    return _db!;
  }

  void closeConnection() {
    _db?.close();
    _db = null;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    final batch = db.batch();
    final migrations = SqliteMigrationFactory().getCreateMigration();
    for (var migration in migrations) {
      migration.create(batch);
    }
    batch.commit();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int version) async {
    final batch = db.batch();
    final migrations = SqliteMigrationFactory().getUpgradeMigration(oldVersion);
    for (var migration in migrations) {
      migration.upgrade(batch);
    }
    batch.commit();
  }
  Future<void> _onDowngrade(Database db, int oldVersion, int version) async {}
}
