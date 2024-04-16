import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';

/// 自助换绑的数据层
class ChangeBindingState {

  /// 输入名字
  late String name;

  /// 名字输入文本控制器
  late TextEditingController nameController;

  /// 输入身份证
  late String ID;

  /// 初始化 构造函数
  ChangeBindingState() {
    name = "";
    ID = "";
    nameController = TextEditingController();
  }
}

