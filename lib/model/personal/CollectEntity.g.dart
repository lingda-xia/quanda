// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CollectEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectEntity _$CollectEntityFromJson(Map<String, dynamic> json) =>
    CollectEntity(
      json['id'] as int,
      json['releaseId'] as int,
      json['type'] as int,
      json['title'] as String,
      json['nickname'] as String,
      json['avatarUrl'] as String,
      json['media'] as String,
      json['fileType'] as String,
      json['extension'] as String,
      json['videoImg'] as String?,
      json['createTime'] as String,
    );

Map<String, dynamic> _$CollectEntityToJson(CollectEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'releaseId': instance.releaseId,
      'type': instance.type,
      'title': instance.title,
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'media': instance.media,
      'fileType': instance.fileType,
      'extension': instance.extension,
      'videoImg': instance.videoImg,
      'createTime': instance.createTime,
    };
