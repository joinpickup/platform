import 'package:json_annotation/json_annotation.dart';

part 'place.g.dart';

@JsonSerializable()
class Post {
  int? placeID;

  final DateTime createdAt;

  // generated
  // final Group group;
  // final Space space;

  Post({
    this.placeID,
    required this.createdAt,
  });
}
