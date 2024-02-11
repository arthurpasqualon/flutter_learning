import 'package:learn_app/model/post_comment_model.dart';
import 'package:learn_app/repositories/jsonplaceholder_dio.dart';

class PostCommentsRepository {
  final JsonPlaceholderDio dio;

  PostCommentsRepository(this.dio);
  Future<List<PostCommentModel>> getPostComments(int postId) async {
    var response = await dio.jsonPlaceholderDio.get('/posts/$postId/comments');

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((post) => PostCommentModel.fromJson(post))
          .toList();
    }

    return [];
  }
}
