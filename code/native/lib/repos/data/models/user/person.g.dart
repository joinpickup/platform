// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      personID: json['personID'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      userID: json['userID'] as int,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      username: json['username'] as String,
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'personID': instance.personID,
      'userID': instance.userID,
      'createdAt': instance.createdAt.toIso8601String(),
      'name': instance.name,
      'username': instance.username,
      'avatar': instance.avatar,
      'location': instance.location,
    };
