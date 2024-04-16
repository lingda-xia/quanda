// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PersonalInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalInfo _$PersonalInfoFromJson(Map<String, dynamic> json) => PersonalInfo(
      json['userId'] as int,
      json['nickname'] as String,
      json['avatarUrl'] as String,
      json['sex'] as int,
      json['age'] as int,
      json['distance'] as String?,
      json['authStatus'] as int,
      json['introduction'] as String,
      json['appearanceHighNumber'] as int?,
      json['appearanceLowNumber'] as int?,
      json['appearanceStatus'] as int?,
      json['friendStatus'] as int?,
      (json['balance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PersonalInfoToJson(PersonalInfo instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'sex': instance.sex,
      'age': instance.age,
      'distance': instance.distance,
      'authStatus': instance.authStatus,
      'introduction': instance.introduction,
      'appearanceHighNumber': instance.appearanceHighNumber,
      'appearanceLowNumber': instance.appearanceLowNumber,
      'appearanceStatus': instance.appearanceStatus,
      'friendStatus': instance.friendStatus,
      'balance': instance.balance,
    };
