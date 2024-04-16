import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/chat.dart';
import 'package:quanda/api/publish.dart';
import 'package:quanda/api/user.dart';
import 'package:quanda/model/LongList.dart';
import 'package:quanda/model/publish/ReleaseList.dart';
import 'package:quanda/page/chatPage/tencent_im/friend_logic.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_operation_result.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'state.dart';

/// 他人主页 的逻辑层
class OthersLogic extends GetxController {
  OthersState state = OthersState();

  /// 腾讯im 好友关系链
  final tFriend = Get.find<TFriendLogic>();

  @override
  void onInit() {
    super.onInit();
    state.id = int.parse(Get.parameters["id"]!);
  }

  @override
  void onReady() {
    super.onReady();

    /// 获取个人用户信息
    getInfo();

    /// 获取用户信息
    getUserInfo();

    /// 获取地址信息
    getAddress();
  }

  /// 获取发布列表
  Future<LongList> getList(int type, int page) {
    /// 等待请求完成
    Completer<LongList> completer = Completer();

    /// 发起请求
    PublishRequest.getReleaseList(
      userId: state.id,
      type: type,
      page: page,
      success: (data) {
        /// 重置列表状态关闭
        state.reload[type] = false;

        List res = data.records;

        List<ReleaseList> list = [];
        for (int i = 0; i < res.length; i++) {
          list.add(ReleaseList.fromJson(res[i]));
        }

        if (data.current == 1) {
          state.listMap[type] = list;
        } else {
          state.listMap[type]?.addAll(list);
        }

        /// 将数据返回
        completer.complete(data);
        update();
      },
      fail: (code, msg) {
        /// 重置列表状态关闭
        state.reload[type] = false;

        /// 将错误code输出
        completer.completeError(code);
      },
    );
    return completer.future;
  }

  /// 获取用户信息
  getUserInfo() async {
    /// 发起请求
    UserRequest.personHomePage(
      userId: state.id.toString(),
      success: (data) {
        state.userInfo = data;
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 点赞颜值
  appearanceSave(int status) async {
    /// 发起请求
    PublishRequest.appearanceSave(
      userId: state.id.toString(),
      status: status,
      success: (data) {
        /// 获取用户信息
        getUserInfo();
      },
      fail: (code, msg) {},
    );
  }

  /// 点赞发布
  giveRelease(int id, int type) {
    /// 发起请求
    PublishRequest.giveRelease(
      id: id,
      success: (data) {
        state.reload[type] = true;
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 拉黑用户
  /// [status] 0=拉黑 1=取消拉黑
  blackmailUsers() {
    /// 发起请求
    ChatRequest.blackUserAction(
      userId: state.userInfo.userId.toString(),
      status: 0,
      success: (data) {
        /// 腾讯im 将好友拉入黑名单
        addToBlackList();
      },
      fail: (code, msg) {},
    );
  }

  /// 腾讯im 将好友拉入黑名单
  addToBlackList() async {
    V2TimValueCallback<List<V2TimFriendOperationResult>> res =
        await tFriend.addToBlackList(state.userInfo.userId.toString());

    if (res.data?[0].resultCode == 0) {
      Get.back();
    }
  }

  /// 获取个人用户信息
  getInfo() async {
    var value = SpUtil.getUserInfo();
    if (value != null) {
      state.info = value;
      update();
    }
  }

  /// 获取地址信息
  getAddress() async {
    var value = await SpUtil.getAddress();
    if (value != null) {
      state.address = value;
      update();
    }
  }

  /// 前往私聊页面
  void goToPrivateChat() {
    Get.toNamed(
        "${RouteConfig.privateChat}?id=${state.userInfo.userId}&name=${state.userInfo.nickname}");
  }

  /// 前往加好友页面
  void goToNonFriends() {
    Get.toNamed(
        "${RouteConfig.nonFriends}?id=${state.userInfo.userId}&close=${true}");
  }

  /// 前往查看详情页
  void goToSeeDetails(String id) {
    bool value = true;

    /// 从主页进去的详情 实施详情页不给进入主页
    Get.toNamed("${RouteConfig.seeDetails}?close=$value&id=$id");
  }
}
