import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/function/custom_toast.dart';
import 'package:tencent_im_sdk_plugin/enum/friend_application_type_enum.dart';
import 'package:tencent_im_sdk_plugin/enum/friend_response_type_enum.dart';
import 'package:tencent_im_sdk_plugin/enum/friend_type_enum.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_callback.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_application.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_application_result.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_operation_result.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'state.dart';

/// 腾讯im 关系链 的逻辑层
class TFriendLogic extends GetxController {
  TencentImState state = TencentImState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// 获取好友列表
  getFriendsList() async {
    V2TimValueCallback<List<V2TimFriendInfo>> res =
        await state.timManager.v2TIMFriendshipManager.getFriendList();

    print("腾讯im获取好友列表${res.toJson()}");
  }

  /// 获取好友申请列表
  Future<List<V2TimFriendApplication?>?> getFriendApplicationList() async {
    V2TimValueCallback<V2TimFriendApplicationResult> res = await state
        .timManager.v2TIMFriendshipManager
        .getFriendApplicationList();

    print("获取好友申请列表${res.toJson()}");
    if (res.code == 0) {
      return res.data?.friendApplicationList;
    } else {
      /// 显示提示框  自定义
      CustomToast.showToast("好友添加失败", const Color.fromRGBO(255, 77, 96, 1));
    }

    return null;
  }

  /// 添加好友
  Future<int?> addFriend({
    required String userID,
    required String addWording,
    String? remark,
  }) async {

    V2TimValueCallback<V2TimFriendOperationResult> res =
        await state.timManager.v2TIMFriendshipManager.addFriend(
      /// 好友id
      userID: userID,

      /// 单向好友  还是 双向好友
      addType: FriendTypeEnum.V2TIM_FRIEND_TYPE_BOTH,

      /// 备注
      remark: remark,

      /// 好友组
      friendGroup: "",

      /// 添加简述
      addWording: addWording,

      /// 添加来源
      addSource: "搜索",
    );
    print("添加好友${res.toJson()}");

    if (res.code != 0) {
      /// 显示提示框  自定义
      CustomToast.showToast("好友添加失败", const Color.fromRGBO(255, 77, 96, 1));
    }

    return res.data?.resultCode;
  }

  /// 删除好友
  deleteFromFriendList(String id) async {
    V2TimValueCallback<List<V2TimFriendOperationResult>> res =
        await state.timManager.v2TIMFriendshipManager.deleteFromFriendList(
      /// 删除的好友列表 List<String>
      userIDList: [id],

      /// 删除的类型
      deleteType: FriendTypeEnum.V2TIM_FRIEND_TYPE_BOTH,
    );

    if (res.code != 0) {
      /// 显示提示框  自定义
      CustomToast.showToast(res.desc, const Color.fromRGBO(255, 77, 96, 1));
    }

    print("删除好友${res.toJson()}");
  }

  /// 同意好友申请
  Future<V2TimValueCallback<V2TimFriendOperationResult>>
      acceptFriendApplication(String id) async {
    /// 腾讯im请求同意好友
    V2TimValueCallback<V2TimFriendOperationResult> res =
        await state.timManager.v2TIMFriendshipManager.acceptFriendApplication(
      /// 用户id
      userID: id,

      /// 同意并添加为双向好友
      responseType: FriendResponseTypeEnum.V2TIM_FRIEND_ACCEPT_AGREE_AND_ADD,

      /// 别人发给我的加好友请求
      type: FriendApplicationTypeEnum.V2TIM_FRIEND_APPLICATION_COME_IN,
    );
    print("同意好友申请${res.toJson()}");

    if (res.code != 0) {
      /// 显示提示框  自定义
      CustomToast.showToast(res.desc, const Color.fromRGBO(255, 77, 96, 1));
    }

    return res;
  }

  /// 设置指定好友资料
  Future<V2TimCallback> setFriendInfo(String id, String friendRemark) async {
    /// 腾讯im 设置指定好友资料
    V2TimCallback res =
        await state.timManager.v2TIMFriendshipManager.setFriendInfo(
      /// 用户id
      userID: id,

      /// 修改的好友备注
      friendRemark: friendRemark,
    );
    print("设置指定好友资料${res.toJson()}");

    if (res.code != 0) {
      /// 显示提示框  自定义
      CustomToast.showToast(res.desc, const Color.fromRGBO(255, 77, 96, 1));
    }

    return res;
  }

  /// 将好友拉入黑名单
  Future<V2TimValueCallback<List<V2TimFriendOperationResult>>> addToBlackList(
      String id) async {
    /// 腾讯im 将好友拉入黑名单
    V2TimValueCallback<List<V2TimFriendOperationResult>> res =
        await state.timManager.v2TIMFriendshipManager.addToBlackList(
      /// 需要加入黑名单的好友id列表
      userIDList: [id],
    );

    print("将好友拉入黑名单${res.toJson()}");

    if (res.code != 0) {
      /// 显示提示框  自定义
      CustomToast.showToast(res.desc, const Color.fromRGBO(255, 77, 96, 1));
    }

    return res;
  }

  /// 把用户从黑名单中删除
  Future<V2TimValueCallback<List<V2TimFriendOperationResult>>>
      deleteFromBlackList(String id) async {
    /// 腾讯im 把用户从黑名单中删除
    V2TimValueCallback<List<V2TimFriendOperationResult>> res =
        await state.timManager.v2TIMFriendshipManager.deleteFromBlackList(
      /// 需要删除黑名单的好友id列表
      userIDList: [id],
    );

    print("把用户从黑名单中删除${res.toJson()}");

    if (res.code != 0) {
      /// 显示提示框  自定义
      CustomToast.showToast(res.desc, const Color.fromRGBO(255, 77, 96, 1));
    }

    return res;
  }

  /// 腾讯im 获取黑名单列表
  getBlackList() async {
    /// 腾讯im 获取黑名单列表
    V2TimValueCallback<List<V2TimFriendInfo>> res =
        await state.timManager.v2TIMFriendshipManager.getBlackList();

    print("获取黑名单列表${res.toJson()}");
  }
}
