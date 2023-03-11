import 'package:local/repos/data/models/location.dart';

class Person {
  final int personID;
  final DateTime createdAt;
  final String name;
  final String username;
  final String avatar;

  // generated
  final Location location;

  Person({
    required this.personID,
    required this.createdAt,
    required this.name,
    required this.avatar,
    required this.location,
    required this.username,
  });
  // generated
}
