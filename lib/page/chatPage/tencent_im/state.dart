import 'package:flutter/material.dart';
import 'package:tencent_im_sdk_plugin/manager/v2_tim_manager.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';

///  腾讯im 的数据层
class TencentImState {

  /// 腾讯即时通讯即时消息管理器
  late V2TIMManager timManager;

  /// 消息列表Map
  late Map<String, List<V2TimMessage>?> messageListMap;

  /// 当前进入的聊天的id
  late String selectConvID;

  /// 未读信息总数
  late int unreadMsgSum;

  /// 会话列表
  /// [conversationID]  会话id
  /// [type]  类型  还不知道干啥的
  /// [userID]  用户id
  /// [showName]  名称
  /// [faceUrl]  头像
  /// [unreadCount]  未读信息数
  /// [lastMessage]  最后一条信息
  late List<V2TimConversation?> conversationList;

  TencentImState() {
    timManager = TencentImSDKPlugin.v2TIMManager;
    conversationList = [];
    messageListMap = {};
    selectConvID = "";
    unreadMsgSum = 0;
  }

}


