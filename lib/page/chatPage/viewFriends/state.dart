import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/user/OthersInfo.dart';
import 'package:quanda/utils/ui/screen.dart';

/// 查看好友状态的数据层
class ViewFriendState {
  /// 用户信息
  late OthersInfo othersInfo;

  /// 备注焦点
  late FocusNode bFocusNode;

  /// 描述焦点
  late FocusNode mFocusNode;

  /// 备注 输入框控制器
  late TextEditingController bController;

  /// 描述 输入框控制器
  late TextEditingController mController;

  /// 用户id
  late int id;

  /// 是否需要修改备注和描述
  late bool modify;

  ViewFriendState() {
    modify = false;
    id = 0;
    bFocusNode = FocusNode();
    mFocusNode = FocusNode();
    bController = TextEditingController();
    mController = TextEditingController();
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
  }

}


