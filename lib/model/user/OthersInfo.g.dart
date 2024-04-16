// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OthersInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OthersInfo _$OthersInfoFromJson(Map<String, dynamic> json) => OthersInfo(
      json['userId'] as String,
      json['nickname'] as String,
      json['authStatus'] as int,
      json['avatarUrl'] as String,
      json['sex'] as int,
      json['address'] as String,
      json['introduction'] as String,
      json['tagName'] as String,
      json['remarkName'] as String,
      json['toDesc'] as String,
      json['source'] as String,
      json['friendStatus'] as int,
      (json['momentList'] as List<dynamic>).map((e) => e as String).toList(),
      (json['checkMessageList'] as List<dynamic>)
          .map((e) => CheckMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OthersInfoToJson(OthersInfo instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'nickname': instance.nickname,
      'authStatus': instance.authStatus,
      'avatarUrl': instance.avatarUrl,
      'sex': instance.sex,
      'address': instance.address,
      'introduction': instance.introduction,
      'tagName': instance.tagName,
      'remarkName': instance.remarkName,
      'toDesc': instance.toDesc,
      'source': instance.source,
      'friendStatus': instance.friendStatus,
      'momentList': instance.momentList,
      'checkMessageList': instance.checkMessageList,
    };
