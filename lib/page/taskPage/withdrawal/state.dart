import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';

/// 提现 的数据层
class WithdrawalState {
  /// 金额列表
  late List<String> amountList;

  /// 所选择的金额列表下标
  late int selectIndex;

  /// 复选框的值
  late bool isChecked;

  /// 初始化 构造函数
  WithdrawalState() {
    amountList = ["5", "10", "15"];
    selectIndex = 0;
    isChecked = false;
  }
}
