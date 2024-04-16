import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/login.dart';
import 'package:quanda/api/user.dart';
import 'package:quanda/http/request.dart';
import 'package:quanda/page/chatPage/tencent_im/logic.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 密码登陆的逻辑层
class PasswordLoginLogic extends GetxController {
  PasswordLoginState state = PasswordLoginState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();

    /// 判断是否进入的是相同的页面  相同的页面销毁会比新进来创建晚
    /// 会造成当前页面的文本控制器被销毁无法使用
    if (Get.currentRoute != "/passwordLogin") {
      state.textController.dispose();
    }
  }

  /// 监听密码输入
  void passwordChange(String msg) {
    /// 输入的内容的长度
    int length = msg.characters.length;
    print("密码输入的内容=======>   $msg");

    /// 正则表达   密码至少8位，至少含数字/字母 字符两种组合
    RegExp regExp = RegExp(r"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$");
    bool whether = regExp.hasMatch(msg);
    print("密码输入的内容是否符合正则表达式=======>   $whether");
    state.password = msg;

    /// 是否允许点击登录按钮
    if (length >= 6 && state.phone.characters.length == 11) {
      state.allow = true;
    } else {
      state.allow = false;
    }
    update();
  }

  /// 隐藏密码切换
  void changeHide() {
    print("触发了吗");
    state.hide = !state.hide;
    update();
  }

  /// 监听手机号输入
  void phoneInput(String msg) {
    /// 输入的内容的长度
    int length = msg.characters.length;
    print("手机号输入的内容=======>   $msg");
    print("手机号输入的内容的长度=======>   $length");
    state.phone = msg;

    /// 是否允许点击登录按钮
    if (length == 11 && state.password.characters.length >= 6) {
      state.allow = true;
    } else {
      state.allow = false;
    }
    update();
  }

  /// 确认按钮
  void confirm() {
    /// 先取消输入框的焦点  手机号
    state.focusNode.unfocus();

    /// 先取消输入框的焦点  密码
    state.pwFocusNode.unfocus();
    // if(state.password.characters.length < 8) return print("密码长度不足八位数");
    // if(state.phone.characters.length < 11) return print("手机号码不足十一位");
    /// 密码登录 请求
    LoginRequest.login(
        phone: state.phone,
        password: state.password,
        type: 3,
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
              fail: (code, msg) {});
        },
        fail: (code, msg) {
          print("密码登录出错错误code ==>$code    msg ==>$msg");
        });
  }

  /// 清空手机号
  void empty() {
    state.textController.text = "";
    state.phone = "";
    update();
  }

  /// 前往自动换绑
  void goToLoginBindChange() {
    Get.toNamed(RouteConfig.loginBindChange);
  }

  /// 前往忘记密码页面
  void goToRetrievePassword() {
    Get.toNamed(RouteConfig.retrievePassword);
  }

  /// 前往无法登录页面
  void goToUnableToLogin() {
    Get.toNamed(RouteConfig.unableToLogin);
  }

  /// 前往验证码登录页面
  void goToVerifyLogin() {
    Get.toNamed(RouteConfig.verifyLogin);
  }
}
