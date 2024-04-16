import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/chat.dart';
import 'package:quanda/utils/function/custom_toast.dart';
import 'package:quanda/utils/save/chat_msg.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimAdvancedMsgListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimConversationListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimFriendshipListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimSDKListener.dart';
import 'package:tencent_im_sdk_plugin/enum/log_level_enum.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_callback.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_application.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message_receipt.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_user_full_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'conversation_logic.dart';
import 'friend_logic.dart';
import 'msg_logic.dart';
import 'state.dart';

/// 腾讯im 的逻辑层
class TencentImLogic extends GetxController {
  TencentImState state = TencentImState();

  /// 腾讯im聊天 逻辑层
  final msgLogic = Get.find<MsgLogic>();

  /// 腾讯im 会话列表 逻辑层
  final conversationLogic = Get.find<ConversationLogic>();

  /// 腾讯im 关系链
  final friendLogic = Get.find<TFriendLogic>();

  /// 消息监听器
  late V2TimAdvancedMsgListener msgListener;

  /// 会话列表监听器
  late V2TimConversationListener cListener;

  /// 关系链监听器
  late V2TimFriendshipListener friendListener;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  void onClose() {
    super.onClose();

    /// 移除所有监听器
    removeAllListener();
  }

  /// 初始化
  init() async {
    await initSDK();

    /// 设置关系链监听器
    await friendshipListener();

    /// 设置会话监听器
    await conversationListener();

    /// 设置消息监听器
    await advancedMsgListener();

    /// 来自本地的初始化消息映射
    await initMessageMapFromLocal();
  }

  /// 初始化SDK
  initSDK() async {
    /// sdk监听器
    V2TimSDKListener initLisener = V2TimSDKListener(
      /// 连接失败
      onConnectFailed: (int code, String error) {
        print("连接失败$code,$error");
      },

      /// 未连接
      onConnecting: () {
        print("未连接");
      },

      /// 连接成功
      onConnectSuccess: () {
        print("连接成功");
      },

      /// 接通/断开线路
      onKickedOffline: () {
        print("接通/断开线路");
      },

      /// 自身信息更新
      onSelfInfoUpdated: (V2TimUserFullInfo info) {
        print("自身信息更新$info");
      },

      /// 用户Sig过期
      onUserSigExpired: () {
        print("用户Sig过期");
      },
    );

    /// 初始化SDK
    V2TimValueCallback<bool> res = await state.timManager.initSDK(
      // sdkAppID: 1400691317,
      sdkAppID: 1400727502,
      loglevel: LogLevelEnum.V2TIM_LOG_DEBUG,
      listener: initLisener,
    );

    print("初始化SDK返回的值${res.toJson()}");

    /// 初始化成功
    if (res.code == 0) {
      /// 腾讯im登录
      await timLogin();
      // getUsersInfo("8227792063087968256");
    }
  }

  /// 腾讯im登录
  Future timLogin() async {
    Completer completer = Completer();

    /// 获取聊天用户密钥
    var userSig = await SpUtil.obtainUserSig();

    /// 获取用户信息
    var userInfo = SpUtil.getUserInfo();

    if (userInfo == null) return;

    print("用户信息${userInfo.toJson()}");

    if (userSig == null) {
      /// 获取聊天用户密匙并登录
      await getUserSig(userInfo.userId.toString());
      completer.complete();
    } else {
      /// 腾讯im登录
      state.timManager
          .login(
        userID: userInfo.userId.toString(),
        userSig: userSig,
      )
          .then((value) async {
        print("腾讯im登录返回值${value.toJson()}");
        if (value.code == 0) {
        } else if (value.code == 6206 || value.code == 70013) {
          /// code == 6206  UserSig 过期，请重新获取有效的 UserSig 后再重新登录

          /// 重新获取
          await getUserSig(userInfo.userId.toString());
        } else {
          /// 显示提示框  自定义
          CustomToast.showToast(
              value.desc, const Color.fromRGBO(255, 77, 96, 1));
        }

        completer.complete();
      });
    }
    return completer.future;
  }

