import 'package:flutter/material.dart';
import 'package:quanda/model/chat/LabelEntity.dart';
import 'package:quanda/utils/ui/screen.dart';

/// 标签管理的数据层
class LabelManageState {

  /// 标签列表
  late List<LabelEntity> list;

  /// 是否返回刷新好友列表
  late bool refresh;

  /// 初始化 构造函数
  LabelManageState() {
    refresh = false;

    list = [];
  }

}


