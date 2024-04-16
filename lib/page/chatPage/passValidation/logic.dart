import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/chat.dart';
import 'package:quanda/page/chatPage/tencent_im/friend_logic.dart';
import 'package:quanda/router/router.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_callback.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_operation_result.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'state.dart';

/// 通过验证的逻辑层
class PassValidationLogic extends GetxController {
  PassValidationState state = PassValidationState();

  /// 腾讯im 关系链
  final tFriend = Get.find<TFriendLogic>();

  @override
  void onInit() {
    super.onInit();
    state.id = Get.parameters["id"]!;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();

    state.textController.dispose();
  }

  /// 同意验证好友
  agreeFriend() async {
    /// 发起请求
    ChatRequest.agreeFriend(
      toUserId: state.id,
      remarkName: state.textContent,
      success: (data) async {
        /// 腾讯im请求同意好友
        V2TimValueCallback<V2TimFriendOperationResult> res = await
            tFriend.acceptFriendApplication(state.id);

        if (res.code == 0 && state.textContent.isNotEmpty) {
          /// 设置好友资料  修改备注
          V2TimCallback res =
              await tFriend.setFriendInfo(state.id, state.textContent);
        }

        print("同意好友${res.toJson()}");
        // Get.back(result: "success");
        /// 回到首页
        Future.delayed(const Duration(milliseconds: 1000), () {
          Get.offAllNamed(RouteConfig.main);
        });
      },
      fail: (code, msg) {},
    );
  }

  /// 监听搜索输入
  void onSearch(String msg) {
    print("输入框输入的内容=======>   $msg");
    state.textContent = msg;
    update();
  }

  /// 前往选择标签页面
  void goToSelectLabel() async {
    var data = await Get.toNamed(RouteConfig.selectLabel);
    if(data != null) {
      state.label = data.name;
      state.tagId = data.id.toString();
      update();
    }
  }
}
