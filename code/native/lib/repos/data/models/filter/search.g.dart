// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Search _$SearchFromJson(Map<String, dynamic> json) => Search(
      searchID: json['searchID'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      name: json['name'] as String,
      description: json['description'] as String,
      posts: (json['posts'] as List<dynamic>)
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchToJson(Search instance) => <String, dynamic>{
      'searchID': instance.searchID,
      'createdAt': instance.createdAt.toIso8601String(),
      'name': instance.name,
      'description': instance.description,
      'posts': instance.posts,
    };
