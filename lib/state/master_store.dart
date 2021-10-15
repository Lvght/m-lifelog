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
      {required String? title, required String? content}) async {
    if (_db != null) {
      await _db!.transaction((txn) async {
        int id =
            await txn.insert('Entries', {'title': title, 'content': content});
      });
    }

    entries.insert(0, Entry(title: title, content: content));

    return false;
  }
}
