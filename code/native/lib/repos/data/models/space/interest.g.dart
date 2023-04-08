// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Interest _$InterestFromJson(Map<String, dynamic> json) => Interest(
      interestID: json['interestID'] as int,
      name: json['name'] as String,
      space: Space.fromJson(json['space'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InterestToJson(Interest instance) => <String, dynamic>{
      'interestID': instance.interestID,
      'name': instance.name,
      'space': instance.space,
    };
