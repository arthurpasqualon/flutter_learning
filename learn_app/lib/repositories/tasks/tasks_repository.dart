import 'package:learn_app/model/tasks_model.dart';
import 'package:learn_app/repositories/tasks/tasks_repository_dio.dart';

class TasksRepository {
  final _dio = TasksRepositoryDio().dio;

  Future<TasksModel> get(bool showPendingTasks) async {
    try {
      var query = showPendingTasks ? '?where={"completed":false}' : '';
      var result = await _dio.get('/Tasks$query');
      return TasksModel.fromJson(result.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> create(Task task) async {
    try {
      await _dio.post('/Tasks', data: task.toJson());
      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> update(Task task) async {
    try {
      await _dio.put('/Tasks/${task.objectId}', data: task.toJson());
      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> delete(Task task) async {
    try {
      await _dio.delete('/Tasks/${task.objectId}');
      return;
    } catch (e) {
      throw Exception(e);
    }
  }
}
