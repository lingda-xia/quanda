import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/login.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/function/custom_toast.dart';
import 'state.dart';

/// 登录 自助换绑 新手机号 的逻辑层
class LoginBindChangeLogic extends GetxController {
  LoginBindChangeState state = LoginBindChangeState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    if (state.timer != null) {
      state.timer.cancel();
    }
    state.textController.dispose();
  }

  /// 获取短信验证码
  getSmsCode() {
    /// 数据过滤
    String value = dataFiltering();

    if (value != "") {
      /// 自定义提示框
      CustomToast.showToast(value, const Color.fromRGBO(255, 77, 96, 1));
      return;
    }

    /// 发起请求  检测手机号
    LoginRequest.authPhone(
      phone: state.phone,
      success: (data) {
        /// 发起请求  发送验证码
        LoginRequest.getSmsCode(
          phone: state.phone,
          type: 4,
          success: (data) {
            state.time = 60;
            state.allow = false;

            /// 倒计时
            countDown();
          },
          fail: (code, msg) {},
        );
      },
      fail: (code, msg) {},
    );
  }


  /// 下一步确定方法
  void nextStep() {
    /// 前往输入原手机号码页面
    Get.offNamed(RouteConfig.originalNumber);
  }

  /// 数据过滤
  String dataFiltering() {
    String msg = "";
    if (state.phone.length < 11) msg = "请填写正确的手机号";
    if (state.phone == "") msg = "手机号不能为空";

    return msg;
  }

  /// 倒计时
  countDown() {
    state.timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      state.time--;
      update();
      if (state.time == 0) {
        state.allow = true;
        timer.cancel();
      }
    });
  }

  /// 监听新手机号输入
  void phoneChange(String msg) {
    state.phone = msg;
    update();
  }

  /// 清空内容
  void empty() {
    state.textController.text = "";
    state.phone = "";
    update();
  }

  /// 监听验证码输入
  void changeCode(String msg) {
    state.code = msg;
    update();
  }

}
