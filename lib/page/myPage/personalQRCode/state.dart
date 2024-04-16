import 'package:flutter/material.dart';
import 'package:quanda/model/user/UserInfo.dart';

/// 个人二维码的数据层
class PersonalQRCodeState {

  /// 用户信息
  late UserInfo info;

  /// 是否可以使用二维码 0 = 关闭 1=开启
  late int qrcodeStatus;

  /// 初始化 构造函数
  PersonalQRCodeState() {
    info = UserInfo(0, "", 0, 0, "", 0, 1, "", "", "", 0);
    qrcodeStatus = 0;
  }
}

