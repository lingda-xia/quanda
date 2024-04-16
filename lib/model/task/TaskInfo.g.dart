// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TaskInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskInfo _$TaskInfoFromJson(Map<String, dynamic> json) => TaskInfo(
      json['userId'] as int,
      (json['balance'] as num).toDouble(),
      json['gold'] as int,
      (json['firstCashMoney'] as num).toDouble(),
      (json['firstSignData'] as List<dynamic>)
          .map((e) =>
              e == null ? null : SignData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskInfoToJson(TaskInfo instance) => <String, dynamic>{
      'userId': instance.userId,
      'balance': instance.balance,
      'gold': instance.gold,
      'firstCashMoney': instance.firstCashMoney,
      'firstSignData': instance.firstSignData,
    };
