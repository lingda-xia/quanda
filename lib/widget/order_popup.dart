import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/user.dart';
import 'package:quanda/model/user/OrderInfo.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/payment_popup.dart';

/// 订单弹窗
class PlaceOrder extends StatefulWidget {
  const PlaceOrder({
    Key? key,
    required this.money,
    required this.type,
    required this.id,
    this.deliveryId,
  }) : super(key: key);

  /// 所需圈达币
  final String money;

  /// 发布类型
  final int type;

  /// id
  final int id;

  /// 闲置收货id
  final int? deliveryId;

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {

  /// 是否创建订单成功
  late bool success = false;

  /// 弹起支付订单弹窗
  void openPayment(OrderInfo value) async {
    var data = await Get.bottomSheet(
      /// 支付弹窗 自定义widget
      PaymentOrder(
        money: widget.money,
        module: value.module,
        orderId: value.orderId,
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

    if(data != null) {
      Get.back(result: "success");
    } else {
      setState(() {
        success = true;
      });

    }
  }

  /// 创建订单
  orderSave() {
    /// 发起请求
    UserRequest.orderSave(
      type: widget.type,
      id: widget.id,
      deliveryId: widget.deliveryId,
      success: (data) {
        /// 需要支付
        if (!data.payFlag) {
          /// 弹起支付弹窗
          openPayment(data);
        } else {
          Get.back(result: "success");
        }
      },
      fail: (code, msg) {
        Get.back();
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

        /// 创建订单成功之后
        if(success) {
          Get.back(result: "success");
        }

        return true;
      },
      child: Container(
        height: 500.dp,
        padding: EdgeInsets.all(40.dp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "提交订单",
              style: TextStyle(
                fontSize: 36.dp,
              ),
            ),
            SizedBox(height: 90.dp),

            /// 圈达币和价格
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// 圈达币
                Image.asset(
                  "img/Icon/GoldCoin.png",
                  width: 42.dp,
                  height: 42.dp,
                ),
                SizedBox(width: 10.dp),

                /// 所需金额
                Text(
                  widget.money,
                  style: TextStyle(
                    fontSize: 66.dp,
                    fontFamily: "Rany",
                  ),
                ),
              ],
            ),

            SizedBox(height: 100.dp),

            /// 购买
            GestureDetector(
              onTap: () {
                /// 创建订单
                orderSave();
              },
              child: Container(
                height: 96.dp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.dp),
                  color: paleGreenColor,
                ),
                alignment: Alignment.center,
                child: Text(
                  "购买",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.dp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
