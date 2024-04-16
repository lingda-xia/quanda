import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/receiving.dart';
import 'package:quanda/api/user.dart';
import 'package:quanda/model/location/Address.dart';
import 'package:quanda/page/chatPage/tencent_im/logic.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'state.dart';

/// 个人资料的逻辑层
class PersonalDataLogic extends GetxController {
  PersonalDataState state = PersonalDataState();

  /// 腾讯im
  final tim = Get.find<TencentImLogic>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    /// 获取个人资料信息
    personDateInfo();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// 获取个人资料信息
  personDateInfo() {
    /// 发起请求
    UserRequest.personDateInfo(
      success: (data) {
        state.info = data;

        /// 名称
        state.nController.text = data.nickname;

        /// 简介
        state.jController.text = data.introduction;

        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 用户信息保存
  Future userInfoSave() async {
    Completer completer = Completer();

    /// 获取地址信息
    Address address = await SpUtil.getAddress();

    /// 发起请求
    UserRequest.userInfoSave(
      nickname: state.info.nickname,
      sex: state.info.sex,
      birthday: state.info.birthday,
      address: "${address.province},${address.city},${address.district}",
      avatarUrl: state.info.avatarUrl,
      introduction: state.info.introduction,
      loading: false,
      save: false,
      success: (data) async {
        /// 腾讯im 修改个人信息
        await setSelfInfo();
        completer.complete();
      },
      fail: (code, msg) {
        completer.complete();
      },
    );

    return completer.future;
  }

  /// 腾讯im 修改个人信息
  setSelfInfo() async {
    await tim.setSelfInfo(
      userID: state.info.userId.toString(),
      name: state.info.nickname,
      faceUrl: state.info.avatarUrl,
    );
  }

  /// 获取收货地址信息
  userDeliveryById(int id) {
    /// 发起请求
    ReceivingRequest.userDeliveryById(
      id: id,
      success: (data) {
        state.info.addressInfo = data;

        /// 设置默认收货地址
        userDeliveryDefault(data.id);
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 设置默认收货地址
  userDeliveryDefault(int id) {
    /// 发起请求
    ReceivingRequest.userDeliveryDefault(
      id: id,
      success: (data) {},
      fail: (code, msg) {},
    );
  }

  /// 名称修改
  nameChange(String msg) {
    state.info.nickname = msg;
  }

  /// 简介修改
  onChange(String msg) {
    state.info.introduction = msg;
  }

  /// 前往实名认证页
  void goToCertification() {
    Get.toNamed(RouteConfig.certification);
  }

  /// 前往地址管理页面
  void goToAddressManage() async {
    var data = await Get.toNamed(RouteConfig.addressManage);
    if (data != null) {
      /// 获取收货地址信息
      userDeliveryById(data);
    }
  }
}
