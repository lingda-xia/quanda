import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 无法登录的逻辑层
class UnableToLoginLogic extends GetxController {
  UnableToLoginState state = UnableToLoginState();

  @override
  void onInit() {
    super.onInit();
  }

  /// 前往意见反馈页
  void goToFeedback() {
    Get.toNamed(RouteConfig.feedback);
  }

  /// 前往登录 自动换绑 页
  void goToLoginBindChange() {
    Get.toNamed(RouteConfig.loginBindChange);
  }


}
