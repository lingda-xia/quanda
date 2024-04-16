import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 赠礼的逻辑层
class GiftsLogic extends GetxController {
  GiftsState state = GiftsState();

  @override
  void onInit() {
    super.onInit();
  }

  /// 模仿数据请求
  Future<Map<String, dynamic>> test({int page = 1}) async {
    print("加载的页数是$page");
    await Future.delayed(const Duration(milliseconds: 500));
    int a = 1;
    return {
      "state": a,
      "over": true,
    };
  }

  /// 前往核验码
  void goToVerificationCode() {
    Get.toNamed(RouteConfig.verificationCode);
  }

}
