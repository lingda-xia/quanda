import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/chat.dart';
import 'package:quanda/model/chat/FriendList.dart';
import 'package:quanda/page/chatPage/tencent_im/friend_logic.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_operation_result.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'state.dart';

/// 黑名单的逻辑层
class BlacklistLogic extends GetxController {
  BlacklistState state = BlacklistState();

  /// 腾讯im 好友关系链
  final tFriend = Get.find<TFriendLogic>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    /// 黑名单列表
    blackList();
  }

  /// 黑名单列表
  blackList() {
    /// 发起请求
    ChatRequest.friendList(
      type: 2,
      success: (data) {
        state.list = data;
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 取消拉黑
  blackUserAction(FriendList item) {
    /// 发起请求
    ChatRequest.blackUserAction(
      userId: item.toUserId.toString(),
      status: 1,
      success: (data) {
        /// 腾讯im 把用户从黑名单中删除
        deleteFromBlackList(item);
      },
      fail: (code, msg) {},
    );
  }

  /// 腾讯im 把用户从黑名单中删除
  deleteFromBlackList(FriendList item) async {
    /// 腾讯im 把用户从黑名单中删除
    V2TimValueCallback<List<V2TimFriendOperationResult>> res =
        await tFriend.deleteFromBlackList(item.toUserId.toString());

    if (res.data?[0].resultCode == 0) {
      /// 腾讯im 添加好友
      // addFriend(item);

      /// 黑名单列表
      blackList();
    }
  }

  /// 腾讯im 添加好友
  addFriend(FriendList item) async {
    /// 腾讯im 添加好友
    int? res = await tFriend.addFriend(
      userID: item.toUserId.toString(),
      addWording: item.toDesc ?? "",
      remark: item.remarkName,
    );
  }
}
