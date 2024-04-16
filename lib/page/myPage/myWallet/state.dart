import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';

/// 我的钱包的数据层
class MyWalletState {
  /// 金额列表
  late List<String> amountList;

  /// 所选择的金额列表下标
  late int selectIndex;

  /// 复选框的值
  late bool isChecked;

  /// 是否选择的充值
  late bool statusValue;

  /// 初始化 构造函数
  MyWalletState() {
    amountList = ["5", "10", "20", "50", "100", "200", "500", "1000", "2000"];
    selectIndex = 0;
    isChecked = false;
    statusValue = true;
  }
}
