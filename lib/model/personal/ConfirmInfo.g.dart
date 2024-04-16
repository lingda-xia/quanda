// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ConfirmInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmInfo _$ConfirmInfoFromJson(Map<String, dynamic> json) => ConfirmInfo(
      json['id'] as int,
      json['imageStr'] as String,
      json['title'] as String,
      (json['payMoney'] as num).toDouble(),
      json['extractType'] as int,
      json['addressInfo'] == null
          ? null
          : ReceivingEntity.fromJson(
              json['addressInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConfirmInfoToJson(ConfirmInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageStr': instance.imageStr,
      'title': instance.title,
      'payMoney': instance.payMoney,
      'extractType': instance.extractType,
      'addressInfo': instance.addressInfo,
    };
