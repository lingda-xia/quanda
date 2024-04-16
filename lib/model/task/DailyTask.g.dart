// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DailyTask.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyTask _$DailyTaskFromJson(Map<String, dynamic> json) => DailyTask(
      json['type'] as String,
      json['number'] as int,
      json['count'] as int,
      (json['gold'] as num).toDouble(),
    );

Map<String, dynamic> _$DailyTaskToJson(DailyTask instance) => <String, dynamic>{
      'type': instance.type,
      'number': instance.number,
      'count': instance.count,
      'gold': instance.gold,
    };
