import 'package:flutter/material.dart';
import 'package:quanda/model/chat/SearchEntity.dart';

/// 通讯录的状态
class SearchState {
  /// 输入框控制器
  late TextEditingController textController;

  /// 输入框的文本内容
  late String textContent;

  /// 搜索列表
  late List<SearchEntity> list;

  /// 由于刷新加载组件进入页面会自动刷新 处理自动刷新
  late bool allow;

  /// 列表是否需要重新加载
  late bool reload;

  /// 聚焦
  late FocusNode focusNode;

  /// 初始化 构造函数
  SearchState() {
    textContent = "";

    textController = TextEditingController();

    list = [];

    reload = false;

    allow = false;

    focusNode = FocusNode();
  }
}
