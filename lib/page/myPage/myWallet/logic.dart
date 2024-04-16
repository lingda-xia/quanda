import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 我的钱包 的逻辑层
class MyWalletLogic extends GetxController {
  MyWalletState state = MyWalletState();

  @override
  void onInit() {
    super.onInit();
  }

  /// 模仿数据请求
  Future<Map<String, dynamic>> test({int page = 1}) async {
    print("加载的页数是$page");
    await Future.delayed(const Duration(milliseconds: 500));
    int a = 1;
    return {
      "state": a,
      "over": true,
    };
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

  /// 前往账单
  void goToBill() {
    Get.toNamed(RouteConfig.bill);
  }

  /// 是否是选择充值
  void selectStatusValue(bool value) {
    state.statusValue = value;
    update();
  }
}
