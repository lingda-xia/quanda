import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/personal/OrderEntity.dart';

/// 我的订单的数据层
class MyOrderState {

  /// tab列表
  late List<String> tabs;

  /// 列表Map
  late Map<int, List<OrderEntity>?> listMap;

  /// 列表是否需要重新加载
  late Map<int, bool> reload;

  /// 定时器
  late Timer timer;

  /// 选择的状态
  late int select;

  /// 初始化 构造函数
  MyOrderState() {
    timer = Timer(const Duration(), () {});

    select = -1;

    tabs = [
      "全部",
      "待支付",
      "待发货",
      "待收货/使用",
      "退款/售后",
    ];

    reload = {
      -1: false,
      0: false,
      1: false,
      2: false,
      4: false,
    };

    listMap = {
      -1: [],
      0: [],
      1: [],
      2: [],
      4: [],
    };
  }
}

