import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 实名认证的逻辑层
class CertificationLogic extends GetxController {
  CertificationState state = CertificationState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    print("是否是页面关闭了");
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



}
