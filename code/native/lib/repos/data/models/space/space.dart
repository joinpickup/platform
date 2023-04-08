import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'space.g.dart';

@JsonSerializable()
class Space extends Equatable {
  final int spaceID;
  final String name;

  const Space({
    required this.spaceID,
    required this.name,
  });

  @override
  List<Object?> get props => [spaceID, name];

  factory Space.fromJson(Map<String, dynamic> json) => _$SpaceFromJson(json);

  Map<String, dynamic> toJson() => _$SpaceToJson(this);
}
