// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TaskParam.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskParam _$TaskParamFromJson(Map<String, dynamic> json) => TaskParam(
      json['title'] as String,
      json['address'] as String,
      json['lon'] as String,
      json['lat'] as String,
      json['content'] as String,
      (json['media'] as List<dynamic>).map((e) => e as String).toList(),
      json['imgList'] as List<dynamic>,
      (json['payMoney'] as num).toDouble(),
      (json['rangeKm'] as num).toDouble(),
      (json['broadcastTime'] as num).toDouble(),
      json['taskType'] as int,
      json['sex'] as int,
      json['personNumber'] as int,
      json['finishMoney'] as int,
      json['taskTime'] as int,
      json['status'] as int,
    );

Map<String, dynamic> _$TaskParamToJson(TaskParam instance) => <String, dynamic>{
      'title': instance.title,
      'address': instance.address,
      'lon': instance.lon,
      'lat': instance.lat,
      'content': instance.content,
      'media': instance.media,
      'imgList': instance.imgList,
      'payMoney': instance.payMoney,
      'rangeKm': instance.rangeKm,
      'broadcastTime': instance.broadcastTime,
      'taskType': instance.taskType,
      'sex': instance.sex,
      'personNumber': instance.personNumber,
      'finishMoney': instance.finishMoney,
      'taskTime': instance.taskTime,
      'status': instance.status,
    };
