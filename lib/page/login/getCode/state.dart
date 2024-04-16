import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quanda/model/personal/BillEntity.dart';

/// 获取短信验证码 的数据层
class GetCodeState {

  /// 验证码输入文本控制器
  late TextEditingController pinController;

  /// 聚焦
  late FocusNode focusNode;

  /// 倒计时
  late int time;

  /// 定时器
  late Timer timer;

  /// 是否允许点击按钮
  late bool allow;

  /// 阻止一开始进入页面就赋值
  late bool start;

  /// 短信验证码类型
  late int type;

  /// 手机号码
  late String phone;

  /// 密码
  late String pw;

  /// 初始化 构造函数
  GetCodeState() {
    pinController = TextEditingController();
    focusNode = FocusNode();
    time = 60;
    allow = false;
    start = false;
    type = 0;
    phone = "";
    pw = "";
    timer = Timer(const Duration(), () {});
  }
}

