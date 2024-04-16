import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';

/// 发布广播的数据层
class BroadcastState {

  // /// 标题
  // late String title;
  //
  // /// 内容
  // late String content;

  /// 图片列表
  late List<String> media;

  /// 公里数
  late double kilometers;

  /// 时长数
  late double times;

  /// 所需支付的总金额
  late double payMoney;

  /// 金币奖励类型:广播  用于完成发布广播需要
  late String goldType;

  /// 初始化 构造函数
  BroadcastState() {
    // title = "";
    //
    // content = "";

    kilometers = 1;

    times = 24;

    payMoney = 0;

    media = [];

    goldType = "";

  }
}
