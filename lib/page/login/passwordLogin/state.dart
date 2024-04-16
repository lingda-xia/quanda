import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/router/router.dart';

/// 密码登陆的数据层
class PasswordLoginState {
  /// 输入密码
  late String password;

  /// 密码输入文本控制器
  late TextEditingController textController;

  /// 输入的手机号
  late String phone;

  /// 是否隐藏密码
  late bool hide;

  /// 是否允许点击登录按钮
  late bool allow;

  /// 控制输入框的焦点   手机号
  late FocusNode focusNode;

  /// 控制输入框的焦点   密码
  late FocusNode pwFocusNode;

  /// 初始化 构造函数
  PasswordLoginState() {
    phone = "";
    password = "";
    textController = TextEditingController();
    hide = true;
    focusNode = FocusNode();
    pwFocusNode = FocusNode();
    allow = false;
  }
}
