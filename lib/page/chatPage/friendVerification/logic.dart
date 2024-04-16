import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/chat.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'state.dart';

/// 加好友验证的逻辑层
class FriendVerificationLogic extends GetxController {
  FriendVerificationState state = FriendVerificationState();

  @override
  void onInit() {
    super.onInit();
    state.id = Get.parameters["id"]!;
    state.type = Get.parameters["type"]!;
  }

  @override
  void onReady() {
    super.onReady();

    /// 查看用户信息
    seeUserInfo();
  }

  @override
  void onClose() {
    super.onClose();
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
      type: int.parse(state.type),
      success: (data) {
        state.othersInfo = data;
        update();
      },
    );
  }

  /// 输入完成时
  onEditingComplete() {
    state.focusNode.unfocus();

    /// 发起请求
    ChatRequest.checkMessageAdd(
      userId: state.id,

      content: state.textController.text,

      /// 1=被加的 2=我加的 其他为普通查看
      type: int.parse(state.type),

      success: (data) {
        /// 查看用户信息  获取信息验证列表
        seeUserInfo();
        state.textController.text = "";
        state.focus = 0.dp;

        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 回复
  reply(BuildContext context) async {
    state.focus = 50.dp;
    update();

    /// 获取焦点
    FocusScope.of(context).requestFocus(state.focusNode);
  }

  /// 前往通过验证页
  void goToPassValidation() async {
    var data = await Get.toNamed("${RouteConfig.passValidation}?id=${state.id}");
    if(data == "success") {
      Get.back(result: "success");
    }
  }
}
