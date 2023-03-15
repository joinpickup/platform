import 'package:json_annotation/json_annotation.dart';
import 'package:local/repos/data/models/space/interest.dart';
import 'package:local/repos/data/models/user/person.dart';

part 'post.g.dart';

enum PostVisibility { public, private, unlisted }

@JsonSerializable()
class Post {
  int? postID;
  final int posterID;
  final int interestID;

  final DateTime createdAt;
  final String title;
  final String body;
  final PostVisibility visibility;

  // generated
  Person? poster;
  Interest? interest;
  // final Group group;
  // final Space space;

  Post({
    this.postID,
    this.poster,
    this.interest,
    required this.posterID,
    required this.interestID,
    required this.createdAt,
    required this.title,
    required this.body,
    required this.visibility,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
