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
  bool _exausted = false;
  final entries = ObservableList<Entry>();

  @observable
  bool darkTheme = false;

  @action
  Future<void> getContent() async {
    if (_db != null && !_exausted) {
      await _db!.transaction((txn) async {
        List<Map<String, Object?>> result = await txn.query('Entries',
            offset: _offset, limit: 10, orderBy: '-created_at');

        if (result.length < 10) _exausted = true;

        for (Map<String, Object?> e in result) {
          entries.add(Entry.fromMap(e));
        }

        _offset += result.length;
      });
    }
  }

  Future<void>? reset() async {
    await closeDatabase();
    _offset = 0;
    _exausted = false;
    entries.clear();
    _db = await DatabaseHelper.initializeDatabase();
    await getContent();
  }

  Future<void>? closeDatabase() async {
    if (_db != null) {
      await _db!.close();
    }
  }

  /// Returns [true] if successful. [false], otherwise.
  @action
  Future<bool> initializeDatabase() async {
    _db = await DatabaseHelper.initializeDatabase();

    if (_db != null) {
      List<Map<String, Object?>> r = await _db!.query('User', limit: 1);
      darkTheme = r.first['dark_theme'] as int == 0;

      return true;
    }

    return false;
  }

  Future<bool>? saveEntry(Entry e) async {
    if (_db != null) {
      // Empty strings MUST NOT be used as values.
      // They might happen because of the TextEditingControllers
      String? title = e.title, content = e.content;
      if (e.title != null && e.title!.isEmpty) title = null;
      if (content != null && content.isEmpty) content = null;

      // At least ONE information must be provided.
      if (title == null && content == null && e.sentiment == null) return false;

      await _db!.transaction((txn) async {
        int id = await txn.insert('Entries', {
          'title': title,
          'content': content,
          'feeling': e.sentiment,
          'image': e.image,
          'created_at': e.createdAt.millisecondsSinceEpoch,
        });

        e.id = id;
        entries.add(e);
      });

      entries.sort((Entry a, Entry b) {
        return b.createdAt.compareTo(a.createdAt);
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

  Future<void>? editEntry(Entry e, {required int index}) async {
    if (_db != null) {
      // Empty strings MUST NOT be used as values.
      // They might happen because of the TextEditingControllers
      String? title = e.title, content = e.content;
      if (e.title != null && e.title!.isEmpty) title = null;
      if (content != null && content.isEmpty) content = null;

      int affectedRows = await _db!.update(
          'Entries',
          {
            'title': title,
            'content': content,
            'feeling': e.sentiment,
            'image': e.image,
            'created_at': e.createdAt.millisecondsSinceEpoch,
          },
          where: 'id = ?',
          whereArgs: [e.id]);

      if (affectedRows == 1) {
        entries[index] = e;

        entries.sort((Entry a, Entry b) {
          return b.createdAt.compareTo(a.createdAt);
        });
      }
    }
  }
}
