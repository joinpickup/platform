import 'package:json_annotation/json_annotation.dart';
import 'package:local/repos/data/models/post/post.dart';

part 'search.g.dart';

@JsonSerializable()
class Search {
  final int searchID;
  final DateTime createdAt;

  final String name;
  final String description;

  // generated
  final List<Post> posts;

  Search({
    required this.searchID,
    required this.createdAt,
    required this.name,
    required this.description,
    required this.posts,
  });

  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);

  Map<String, dynamic> toJson() => _$SearchToJson(this);
}
