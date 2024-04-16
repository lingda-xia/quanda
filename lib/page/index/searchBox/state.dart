import 'package:flutter/material.dart';
import 'package:quanda/model/index/IndexSearch.dart';
import 'package:quanda/model/index/UserSearch.dart';
import 'package:quanda/model/location/Address.dart';

/// 首页 搜索框 数据层
class SearchBoxState {

  /// 输入框控制器
  late TextEditingController textController;

  /// 输入框的文本内容
  late String textContent;

  /// 互动列表
  late List<IndexSearch> list;

  /// 用户列表
  late List<UserSearch> userList;

  /// 地址信息
  late Address address;

  /// 列表是否需要重新加载
  late Map<int, bool> reload;

  /// tab列表
  late List<String> tabList;

  /// 类型列表
  late List<String> typeList;

  /// tab选择的下标
  late int index;

  /// 允许加载数据
  late bool allow;

  /// 焦点
  late FocusNode focusNode;

  /// 初始化 构造函数
  SearchBoxState() {
    focusNode = FocusNode();
    allow = false;
    textContent = "";
    textController = TextEditingController();
    address = Address("", "", "", "", "", "", 0, 0, "");
    reload = {
      0: false,
      1: false,
    };
    list = [];
    userList = [];
    tabList = [
      "用户",
      "互动",
    ];
    typeList = [
      "全部",
      "瞬间",
      "广播",
      "任务",
      "闲置",
    ];
    index = 0;
  }
}
