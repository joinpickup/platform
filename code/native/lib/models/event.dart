import 'package:local/models/location.dart';

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

  Event({
    required this.eventID,
    required this.name,
    required this.description,
    required this.location,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
  });
}
