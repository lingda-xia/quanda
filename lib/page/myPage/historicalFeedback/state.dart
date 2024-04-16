import 'package:flutter/material.dart';
import 'package:quanda/model/personal/FeedbackInfo.dart';

/// 历史反馈的数据层
class HistoricalFeedbackState {

  /// 列表是否需要重新加载
  late bool reload;

  /// 反馈列表
  late List<FeedbackInfo> list;

  /// 初始化 构造函数
  HistoricalFeedbackState() {
    reload = false;
    list = [];
  }
}

