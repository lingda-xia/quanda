import 'package:flutter/material.dart';
import 'package:quanda/model/chat/NoticeEntity.dart';
import 'package:tencent_im_sdk_plugin/manager/v2_tim_manager.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';

/// 聊天页面的状态
class ChatState {
  /// 会话列表
  /// [conversationID]  会话id
  /// [type]  类型  还不知道干啥的
  /// [userID]  用户id
  /// [showName]  名称
  /// [faceUrl]  头像
  /// [unreadCount]  未读信息数
  /// [lastMessage]  最后一条信息
  late List<V2TimConversation?> conversationList;

  /// 系统通知
  late NoticeEntity notice;

  ChatState() {

    conversationList = [];

    notice = NoticeEntity(0, "", null);
  }
}
