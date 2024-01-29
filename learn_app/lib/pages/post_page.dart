import 'package:flutter/material.dart';
import 'package:learn_app/model/card_detail_model.dart';
import 'package:learn_app/model/posts_model.dart';
import 'package:learn_app/pages/post_detail.dart';
import 'package:learn_app/repositories/posts_repository.dart';

var IMAGE_FAKE = "https://picsum.photos/200/300";

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  var postsRepository = PostsRepository();
  var posts = <PostsModel>[];

  @override
  void initState() {
    super.initState();
    loadPosts();
  }

  void loadPosts() async {
    posts = await postsRepository.fetchPosts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: posts.isEmpty
              ? const LinearProgressIndicator()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: posts.length,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    var post = posts[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return PostDetail(
                                cardDetail: CardDetailModel(
                              post.id,
                              post.title,
                              post.body,
                              IMAGE_FAKE,
                            ));
                          }));
                        },
                        child: Hero(
                          tag: post.id,
                          child: Card(
                            shadowColor: Colors.grey,
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.network(
                                        IMAGE_FAKE,
                                        width: 100,
                                        height: 100,
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                          child: Text(
                                        post!.title,
                                        style: const TextStyle(fontSize: 24),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    post!.body,
                                    style: const TextStyle(fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            "Read More",
                                            style: TextStyle(
                                                color: Colors.purple,
                                                decoration:
                                                    TextDecoration.underline),
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )),
    );
  }
}
