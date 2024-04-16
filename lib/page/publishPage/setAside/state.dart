import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/personal/ReceivingEntity.dart';

/// 发布闲置 的数据层
class SetAsideState {

  /// 价格
  late String payMoney;

  /// 文本控制器
  late TextEditingController textController;

  /// 选择的提取方式
  late int extractType;

  /// 提取方式的列表
  late List<String> extractList;

  /// 金币奖励类型: 闲置 用于完成发布闲置需要
  late String goldType;

  /// 收货地址
  late ReceivingEntity address;

  /// 初始化 构造函数
  SetAsideState() {

    address = ReceivingEntity(0, 0, "", "", "", "", 0);

    textController = TextEditingController();

    payMoney = "0";

    extractType = 0;

    extractList = [
      "上门自提",
      "我出邮费",
      "你出邮费",
    ];

    goldType = "";

  }
}
