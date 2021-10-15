import 'package:lifelog/helpers/database_helper.dart';
import 'package:lifelog/models/entry.dart';
import 'package:mobx/mobx.dart';
import 'package:sqflite/sqflite.dart';

part 'master_store.g.dart';

class MasterStore = _MasterStoreBase with _$MasterStore;

abstract class _MasterStoreBase with Store {
  _MasterStoreBase();

  Database? _db;
  int _offset = 0;
  final entries = ObservableList<Entry>();

  Future<void>? getContent() async {
    if (_db != null) {
      await _db!.transaction((txn) async {
        List<Map<String, Object?>> result = await txn.query('Entries',
            offset: _offset, limit: 10, orderBy: '-id');

        for (Map<String, Object?> e in result) {
          entries.add(Entry.fromMap(e));
        }

        _offset += 10;
      });
    }
  }

  /// Returns [true] if successful. [false], otherwise.
  Future<bool> initializeDatabase() async {
    _db = await DatabaseHelper.initializeDatabase();
    return _db != null;
  }

  Future<bool>? saveEntry(
      {required String? title,
      required String? content,
      required int? sentiment}) async {
    if (_db != null) {
      // Empty strings MUST NOT be used as values.
      // They might happen because of the TextEditingControllers
      if (title != null && title.isEmpty) title = null;
      if (content != null && content.isEmpty) content = null;

      // At least ONE information must be provided.
      if (title == null && content == null && sentiment == null) return false;

      await _db!.transaction((txn) async {
        int id = await txn.insert('Entries', {
          'title': title,
          'content': content,
          'feeling': sentiment,
          'created_at': DateTime.now().toIso8601String()
        });

        entries.insert(
            0,
            Entry(
                id: id,
                createdAt: DateTime.now(),
                title: title,
                sentiment: sentiment,
                content: content));
      });
    }

    return false;
  }

  Future<void>? deleteEntry(int index) async {
    if (_db != null) {
      if (await _db!.delete('Entries',
              where: 'id = ?', whereArgs: [entries[index].id]) ==
          1) {
        entries.removeAt(index);
      }
    }
  }
}
