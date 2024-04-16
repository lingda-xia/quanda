import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/router/router.dart';

/// 验证码登陆的数据层
class VerifyLoginState {

  /// 密码输入文本控制器
  late TextEditingController textController;

  /// 输入的手机号
  late String phone;

  /// 是否允许点击按钮
  late bool allow;

  /// 初始化 构造函数
  VerifyLoginState() {
    phone = "";
    textController = TextEditingController();
    allow = false;
  }
}
