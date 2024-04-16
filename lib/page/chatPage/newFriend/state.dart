import 'package:flutter/material.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_application.dart';

/// 新的朋友的数据层
class NewFriendState {

  /// 新朋友列表
  /// [addSource] 添加来源
  /// [addTime] 添加时间
  /// [addWording] 验证信息
  /// [faceUrl] 头像
  /// [nickname] 名称
  /// [type] 类型  目前已知 2 是本人看的   1 是对方看的
  /// [userID] 用户id
  late List<V2TimFriendApplication?> list;

  NewFriendState() {
    list = [];
  }

}


