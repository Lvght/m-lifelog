import 'package:mobx/mobx.dart';

part 'options_screen_store.g.dart';

class OptionsScreenStore = _OptionsScreenStoreBase with _$OptionsScreenStore;

abstract class _OptionsScreenStoreBase with Store {
  @observable
  bool isLoggedIn = false;

  @action
  void setIsLoggedIn(bool v) => isLoggedIn = v;
}
