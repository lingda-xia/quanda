import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/chat.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 查看非好友状态的逻辑层
class NonFriendLogic extends GetxController {
  NonFriendState state = NonFriendState();

  @override
  void onInit() {
    super.onInit();
    state.id = Get.parameters["id"]!;
    if (Get.parameters["close"] != null) {
      state.close = jsonDecode(Get.parameters["close"]!);
    }
  }

  @override
  void onReady() {
    super.onReady();
    /// 查看用户信息
    seeUserInfo();
  }

  /// 查看用户信息
  void seeUserInfo() async {
    /// 发起请求
    ChatRequest.seeUserInfo(
      /// 用户id
      userId: state.id,

      /// 来源
      source: "搜索",

      /// 1=被加的 2=我加的 其他为普通查看
      type: 3,
      success: (data) {
        state.othersInfo = data;
        update();
      },
    );
  }

  /// 前往他人主页
  void goToOthers() {
    if (!state.close) {
      Get.toNamed("${RouteConfig.others}?id=${state.id}");
    } else {
      Get.back();
    }
  }

  /// 前往添加好友页
  void goToAddFriends() {
    Get.toNamed(RouteConfig.addFriends, arguments: state.id);
  }

}