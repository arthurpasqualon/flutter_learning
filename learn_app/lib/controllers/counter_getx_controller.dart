import 'package:get/state_manager.dart';

class CounterGetXController extends GetxController {
  var count = 0.obs;
  increment() => count++;
}
