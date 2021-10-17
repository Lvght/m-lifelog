// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MasterStore on _MasterStoreBase, Store {
  final _$darkThemeAtom = Atom(name: '_MasterStoreBase.darkTheme');

  @override
  bool get darkTheme {
    _$darkThemeAtom.reportRead();
    return super.darkTheme;
  }

  @override
  set darkTheme(bool value) {
    _$darkThemeAtom.reportWrite(value, super.darkTheme, () {
      super.darkTheme = value;
    });
  }

  final _$setDarkThemeAsyncAction =
      AsyncAction('_MasterStoreBase.setDarkTheme');

  @override
  Future<void> setDarkTheme(bool v) {
    return _$setDarkThemeAsyncAction.run(() => super.setDarkTheme(v));
  }

  final _$getContentAsyncAction = AsyncAction('_MasterStoreBase.getContent');

  @override
  Future<void> getContent() {
    return _$getContentAsyncAction.run(() => super.getContent());
  }

  final _$initializeDatabaseAsyncAction =
      AsyncAction('_MasterStoreBase.initializeDatabase');

  @override
  Future<bool> initializeDatabase() {
    return _$initializeDatabaseAsyncAction
        .run(() => super.initializeDatabase());
  }

  @override
  String toString() {
    return '''
darkTheme: ${darkTheme}
    ''';
  }
}
