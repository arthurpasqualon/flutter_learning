import 'package:learn_app/model/task.dart';

class TaskRepository {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> addTask(Task task) async {
    await Future.delayed(const Duration(seconds: 1));
    _tasks.add(task);
  }

  Future<void> removeTask(Task task) async {
    await Future.delayed(const Duration(seconds: 1));
    _tasks.remove(task);
  }

  void updateTask(Task task) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _tasks.indexWhere((t) => t.id == task.id);
    _tasks[index] = task;
  }

  Future<void> toggleTask(Task task) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _tasks.indexWhere((t) => t.id == task.id);
    _tasks[index] = Task(task.description, !task.isDone);
  }

  void clearTasks() async {
    await Future.delayed(const Duration(seconds: 1));
    _tasks.clear();
  }

  Future<List<Task>> fetchTasks() async {
    await Future.delayed(const Duration(seconds: 1));
    return _tasks;
  }

  Future<List<Task>> fetchPendingTasks() async {
    await Future.delayed(const Duration(seconds: 1));
    return _tasks.where((t) => !t.isDone).toList();
  }
}
