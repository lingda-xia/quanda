import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/personal/CollectEntity.dart';

/// 我的收藏的数据层
class MyCollectionState {

  /// tab列表
  late List<String> tabs;

  /// 列表Map
  late Map<int, List<CollectEntity>?> listMap;

  /// 列表是否需要重新加载
  late Map<int, bool> reload;

  /// 初始化 构造函数
  MyCollectionState() {
    listMap = {
      0: [],
      1: [],
      2: [],
      3: [],
      4: [],
    };

    reload = {
      0: false,
      1: false,
      2: false,
      3: false,
      4: false,
    };

    tabs = [
      "全部",
      "瞬间",
      "广播",
      "任务",
      "闲置",
    ];
  }
}

