import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation_result.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';

import 'state.dart';

/// 腾讯im 会话列表 逻辑层
class ConversationLogic extends GetxController {
  TencentImState state = TencentImState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// 获取会话列表
  getConversationList() async {
    V2TimValueCallback<V2TimConversationResult> res = await state
        .timManager.v2ConversationManager
        .getConversationList(nextSeq: "0", count: 20);

    print("获取会话列表${res.toJson()}");
    if (res.code == 0) {
      state.conversationList = res.data?.conversationList ?? [];
      update();
    }
  }

  /// 会话列表有更新
  onConversationChanged(List<V2TimConversation> list) {
    for(int i = 0; i < list.length; i++) {
      int index = state.conversationList.indexWhere(
              (item) => item!.conversationID == list[i].conversationID);
      if (index > -1) {
        state.conversationList.setAll(index, [list[i]]);
        update();
      } else {
        state.conversationList.add(list[i]);
        update();
      }
    }
  }

  /// 有新对话
  onNewConversation(List<V2TimConversation> list) {
    state.conversationList.addAll(list);
    update();
  }

}
