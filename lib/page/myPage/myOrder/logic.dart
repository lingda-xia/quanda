import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/order.dart';
import 'package:quanda/model/LongList.dart';
import 'package:quanda/model/personal/OrderEntity.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/custom_dialog.dart';
import 'package:quanda/widget/payment_popup.dart';
import 'state.dart';

/// 我的订单的逻辑层
class MyOrderLogic extends GetxController {
  MyOrderState state = MyOrderState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    /// 倒计时
    countDown();
  }

  @override
  void onClose() {
    super.onClose();
    if (state.timer != null) {
      state.timer.cancel();
    }
  }

  /// 获取订单列表
  Future<LongList> getList(int status, int page) {
    /// 等待请求完成
    Completer<LongList> completer = Completer();

    /// 发起请求
    OrderRequest.orderList(
        status: status == -1 ? null : status,
        page: page,
        success: (data) {
          /// 重置列表状态关闭
          state.reload[status] = false;

          /// 列表数据
          List res = data.records;

          List<OrderEntity> list = [];

          for (int i = 0; i < res.length; i++) {
            list.add(OrderEntity.fromJson(res[i]));
          }

          /// 第一页
          if (data.current == 1) {
            state.listMap[status] = list;
          } else {
            state.listMap[status]?.addAll(list);
          }

          /// 将数据返回
          completer.complete(data);
          update();
        },
        fail: (code, msg) {
          /// 重置列表状态关闭
          state.reload[status] = false;
          /// 将错误code输出
          completer.completeError(code);
        });

    return completer.future;
  }

  /// 确认收货
  idleOrderConfirm(String id) {
    /// 发起请求
    OrderRequest.idleOrderConfirm(
      id: id,
      success: (data) {
        /// 重新加载列表
        state.reload[state.select] = true;
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 弹起支付订单弹窗
  openPayment(int orderId, String money) async {
    var data = await Get.bottomSheet(
      /// 支付弹窗 自定义widget
      PaymentOrder(
        money: money,
        module: "orderPay",
        orderId: orderId,
      ),

      /// 蒙层颜色
      barrierColor: const Color.fromRGBO(7, 17, 20, 0.84),

      /// 设置圆角  圆角矩形
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40.dp),
          topLeft: Radius.circular(40.dp),
        ),
      ),
      backgroundColor: blackGrey,
    );

    if(data == "success") {
      /// 重置列表
      state.reload[state.select] = false;
    }
  }

  /// 打开提示对话框
  Future openDialog(String content, String tips, Function confirm) async {
    await Get.dialog(
      /// 自定义对话框
      CustomDialog(
        /// 确认事件
        confirm: () => confirm(),

        /// 内容
        content: content,

        /// 提示内容
        tips: tips,

        /// 取消文本
        cancelText: "否",

        /// 确认文本
        confirmText: "是",
      ),

      /// 打开蒙层
      barrierDismissible: false,
    );
  }

  /// 倒计时
  countDown() {
    state.timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      update();
    });
  }

  /// 申请退款
  refundOrder(String id) {
    /// 发起请求
    OrderRequest.refundOrder(
      id: id,
      success: (data) {
        /// 重新加载列表
        state.reload[state.select] = true;
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 订单取消
  cancelOrder(String id, int status) {
    /// 发起请求
    OrderRequest.cancelOrder(
      id: id,
      success: (data) {
        /// 重新加载列表
        state.reload[status] = true;
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 前往核验码
  void goToVerificationCode(int type, int sourceOrderId) async {
    var data = await Get.toNamed(
        "${RouteConfig.verificationCode}?type=$type&sourceOrderId=$sourceOrderId");
    print("这是--------------$data");
    /// 获取订单列表
    getList(state.select, 1);
  }
}
