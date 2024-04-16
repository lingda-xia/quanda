// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IdleDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdleDetail _$IdleDetailFromJson(Map<String, dynamic> json) => IdleDetail(
      json['orderId'] as int,
      json['idleId'] as int,
      json['orderNo'] as String,
      json['userId'] as int,
      json['sellUserId'] as int,
      json['goodsTitle'] as String,
      json['checkStatus'] as int,
      json['orderStatus'] as int,
      json['logisticsType'] as int,
      (json['totalMoney'] as num).toDouble(),
      json['expressName'] as String,
      json['expressId'] as int,
      json['expressNo'] as String,
      json['checkCode'] as String,
      json['deleteStatus'] as int,
      json['deliveryId'] as int,
      json['createTime'] as String,
      InfoEntity.fromJson(json['userInfo'] as Map<String, dynamic>),
      json['userDeliveryInfo'] == null
          ? null
          : ReceivingEntity.fromJson(
              json['userDeliveryInfo'] as Map<String, dynamic>),
      json['mediaUrl'] as String,
    );

Map<String, dynamic> _$IdleDetailToJson(IdleDetail instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'idleId': instance.idleId,
      'orderNo': instance.orderNo,
      'userId': instance.userId,
      'sellUserId': instance.sellUserId,
      'goodsTitle': instance.goodsTitle,
      'checkStatus': instance.checkStatus,
      'orderStatus': instance.orderStatus,
      'logisticsType': instance.logisticsType,
      'totalMoney': instance.totalMoney,
      'expressName': instance.expressName,
      'expressId': instance.expressId,
      'expressNo': instance.expressNo,
      'checkCode': instance.checkCode,
      'deleteStatus': instance.deleteStatus,
      'deliveryId': instance.deliveryId,
      'createTime': instance.createTime,
      'userInfo': instance.userInfo,
      'userDeliveryInfo': instance.userDeliveryInfo,
      'mediaUrl': instance.mediaUrl,
    };
