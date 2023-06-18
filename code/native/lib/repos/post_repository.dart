import 'dart:convert';

import 'package:http/http.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:local/repos/data/models/space/interest.dart';
import 'package:local/repos/data/models/space/space.dart';
import 'package:local/util/middleware/middleware.dart';

// needed for serialization
class AddPostBody {
  final String title;
  final String body;
  final int posterID;
  final List<int> interests;

  AddPostBody({
    required this.title,
    required this.body,
    required this.posterID,
    required this.interests,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'body': body});
    result.addAll({'posterID': posterID});
    result.addAll({'interests': interests});

    return result;
  }

  factory AddPostBody.fromMap(Map<String, dynamic> map) {
    return AddPostBody(
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      posterID: map['posterID']?.toInt() ?? 0,
      interests: List<int>.from(map['interests']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddPostBody.fromJson(String source) =>
      AddPostBody.fromMap(json.decode(source));
}

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

  Future<void> addPost({
    required Post post,
  }) async {
    // create post body

    var newAddPost = AddPostBody(
      body: post.body,
      title: post.title,
      posterID: post.poster.personID,
      interests: post.interests.map((e) => e.interestID).toList(),
    );

    try {
      await platformService.newRequest("POST", "/v1/post", newAddPost);
    } catch (e) {
      Future.error(e);
    }
  }

  Future<List<Post>> searchPosts(
    String query,
    List<Interest> interests,
    List<Space> spaces,
  ) async {
    // handle space searches
    String spaceQuery = "";
    if (spaces.length > 1) {
      spaceQuery = spaces.map((e) {
        return e.spaceID.toString();
      }).reduce(
        (value, element) {
          return "space=$value&space=$element";
        },
      );
    } else if (spaces.length == 1) {
      spaceQuery = "space=${spaces[0].spaceID}";
    }

    // handle interest searches
    String interestQuery = "";
    if (interests.length > 1) {
      interestQuery = interests.map((e) {
        return e.interestID.toString();
      }).reduce(
        (value, element) {
          return "interest=$value&interest=$element";
        },
      );
    } else if (interests.length == 1) {
      interestQuery = "interest=${interests[0].interestID}";
    }

    String filterQuery = "?$interestQuery&$spaceQuery&query=$query";
    String filterURL = "/v1/post/search$filterQuery";
    String encodedFilterURL = Uri.encodeFull(filterURL);
    print(encodedFilterURL);

    // get stuff from API
    Response postsRes =
        await platformService.newRequest("GET", encodedFilterURL, null);

    // need to serialize
    List<dynamic> postsDynamic = jsonDecode(postsRes.body);
    List<Post> posts = postsDynamic.map((e) => Post.fromJson(e)).toList();

    return posts;
  }
}
