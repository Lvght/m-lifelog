import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<void> _onConfigure(Database db) async {
    // Adiciona suporte ao on_delete=cascade
    await db.execute('PRAGMA foreign_keys = ON');
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db
        .execute('CREATE TABLE Entries (id INTEGER PRIMARY KEY, title TEXT, '
            'content TEXT, feeling INT, created_at TEXT)');
  }

  static Future<Database?> initializeDatabase() async {
    Database _db = await openDatabase(
      'lifelog.db',
      version: 1,
      onConfigure: _onConfigure,
      onCreate: _onCreate,
    );
    return _db;
  }
}
