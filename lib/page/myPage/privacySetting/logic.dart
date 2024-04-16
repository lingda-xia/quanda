import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/personal.dart';
import 'state.dart';

/// 隐私设置的逻辑层
class PrivacySettingLogic extends GetxController {
  PrivacySettingState state = PrivacySettingState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    /// 发起请求
    userSettingInfo();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// 获取用户的隐私信息
  userSettingInfo() {
    /// 发起请求
    PersonalRequest.userSettingInfo(
      success: (data) {
        state.info = data;
        update();
      },
      fail: (code, msg) {

      },
    );
  }

  /// 用户隐私保存
  Future userSettingSave() async {
    Completer completer = Completer();

    /// 发起请求
    PersonalRequest.userSettingSave(
      map: state.info,
      success: (data) {
        completer.complete();
      },
      fail: (code, msg) {
        completer.complete();
      },
    );

    return completer.future;
  }

  /// switch开关改变
  void onChanged(bool value, String key) {
    state.info[key] = value ? 1 : 0;
    update();
  }

}
