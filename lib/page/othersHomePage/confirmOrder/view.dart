import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/function/custom_toast.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';
import 'package:quanda/widget/order_popup.dart';

import 'logic.dart';
import 'state.dart';

/// 发布闲置 页面
class ConfirmOrder extends StatelessWidget {
  ConfirmOrder({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(ConfirmOrderLogic());

  /// 数据层
  final state = Get.find<ConfirmOrderLogic>().state;

  /// 手机号码显示处理
  String phone() {
    String str = "";

    if (state.info.addressInfo!.phone != "") {
      str = state.info.addressInfo!.phone.replaceRange(3, 7, "****");
    }

    return str;
  }

  /// 弹起提交订单弹窗
  void openOrder() async {

    if(state.info.addressInfo == null) {
      /// 自定义提示框
      CustomToast.showToast("请选择收货地址", const Color.fromRGBO(255, 77, 96, 1));
      return ;
    }

    var data = await Get.bottomSheet(
      /// 提交订单弹窗 自定义widget
      PlaceOrder(
        money: state.info.payMoney.toString(),
        type: 4,
        id: state.id,
        deliveryId: state.info.addressInfo!.id,
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

    print("--------------$data");

    if(data == "success") {
      Get.back(result: "success");
    }
  }

  /// 提货地址
  Widget address() {
    return Container(
      padding: EdgeInsets.all(25.dp),
      margin: EdgeInsets.symmetric(horizontal: 30.dp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.dp),
        color: blackGrey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("运费:"),
              Text(
                state.list[state.info.extractType],
                style: TextStyle(
                  fontSize: 26.dp,
                  color: orange,
                ),
              ),
            ],
          ),

          SizedBox(height: 25.dp),

          /// 下划线
          Divider(
            height: 1.dp,
            thickness: 1.dp,
            color: const Color.fromRGBO(34, 41, 43, 1),
          ),

          SizedBox(height: 30.dp),

          /// 收货地址  上门自提 不需要选择地址
          GestureDetector(
            onTap: state.info.extractType == 1 ? null : logic.goToAddressManage,
            behavior: HitTestBehavior.translucent,
            child: Row(
              children: [
                Text(state.info.extractType == 1 ? "提货地址" : "收货地址："),

                const Expanded(child: SizedBox()),

                /// 是否选择了地址
                state.info.addressInfo == null
                    ? Image.asset(
                        "img/Icon/addAddress.png",
                        width: 50.dp,
                        height: 50.dp,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${state.info.addressInfo!.contact} ${phone()}",
                            style: TextStyle(
                              fontSize: 26.dp,
                            ),
                          ),
                          SizedBox(height: 10.dp),
                          Text(
                            state.info.addressInfo!.areaAddress,
                            style: TextStyle(
                              fontSize: 22.dp,
                              color: greyColor,
                            ),
                          ),
                          SizedBox(height: 4.dp),
                          Text(
                            state.info.addressInfo!.address,
                            style: TextStyle(
                              fontSize: 22.dp,
                              color: greyColor,
                            ),
                          ),
                        ],
                      ),
                SizedBox(width: 40.dp),
                state.info.extractType == 1
                    ? Container()
                    : Image.asset(
                        "img/Icon/right.png",
                        width: 16.dp,
                        height: 26.dp,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("确认订单"),
      ),
      body: GetBuilder<ConfirmOrderLogic>(
        builder: (_) {
          return Column(
            children: [
              SizedBox(height: 30.dp),

              /// 订单信息展示
              Container(
                padding: EdgeInsets.all(36.dp),
                margin: EdgeInsets.symmetric(horizontal: 30.dp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.dp),
                  color: blackGrey,
                ),
                child: Row(
                  children: [
                    /// 图片展示
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14.dp),
                      child: CachedImage(
                        imgUrl: state.info.imageStr,
                        width: 172.dp,
                        height: 172.dp,
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(width: 30.dp),

                    Expanded(
                      child: SizedBox(
                        height: 172.dp,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// 标题
                            Text(
                              state.info.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "${state.info.payMoney}币",
                                style: TextStyle(
                                  fontSize: 36.dp,
                                  fontFamily: "Rany",
                                  color: orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.dp),

              /// 提货地址
              address(),

              const Expanded(child: SizedBox()),

              /// 底部购买
              Container(
                height: 156.dp,
                color: blackGrey,
                padding: EdgeInsets.symmetric(vertical: 40.dp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "圈达币付款：",
                      style: TextStyle(
                        fontSize: 24.dp,
                      ),
                    ),

                    SizedBox(width: 20.dp),

                    Text(
                      "${state.info.payMoney}币",
                      style: TextStyle(
                          fontSize: 34.dp, color: orange, fontFamily: "Rany"),
                    ),

                    SizedBox(width: 20.dp),

                    /// 购买按钮
                    GestureDetector(
                      onTap: openOrder,
                      child: Container(
                        width: 176.dp,
                        height: 70.dp,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("img/Icon/Verification.png"),
                        )),
                        alignment: Alignment.center,
                        child: Text(
                          "立即购买",
                          style: TextStyle(
                            fontSize: 26.dp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 60.dp),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
