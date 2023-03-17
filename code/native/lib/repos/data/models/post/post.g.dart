// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      postID: json['postID'] as int?,
      poster: json['poster'] == null
          ? null
          : Person.fromJson(json['poster'] as Map<String, dynamic>),
      interest: json['interest'] == null
          ? null
          : Interest.fromJson(json['interest'] as Map<String, dynamic>),
      posterID: json['posterID'] as int,
      interestID: json['interestID'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      title: json['title'] as String,
      body: json['body'] as String,
      visibility: $enumDecode(_$PostVisibilityEnumMap, json['visibility']),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'postID': instance.postID,
      'posterID': instance.posterID,
      'interestID': instance.interestID,
      'createdAt': instance.createdAt.toIso8601String(),
      'title': instance.title,
      'body': instance.body,
      'visibility': _$PostVisibilityEnumMap[instance.visibility]!,
      'poster': instance.poster,
      'interest': instance.interest,
    };

const _$PostVisibilityEnumMap = {
  PostVisibility.public: 'public',
  PostVisibility.private: 'private',
  PostVisibility.unlisted: 'unlisted',
};
