import 'package:json_annotation/json_annotation.dart';

part 'interest.g.dart';

@JsonSerializable()
class Interest {
  final int interestID;
  final String name;

  Interest({
    required this.interestID,
    required this.name,
  });

  factory Interest.fromJson(Map<String, dynamic> json) =>
      _$InterestFromJson(json);

  Map<String, dynamic> toJson() => _$InterestToJson(this);
}
