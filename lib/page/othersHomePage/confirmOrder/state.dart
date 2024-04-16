import 'package:flutter/material.dart';
import 'package:quanda/model/personal/ConfirmInfo.dart';
import 'package:quanda/model/personal/ReceivingEntity.dart';

/// 发布闲置 的数据层
class ConfirmOrderState {
  /// 确认订单信息
  late ConfirmInfo info;

  /// 运费类型
  late List<String> list;

  /// 闲置id
  late int id;

  /// 初始化 构造函数
  ConfirmOrderState() {
    id = 0;
    info =
        ConfirmInfo(0, "", "", 0, 0, ReceivingEntity(0, 0, "", "", "", "", 0));
    list = ["", "上门自提", "寄到付款", "付款后寄"];
  }
}
