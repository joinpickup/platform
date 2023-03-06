import 'package:local/models/interest.dart';
import 'package:local/models/location.dart';
import 'package:local/models/person.dart';

class Event {
  final int eventID;
  final String name;
  final String description;

  final DateTime startDate;
  final String startTime;
  final DateTime endDate;
  final String endTime;

  // generated
  final Location location;
  final Interest interest;
  final List<Person> participants;

  Event({
    required this.eventID,
    required this.name,
    required this.description,
    required this.interest,
    required this.participants,
    required this.location,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
  });
}
