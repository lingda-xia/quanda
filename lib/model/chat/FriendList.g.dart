// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FriendList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendList _$FriendListFromJson(Map<String, dynamic> json) => FriendList(
      json['toUserId'] as int,
      json['remarkName'] as String,
      json['toDesc'] as String?,
      json['avatarUrl'] as String,
      json['tagId'] as String?,
      json['name'] as String?,
      json['indexLetter'] as String,
    );

Map<String, dynamic> _$FriendListToJson(FriendList instance) =>
    <String, dynamic>{
      'toUserId': instance.toUserId,
      'remarkName': instance.remarkName,
      'toDesc': instance.toDesc,
      'avatarUrl': instance.avatarUrl,
      'tagId': instance.tagId,
      'name': instance.name,
      'indexLetter': instance.indexLetter,
    };
