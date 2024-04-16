import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/order.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 核验码的逻辑层
class VerificationCodeLogic extends GetxController {
  VerificationCodeState state = VerificationCodeState();

  @override
  void onInit() {
    super.onInit();
    state.type = Get.parameters["type"]!;
    state.sourceOrderId = int.parse(Get.parameters["sourceOrderId"]!);
  }

  @override
  void onReady() {
    super.onReady();

    /// 订单检验信息
    refundOrder();
  }

  /// 订单检验信息
  refundOrder() {
    /// 发起请求
    OrderRequest.orderCheckInfo(
      type: int.parse(state.type),
      sourceOrderId: state.sourceOrderId,
      success: (data) {
        state.info = data;
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 前往私聊页面
  void goToPrivateChat() {
    Get.toNamed(
        "${RouteConfig.privateChat}?id=${state.info.userInfo.userId}&name=${state.info.userInfo.nickname}");
  }
}
