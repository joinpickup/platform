// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_participant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventParticipant _$EventParticipantFromJson(Map<String, dynamic> json) =>
    EventParticipant(
      person: Person.fromJson(json['person'] as Map<String, dynamic>),
      participantType:
          $enumDecode(_$EventParticipantTypeEnumMap, json['participantType']),
    );

Map<String, dynamic> _$EventParticipantToJson(EventParticipant instance) =>
    <String, dynamic>{
      'participantType':
          _$EventParticipantTypeEnumMap[instance.participantType]!,
      'person': instance.person,
    };

const _$EventParticipantTypeEnumMap = {
  EventParticipantType.organizer: 'organizer',
  EventParticipantType.participant: 'participant',
};
