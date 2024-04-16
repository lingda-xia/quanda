import 'dart:convert';

import 'package:quanda/api/chat.dart';
import 'package:quanda/page/chatPage/tencent_im/logic.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';
import 'package:get/get.dart';

/// 聊天 逻辑层
class ChatLogic extends GetxController {
  final ChatState state = ChatState();

  /// 腾讯im
  final tim = Get.find<TencentImLogic>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    /// 获取会话列表
    getConversationList();
    /// 获取系统通知
    getSystemMsgInfo();
  }

  /// 时间转换
  String timeChange(int value) {
    /// 时间戳转时间
    final time = DateTime.fromMillisecondsSinceEpoch(value * 1000);
    return "${time.hour}:${time.minute}";
  }

  /// 获取系统通知
  getSystemMsgInfo() {
    /// 发起请求
    ChatRequest.systemMsgInfo(
      success: (data) {
        state.notice = data;
        update();
      },
      fail: (code, msg) {

      },
    );
  }

  /// 获取会话列表
  getConversationList() async {
    /// 获取会话列表 腾讯im
    await tim.conversationLogic.getConversationList();
  }

  /// 前往通讯录页面
  void goToMailList() {
    Get.toNamed(RouteConfig.mailList);
  }

  /// 前往临时会话页面
  void goToTemporarySession() {
    Get.toNamed(RouteConfig.temporarySession);
  }

  /// 前往私聊页面
  void goToPrivateChat(String id, String name) {
    Get.toNamed("${RouteConfig.privateChat}?id=$id&name=$name");
  }

  /// 前往系统通知页面
  void goToSystemNotice() {
    Get.toNamed(RouteConfig.systemNotice);
  }
}
