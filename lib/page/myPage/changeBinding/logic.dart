import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 自助换绑的逻辑层
class ChangeBindingLogic extends GetxController {
  ChangeBindingState state = ChangeBindingState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    state.nameController.dispose();
  }

  /// 监听名字输入
  void nameChange(String msg) {
    print("名字输入的内容=======>   $msg");
    state.name = msg;
    update();
  }

  /// 清空名字内容
  void empty() {
    print("触发了吗");
    state.nameController.text = "";
    state.name = "";
    update();
  }

  /// 监听身份证输入
  void changeID(String msg) {
    print("身份证输入的内容=======>   $msg");
    state.ID = msg;
    update();
  }

  /// 下一步确定方法
  void nextStep() {
    /// 正则表达  身份证
    RegExp regExp = RegExp(r"^\d{6}(18|19|20)?\d{2}(0[1-9]|1[012])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$");
    bool whether = regExp.hasMatch(state.ID);
    print("身份证输入是否正确=======>   $whether");
  }



}
