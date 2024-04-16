// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ReleaseList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReleaseList _$ReleaseListFromJson(Map<String, dynamic> json) => ReleaseList(
      json['id'] as int,
      json['userId'] as int,
      json['type'] as int,
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
      json['commentNumber'] as int,
      json['broadcastStatus'] as int,
      json['deleteStatus'] as int,
      json['giveStatus'] as int,
      json['createTime'] as String,
      json['idleOrderStatus'] as bool,
      (json['mediaList'] as List<dynamic>)
          .map((e) => ImgEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['currentNumber'] as int,
    );

Map<String, dynamic> _$ReleaseListToJson(ReleaseList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': instance.type,
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
      'commentNumber': instance.commentNumber,
      'broadcastStatus': instance.broadcastStatus,
      'deleteStatus': instance.deleteStatus,
      'giveStatus': instance.giveStatus,
      'createTime': instance.createTime,
      'idleOrderStatus': instance.idleOrderStatus,
      'mediaList': instance.mediaList,
      'currentNumber': instance.currentNumber,
    };
