import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';

/// 登录 自助换绑 新手机号 的数据层
class LoginBindChangeState {

  /// 输入新手机号
  late String phone;

  /// 输入文本控制器
  late TextEditingController textController;

  /// 输入验证码
  late String code;

  /// 倒计时
  late int time;

  /// 定时器
  late Timer timer;

  /// 是否允许点击按钮
  late bool allow;

  /// 初始化 构造函数
  LoginBindChangeState() {
    phone = "";
    code = "";
    textController = TextEditingController();
    time = 60;
    allow = true;
    timer = Timer(const Duration(), () {});
  }
}

