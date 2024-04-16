// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InfoEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoEntity _$InfoEntityFromJson(Map<String, dynamic> json) => InfoEntity(
      json['nickname'] as String,
      json['avatarUrl'] as String,
      json['followStatus'] as String?,
      json['userId'] as String?,
    );

Map<String, dynamic> _$InfoEntityToJson(InfoEntity instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'followStatus': instance.followStatus,
      'userId': instance.userId,
    };
