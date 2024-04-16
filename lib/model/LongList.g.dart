// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LongList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LongList _$LongListFromJson(Map<String, dynamic> json) => LongList(
      json['records'] as List<dynamic>,
      json['total'] as int,
      json['size'] as int,
      json['current'] as int,
      json['time'] as String,
      json['data'] as Map<String, dynamic>,
      json['pages'] as int,
    );

Map<String, dynamic> _$LongListToJson(LongList instance) => <String, dynamic>{
      'records': instance.records,
      'total': instance.total,
      'size': instance.size,
      'current': instance.current,
      'time': instance.time,
      'data': instance.data,
      'pages': instance.pages,
    };
