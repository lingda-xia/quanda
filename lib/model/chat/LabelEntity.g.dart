// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LabelEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabelEntity _$LabelEntityFromJson(Map<String, dynamic> json) => LabelEntity(
      json['id'] as int,
      json['userId'] as int,
      json['name'] as String,
      json['tagFriendName'] as String,
      json['friendCount'] as int,
    );

Map<String, dynamic> _$LabelEntityToJson(LabelEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'tagFriendName': instance.tagFriendName,
      'friendCount': instance.friendCount,
    };
