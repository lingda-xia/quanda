import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/login.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 验证码登陆的逻辑层
class VerifyLoginLogic extends GetxController {
  VerifyLoginState state = VerifyLoginState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    state.textController.dispose();
  }

  /// 获取短信验证码
  getSmsCode() {
    /// 发起请求
    LoginRequest.getSmsCode(
      phone: state.phone,
      type: 1,
      success: (data) {
        Get.toNamed("${RouteConfig.getCode}?phone=${state.phone}&type=${1}");
      },
      fail: (code, msg) {},
    );
  }

  /// 监听手机号输入
  void phoneInput(String msg) {
    /// 输入的内容的长度
    int length = msg.characters.length;
    print("手机号输入的内容=======>   $msg");
    state.phone = msg;

    /// 是否允许点击按钮
    if (length == 11) {
      state.allow = true;
    } else {
      state.allow = false;
    }
    update();
  }

  /// 清空手机号
  void empty() {
    print("触发了吗");
    state.textController.text = "";
    state.phone = "";
    update();
  }

  /// 前往自动换绑
  void goToLoginBindChange() {
    Get.toNamed(RouteConfig.loginBindChange);
  }

  /// 前往无法登录页面
  void goToUnableToLogin() {
    Get.toNamed(RouteConfig.unableToLogin);
  }

  /// 前往忘记密码页面
  void goToRetrievePassword() {
    Get.toNamed(RouteConfig.retrievePassword);
  }

  /// 前往密码登录页面
  void goToPasswordLogin() {
    Get.toNamed(RouteConfig.passwordLogin);
  }
}
