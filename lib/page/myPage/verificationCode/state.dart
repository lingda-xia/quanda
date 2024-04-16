import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/personal/CheckInfo.dart';
import 'package:quanda/model/user/InfoEntity.dart';

/// 核验码的数据层
class VerificationCodeState {
  /// 验证信息
  late CheckInfo info;

  /// 类型
  late String type;

  /// 源订单id
  late int sourceOrderId;

  /// 初始化 构造函数
  VerificationCodeState() {
    sourceOrderId = 0;
    type = "1";
    info = CheckInfo("", "", "", "", 0, InfoEntity("", "", "", ""), 0, 0, 0);
  }
}
