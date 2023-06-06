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
      isPublic: json['isPublic'] as bool,
      notificationsEnabled: json['notificationsEnabled'] as bool,
      posts: (json['posts'] as List<dynamic>)
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
      owner: Person.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchToJson(Search instance) => <String, dynamic>{
      'searchID': instance.searchID,
      'createdAt': instance.createdAt.toIso8601String(),
      'name': instance.name,
      'description': instance.description,
      'isPublic': instance.isPublic,
      'notificationsEnabled': instance.notificationsEnabled,
      'posts': instance.posts,
      'owner': instance.owner,
    };
