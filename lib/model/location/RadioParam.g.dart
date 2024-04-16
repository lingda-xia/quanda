// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RadioParam.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadioParam _$RadioParamFromJson(Map<String, dynamic> json) => RadioParam(
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
      json['status'] as int,
    );

Map<String, dynamic> _$RadioParamToJson(RadioParam instance) =>
    <String, dynamic>{
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
      'status': instance.status,
    };
