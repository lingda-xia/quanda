// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CheckInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInfo _$CheckInfoFromJson(Map<String, dynamic> json) => CheckInfo(
      json['checkCode'] as String,
      json['goodsTitle'] as String,
      json['goodsImgUrl'] as String,
      json['createTime'] as String,
      (json['money'] as num).toDouble(),
      InfoEntity.fromJson(json['userInfo'] as Map<String, dynamic>),
      json['type'] as int,
      json['releaseId'] as int,
      json['sourceOrderId'] as int,
    );

Map<String, dynamic> _$CheckInfoToJson(CheckInfo instance) => <String, dynamic>{
      'checkCode': instance.checkCode,
      'goodsTitle': instance.goodsTitle,
      'goodsImgUrl': instance.goodsImgUrl,
      'createTime': instance.createTime,
      'money': instance.money,
      'userInfo': instance.userInfo,
      'type': instance.type,
      'releaseId': instance.releaseId,
      'sourceOrderId': instance.sourceOrderId,
    };
