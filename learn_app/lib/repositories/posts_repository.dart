import 'package:learn_app/model/posts_model.dart';
import 'package:learn_app/repositories/jsonplaceholder_dio.dart';

class PostsRepository {
  final JsonPlaceholderDio dio;

  PostsRepository(this.dio);

  Future<List<PostsModel>> fetchPosts() async {
    var response = await dio.jsonPlaceholderDio.get('/posts');

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((post) => PostsModel.fromJson(post))
          .toList();
    }

    return [];
  }
}
