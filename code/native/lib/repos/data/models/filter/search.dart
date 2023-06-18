import 'package:json_annotation/json_annotation.dart';
import 'package:local/repos/data/models/post/post.dart';
import 'package:local/repos/data/models/space/interest.dart';
import 'package:local/repos/data/models/space/space.dart';
import 'package:local/repos/data/models/user/person.dart';

part 'search.g.dart';

@JsonSerializable()
class Search {
  final int searchID;
  final DateTime createdAt;

  final String name;
  final String description;
  final bool isPublic;
  final bool notificationsEnabled;

  // filters
  final List<Interest> interests;
  final List<Space> spaces;

  // generated
  final List<Post> posts;
  final Person owner;

  Search({
    required this.searchID,
    required this.createdAt,
    required this.name,
    required this.description,
    required this.isPublic,
    required this.notificationsEnabled,
    required this.interests,
    required this.spaces,
    required this.posts,
    required this.owner,
  });

  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);

  Map<String, dynamic> toJson() => _$SearchToJson(this);
}
