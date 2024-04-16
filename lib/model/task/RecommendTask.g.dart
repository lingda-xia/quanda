// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RecommendTask.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendTask _$RecommendTaskFromJson(Map<String, dynamic> json) =>
    RecommendTask(
      json['id'] as int,
      json['type'] as int,
      json['title'] as String,
      json['content'] as String,
      (json['gold'] as num).toDouble(),
      json['distance'] as String,
      json['lon'] as String,
      json['lat'] as String,
    );

Map<String, dynamic> _$RecommendTaskToJson(RecommendTask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'content': instance.content,
      'gold': instance.gold,
      'distance': instance.distance,
      'lon': instance.lon,
      'lat': instance.lat,
    };
