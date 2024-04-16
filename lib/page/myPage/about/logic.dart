import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 关于圈达的逻辑层
class AboutLogic extends GetxController {
  AboutState state = AboutState();

  @override
  void onInit() {
    super.onInit();
  }

  /// 前往个人信息页
  void goToPersonalData() {
    // Get.toNamed(RouteConfig.personalData);
  }

  /// 前往黑名单页
  void goToBlacklist() {
    // Get.toNamed(RouteConfig.blacklist);
  }

  // /// 前往个人信息页
  // void goToPersonalData() {
  //   Get.toNamed(RouteConfig.personalData);
  // }
  //
  // /// 前往个人信息页
  // void goToPersonalData() {
  //   Get.toNamed(RouteConfig.personalData);
  // }



}
