import 'package:get/state_manager.dart';
import 'package:learn_app/model/tasks_model.dart';

class TaskGetXController extends GetxController {
  final RxList<Task> _tasks = <Task>[].obs;
  final _showPendingTasks = false.obs;

  List get tasks => _showPendingTasks.value
      ? _tasks.where((element) => !element.completed).toList()
      : _tasks.toList();

  bool get showPendingTasks => _showPendingTasks.value;
  set showPendingTasks(bool value) => _showPendingTasks.value = value;
  void addTask(Task task) {
    _tasks.add(task);
  }

  void removeTask(String id) {
    _tasks.removeWhere((element) => element.objectId == id);
  }

  void toggleTask(String id, bool value) {
    var task = _tasks.firstWhere((element) => element.objectId == id);
    task.completed = value;
    _tasks.refresh();
  }
}
