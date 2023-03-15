import 'package:json_annotation/json_annotation.dart';
import 'package:local/repos/data/models/user/person.dart';

part 'event_participant.g.dart';

enum EventParticipantType { organizer, participant }

@JsonSerializable()
class EventParticipant {
  // generated
  EventParticipantType participantType;
  Person person;

  EventParticipant({
    required this.person,
    required this.participantType,
  });

  factory EventParticipant.fromJson(Map<String, dynamic> json) =>
      _$EventParticipantFromJson(json);

  Map<String, dynamic> toJson() => _$EventParticipantToJson(this);
}
