// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compose_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ComposeStore on _ComposeStoreBase, Store {
  final _$currentSentimentAtom =
      Atom(name: '_ComposeStoreBase.currentSentiment');

  @override
  int? get currentSentiment {
    _$currentSentimentAtom.reportRead();
    return super.currentSentiment;
  }

  @override
  set currentSentiment(int? value) {
    _$currentSentimentAtom.reportWrite(value, super.currentSentiment, () {
      super.currentSentiment = value;
    });
  }

  final _$dateTimeAtom = Atom(name: '_ComposeStoreBase.dateTime');

  @override
  DateTime? get dateTime {
    _$dateTimeAtom.reportRead();
    return super.dateTime;
  }

  @override
  set dateTime(DateTime? value) {
    _$dateTimeAtom.reportWrite(value, super.dateTime, () {
      super.dateTime = value;
    });
  }

  final _$imageAtom = Atom(name: '_ComposeStoreBase.image');

  @override
  Uint8List? get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(Uint8List? value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  final _$_ComposeStoreBaseActionController =
      ActionController(name: '_ComposeStoreBase');

  @override
  void setCurrentSentiment(int? v) {
    final _$actionInfo = _$_ComposeStoreBaseActionController.startAction(
        name: '_ComposeStoreBase.setCurrentSentiment');
    try {
      return super.setCurrentSentiment(v);
    } finally {
      _$_ComposeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDateTime(DateTime? v) {
    final _$actionInfo = _$_ComposeStoreBaseActionController.startAction(
        name: '_ComposeStoreBase.setDateTime');
    try {
      return super.setDateTime(v);
    } finally {
      _$_ComposeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setImage(Uint8List? v) {
    final _$actionInfo = _$_ComposeStoreBaseActionController.startAction(
        name: '_ComposeStoreBase.setImage');
    try {
      return super.setImage(v);
    } finally {
      _$_ComposeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentSentiment: ${currentSentiment},
dateTime: ${dateTime},
image: ${image}
    ''';
  }
}
