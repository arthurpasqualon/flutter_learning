import 'dart:convert';

import 'package:learn_app/model/post_comment_model.dart';
import 'package:http/http.dart' as http;

class PostCommentsRepositoryHttp {
  Future<List<PostCommentModel>> getPostComments(int postId) async {
    var response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts/$postId/comments'));

    if (response.statusCode == 200) {
      var jsonResponse = await http
          .get(Uri.parse(
              'https://jsonplaceholder.typicode.com/posts/$postId/comments'))
          .then((response) => response.body);
      var decodedJson = jsonDecode(jsonResponse);
      return (decodedJson as List)
          .map((post) => PostCommentModel.fromJson(post))
          .toList();
    }

    return [];
  }
}
