// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExpressEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpressEntity _$ExpressEntityFromJson(Map<String, dynamic> json) =>
    ExpressEntity(
      json['id'] as int,
      json['expressName'] as String,
      json['expressCode'] as String,
    );

Map<String, dynamic> _$ExpressEntityToJson(ExpressEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'expressName': instance.expressName,
      'expressCode': instance.expressCode,
    };
