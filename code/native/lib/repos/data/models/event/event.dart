import 'package:json_annotation/json_annotation.dart';
import 'package:local/repos/data/models/space/interest.dart';
import 'package:local/repos/data/models/location/place.dart';
import 'package:local/repos/data/models/user/person.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  final int eventID;
  final String name;
  final String description;

  final DateTime startDate;
  final String startTime;
  final DateTime endDate;
  final String endTime;

  // generated
  final Place place;
  final Interest interest;
  final List<Person> participants;

  Event({
    required this.eventID,
    required this.name,
    required this.description,
    required this.interest,
    required this.participants,
    required this.place,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
