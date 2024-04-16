import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/login.dart';
import 'package:quanda/api/user.dart';
import 'package:quanda/model/user/UserInfo.dart';
import 'package:quanda/utils/function/custom_toast.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'state.dart';

/// 更换手机号码绑定 的逻辑层
class ChangeNumberLogic extends GetxController {
  ChangeNumberState state = ChangeNumberState();

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

  /// 数据过滤
  String dataFiltering() {
    String msg = "";
    if (state.phone.length < 11) msg = "请填写正确的手机号";
    if (state.phone == "") msg = "手机号不能为空";

    return msg;
  }

  /// 修改手机号
  editPhone() {
    /// 发起请求  修改手机号
    LoginRequest.editPhone(
      phone: state.phone,
      smsCode: state.code,
      success: (data) {
        /// 发起请求  获取个人信息
        UserRequest.getUserInfo(
          success: (data) {
            Future.delayed(const Duration(milliseconds: 1000), () {
              Get.back();
            });
          },
          fail: (code, msg) {},
        );
      },
      fail: (code, msg) {},
    );
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

  /// 获取用户信息
  getUserInfo() async {
    UserInfo? value = SpUtil.getUserInfo();
    if (value != null) {
      state.info = value;
      update();
    }
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
