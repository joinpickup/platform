import 'interest.dart';

class Group {
  final int groupID;
  final String name;
  final String description;
  final String slug;

  // interest
  final Interest interest;

  Group({
    required this.groupID,
    required this.name,
    required this.description,
    required this.slug,
    required this.interest,
  });
}
