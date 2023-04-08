import 'package:json_annotation/json_annotation.dart';
import 'package:local/repos/data/models/location/location.dart';

part 'person.g.dart';

@JsonSerializable()
class Person {
  final int personID;
  final int userID;
  final DateTime createdAt;
  final String name;
  final String username;
  final String avatar;

  // generated
  final Location location;

  Person({
    required this.personID,
    required this.createdAt,
    required this.userID,
    required this.name,
    required this.avatar,
    required this.location,
    required this.username,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
