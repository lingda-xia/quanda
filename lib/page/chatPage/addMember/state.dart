import 'package:flutter/material.dart';
import 'package:quanda/model/chat/FriendList.dart';
import 'package:quanda/utils/ui/screen.dart';

/// 添加成员的数据层
class AddMemberState {
  /// 输入框控制器
  late TextEditingController textController;

  /// 输入框的文本内容
  late String textContent;

  /// 好友列表
  late List<FriendList> friendList;

  /// 好友item的高度
  late double cellHeight;

  /// 组头的高度
  late double groupHeight;

  /// 每一个组头距离顶部的距离
  late Map groupOffsetMap;

  /// 已添加的好友列表
  late List<FriendList> selected;

  /// 滚动控制器
  late ScrollController scrollController;

  /// 滚动控制器
  late GlobalKey<AnimatedListState> globalKey;

  /// 初始化 构造函数
  AddMemberState() {
    textContent = "";
    textController = TextEditingController();
    scrollController = ScrollController();
    globalKey = GlobalKey();
    /// 好友item的高度
    cellHeight = 140.dp;
    /// 组头的高度
    groupHeight = 50.dp;
    /// 每一个组头距离顶部的距离
    groupOffsetMap = {};
    /// 已选择的好友头像
    selected = [];
    /// 好友列表
    friendList = [];
  }
}
