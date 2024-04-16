import 'package:flutter/material.dart';
import 'package:quanda/model/user/PersonalDataInfo.dart';

/// 个人资料的数据层
class PersonalDataState {
  /// 个人资料信息
  late PersonalDataInfo info;

  /// 名字输入框控制器
  late TextEditingController nController;

  /// 简介输入框控制器
  late TextEditingController jController;

  /// 初始化 构造函数
  PersonalDataState() {
    info = PersonalDataInfo(0, "", 0, 1, 18, "", "", "", null, {});
    nController = TextEditingController();
    jController = TextEditingController();
  }
}
