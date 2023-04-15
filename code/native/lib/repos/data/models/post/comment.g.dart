// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      commentID: json['commentID'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      body: json['body'] as String,
      parentComment: json['parentComment'] == null
          ? null
          : Comment.fromJson(json['parentComment'] as Map<String, dynamic>),
      post: Post.fromJson(json['post'] as Map<String, dynamic>),
      poster: Person.fromJson(json['poster'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'commentID': instance.commentID,
      'createdAt': instance.createdAt.toIso8601String(),
      'body': instance.body,
      'parentComment': instance.parentComment,
      'post': instance.post,
      'poster': instance.poster,
    };
