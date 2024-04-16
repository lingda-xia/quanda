// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SystemMsg.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemMsg _$SystemMsgFromJson(Map<String, dynamic> json) => SystemMsg(
      json['id'] as int,
      json['userId'] as int,
      json['readFlag'] as int,
      MsgInfo.fromJson(json['msgInfo'] as Map<String, dynamic>),
      json['createTime'] as String,
    );

Map<String, dynamic> _$SystemMsgToJson(SystemMsg instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'readFlag': instance.readFlag,
      'msgInfo': instance.msgInfo,
      'createTime': instance.createTime,
    };
