import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/user/UserInfo.dart';

/// 设置密码的数据层
class SetPasswordState {

  /// 输入密码
  late String password;

  /// 密码输入文本控制器
  late TextEditingController textController;

  /// 密码焦点
  late FocusNode mFocusNode;

  /// 确认密码焦点
  late FocusNode qFocusNode;

  /// 再次确认
  late String reconfirm;

  /// 是否隐藏密码
  late bool hide;

  /// 用户信息
  late UserInfo info;

  /// 是否是登录页过来的验证码
  late String code;

  /// 是否是登录页过来的手机号
  late String phone;

  /// 初始化 构造函数
  SetPasswordState() {
    mFocusNode = FocusNode();
    qFocusNode = FocusNode();
    code = "";
    phone = "";
    password = "";
    reconfirm = "";
    textController = TextEditingController();
    hide = true;
    info = UserInfo(0, "", 0, 0, "", 0, 1, "", "", "", 0);
  }
}

