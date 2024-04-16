// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SearchEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchEntity _$SearchEntityFromJson(Map<String, dynamic> json) => SearchEntity(
      json['userId'] as String,
      json['nickname'] as String,
      json['avatarUrl'] as String,
      json['toDesc'] as String,
      json['friendStatus'] as bool,
      json['introduction'] as String,
      json['remarkName'] as String,
    );

Map<String, dynamic> _$SearchEntityToJson(SearchEntity instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'toDesc': instance.toDesc,
      'friendStatus': instance.friendStatus,
      'introduction': instance.introduction,
      'remarkName': instance.remarkName,
    };
