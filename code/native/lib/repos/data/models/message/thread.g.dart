// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Thread _$ThreadFromJson(Map<String, dynamic> json) => Thread(
      threadID: json['threadID'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      person1: Person.fromJson(json['person1'] as Map<String, dynamic>),
      person2: Person.fromJson(json['person2'] as Map<String, dynamic>),
      lastMessage:
          Message.fromJson(json['lastMessage'] as Map<String, dynamic>),
      isRead: json['isRead'] as bool,
      isRequest: json['isRequest'] as bool,
    );

Map<String, dynamic> _$ThreadToJson(Thread instance) => <String, dynamic>{
      'threadID': instance.threadID,
      'createdAt': instance.createdAt.toIso8601String(),
      'person1': instance.person1,
      'person2': instance.person2,
      'lastMessage': instance.lastMessage,
      'isRead': instance.isRead,
      'isRequest': instance.isRequest,
    };
