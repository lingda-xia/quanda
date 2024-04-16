import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 登录 自助换绑 原手机号 的逻辑层
class OriginalNumberLogic extends GetxController {
  OriginalNumberState state = OriginalNumberState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    print("是否是页面关闭了");
    state.textController.dispose();
  }

  /// 监听手机号输入
  void phoneChange(String msg) {
    print("手机号输入的内容=======>   $msg");
    state.phone = msg;
    update();
  }

  /// 清空名字内容
  void empty() {
    print("触发了吗");
    state.textController.text = "";
    state.phone = "";
    update();
  }

  /// 监听身份证输入
  void changeCode(String msg) {
    print("身份证输入的内容=======>   $msg");
    state.code = msg;
    update();
  }

  /// 下一步确定方法
  void nextStep() {

    /// 前往身份核实
    Get.toNamed(RouteConfig.verifyIdentity);
  }



}
