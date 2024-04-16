import 'package:flutter/material.dart';
import 'package:quanda/model/publish/ReleaseList.dart';

/// 我的互动的数据层
class MyInteractionState {
  /// 互动列表
  late List<ReleaseList> list;

  /// 类别列表 类型 1=瞬间 2=广播 3=任务 4=闲置
  late List<String> typeList;

  /// 类别名称 1=瞬间 2=广播 3=任务 4=闲置
  late List<String> typeNameList;

  /// 列表是否需要重新加载
  late bool reload;

  /// 初始化 构造函数
  MyInteractionState() {
    list = [];
    typeList = ["", "MyMoment", "MyRadio", "MyMission", "MyIdle"];
    typeNameList = ["", "瞬间", "广播", "任务", "闲置"];
    reload = false;
  }
}
