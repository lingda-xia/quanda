// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PersonalDataInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalDataInfo _$PersonalDataInfoFromJson(Map<String, dynamic> json) =>
    PersonalDataInfo(
      json['userId'] as int,
      json['nickname'] as String,
      json['authStatus'] as int,
      json['sex'] as int,
      json['age'] as int,
      json['birthday'] as String,
      json['introduction'] as String,
      json['avatarUrl'] as String,
      json['addressInfo'] == null
          ? null
          : ReceivingEntity.fromJson(
              json['addressInfo'] as Map<String, dynamic>),
      Map<String, String>.from(json['authInfo'] as Map),
    );

Map<String, dynamic> _$PersonalDataInfoToJson(PersonalDataInfo instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'nickname': instance.nickname,
      'authStatus': instance.authStatus,
      'sex': instance.sex,
      'age': instance.age,
      'birthday': instance.birthday,
      'introduction': instance.introduction,
      'avatarUrl': instance.avatarUrl,
      'addressInfo': instance.addressInfo,
      'authInfo': instance.authInfo,
    };
