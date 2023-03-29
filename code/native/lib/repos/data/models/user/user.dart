import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    required this.email,
    required this.password,
    required this.userID,
    required this.hasSubscription,
  });

  final String email;
  final String password;
  final bool hasSubscription;
  final int userID;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
