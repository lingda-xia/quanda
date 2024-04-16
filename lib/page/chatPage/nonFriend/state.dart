import 'package:flutter/material.dart';
import 'package:quanda/model/user/OthersInfo.dart';

/// 查看非好友状态的数据层
class NonFriendState {

  /// 用户信息
  late OthersInfo othersInfo;

  /// 用户id
  late String id;

  /// 点击前往主页是否是直接返回页面
  late bool close;

  NonFriendState() {
    close = false;
    othersInfo = OthersInfo(
      "",
      "用户名称",
      0,
      "",
      1,
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      [],
      [],
    );
    id = "";
  }
}


