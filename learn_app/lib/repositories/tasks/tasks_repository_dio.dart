import 'package:dio/dio.dart';
import 'package:learn_app/repositories/tasks/tasks_repository_dio_interceptor.dart';

class TasksRepositoryDio {
  final _dio = Dio();

  TasksRepositoryDio() {
    _dio.interceptors.add(TasksRepositoryDioInterceptor());
  }

  get dio => _dio;
}
