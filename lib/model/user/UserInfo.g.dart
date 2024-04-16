// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      json['userId'] as int,
      json['phone'] as String,
      json['deleteStatus'] as int,
      json['useStatus'] as int,
      json['nickname'] as String,
      (json['balance'] as num).toDouble(),
      json['sex'] as int,
      json['birthday'] as String,
      json['address'] as String,
      json['avatarUrl'] as String,
      json['authStatus'] as int,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'userId': instance.userId,
      'phone': instance.phone,
      'deleteStatus': instance.deleteStatus,
      'useStatus': instance.useStatus,
      'nickname': instance.nickname,
      'balance': instance.balance,
      'sex': instance.sex,
      'birthday': instance.birthday,
      'address': instance.address,
      'avatarUrl': instance.avatarUrl,
      'authStatus': instance.authStatus,
    };
