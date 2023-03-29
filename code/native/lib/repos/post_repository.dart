import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:local/repos/data/models/post/post.dart';

class PostRepository {
  PostRepository() {
    postStorage = Hive.box("posts");
  }

  late Box postStorage;

  Future<List<Post>> getPostsFromStore() async {
    await Future.delayed(const Duration(milliseconds: 300));
    String jsonPosts = postStorage.get("posts");
    List<dynamic> dynamicPosts = jsonDecode(jsonPosts);
    List<Post> posts = dynamicPosts.map((e) => Post.fromJson(e)).toList();
    return posts;
  }

  Future<void> addPostsToStore(List<Post> posts) async {
    String mapPosts = jsonEncode(posts);
    await postStorage.put("posts", mapPosts);
  }

  Future<Post?> getPost({
    required int postID,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    List<Post> posts = await getPostsFromStore();
    Post? post = posts.firstWhere((post) => post.postID == postID);
    return post;
  }

  Future<List<Post>> searchPosts({
    required String query,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    List<Post> posts = await getPostsFromStore();
    return posts
        .where(
          (element) => element.body.contains(query),
        )
        .toList();
  }

  Future<Post> addPost({
    required Post post,
  }) async {
    List<Post> posts = await getPostsFromStore();
    Post last = posts.last;
    post.postID = last.postID! + 1;
    posts.add(post);
    await addPostsToStore(posts);
    posts = await getPostsFromStore();
    return post;
  }
}
