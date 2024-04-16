import 'package:flutter/material.dart';
import 'package:quanda/utils/ui/screen.dart';

/// 选择生日 的数据层
class ChooseBirthdayState {

  /// 初始时间
  late DateTime initTime;

  /// 选择的时间
  late DateTime time;

  /// 初始化 构造函数
  ChooseBirthdayState() {

    initTime = DateTime(2000, 1, 1);

    time = DateTime(2000, 1, 1);
  }

}
