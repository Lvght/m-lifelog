// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OptionsScreenStore on _OptionsScreenStoreBase, Store {
  final _$isLoggedInAtom = Atom(name: '_OptionsScreenStoreBase.isLoggedIn');

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  final _$_OptionsScreenStoreBaseActionController =
      ActionController(name: '_OptionsScreenStoreBase');

  @override
  void setIsLoggedIn(bool v) {
    final _$actionInfo = _$_OptionsScreenStoreBaseActionController.startAction(
        name: '_OptionsScreenStoreBase.setIsLoggedIn');
    try {
      return super.setIsLoggedIn(v);
    } finally {
      _$_OptionsScreenStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoggedIn: ${isLoggedIn}
    ''';
  }
}
