import 'package:get/get.dart';
import 'package:quanda/utils/function/custom_toast.dart';
import 'package:quanda/utils/save/chat_msg.dart';
import 'package:tencent_im_sdk_plugin/enum/history_msg_get_type_enum.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_callback.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_msg_create_info_result.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'state.dart';
import 'package:flutter/material.dart';

/// 腾讯im 聊天 逻辑层
class MsgLogic extends GetxController {
  TencentImState state = TencentImState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// 设置进入的聊天的id
  setSelectConvID(String id) {
    state.selectConvID = id;
  }

  /// 监听到新消息时
  onReceiveNewMsg(V2TimMessage msg) async {
    /// 用户id
    final convID = msg.userID ?? msg.groupID;
    if (convID == state.selectConvID && convID != null) {
      /// 将消息标记为已读
      markC2CMessageAsRead(convID);
    }
    if (convID != null) {
      state.messageListMap[convID]?.add(msg);

      /// 将消息保存到本地
      storeMsgToLocal(state.messageListMap[convID], convID);
      update();
    }
  }

  /// 更新消息列表Map
  upDateMessageListMap(List<V2TimMessage> list, String userID) {
    state.messageListMap[userID] = list;
    update();
  }

  /// 发生文本信息
  /// [text] 文本消息
  /// [userID] 用户id
  Future sendTextMessage(String text, String userID) async {
    /// 创建文本信息
    V2TimValueCallback<V2TimMsgCreateInfoResult> createMessage = await state
        .timManager.v2TIMMessageManager
        .createTextMessage(text: text);

    print("自定义发送文本信息返回值${createMessage.toJson()}");

    if (createMessage.code == 0) {
      String id = createMessage.data!.id!;

      /// 发送信息
      V2TimValueCallback<V2TimMessage> res =
          await state.timManager.v2TIMMessageManager.sendMessage(
        /// 消息唯一标识
        id: id,

        /// 消息接收者的 userID, 如果是发送 C2C 单聊消息，只需要指定 receiver 即可。
        receiver: userID,

        /// 目标群组 ID，如果是发送群聊消息，只需要指定 groupID 即可。
        groupID: "",

        /// 消息优先级，仅针对群聊消息有效。请把重要消息设置为高优先级（比如红包、礼物消息），
        /// 高频且不重要的消息设置为低优先级（比如点赞消息）。
        // priority: ,
        /// 是否只有在线用户才能收到，如果设置为 true ，接收方历史消息拉取不到，
        /// 常被用于实现“对方正在输入”或群组里的非重要提示等弱提示功能，该字段不支持 AVChatRoom。
        onlineUserOnly: false,

        /// 是否排除未读计数  默认false
        isExcludedFromUnreadCount: false,

        /// offlinePushInfo	离线推送时携带的标题和内容。
        // offlinePushInfo: ,
        /// 消息是否需要已读回执（只有 Group 消息有效，6.1 及以上版本支持，需要您购买旗舰版套餐）
        // needReadReceipt: false,
        /// 云自定义消息字段，只能在消息发送前添加
        // cloudCustomData: "",
        /// 本地自定义数据
        localCustomData: "自定义本地自定义数据",
        // needReadReceipt: true,
      );

      if (res.code == 0) {
        /// 发送的消息
        V2TimMessage msg = res.data ?? V2TimMessage(elemType: 11);

        final currentTempMsg = state.messageListMap[userID] ?? [];

        /// 将新发送的消息添加进数组中
        state.messageListMap[userID] = [msg, ...currentTempMsg];

        /// 将消息保存到本地
        storeMsgToLocal(state.messageListMap[userID], userID);
        update();

        return msg;
      } else {
        /// 显示提示框  自定义
        CustomToast.showToast(res.desc, const Color.fromRGBO(255, 77, 96, 1));
      }
      print("发送信息${res.toJson()}");
    }

    return null;
  }

