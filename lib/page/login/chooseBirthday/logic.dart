import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/page/chatPage/tencent_im/logic.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 选择生日 的逻辑层
class ChooseBirthdayLogic extends GetxController {
  ChooseBirthdayState state = ChooseBirthdayState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// 改变时间
  void change(DateTime newTime) {
    state.time = newTime;
    update();
  }

  /// 前往选择形象
  void goToChooseFigure() {
    Get.toNamed(RouteConfig.chooseFigure);
  }

}
