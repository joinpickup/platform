// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Locale _$LocaleFromJson(Map<String, dynamic> json) => Locale(
      country: json['country'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      displayName: json['displayName'] as String,
    );

Map<String, dynamic> _$LocaleToJson(Locale instance) => <String, dynamic>{
      'country': instance.country,
      'state': instance.state,
      'city': instance.city,
      'displayName': instance.displayName,
    };
