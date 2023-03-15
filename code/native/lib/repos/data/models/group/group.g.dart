// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      groupID: json['groupID'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String,
      description: json['description'] as String,
      slug: json['slug'] as String,
      interest: Interest.fromJson(json['interest'] as Map<String, dynamic>),
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      members: (json['members'] as List<dynamic>)
          .map((e) => GroupMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'groupID': instance.groupID,
      'name': instance.name,
      'icon': instance.icon,
      'description': instance.description,
      'slug': instance.slug,
      'location': instance.location,
      'interest': instance.interest,
      'members': instance.members,
    };
