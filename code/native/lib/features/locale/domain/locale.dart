import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'locale.g.dart';

@JsonSerializable()
class Locale {
  final String country;
  final String state;
  final String city;
  final String displayName;

  const Locale({
    required this.country,
    required this.state,
    required this.city,
    required this.displayName,
  });

  // Pocketbase stuff
  factory Locale.fromRecord(RecordModel record) =>
      Locale.fromJson(record.toJson());

  factory Locale.fromJson(Map<String, dynamic> json) => _$LocaleFromJson(json);

  Map<String, dynamic> toJson() => _$LocaleToJson(this);
}
