import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/login.dart';
import 'package:quanda/api/user.dart';
import 'package:quanda/page/chatPage/tencent_im/logic.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 获取短信验证码 的逻辑层
class GetCodeLogic extends GetxController {
  GetCodeState state = GetCodeState();

  @override
  void onInit() {
    super.onInit();

    /// 开始倒计时
    countDown();
  }

  @override
  void onReady() {
    super.onReady();

    /// 刚进入页面不需要立刻赋值
    Future.delayed(const Duration(milliseconds: 1000), () {
      /// 重新赋值
      reassign();
      state.start = true;
    });
  }

  @override
  void onClose() {
    super.onClose();
    if (state.timer != null) {
      state.timer.cancel();
    }
    state.pinController.dispose();
    state.focusNode.dispose();
  }

  /// 重新赋值
  reassign() {
    state.phone = Get.parameters["phone"]!;
    state.type = int.parse(Get.parameters["type"]!);

    if (Get.parameters["pw"] != null) {
      state.pw = Get.parameters["pw"]!;
    }
    update();
  }

  /// 验证完成
  onCompleted(String code) {
    if (state.type == 1) {
      /// 登录
      login(code);
    } else if (state.type == 3) {
      /// 修改密码
      editPass(code);
    }
  }

  /// 登录
  login(String code) {
    /// 发起请求
    LoginRequest.login(
      phone: state.phone,
      smsCode: code,
      type: 1,
      success: (data) {
        /// 获取个人信息 请求
        UserRequest.getUserInfo(
          success: (data) async {
            /// 腾讯im
            final tim = Get.find<TencentImLogic>();

            /// 腾讯im登录
            await tim.timLogin();

            /// 当用户还未有名称时进入到选择界面
            if (data.nickname == "") {
              Future.delayed(const Duration(milliseconds: 1000), () {
                Get.offAllNamed(RouteConfig.chooseGender);
              });
            } else {
              /// 登录成功之后进入首页
              Future.delayed(const Duration(milliseconds: 1000), () {
                Get.offAllNamed(RouteConfig.main);
              });
            }
          },

          /// 信息获取失败
          fail: (code, msg) {},
        );
      },
      fail: (code, msg) {
        print("密码登录出错错误code ==>$code    msg ==>$msg");
      },
    );
  }

  /// 设置密码(修改密码)
  editPass(String code) {
    /// 发起请求
    LoginRequest.editPass(
      phone: state.phone,
      smsCode: code,
      password: state.pw,
      success: (data) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          Get.back();
        });
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

  /// 获取短信验证码
  getSmsCode() {
    /// 发起请求
    LoginRequest.getSmsCode(
      phone: state.phone,
      type: state.type,
      success: (data) {
        state.time = 60;
        state.allow = false;

        /// 倒计时
        countDown();
      },
      fail: (code, msg) {},
    );
  }
}
