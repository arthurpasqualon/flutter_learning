import 'package:mobx/mobx.dart';
part 'counter_mobx_store.g.dart';

class CounterMobxStore = _CounterMobxStore with _$CounterMobxStore;

abstract class _CounterMobxStore with Store {
  @observable
  int counter = 0;

  @action
  void increment() {
    counter++;
  }
}
