import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/personal/FollowEntity.dart';

/// 粉丝关注的数据层
class FansFollowState {

  /// tabs列表
  late List<String> tabs;

  /// 列表Map
  late Map<int, List<FollowEntity>?> listMap;

  /// 列表是否需要重新加载
  late Map<int, bool> reload;

  /// 初始化 构造函数
  FansFollowState() {
    tabs = [
      "关注",
      "粉丝",
    ];

    listMap = {
      1: [],
      2: [],
    };

    reload = {
      1: false,
      2: false,
    };
  }
}

