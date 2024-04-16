// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DynamicParam.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicParam _$DynamicParamFromJson(Map<String, dynamic> json) => DynamicParam(
      json['title'] as String,
      json['address'] as String,
      json['lon'] as String,
      json['lat'] as String,
      json['content'] as String,
      (json['media'] as List<dynamic>).map((e) => e as String).toList(),
      json['imgList'] as List<dynamic>,
      json['status'] as int,
    );

Map<String, dynamic> _$DynamicParamToJson(DynamicParam instance) =>
    <String, dynamic>{
      'title': instance.title,
      'address': instance.address,
      'lon': instance.lon,
      'lat': instance.lat,
      'content': instance.content,
      'media': instance.media,
      'imgList': instance.imgList,
      'status': instance.status,
    };
