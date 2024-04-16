import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/user/UserInfo.dart';

/// 账号安全的数据层
class AccountSecurityState {

  /// 用户信息
  late UserInfo info;

  /// 初始化 构造函数
  AccountSecurityState() {
    info = UserInfo(0, "", 0, 0, "", 0, 1, "", "", "", 0);
  }
}

