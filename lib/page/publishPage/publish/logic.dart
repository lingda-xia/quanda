import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 发布页面的逻辑层
class PublishLogic extends GetxController {
  PublishState state = PublishState();

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

  /// 关闭发布页
  void goBack() {
    Get.back();
  }

  /// 前往页面
  void goToPage(String page) {
    Get.toNamed(page);
  }

}
