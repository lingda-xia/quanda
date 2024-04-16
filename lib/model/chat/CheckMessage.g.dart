// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CheckMessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckMessage _$CheckMessageFromJson(Map<String, dynamic> json) => CheckMessage(
      json['id'] as int,
      json['userId'] as int,
      json['toUserId'] as int,
      json['content'] as String,
      json['name'] as String,
    );

Map<String, dynamic> _$CheckMessageToJson(CheckMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'toUserId': instance.toUserId,
      'content': instance.content,
      'name': instance.name,
    };
