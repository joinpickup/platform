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
    // get stuff from API
    Response postsRes =
        await platformService.newRequest("GET", "/v1/post", null);

    // need to serialize
    List<dynamic> postsDynamic = jsonDecode(postsRes.body);
    List<Post> posts = postsDynamic.map((e) => Post.fromJson(e)).toList();

    return posts;
  }

  Future<Post?> getPost({
    required int postID,
  }) async {
    // get stuff from API

    try {
      Response postsRes =
          await platformService.newRequest("GET", "/v1/post/$postID", null);

      // need to serialize
      Map<String, dynamic> postsDynamic = jsonDecode(postsRes.body);
      Post post = Post.fromJson(postsDynamic);

      return post;
    } catch (e) {
      Future.error(e);
    }

    return null;
  }

  Future<Post> addPost({
    required Post post,
  }) async {
    return post;
  }
}
