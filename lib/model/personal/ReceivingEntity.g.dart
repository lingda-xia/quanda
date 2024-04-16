// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ReceivingEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceivingEntity _$ReceivingEntityFromJson(Map<String, dynamic> json) =>
    ReceivingEntity(
      json['id'] as int,
      json['userId'] as int,
      json['address'] as String,
      json['contact'] as String,
      json['phone'] as String,
      json['areaAddress'] as String,
      json['defaultStatus'] as int,
    );

Map<String, dynamic> _$ReceivingEntityToJson(ReceivingEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'address': instance.address,
      'contact': instance.contact,
      'phone': instance.phone,
      'areaAddress': instance.areaAddress,
      'defaultStatus': instance.defaultStatus,
    };
