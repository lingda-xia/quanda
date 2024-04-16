// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProfitEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfitEntity _$ProfitEntityFromJson(Map<String, dynamic> json) => ProfitEntity(
      json['id'] as int,
      json['userId'] as int,
      json['type'] as int,
      json['profitDesc'] as String,
      (json['profitNumber'] as num).toDouble(),
      json['createTime'] as String,
    );

Map<String, dynamic> _$ProfitEntityToJson(ProfitEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': instance.type,
      'profitDesc': instance.profitDesc,
      'profitNumber': instance.profitNumber,
      'createTime': instance.createTime,
    };
