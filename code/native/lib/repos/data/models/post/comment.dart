import 'package:json_annotation/json_annotation.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:local/repos/data/models/user/person.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final int? commentID;

  final DateTime createdAt;
  final String body;
  final Comment? parentComment;
  final Post post;

  // generated
  final Person poster;

  const Comment({
    this.commentID,
    required this.createdAt,
    required this.body,
    required this.parentComment,
    required this.post,
    required this.poster,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
