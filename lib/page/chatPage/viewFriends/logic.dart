import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/chat.dart';
import 'package:quanda/page/chatPage/tencent_im/friend_logic.dart';
import 'package:quanda/router/router.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_callback.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_operation_result.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'state.dart';

/// 查看好友状态的逻辑层
class ViewFriendLogic extends GetxController {
  ViewFriendState state = ViewFriendState();

  /// 腾讯im 好友关系链
  final tFriend = Get.find<TFriendLogic>();

  @override
  void onInit() {
    super.onInit();
    state.id = Get.arguments!;
  }

  @override
  void onReady() {
    super.onReady();
    seeUserInfo();
  }

  @override
  void onClose() {
    super.onClose();
    state.bController.dispose();
    state.mController.dispose();
  }

  /// 查看用户信息
  void seeUserInfo() async {
    /// 发起请求
    ChatRequest.seeUserInfo(
      /// 用户id
      userId: state.id.toString(),

      /// 来源
      source: "搜索",

      /// 1=被加的 2=我加的 其他为普通查看
      type: 3,
      success: (data) {
        state.othersInfo = data;
        state.mController.text = data.toDesc;
        state.bController.text = data.remarkName;
        update();
      },
    );
  }

  /// 修改好友描述和备注
  Future friendEditBy() async {
    Completer completer = Completer();

    /// 发起请求
    ChatRequest.friendEditBy(
      toUserId: state.othersInfo.userId,
      remarkName: state.othersInfo.remarkName,
      toDesc: state.othersInfo.toDesc,
      success: (data) async {
        /// 腾讯im 设置指定好友资料
        V2TimCallback res = await tFriend.setFriendInfo(
            state.othersInfo.userId, state.othersInfo.remarkName);

        completer.complete();
      },
      fail: (code, msg) {
        completer.complete();
      },
    );

    return completer.future;
  }

  /// 拉黑用户
  blackmailUsers() {
    /// 发起请求
    ChatRequest.blackUserAction(
      userId: state.id.toString(),
      status: 0,
      success: (data) async {
        /// 腾讯im 将好友拉入黑名单
        addToBlackList();
      },
    );
  }

  /// 腾讯im 将好友拉入黑名单
  addToBlackList() async {
    V2TimValueCallback<List<V2TimFriendOperationResult>> res =
    await tFriend.addToBlackList(state.id.toString());

    if (res.data?[0].resultCode == 0) {
      Get.back();
    }
  }

  /// 描述输入
  void describeChange(String msg) {
    state.modify = true;
    state.othersInfo.toDesc = msg;
  }

  /// 备注输入
  void remarksChange(String msg) {
    state.modify = true;
    state.othersInfo.remarkName = msg;
  }

  /// 前往选择标签页面
  void goToSelectLabel() async {
    var data = await Get.toNamed(RouteConfig.selectLabel,
        arguments: state.othersInfo.userId);
    if (data == "success") {
      /// 查看用户信息
      seeUserInfo();
    }
  }

  /// 前往他人主页
  void goToOthers() {
    Get.toNamed("${RouteConfig.others}?id=${state.id}");
  }

  /// 前往私聊页面
  void goToPrivateChat() {
    Get.toNamed(
        "${RouteConfig.privateChat}?id=${state.othersInfo.userId}&name=${state.othersInfo.nickname}");
  }

  /// 前往投诉页面
  void goToComplaint() {
    Get.toNamed(RouteConfig.complaint);
  }
}
