import 'package:dio/dio.dart';

class JsonPlaceholderDio {
  final _dio = Dio();

  JsonPlaceholderDio() {
    _dio.options.baseUrl = 'https://jsonplaceholder.typicode.com';
  }

  Dio get jsonPlaceholderDio => _dio;
}
