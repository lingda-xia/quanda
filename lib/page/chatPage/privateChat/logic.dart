import 'dart:convert';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quanda/api/chat.dart';
import 'package:quanda/api/imageUpload.dart';
import 'package:quanda/page/chatPage/tencent_im/msg_logic.dart';
import 'package:quanda/utils/function/custom_toast.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';

import 'state.dart';
import 'package:get/get.dart';

class PrivateChatLogic extends GetxController {
  final PrivateChatState state = PrivateChatState();

  /// 腾讯im 聊天 逻辑层
  final msgLogic = Get.find<MsgLogic>();

  @override
  void onInit() {
    super.onInit();

    state.id = Get.parameters["id"]!;

    state.name = Get.parameters["name"]!;

    /// 设置进入的聊天的id
    msgLogic.setSelectConvID(Get.parameters["id"] ?? "");

    /// 设置单聊（C2C）消息已读
    markC2CMessageAsRead();

    update();
  }

  @override
  void onReady() {
    super.onReady();
    getHistoryMessageList();
  }

  @override
  void onClose() {
    super.onClose();

    /// 清空进入的聊天的id
    msgLogic.setSelectConvID("");
    state.listController.dispose();
    state.controller.dispose();
  }

  /// 页面滚动
  jumpTo(double value) {
    /// 滑动到底部
    state.listController.jumpTo(value);
  }

  /// 下拉加载聊天数据
  onLoad() async {
    /// 当前的聊天列表
    final List<V2TimMessage> list =
        msgLogic.state.messageListMap[state.id] ?? [];

    /// 加载数据
    bool value = await msgLogic.getHistoryMessageList(
      count: 20,
      userID: state.id,

      /// 最后一条信息的id
      lastMsgID: list.isNotEmpty ? list[list.length - 1].msgID : "",
    );

    if (value) {
      state.controller.finishLoad(IndicatorResult.success);
    } else {
      /// 没有更多数据了
      state.controller.finishLoad(IndicatorResult.noMore);
    }
  }

  /// 获取高级历史信息
  getHistoryMessageList() async {
    /// 获取高级历史信息 腾讯im
    await msgLogic.getHistoryMessageList(
      count: 20,
      userID: state.id,
    );
  }

  /// 设置单聊（C2C）消息已读
  markC2CMessageAsRead() async {
    /// 设置单聊（C2C）消息已读  腾讯im
    msgLogic.markC2CMessageAsRead(state.id);
  }

  /// 发生文本信息
  sendTextMessage() async {
    if (state.textContent.isEmpty) {
      /// 显示提示框  自定义
      CustomToast.showToast("发送的消息不能为空", const Color.fromRGBO(255, 77, 96, 1));
      return;
    }

    /// 发送文本消息 腾讯im
    V2TimMessage? value = await msgLogic.sendTextMessage(
      state.textContent,
      state.id,
    );

    /// 重新改造需要保存的值
    Map<String, dynamic> map = {
      ...?value?.toJson(),
      "seifFlag": value?.isSelf == false ? 0 : 1,
      "userId": value?.userID,
    };

    /// 发起请求 保存聊天记录
    ChatRequest.chatSave(
      data: map,
      success: (data) {},
      fail: (code, msg) {},
    );

    if (value != null) {
      /// 清空文本输入
      state.textController.text = "";
      state.textContent = "";
    }
  }

  /// 发生图片信息
  sendImageMessage() async {
    try {
      /// 多图片选择器
      final List<XFile>? pickedFileList = await state.picker.pickMultiImage();
      print("这是选择图片的返回${pickedFileList![0].path}");

      /// 发送图片消息 腾讯im
      V2TimMessage? value = await msgLogic.sendImageMessage(
        pickedFileList[0].path,
        state.id,
      );

      /// 上传图片接口
      ImageUpload.upload(pickedFileList, loading: false, success: (data) {
        print("这是发送后返回的图片消息${value?.toJson()}");

        /// 替换图片的地址
        value?.imageElem?.imageList![0]!.url = data[0].filePath;

        /// 重新改造需要保存的值
        Map<String, dynamic> map = {
          ...?value?.toJson(),
          "seifFlag": value?.isSelf == false ? 0 : 1,
          "userId": value?.userID,
        };

        /// 发起请求 保存聊天记录
        ChatRequest.chatSave(
          data: map,
          success: (data) {},
          fail: (code, msg) {},
        );
      });
    } catch (e) {
      print("多图片选择器出现了错误$e");
    }
  }

  /// 信息输入
  void onInput(String msg) {
    print("输入框输入的内容=======>   $msg");
    state.textContent = msg;
    update();
  }
}
