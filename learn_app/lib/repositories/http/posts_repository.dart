import 'dart:convert';

import 'package:learn_app/model/posts_model.dart';
import 'package:http/http.dart' as http;

class PostsRepositoryHttp {
  Future<List<PostsModel>> fetchPosts() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      if (response.statusCode == 200) {
        final jsonResponse = await http
            .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'))
            .then((response) => response.body);
        final decodedJson = jsonDecode(jsonResponse);
        return (decodedJson as List)
            .map((post) => PostsModel.fromJson(post))
            .toList();
      }

      return [];
    } catch (e) {
      throw Exception('Erro ao buscar Posts');
    }
  }
}
