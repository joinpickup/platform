// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      messageID: json['messageID'] as int,
      sentAt: DateTime.parse(json['sentAt'] as String),
      body: json['body'] as String,
      sender: Person.fromJson(json['sender'] as Map<String, dynamic>),
      receiver: Person.fromJson(json['receiver'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'messageID': instance.messageID,
      'sentAt': instance.sentAt.toIso8601String(),
      'body': instance.body,
      'sender': instance.sender,
      'receiver': instance.receiver,
    };
