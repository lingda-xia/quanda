// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NoticeEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeEntity _$NoticeEntityFromJson(Map<String, dynamic> json) => NoticeEntity(
      json['msgCount'] as int,
      json['info'] as String,
      json['createTime'] as String?,
    );

Map<String, dynamic> _$NoticeEntityToJson(NoticeEntity instance) =>
    <String, dynamic>{
      'msgCount': instance.msgCount,
      'info': instance.info,
      'createTime': instance.createTime,
    };