  /// 发生图片信息
  /// [path] 本地图片绝对路径
  /// [userID] 用户id
  Future sendImageMessage(String path, String userID) async {
    /// 创建文本信息
    V2TimValueCallback<V2TimMsgCreateInfoResult> createMessage =
        await state.timManager.v2TIMMessageManager.createImageMessage(
      imagePath: path, // 本地图片绝对路径,不能使用网络Url
    );

    print("自定义发送图片信息返回值${createMessage.toJson()}");

    if (createMessage.code == 0) {
      String id = createMessage.data!.id!;

      /// 发送信息
      V2TimValueCallback<V2TimMessage> res =
          await state.timManager.v2TIMMessageManager.sendMessage(
        /// 消息唯一标识
        id: id,

        /// 消息接收者的 userID, 如果是发送 C2C 单聊消息，只需要指定 receiver 即可。
        receiver: userID,

        /// 目标群组 ID，如果是发送群聊消息，只需要指定 groupID 即可。
        groupID: "",

        /// 消息优先级，仅针对群聊消息有效。请把重要消息设置为高优先级（比如红包、礼物消息），
        /// 高频且不重要的消息设置为低优先级（比如点赞消息）。
        // priority: ,
        /// 是否只有在线用户才能收到，如果设置为 true ，接收方历史消息拉取不到，
        /// 常被用于实现“对方正在输入”或群组里的非重要提示等弱提示功能，该字段不支持 AVChatRoom。
        onlineUserOnly: false,

        /// 是否排除未读计数  默认false
        isExcludedFromUnreadCount: false,

        /// offlinePushInfo	离线推送时携带的标题和内容。
        // offlinePushInfo: ,
        /// 消息是否需要已读回执（只有 Group 消息有效，6.1 及以上版本支持，需要您购买旗舰版套餐）
        // needReadReceipt: false,
        /// 云自定义消息字段，只能在消息发送前添加
        // cloudCustomData: "",
        /// 本地自定义数据
        localCustomData: "自定义本地自定义数据",
        // needReadReceipt: true,
      );

      if (res.code == 0) {
        /// 发送的消息
        V2TimMessage msg = res.data ?? V2TimMessage(elemType: 11);

        final currentTempMsg = state.messageListMap[userID] ?? [];

        /// 将新发送的消息添加进数组中
        state.messageListMap[userID] = [msg, ...currentTempMsg];

        /// 将消息保存到本地
        storeMsgToLocal(state.messageListMap[userID], userID);
        update();

        return msg;
      } else {
        /// 显示提示框  自定义
        CustomToast.showToast(res.desc, const Color.fromRGBO(255, 77, 96, 1));
      }
      print("发送信息${res.toJson()}");
    }

    return null;
  }

  /// 获取单聊（C2C）历史消息
  getC2CHistoryMessageList(String id) async {
    V2TimValueCallback<List<V2TimMessage>> res =
        await state.timManager.v2TIMMessageManager.getC2CHistoryMessageList(
      /// 用户id
      userID: id,

      /// 拉取消息的个数，不宜太多，会影响消息拉取的速度，这里建议一次拉取 20 个
      count: 20,

      /// 获取消息的起始消息，如果传 null，起始消息为会话的最新消息
      lastMsgID: null,
    );

    print("获取单聊（C2C）历史消息${res.toJson()}");
  }

  /// 获取高级历史信息
  getHistoryMessageList(
      {HistoryMsgGetTypeEnum getType =
          HistoryMsgGetTypeEnum.V2TIM_GET_CLOUD_OLDER_MSG,
      String? userID,
      String? groupID,
      int lastMsgSeq = -1,
      required int count,
      String? lastMsgID}) async {
    /// 是否还有更多的数据
    late bool haveMoreData = true;

    /// 单聊或者群聊
    final convID = userID ?? groupID;

    /// 获取本地的缓存消息
    final currentHistoryMsgList = state.messageListMap[convID];

    /// 历史消息记录是否为空
    final bool ifEmptyHistory =
        (currentHistoryMsgList == null || currentHistoryMsgList.isEmpty);

    /// 获取高级历史信息
    V2TimValueCallback<List<V2TimMessage>> res =
        await state.timManager.v2TIMMessageManager.getHistoryMessageList(
      count: count,
      getType: getType,
      userID: userID,
      groupID: groupID,
      lastMsgID: lastMsgID,
      lastMsgSeq: lastMsgSeq,
    );

    /// 最后的消息id不为空  历史消息不为空
    if (lastMsgID != null && currentHistoryMsgList != null) {
      final list = res.data;

      /// 拼接拉取更多历史
      final newList = [...currentHistoryMsgList, ...?list];
      state.messageListMap[convID!] = newList;
      update();
    } else {
      /// 首屏默认数据
      final List<V2TimMessage> msgList = res.data ?? [];
      state.messageListMap[convID!] = msgList;

      /// 保存消息到本地
      storeMsgToLocal(msgList, convID, ifEmptyHistory);
      update();
    }
    print("获取高级历史信息${res.toJson()}");
    print("获取高级历史信息${res.data?.length}");

    if (res.data != null) {
      if (res.data!.isEmpty || res.data!.length < 20) {
        /// 是否还有更多的数据
        haveMoreData = false;
      }
    } else {
      /// 是否还有更多的数据
      haveMoreData = false;
    }

    return haveMoreData;
  }

  /// 将消息存储到本地
  void storeMsgToLocal(List<V2TimMessage>? msgList, String convID,
      [bool? addToIDList]) async {
    /// 是否添加到列表
    if (addToIDList == true) {
      /// 保存id列表
      await ChatMag.saveIDList(convID);
    }
    await ChatMag.saveMsgList(msgList, convID);
  }

  /// 设置单聊（C2C）消息已读
  Future markC2CMessageAsRead(String userID) async {
    V2TimCallback res =
        await state.timManager.v2TIMMessageManager.markC2CMessageAsRead(
      userID: userID,
    );

    print("设置单聊（C2C）消息已读${res.toJson()}");
  }
}
