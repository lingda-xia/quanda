// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SetAsideParam.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetAsideParam _$SetAsideParamFromJson(Map<String, dynamic> json) =>
    SetAsideParam(
      json['title'] as String,
      json['address'] as String,
      json['lon'] as String,
      json['lat'] as String,
      json['content'] as String,
      (json['media'] as List<dynamic>).map((e) => e as String).toList(),
      json['imgList'] as List<dynamic>,
      json['payMoney'] as String,
      json['extractType'] as int,
      json['status'] as int,
    );

Map<String, dynamic> _$SetAsideParamToJson(SetAsideParam instance) =>
    <String, dynamic>{
      'title': instance.title,
      'address': instance.address,
      'lon': instance.lon,
      'lat': instance.lat,
      'content': instance.content,
      'media': instance.media,
      'imgList': instance.imgList,
      'payMoney': instance.payMoney,
      'extractType': instance.extractType,
      'status': instance.status,
    };
