import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/interaction.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/widget/custom_dialog.dart';
import 'state.dart';

/// 闲置订单详情的逻辑层
class IdleOrderDetailsLogic extends GetxController {
  IdleOrderDetailsState state = IdleOrderDetailsState();

  @override
  void onInit() {
    super.onInit();
    state.id = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();

    /// 获取闲置订单详情
    getIdleOrderInfo();
  }

  /// 获取闲置订单详情
  getIdleOrderInfo() {
    /// 发起请求
    InteractionRequest.idleOrderInfo(
      id: state.id,
      success: (data) {
        state.data = data;
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 闲置发货
  idleOrderSendGoods() {
    /// 发起请求
    InteractionRequest.idleOrderSendGoods(
      orderId: state.data.orderId.toString(),
      expressName: state.express.expressName,
      expressId: state.express.id,
      expressNo: state.textContent,
      success: (data) {
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 删除订单
  idleOrderDel() {
    /// 发起请求
    InteractionRequest.idleOrderDel(
      id: state.data.orderId.toString(),
      success: (data) {
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 拒绝退款
  refuseRefund() {
    /// 发起请求
    InteractionRequest.refuseRefund(
      id: state.data.orderId.toString(),
      success: (data) {
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 同意退款
  agreeRefund() {
    /// 发起请求
    InteractionRequest.agreeRefund(
      id: state.data.orderId.toString(),
      success: (data) {
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 打开提示对话框
  Future openDialog(String content, Function confirm) async {
    await Get.dialog(
      /// 自定义对话框
      CustomDialog(
        /// 确认事件
        confirm: () => confirm(),

        /// 内容
        content: content,

        /// 取消文本
        cancelText: "取消",

        /// 确认文本
        confirmText: "确认",
      ),

      /// 打开蒙层
      barrierDismissible: false,
    );
  }

  /// 监听搜索输入
  void onChanged(String msg) {
    print("输入框输入的内容=======>$msg");
    state.textContent = msg;
    update();
  }

  /// 单选按钮改变
  void radioChanged(int value) {
    print("单选按钮改变=======>   $value");
    state.groupValue = value;
    update();
  }

  /// 前往快递选择页面
  void goToExpress() async {
    var data =
        await Get.toNamed(RouteConfig.express, arguments: state.express.id);

    if (data != null) {
      state.express = data;
      update();
    }
  }
}
