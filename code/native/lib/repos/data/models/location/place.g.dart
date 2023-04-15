// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
      placeID: json['placeID'] as int?,
      name: json['name'] as String,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'placeID': instance.placeID,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
      'location': instance.location,
    };
