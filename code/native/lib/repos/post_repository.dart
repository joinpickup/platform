import 'dart:convert';

import 'package:http/http.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:local/util/middleware/middleware.dart';

class PostRepository {
  PostRepository({
    required this.platformService,
  });

  ServiceInstance platformService;

  Future<List<Post>> getPostsForUser() async {
    await Future.delayed(const Duration(milliseconds: 300));
    Response postsRes =
        await platformService.newRequest("GET", "/v1/post", null);

    List<dynamic> postsDynamic = jsonDecode(postsRes.body);
    List<Post> posts = postsDynamic.map((e) => Post.fromJson(e)).toList();

    return posts;
  }

  Future<Post?> getPost({
    required int postID,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return null;
  }

  Future<Post> addPost({
    required Post post,
  }) async {
    return post;
  }
}
