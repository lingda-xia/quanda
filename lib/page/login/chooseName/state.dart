import 'package:flutter/material.dart';
import 'package:quanda/utils/ui/screen.dart';

/// 选择名称 的数据层
class ChooseNameState {

  /// 名称
  late String name;

  /// 控制输入框的焦点
  late FocusNode focusNode;

  /// 初始化 构造函数
  ChooseNameState() {

    name = "";

    focusNode = FocusNode();
  }

}