  /// 获取聊天用户密匙并登录
  Future getUserSig(String userID) async {
    Completer completer = Completer();

    /// 请求获取聊天用户密钥
    ChatRequest.getUserSig(success: (data) {
      /// 腾讯im登录
      state.timManager
          .login(
        userID: userID,
        userSig: data,
      )
          .then((value) async {
        print("腾讯im登录返回值${value.toJson()}");
        if (value.code == 0) {
        } else if (value.code == 6206 || value.code == 70013) {
          /// code == 6206  UserSig 过期，请重新获取有效的 UserSig 后再重新登录

          /// 重新获取
          await getUserSig(userID);
        } else {
          /// 显示提示框  自定义
          CustomToast.showToast(
              value.desc, const Color.fromRGBO(255, 77, 96, 1));
        }

        completer.complete();
      });
    });

    return completer.future;
  }

  /// 来自本地的初始化消息映射
  initMessageMapFromLocal() async {
    /// 获取本地id列表
    final List<String>? localMsgIDList = await ChatMag.getIDList();

    // int index = -1;

    if (localMsgIDList != null) {
      for (String userID in localMsgIDList) {
        // index++;
        /// 获取消息列表
        final List<String>? localMsgJson = await ChatMag.getMsgList(userID);
        if (localMsgJson != null) {
          List<V2TimMessage> localMsg = localMsgJson
              .map((item) => V2TimMessage.fromJson(jsonDecode(item)))
              .toList();

          /// 将对应的userID的消息列表放入集合之中
          state.messageListMap[userID] = localMsg;
          // if (index < 10) {
          //   Future.delayed(Duration.zero)
          //       .then((value) => _preLoadImage(msgList));
          // }
        } else {
          // state.messageListMap[userID] = [];
          print("该用户的消息列表为空");
        }
        update();
      }
    } else {
      print("本地id列表暂无数据");
    }
  }

  /// 修改个人信息
  Future setSelfInfo(
      {required String userID,
      required String name,
      required String? faceUrl, int? gender}) async {
    Completer completer = Completer();

    V2TimCallback res = await state.timManager.setSelfInfo(
      userFullInfo: V2TimUserFullInfo.fromJson({
        "userID": userID,

        /// 名称
        "nickName": name,

        /// 头像
        "faceUrl": faceUrl,

        "allowType": 1,

        /// 性别
        "gender": gender,
      }),
    );

    print("腾讯im修改个人信息${res.toJson()}");

    if (res.code == 0) {
      completer.complete();
    } else {
      /// 显示提示框  自定义
      CustomToast.showToast(res.desc, const Color.fromRGBO(255, 77, 96, 1));
      completer.complete();
    }
    return completer.future;
  }

  /// 设置未读信息总数
  setUnreadMsgSum(int num) {
    state.unreadMsgSum = num;
    update();
  }

  /// 获取用户信息
  getUsersInfo(String userID) async {
    V2TimValueCallback<List<V2TimUserFullInfo>> res =
        await state.timManager.getUsersInfo(
      /// 用户id
      userIDList: [userID],
    );

    print("腾讯im获取用户信息${res.toJson()}");
  }

  /// 设置会话监听器
  conversationListener() async {
    cListener = V2TimConversationListener(

        /// 对话已更改
        onConversationChanged: (List<V2TimConversation> list) {
      /// 会话列表有更新
      conversationLogic.onConversationChanged(list);
      print("对话有更新${list[0].toJson()}");
    },

        /// 有新对话
        onNewConversation: (List<V2TimConversation> list) {
      /// 会话列表有更新
      conversationLogic.onConversationChanged(list);
      print("有新对话${list[0].toJson()}");
    },

        /// 在同步服务器上失败
        onSyncServerFailed: () {
      print("在同步服务器上失败");
    },

        /// 同步服务器完成
        onSyncServerFinish: () {
      print("同步服务器完成");
    },

        /// 同步服务器启动
        onSyncServerStart: () {
      print("同步服务器启动");
    },

        /// 未读消息总数已更改
        onTotalUnreadMessageCountChanged: (int num) {
      /// 设置未读信息总数
      setUnreadMsgSum(num);
      print("未读消息总数已更新$num");
    });

    /// 添加监听器
    await state.timManager.v2ConversationManager
        .setConversationListener(listener: cListener);
  }

