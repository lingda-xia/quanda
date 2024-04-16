import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/screen.dart';

import '../../../model/user/OthersInfo.dart';

/// 加好友验证的数据层
class FriendVerificationState {
  /// 用户信息
  late OthersInfo othersInfo;

  /// 焦点控制
  late FocusNode focusNode;

  /// 是否显示输入框
  late double focus;

  /// 输入框控制器
  late TextEditingController textController;

  /// 用户id
  late String id;

  /// 类型 1=被加的 2=我加的 其他为普通查看
  late String type;

  FriendVerificationState() {
    id = "";
    type = "1";
    othersInfo = OthersInfo(
      "",
      "用户名称",
      0,
      "${RequestApi.baseUrl}/api/static/boy.png",
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

    textController = TextEditingController();

    focus = 0;

    focusNode = FocusNode();
  }
}
