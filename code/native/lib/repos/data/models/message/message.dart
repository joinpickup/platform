import 'package:json_annotation/json_annotation.dart';
import 'package:local/repos/data/models/user/person.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final int messageID;
  final DateTime sentAt;
  final String body;

  // generated
  final Person sender;
  final Person receiver;

  Message({
    required this.messageID,
    required this.sentAt,
    required this.body,
    required this.sender,
    required this.receiver,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