  /// 设置关系链监听器
  friendshipListener() async {
    friendListener = V2TimFriendshipListener(

        /// 在朋友申请列表中添加
        onFriendApplicationListAdded:
            (List<V2TimFriendApplication> friendApplicationList) {
      print("在朋友申请列表中添加${friendApplicationList[0].toJson()}");
    },

        /// 在朋友申请列表中删除
        onFriendApplicationListDeleted: (List<String> userIDList) {
      print("在朋友申请列表中删除${userIDList[0]}");
    },

        /// 在朋友申请列表中读取
        onFriendApplicationListRead: () {
      print("在朋友申请列表中读取");
    },

        /// 好友信息已更改
        onFriendInfoChanged: (List<V2TimFriendInfo> infoList) {
      print("好友信息已更改${infoList[0].toJson()}");
    },

        /// 已添加好友列表
        onFriendListAdded: (List<V2TimFriendInfo> users) {
      print("已添加好友列表${users[0].toJson()}");
    },

        /// 好友已删除
        onFriendListDeleted: (List<String> userList) {
      print("好友已删除${userList[0]}");
    },

        /// 在黑名单上添加
        onBlackListAdd: (List<V2TimFriendInfo> infoList) {
      print("在黑名单上添加${infoList[0].toJson()}");
    },

        /// 在黑名单上删除
        onBlackListDeleted: (List<String> userList) {
      print("在黑名单上删除${userList[0]}");
    });

    /// 添加监听器
    await state.timManager.v2TIMFriendshipManager
        .setFriendListener(listener: friendListener);
  }

  /// 设置消息监听器
  advancedMsgListener() async {
    msgListener = V2TimAdvancedMsgListener(
      /// 接收C2C读取回执
      onRecvC2CReadReceipt: (List<V2TimMessageReceipt> receiptList) {
        print("接收C2C读取回执${receiptList[0].toJson()}");

        // _onRecvC2CReadReceipt(List<V2TimMessageReceipt> receiptList) {
        //   for (var receipt in receiptList) {
        //     final convID = receipt.userID;
        //     final isNotEmpty = _messageListMap[convID]?.isNotEmpty;
        //     if (isNotEmpty != null && isNotEmpty) {
        //       _messageListMap[convID] = _messageListMap[convID]!.map((element) {
        //         final isSelf = element.isSelf ?? false;
        //         final isPeerRead = element.isPeerRead ?? false;
        //         if (isSelf && !isPeerRead) {
        //           element.isPeerRead = true;
        //         }
        //         return element;
        //       }).toList();
        //     }
        //   }
        //   notifyListeners();
        // }
      },

      /// 修改接收消息时
      onRecvMessageModified: (V2TimMessage msg) {
        print("修改接收消息时${msg.toJson()}");
        // _onMessageModified(V2TimMessage modifiedMessage, [String? convID]) async {
        //   final activeMessageList = _messageListMap[convID ?? _currentSelectedConv];
        //   final V2TimMessage newMsg =
        //       await _lifeCycle?.modifiedMessageWillMount(modifiedMessage) ??
        //           modifiedMessage;
        //   final msgID = newMsg.msgID;
        //   _messageListMap[_currentSelectedConv] = activeMessageList!.map((item) {
        //     if (item.msgID == msgID) {
        //       return newMsg;
        //     }
        //     return item;
        //   }).toList();
        // }
      },

      /// 接收消息时读取回执
      onRecvMessageReadReceipts: (List<V2TimMessageReceipt> receiptList) {
        print("接收消息时读取回执${receiptList[0].toJson()}");

        // _onRecvMessageReadReceipts(List<V2TimMessageReceipt> receiptList) {
        //   for (var receipt in receiptList) {
        //     final msgID = receipt.msgID;
        //     if (msgID != null) {
        //       _messageReadReceiptMap[msgID] = receipt;
        //     }
        //   }
        // }
      },

      /// 接收消息已撤销
      onRecvMessageRevoked: (String msgID) {
        print("接收消息已撤销$msgID");
      },

      /// 接收新消息时
      onRecvNewMessage: (V2TimMessage msg) {
        print("接收新消息时${msg.toJson()}");

        /// 监听到新消息时
        msgLogic.onReceiveNewMsg(msg);
      },

      /// 发送消息时的进度
      onSendMessageProgress: (V2TimMessage message, int progress) {
        print("发送消息时的进度${message.toJson()}---$progress");
      },
    );

    /// 添加监听器
    await state.timManager.v2TIMMessageManager
        .addAdvancedMsgListener(listener: msgListener);
  }

  /// 移除所有监听器
  removeAllListener() async {
    /// 移除信息监听器
    await state.timManager.v2TIMMessageManager.removeAdvancedMsgListener(
      listener: msgListener,
    );

    /// 移除关系链监听器
    await state.timManager.v2TIMFriendshipManager.removeFriendListener(
      listener: friendListener,
    );

    /// 移除会话列表监听器
    await state.timManager.v2ConversationManager.removeConversationListener(
      listener: cListener,
    );
  }
}
