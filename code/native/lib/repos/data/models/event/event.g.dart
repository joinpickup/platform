// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      eventID: json['eventID'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      interest: Interest.fromJson(json['interest'] as Map<String, dynamic>),
      participants: (json['participants'] as List<dynamic>)
          .map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList(),
      place: Place.fromJson(json['place'] as Map<String, dynamic>),
      startDate: DateTime.parse(json['startDate'] as String),
      startTime: json['startTime'] as String,
      endDate: DateTime.parse(json['endDate'] as String),
      endTime: json['endTime'] as String,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'eventID': instance.eventID,
      'name': instance.name,
      'description': instance.description,
      'startDate': instance.startDate.toIso8601String(),
      'startTime': instance.startTime,
      'endDate': instance.endDate.toIso8601String(),
      'endTime': instance.endTime,
      'place': instance.place,
      'interest': instance.interest,
      'participants': instance.participants,
    };
