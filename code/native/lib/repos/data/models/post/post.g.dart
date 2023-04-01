// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      postID: json['postID'] as int?,
      poster: Person.fromJson(json['poster'] as Map<String, dynamic>),
      interest: Interest.fromJson(json['interest'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      title: json['title'] as String,
      body: json['body'] as String,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'postID': instance.postID,
      'createdAt': instance.createdAt.toIso8601String(),
      'title': instance.title,
      'body': instance.body,
      'poster': instance.poster,
      'interest': instance.interest,
    };
