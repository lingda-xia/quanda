import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 选择性别 的逻辑层
class ChooseGenderLogic extends GetxController {
  ChooseGenderState state = ChooseGenderState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// 改变性别
  void change(int i) {
    state.select = i;
    update();
  }

  /// 前往选择生日
  void goToChooseBirthday() {
    Get.toNamed(RouteConfig.chooseBirthday);
  }

}
