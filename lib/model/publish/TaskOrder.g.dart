// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TaskOrder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskOrder _$TaskOrderFromJson(Map<String, dynamic> json) => TaskOrder(
      json['orderId'] as int,
      json['taskId'] as int,
      json['orderNo'] as String,
      json['userId'] as int,
      json['sellUserId'] as int,
      json['goodsTitle'] as String,
      json['checkStatus'] as int,
      json['orderStatus'] as int,
      (json['totalMoney'] as num).toDouble(),
      json['taskTime'] as int,
      json['mediaUrl'] as String,
      json['checkTime'] as String?,
      json['createTime'] as String,
      InfoEntity.fromJson(json['userInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TaskOrderToJson(TaskOrder instance) => <String, dynamic>{
      'orderId': instance.orderId,
      'taskId': instance.taskId,
      'orderNo': instance.orderNo,
      'userId': instance.userId,
      'sellUserId': instance.sellUserId,
      'goodsTitle': instance.goodsTitle,
      'checkStatus': instance.checkStatus,
      'orderStatus': instance.orderStatus,
      'totalMoney': instance.totalMoney,
      'taskTime': instance.taskTime,
      'mediaUrl': instance.mediaUrl,
      'checkTime': instance.checkTime,
      'createTime': instance.createTime,
      'userInfo': instance.userInfo,
    };
