import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/login.dart';
import 'package:quanda/model/user/UserInfo.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/function/custom_toast.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'state.dart';

/// 设置密码的逻辑层
class SetPasswordLogic extends GetxController {
  SetPasswordState state = SetPasswordState();

  @override
  void onInit() {
    super.onInit();
    if(Get.parameters["code"] != null) {
      state.code = Get.parameters["code"]!;
      state.phone = Get.parameters["phone"]!;
    }
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
    state.textController.dispose();
  }

  /// 获取用户信息
  getUserInfo() async {
    UserInfo? value = SpUtil.getUserInfo();
    if (value != null) {
      state.info = value;
      update();
    }
  }

  /// 确认按钮
  void confirm() {
    /// 失去焦点
    state.mFocusNode.unfocus();
    state.qFocusNode.unfocus();

    /// 数据过滤
    String value = dataFiltering();

    if (value != "") {
      print("-------$value");
      /// 自定义提示框
      CustomToast.showToast(value, const Color.fromRGBO(255, 77, 96, 1));
      return;
    }

    /// 是否是从登录页过来的验证码
    if(state.code != "") {
      /// 找回密码
      retrievePassword();
    } else {
      /// 获取验证码
      getSmsCode();
    }
  }

  /// 获取验证码
  getSmsCode() {
    /// 发起请求 获取验证码
    LoginRequest.getSmsCode(
      phone: state.info.phone,
      type: 3,
      success: (data) async {
        /// 前往获取验证码页面
        await Get.toNamed(
            "${RouteConfig.getCode}?phone=${state.info.phone}&type=${3}&pw=${state.password}");

        Get.back();
      },
      fail: (code, msg) {},
    );
  }

  /// 找回密码
  retrievePassword() {
    /// 发起请求 找回密码
    LoginRequest.retrievePassword(
      phone: state.phone,
      smsCode: state.code,
      password: state.password,
      success: (data) async {
        /// 浏览密码登录页并删除上一个页面。
        Get.offNamed(RouteConfig.passwordLogin);
      },
      fail: (code, msg) {},
    );
  }

  /// 数据过滤
  String dataFiltering() {
    String msg = "";

    /// 正则表达   密码至少8位，至少含数字/字母/字符两种组合
    RegExp regExp = RegExp(r"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$");
    bool whether = regExp.hasMatch(state.password);

    print("密码输入的内容是否符合正则表达式=======>   $whether");

    if (!whether) msg = "密码格式不正确";
    if (state.password != state.reconfirm) msg = "密码不一致";
    if (state.password.characters.length < 8) msg = "密码至少8位";

    print("-------------$msg");
    return msg;
  }

  /// 监听密码输入
  void passwordChange(String msg) {
    print("密码输入的内容=======>   $msg");

    state.password = msg;
    update();
  }

  /// 隐藏密码切换
  void changeHide() {
    state.hide = !state.hide;
    update();
  }

  /// 监听密码再次输入
  void again(String msg) {
    print("再次确认输入的内容=======>   $msg");
    state.reconfirm = msg;
    update();
  }
}
