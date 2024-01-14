import 'package:hive/hive.dart';
import 'package:learn_app/model/task_model.dart';

class TaskRepository {
  final List<TaskModel> _tasks = [];
  static late Box _box;

  // ignore: constant_identifier_names
  static const TASK_KEY = 'tasks';

  List<TaskModel> get tasks => _tasks;

  TaskRepository._create();

  static Future<TaskRepository> load() async {
    if (Hive.isBoxOpen(TASK_KEY)) {
      _box = Hive.box(TASK_KEY);
    } else {
      _box = await Hive.openBox(TASK_KEY);
    }
    return TaskRepository._create();
  }

  List<TaskModel> fetchTasks(bool showOnlyPendingTasks) {
    if (showOnlyPendingTasks) {
      return _box.values
          .cast<TaskModel>()
          .where((task) => task.isDone == false)
          .toList();
    }
    return _box.values.cast<TaskModel>().toList();
  }

  void addTask(TaskModel task) {
    _box.add(task);
  }

  void updateTask(TaskModel task) {
    task.save();
  }

  void deleteTask(TaskModel task) {
    task.delete();
  }
}
