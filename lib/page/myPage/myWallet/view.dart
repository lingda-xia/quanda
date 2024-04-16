import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';
import 'widget/selectList.dart';

/// 我的钱包页面
class MyWallet extends StatelessWidget {
  MyWallet({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(MyWalletLogic());

  /// 数据层
  final state = Get.find<MyWalletLogic>().state;

  /// 提现和充值按钮
  Widget twoButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// 提现按钮
        GestureDetector(
          onTap: () => logic.selectStatusValue(false),
          child: Container(
            width: 174.dp,
            height: 78.dp,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("img/bigIcon/GradientBor.png"),
              ),
            ),
            child: Text(
              "提现",
              style: TextStyle(
                color: const Color.fromRGBO(155, 208, 114, 1),
                fontSize: 28.dp,
              ),
            ),
          ),
        ),
        SizedBox(width: 125.dp),

        /// 充值按钮
        GestureDetector(
          onTap: () => logic.selectStatusValue(true),
          child: Container(
            width: 174.dp,
            height: 78.dp,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("img/bigIcon/GradientBox.png"),
              ),
            ),
            child: Text(
              "充值",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.dp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 选择的方式
  Widget rechargeMode() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<MyWalletLogic>(builder: (e) {
            return Text(
              state.statusValue ? "充值方式" : "提现账户",
              style: TextStyle(
                fontSize: 36.dp,
              ),
            );
          }),

          SizedBox(height: 30.dp),

          /// 支付宝账户
          GestureDetector(
            onTap: () => logic.onChanged(),
            behavior: HitTestBehavior.translucent,
            child: Container(
              height: 96.dp,
              padding: EdgeInsets.symmetric(horizontal: 30.dp),
              decoration: BoxDecoration(
                color: blackGrey,
                borderRadius: BorderRadius.circular(48.dp),
              ),
              child: Row(
                children: [
                  /// 支付宝图标
                  Image.asset(
                    "img/Icon/Alipay.png",
                    width: 45.dp,
                    height: 45.dp,
                  ),
                  SizedBox(width: 20.dp),
                  Text(
                    "支付宝充值",
                    style: TextStyle(
                      fontSize: 30.dp,
                      color: greyColor,
                    ),
                  ),
                  const Expanded(child: SizedBox()),

                  Text(
                    "去授权",
                    style: TextStyle(
                      color: paleGreenColor,
                      fontSize: 30.dp,
                    ),
                  ),

                  /// 复选框
                  GetBuilder<MyWalletLogic>(builder: (e) {
                    return Stack(
                      children: [
                        Visibility(
                          visible: state.isChecked,
                          child: Image.asset(
                            "img/Icon/check_yes.png",
                            width: 36.dp,
                            height: 36.dp,
                          ),
                        ),
                        Visibility(
                          visible: !state.isChecked,
                          child: Image.asset(
                            "img/Icon/check_no.png",
                            width: 36.dp,
                            height: 36.dp,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.dp),
          Center(
            child: Text(
              "注：每半年只能换绑一次，一个支付宝账号只能绑定一个圈达账号",
              style: TextStyle(
                fontSize: 20.dp,
                color: darkGreyColor,
              ),
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
        /// 回退键
        leading: const BackButton(),
        title: const Text("我的钱包"),
        actions: [
          /// 账单
          GestureDetector(
            onTap: () => logic.goToBill(),
            behavior: HitTestBehavior.translucent,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 40.dp),
              child: Row(
                children: [
                  Image.asset(
                    "img/Icon/wenhao.png",
                    width: 28.dp,
                    height: 28.dp,
                  ),
                  SizedBox(width: 6.dp),
                  Text(
                    "账单明细",
                    style: TextStyle(
                      fontSize: 24.dp,
                      color: paleGreenColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.dp),

            /// 圈达币
            Image.asset(
              "img/Icon/GoldCoin.png",
              width: 82.dp,
              height: 82.dp,
            ),

            SizedBox(height: 20.dp),

            /// 圈达币余额
            Text(
              "78900",
              style: TextStyle(
                fontSize: 50.dp,
                fontFamily: "Rany",
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60.dp),

            /// 提现和充值按钮
            twoButton(),

            SizedBox(height: 30.dp),

            /// 下划线
            Divider(
              height: 1.dp,
              thickness: 1.dp,
              color: const Color.fromRGBO(44, 48, 47, 1),
            ),

            SizedBox(height: 30.dp),

            /// 选择列表
            SelectList(
              data: state,
              onTap: (index) => logic.selectAmount(index),
            ),
            SizedBox(height: 80.dp),

            /// 选择的方式
            rechargeMode(),

            SizedBox(height: 80.dp),

            /// 提现按钮
            GestureDetector(
              onTap: () => {},
              child: Container(
                height: 96.dp,
                margin: EdgeInsets.symmetric(horizontal: 30.dp),
                decoration: BoxDecoration(
                  color: paleGreenColor,
                  borderRadius: BorderRadius.circular(48.dp),
                ),
                alignment: Alignment.center,
                child: GetBuilder<MyWalletLogic>(builder: (e) {
                  return Text(
                    state.statusValue ? "充值" : "提现",
                    style: TextStyle(
                      fontSize: 36.dp,
                      color: Colors.white,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
