import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 提现 的逻辑层
class WithdrawalLogic extends GetxController {
  WithdrawalState state = WithdrawalState();

  @override
  void onInit() {
    super.onInit();
  }

  /// 选择金额
  void selectAmount(int index) {
    state.selectIndex = index;
    update();
  }

  /// 复选框改变
  void onChanged() {
    print("ssss");
    state.isChecked = !state.isChecked;
    update();
  }

  /// 前往 金币收益
  void goToGoldIncome() {
    Get.toNamed(RouteConfig.goldIncome);
  }

}
