import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';

/// 账号注销的数据层
class AccountCancellationState {

  /// 是否同意协议
  late bool agree;

  /// 初始化 构造函数
  AccountCancellationState() {
    agree = false;
  }
}

