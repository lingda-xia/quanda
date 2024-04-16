import 'package:flutter/material.dart';
import 'package:quanda/model/personal/BillEntity.dart';

/// 账单的数据层
class BillState {

  late List<BillEntity> list;

  /// 初始化 构造函数
  BillState() {

    list = [];
  }
}

