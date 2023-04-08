import 'package:json_annotation/json_annotation.dart';
import 'package:local/repos/data/models/location/location.dart';

part 'place.g.dart';

@JsonSerializable()
class Place {
  final int? placeID;
  final String name;
  final DateTime createdAt;

  // generated
  final Location location;

  Place({
    this.placeID,
    required this.name,
    required this.location,
    required this.createdAt,
  });

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}
