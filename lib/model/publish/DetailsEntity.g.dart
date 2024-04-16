// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DetailsEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailsEntity _$DetailsEntityFromJson(Map<String, dynamic> json) =>
    DetailsEntity(
      json['id'] as int,
      json['userId'] as int,
      json['type'] as int,
      json['media'] as String,
      json['title'] as String,
      json['content'] as String,
      json['address'] as String,
      json['lon'] as String,
      json['lat'] as String,
      json['rangeKm'] as int,
      json['broadcastTime'] as int,
      json['taskType'] as int,
      json['sex'] as int,
      json['personNumber'] as int,
      (json['finishMoney'] as num).toDouble(),
      json['taskTime'] as int,
      json['extractType'] as int,
      (json['advertMoney'] as num).toDouble(),
      (json['payMoney'] as num).toDouble(),
      json['status'] as int,
      json['reason'] as String,
      json['giveNumber'] as int,
      json['collectNumber'] as int,
      json['commentNumber'] as int,
      json['broadcastStatus'] as int,
      json['deleteStatus'] as int,
      json['createTime'] as String,
      (json['mediaList'] as List<dynamic>)
          .map((e) => ImgEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      InfoEntity.fromJson(json['userInfo'] as Map<String, dynamic>),
      json['buyStatus'] as bool,
      json['repayShortNumber'] as int?,
      json['giveStatus'] as int,
      json['collectStatus'] as int,
    );

Map<String, dynamic> _$DetailsEntityToJson(DetailsEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': instance.type,
      'media': instance.media,
      'title': instance.title,
      'content': instance.content,
      'address': instance.address,
      'lon': instance.lon,
      'lat': instance.lat,
      'rangeKm': instance.rangeKm,
      'broadcastTime': instance.broadcastTime,
      'taskType': instance.taskType,
      'sex': instance.sex,
      'personNumber': instance.personNumber,
      'finishMoney': instance.finishMoney,
      'taskTime': instance.taskTime,
      'extractType': instance.extractType,
      'advertMoney': instance.advertMoney,
      'payMoney': instance.payMoney,
      'status': instance.status,
      'reason': instance.reason,
      'giveNumber': instance.giveNumber,
      'collectNumber': instance.collectNumber,
      'commentNumber': instance.commentNumber,
      'broadcastStatus': instance.broadcastStatus,
      'deleteStatus': instance.deleteStatus,
      'createTime': instance.createTime,
      'mediaList': instance.mediaList,
      'userInfo': instance.userInfo,
      'buyStatus': instance.buyStatus,
      'repayShortNumber': instance.repayShortNumber,
      'giveStatus': instance.giveStatus,
      'collectStatus': instance.collectStatus,
    };
