// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FollowEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowEntity _$FollowEntityFromJson(Map<String, dynamic> json) => FollowEntity(
      json['id'] as int,
      json['userId'] as int,
      json['sellUserId'] as int,
      json['followStatus'] as int,
      json['nickname'] as String,
      json['avatarUrl'] as String,
    );

Map<String, dynamic> _$FollowEntityToJson(FollowEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'sellUserId': instance.sellUserId,
      'followStatus': instance.followStatus,
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
    };
