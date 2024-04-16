import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 选择形象 的逻辑层
class ChooseFigureLogic extends GetxController {
  ChooseFigureState state = ChooseFigureState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// 改变形象
  void change(String str) {
    state.select = str;
    update();
  }

  /// 前往选择生日
  void goToChooseName() {
    Get.toNamed(RouteConfig.chooseName);
  }

}
