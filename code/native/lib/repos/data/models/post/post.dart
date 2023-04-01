import 'package:json_annotation/json_annotation.dart';
import 'package:local/repos/data/models/space/interest.dart';
import 'package:local/repos/data/models/user/person.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  int? postID;

  final DateTime createdAt;
  final String title;
  final String body;

  // generated
  Person poster;
  Interest interest;
  // final Group group;
  // final Space space;

  Post({
    this.postID,
    required this.poster,
    required this.interest,
    required this.createdAt,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
