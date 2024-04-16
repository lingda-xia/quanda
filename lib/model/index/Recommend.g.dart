// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Recommend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recommend _$RecommendFromJson(Map<String, dynamic> json) => Recommend(
      json['id'] as int,
      json['userId'] as int,
      json['type'] as int,
      json['title'] as String,
      json['lon'] as String,
      json['lat'] as String,
      json['giveNumber'] as int,
      json['distance'] as String,
      json['giveStatus'] as int,
      json['mainImgUrl'] as String,
      json['extension'] as String,
      json['videoImg'] as String?,
      InfoEntity.fromJson(json['userInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecommendToJson(Recommend instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': instance.type,
      'title': instance.title,
      'lon': instance.lon,
      'lat': instance.lat,
      'giveNumber': instance.giveNumber,
      'distance': instance.distance,
      'giveStatus': instance.giveStatus,
      'mainImgUrl': instance.mainImgUrl,
      'extension': instance.extension,
      'videoImg': instance.videoImg,
      'userInfo': instance.userInfo,
    };
