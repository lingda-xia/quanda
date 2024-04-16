import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/chat.dart';
import 'package:quanda/page/chatPage/tencent_im/friend_logic.dart';
import 'state.dart';

/// 添加好友的逻辑层
class AddFriendsLogic extends GetxController {
  AddFriendsState state = AddFriendsState();

  /// 腾讯im 关系链
  final tFriend = Get.find<TFriendLogic>();

  @override
  void onInit() {
    super.onInit();
    state.id = Get.arguments;
  }

  @override
  void onClose() {
    super.onClose();
    state.textController.dispose();
  }

  /// 发送好友申请
  sendFriendApplication() async {

    // /// 发起 好友申请 请求
    // ChatRequest.friendApply(
    //   toUserId: state.id,
    //   source: "搜索",
    //   info: state.textContent,
    //   success: (_) async {
        /// 腾讯im 添加好友
        int? code = await tFriend.addFriend(
          userID: state.id,
          addWording: state.textContent,
        );
        if (code == 0 || code == 30539) {
          print("添加成功");
          Get.back();
        }
    //   },
    //   fail: (code, msg) {},
    // );
  }

  /// 监听搜索输入
  void onSearch(String msg) {
    print("输入框输入的内容=======>   $msg");
    state.textContent = msg;
    update();
  }
}
