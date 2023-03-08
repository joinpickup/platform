import 'package:local/models/location.dart';
import 'package:local/models/person.dart';

import 'interest.dart';

class Group {
  final int groupID;
  final String name;
  final String description;
  final String slug;

  // interest
  final Location location;
  final Interest interest;
  final List<Person> members;

  Group({
    required this.groupID,
    required this.name,
    required this.description,
    required this.slug,
    required this.interest,
    required this.location,
    required this.members,
  });
}