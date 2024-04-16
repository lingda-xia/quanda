import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quanda/model/user/UserInfo.dart';

/// 更换手机号码绑定 的数据层
class ChangeNumberState {

  /// 输入新手机号
  late String phone;

  /// 输入文本控制器
  late TextEditingController textController;

  /// 输入验证码
  late String code;

  /// 用户信息
  late UserInfo info;

  /// 倒计时
  late int time;

  /// 定时器
  late Timer timer;

  /// 是否允许点击按钮
  late bool allow;

  /// 初始化 构造函数
  ChangeNumberState() {
    phone = "";
    code = "";
    textController = TextEditingController();
    info = UserInfo(0, "", 0, 0, "", 0, 1, "", "", "", 0);
    time = 60;
    allow = true;
    timer = Timer(const Duration(), () {});
  }
}

