import 'package:json_annotation/json_annotation.dart';
import 'package:local/repos/data/models/message/message.dart';
import 'package:local/repos/data/models/user/person.dart';

part 'thread.g.dart';

@JsonSerializable()
class Thread {
  final int threadID;
  final DateTime createdAt;

  // generated
  final Person person1;
  final Person person2;
  final Message lastMessage;
  final bool isRead;

  Thread({
    required this.threadID,
    required this.createdAt,
    required this.person1,
    required this.person2,
    required this.lastMessage,
    required this.isRead,
  });

  factory Thread.fromJson(Map<String, dynamic> json) => _$ThreadFromJson(json);

  Map<String, dynamic> toJson() => _$ThreadToJson(this);
}
