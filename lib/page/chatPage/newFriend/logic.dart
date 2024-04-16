import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/page/chatPage/tencent_im/friend_logic.dart';
import 'package:quanda/router/router.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_application.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_application_result.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'state.dart';

/// 新的朋友的逻辑层
class NewFriendLogic extends GetxController {
  NewFriendState state = NewFriendState();

  /// 腾讯im 关系链
  final tFriend = Get.find<TFriendLogic>();

  @override
  void onInit() {
    super.onInit();
    /// 获取好友申请列表
    getFriendApplicationList();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// 获取好友申请列表
  getFriendApplicationList() async {
    /// 获取好友申请列表 腾讯im
    List<V2TimFriendApplication?>? list = await tFriend.getFriendApplicationList();
    state.list = list ?? [];
    update();
  }

  /// 前往加好友验证页面
  void goToFriendVerification(String id, int type) async {
    var data = await Get.toNamed("${RouteConfig.friendVerification}?id=$id&type=$type");
    if(data == "success") {
      /// 获取好友申请列表
      getFriendApplicationList();
    }
  }
}