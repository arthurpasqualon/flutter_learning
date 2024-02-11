import 'package:flutter/material.dart';
import 'package:learn_app/main.dart';
import 'package:learn_app/model/card_detail_model.dart';
import 'package:learn_app/model/post_comment_model.dart';
import 'package:learn_app/repositories/post_comments_repository.dart';

class PostDetail extends StatefulWidget {
  final CardDetailModel cardDetail;

  const PostDetail({super.key, required this.cardDetail});

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  List<PostCommentModel> comments = [];
  var postCommentRepository = getIt<PostCommentsRepository>();

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  fetchComments() async {
    comments =
        await postCommentRepository.getPostComments(widget.cardDetail.id);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.cardDetail.id,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.cardDetail.title),
        ),
        body: SafeArea(
          child: comments.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  height: double.infinity,
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: const CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          Image.network(
                            widget.cardDetail.imageUrl,
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            widget.cardDetail.description,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Comments",
                            style: TextStyle(fontSize: 24),
                          ),
                          const SizedBox(
                            height: 8,
                          )
                        ],
                      );
                    }
                    index -= 1;

                    var comment = comments[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              comment.name,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              comment.email,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              comment.body,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
