import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';

/// 赠礼的数据层
class GiftsState {

  /// tabs列表
  late List<String> tabs;

  /// 初始化 构造函数
  GiftsState() {
    tabs = [
      "收礼",
      "赠礼",
    ];
  }
}

