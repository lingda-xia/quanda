// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserSearch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSearch _$UserSearchFromJson(Map<String, dynamic> json) => UserSearch(
      json['userId'] as String,
      json['nickname'] as String,
      json['introduction'] as String,
      json['avatarUrl'] as String,
      json['friendStatus'] as String,
    );

Map<String, dynamic> _$UserSearchToJson(UserSearch instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'nickname': instance.nickname,
      'introduction': instance.introduction,
      'avatarUrl': instance.avatarUrl,
      'friendStatus': instance.friendStatus,
    };
