import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/personal/PrivacyInfo.dart';

/// 隐私设置的数据层
class PrivacySettingState {

  /// 隐私设置
  late Map<String, dynamic> info;

  /// 初始化 构造函数
  PrivacySettingState() {
    info = {};
  }
}
