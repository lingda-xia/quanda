// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderInfo _$OrderInfoFromJson(Map<String, dynamic> json) => OrderInfo(
      json['payFlag'] as bool,
      json['orderId'] as int,
      json['module'] as String,
    );

Map<String, dynamic> _$OrderInfoToJson(OrderInfo instance) => <String, dynamic>{
      'payFlag': instance.payFlag,
      'orderId': instance.orderId,
      'module': instance.module,
    };
