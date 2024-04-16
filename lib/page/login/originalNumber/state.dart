import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';

/// 登录 自助换绑 原手机号 的数据层
class OriginalNumberState {

  /// 输入手机号
  late String phone;

  /// 输入文本控制器
  late TextEditingController textController;

  /// 输入验证码
  late String code;

  /// 初始化 构造函数
  OriginalNumberState() {
    phone = "";
    code = "";
    textController = TextEditingController();
  }
}

