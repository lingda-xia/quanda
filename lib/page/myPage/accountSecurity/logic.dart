import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/model/user/UserInfo.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'state.dart';

/// 账号安全的逻辑层
class AccountSecurityLogic extends GetxController {
  AccountSecurityState state = AccountSecurityState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    /// 获取用户信息
    getUserInfo();
  }

  /// 获取用户信息
  getUserInfo() async {
    UserInfo? value = SpUtil.getUserInfo();
    if (value != null) {
      state.info = value;
      update();
    }
  }

  /// 前往更换手机号绑定页
  void goToChangeNumber() async {
    await Get.toNamed(RouteConfig.changeNumber);
    /// 获取用户信息
    getUserInfo();
  }

  /// 前往设置密码页
  void goToSetPassword() {
    Get.toNamed(RouteConfig.setPassword);
  }

  /// 前往账号注销页
  void goToAccountCancellation() {
    Get.toNamed(RouteConfig.accountCancellation);
  }

}
