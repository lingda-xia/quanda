import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 账号注销的逻辑层
class AccountCancellationLogic extends GetxController {
  AccountCancellationState state = AccountCancellationState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// 改变协议的状态
  void change() {
    state.agree = !state.agree;
    update();
  }

  /// 前往注销原因页
  void goToCancellation() {
    Get.toNamed(RouteConfig.cancellation);
  }
}
