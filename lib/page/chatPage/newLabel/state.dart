import 'package:flutter/material.dart';
import 'package:quanda/model/chat/FriendList.dart';
import 'package:quanda/utils/ui/screen.dart';

/// 新建标签的数据层
class NewLabelState {

  /// 输入框控制器
  late TextEditingController textController;

  /// 输入框的文本内容
  late String textContent;

  /// 成员列表
  late List<FriendList> friendList;

  /// 好友item的高度
  late double cellHeight;

  /// 组头的高度
  late double groupHeight;

  /// 每一个组头距离顶部的距离
  late Map groupOffsetMap;

  /// 初始化 构造函数
  NewLabelState() {
    textContent = "";
    textController = TextEditingController();
    /// 好友item的高度
    cellHeight = 140.dp;
    /// 组头的高度
    groupHeight = 50.dp;
    /// 每一个组头距离顶部的距离
    groupOffsetMap = {};
    /// 好友列表
    friendList = [];
  }

}


