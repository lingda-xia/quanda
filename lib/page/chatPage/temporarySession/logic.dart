import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';

class SessionLogic extends GetxController {
  SessionState state = SessionState();

  @override
  void onInit() {
    super.onInit();
  }

  /// 模仿数据请求
  Future<Map<String, dynamic>> test({int page = 1}) async {
    print("加载的页数是$page");
    await Future.delayed(const Duration(milliseconds: 2000));
    int a = 1;
    return {
      "state": a,
      "over": true,
    };
  }


}