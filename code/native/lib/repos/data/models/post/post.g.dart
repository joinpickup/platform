// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      postID: json['postID'] as int?,
      poster: Person.fromJson(json['poster'] as Map<String, dynamic>),
      interests: (json['interests'] as List<dynamic>)
          .map((e) => Interest.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      'interests': instance.interests,
    };
