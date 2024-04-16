// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SignData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignData _$SignDataFromJson(Map<String, dynamic> json) => SignData(
      json['id'] as int,
      json['userId'] as int,
      (json['money'] as num).toDouble(),
      json['signTime'] as String,
      json['status'] as int,
    );

Map<String, dynamic> _$SignDataToJson(SignData instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'money': instance.money,
      'signTime': instance.signTime,
      'status': instance.status,
    };
