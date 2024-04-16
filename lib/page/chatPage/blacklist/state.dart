import 'package:flutter/material.dart';
import 'package:quanda/model/chat/FriendList.dart';

/// 黑名单的数据层
class BlacklistState {

  /// 黑名单列表
  late List<FriendList> list;

  /// 初始化 构造函数
  BlacklistState() {
    list = [];
  }
}
