// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEntity _$OrderEntityFromJson(Map<String, dynamic> json) => OrderEntity(
      json['id'] as int,
      json['sourceOrderId'] as int,
      json['userId'] as int,
      json['sellUserId'] as int,
      json['orderNo'] as String,
      json['goodsTitle'] as String,
      json['orderType'] as int,
      json['orderStatus'] as int,
      json['orderMedia'] as String,
      json['deleteStatus'] as int,
      json['checkStatus'] as int,
      (json['totalMoney'] as num).toDouble(),
      json['refundStatus'] as int,
      json['createTime'] as String,
      (json['mediaList'] as List<dynamic>)
          .map((e) => ImgEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      InfoEntity.fromJson(json['userInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderEntityToJson(OrderEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sourceOrderId': instance.sourceOrderId,
      'userId': instance.userId,
      'sellUserId': instance.sellUserId,
      'orderNo': instance.orderNo,
      'goodsTitle': instance.goodsTitle,
      'orderType': instance.orderType,
      'orderStatus': instance.orderStatus,
      'orderMedia': instance.orderMedia,
      'deleteStatus': instance.deleteStatus,
      'checkStatus': instance.checkStatus,
      'totalMoney': instance.totalMoney,
      'refundStatus': instance.refundStatus,
      'createTime': instance.createTime,
      'mediaList': instance.mediaList,
      'userInfo': instance.userInfo,
    };
