import 'dart:typed_data' show Uint8List;

import 'package:mobx/mobx.dart';

part 'compose_store.g.dart';

class ComposeStore = _ComposeStoreBase with _$ComposeStore;

abstract class _ComposeStoreBase with Store {
  @observable
  int? currentSentiment;

  @observable
  DateTime? dateTime;

  @observable
  Uint8List? image;

  @action
  void setCurrentSentiment(int? v) => currentSentiment = v;

  @action
  void setDateTime(DateTime? v) => dateTime = v;

  @action
  void setImage(Uint8List? v) => image = v;
}
