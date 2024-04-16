import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quanda/model/publish/TaskOrder.dart';

/// 任务人列表的数据层
class TaskListState {

  /// 任务列表
  late List<TaskOrder> list;

  /// 列表是否需要重新加载
  late bool reload;

  /// 定时器
  late Timer timer;

  /// 发布id
  late int id;

  /// 初始化 构造函数
  TaskListState() {
    id = 0;

    list = [];

    reload = false;

    timer = Timer(const Duration(), () {});
  }
}

