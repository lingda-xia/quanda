import 'package:flutter/material.dart';
import 'package:quanda/utils/ui/screen.dart';

/// 添加好友的数据层
class AddFriendsState {

  /// 输入框控制器
  late TextEditingController textController;

  /// 输入框的文本内容
  late String textContent;

  /// 用户id
  late String id;

  /// 初始化 构造函数
  AddFriendsState() {
    textContent = "";
    textController = TextEditingController();

  }

}
