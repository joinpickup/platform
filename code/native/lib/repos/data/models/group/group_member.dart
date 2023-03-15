import 'package:json_annotation/json_annotation.dart';
import 'package:local/repos/data/models/user/person.dart';

part 'group_member.g.dart';

enum GroupMemberType { admin, member }

@JsonSerializable()
class GroupMember {
  // generated
  GroupMemberType memberType;
  Person person;

  GroupMember({
    required this.person,
    required this.memberType,
  });

  factory GroupMember.fromJson(Map<String, dynamic> json) =>
      _$GroupMemberFromJson(json);

  Map<String, dynamic> toJson() => _$GroupMemberToJson(this);
}
