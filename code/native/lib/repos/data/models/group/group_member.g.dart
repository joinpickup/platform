// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupMember _$GroupMemberFromJson(Map<String, dynamic> json) => GroupMember(
      person: Person.fromJson(json['person'] as Map<String, dynamic>),
      memberType: $enumDecode(_$GroupMemberTypeEnumMap, json['memberType']),
    );

Map<String, dynamic> _$GroupMemberToJson(GroupMember instance) =>
    <String, dynamic>{
      'memberType': _$GroupMemberTypeEnumMap[instance.memberType]!,
      'person': instance.person,
    };

const _$GroupMemberTypeEnumMap = {
  GroupMemberType.admin: 'admin',
  GroupMemberType.member: 'member',
};
