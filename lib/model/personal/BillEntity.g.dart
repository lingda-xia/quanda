// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BillEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillEntity _$BillEntityFromJson(Map<String, dynamic> json) => BillEntity(
      json['id'] as int,
      json['userId'] as int,
      json['type'] as int,
      (json['money'] as num).toDouble(),
      json['accountDesc'] as String,
      json['createTime'] as String,
    );

Map<String, dynamic> _$BillEntityToJson(BillEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': instance.type,
      'money': instance.money,
      'accountDesc': instance.accountDesc,
      'createTime': instance.createTime,
    };
