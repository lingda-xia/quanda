import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 系统设置的逻辑层
class SystemSettingLogic extends GetxController {
  SystemSettingState state = SystemSettingState();

  @override
  void onInit() {
    super.onInit();
  }

  /// 前往个人信息页
  void goToPersonalData() {
    Get.toNamed(RouteConfig.personalData);
  }

  /// 前往黑名单页
  void goToBlacklist() {
    Get.toNamed(RouteConfig.blacklist);
  }

  /// 前往账号安全页
  void goToAccountSecurity() {
    Get.toNamed(RouteConfig.accountSecurity);
  }

  /// 前往关于圈达页
  void goToAbout() {
    Get.toNamed(RouteConfig.about);
  }

  /// 前往意见反馈页
  void goToFeedback() {
    Get.toNamed(RouteConfig.feedback);
  }


}
