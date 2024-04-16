import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/task/ProfitEntity.dart';

/// 金币收益 的数据层
class GoldIncomeState {

  /// tabs列表
  late List<String> tabs;

  /// 列表Map
  late Map<int, List<ProfitEntity>?> listMap;

  /// 列表是否需要重新加载
  late Map<int, bool> reload;

  /// 初始化 构造函数
  GoldIncomeState() {
    tabs = [
      "金币收益",
      "现金收益",
    ];

    reload = {
      1: false,
      2: false,
    };

    listMap = {
      1: [],
      2: [],
    };
  }
}

