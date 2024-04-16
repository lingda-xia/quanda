import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/personal.dart';
import 'package:quanda/api/receiving.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 订单支付 的逻辑层
class ConfirmOrderLogic extends GetxController {
  ConfirmOrderState state = ConfirmOrderState();

  @override
  void onInit() {
    super.onInit();
    state.id = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
    /// 确认订单信息
    confirmOrderInfo();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// 确认订单信息
  confirmOrderInfo() {
    /// 发起请求
    PersonalRequest.confirmOrderInfo(
      id: state.id,
      success: (data) {
        state.info = data;
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 获取收货地址信息
  userDeliveryById(int id) {
    /// 发起请求
    ReceivingRequest.userDeliveryById(
      id: id,
      success: (data) {
        state.info.addressInfo = data;
        update();
      },
      fail: (code, msg) {},
    );
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
