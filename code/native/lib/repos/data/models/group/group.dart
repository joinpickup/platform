import 'package:json_annotation/json_annotation.dart';
import 'package:local/repos/data/models/group/group_member.dart';
import 'package:local/repos/data/models/location/location.dart';
import 'package:local/repos/data/models/space/interest.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  final int groupID;
  final String name;
  final String icon;
  final String description;
  final String slug;

  // interest
  final Location location;
  final Interest interest;
  final List<GroupMember> members;

  Group({
    required this.groupID,
    required this.name,
    required this.icon,
    required this.description,
    required this.slug,
    required this.interest,
    required this.location,
    required this.members,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
