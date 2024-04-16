import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';

/// 发布瞬间 的数据层
class PublishDynamicState {

  /// 金币奖励类型:瞬间  用于完成发布瞬间需要
  late String goldType;

  /// 初始化 构造函数
  PublishDynamicState() {

    goldType = "";

  }
}
