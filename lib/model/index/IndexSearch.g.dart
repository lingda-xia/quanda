// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IndexSearch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndexSearch _$IndexSearchFromJson(Map<String, dynamic> json) => IndexSearch(
      json['extension'] as String?,
      json['giveStatus'] as String,
      json['distance'] as String,
      json['mainImgUrl'] as String,
      json['videoImg'] as String?,
      json['id'] as String,
      json['title'] as String,
      json['type'] as String,
      json['giveNumber'] as String,
      json['userInfo'] as String,
    );

Map<String, dynamic> _$IndexSearchToJson(IndexSearch instance) =>
    <String, dynamic>{
      'extension': instance.extension,
      'giveStatus': instance.giveStatus,
      'distance': instance.distance,
      'mainImgUrl': instance.mainImgUrl,
      'videoImg': instance.videoImg,
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'giveNumber': instance.giveNumber,
      'userInfo': instance.userInfo,
    };
