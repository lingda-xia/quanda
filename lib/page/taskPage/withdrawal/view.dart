import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';
import 'widget/selectList.dart';

/// 提现 页面
class Withdrawal extends StatelessWidget {
  Withdrawal({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(WithdrawalLogic());

  /// 数据层
  final state = Get.find<WithdrawalLogic>().state;

  /// 选择的方式
  Widget rechargeMode() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "提现账户",
                style: TextStyle(
                  fontSize: 36.dp,
                ),
              ),
              const Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () => {},
                child: Text(
                  "没有支付宝？下载领10元",
                  style: TextStyle(
                    fontSize: 26.dp,
                    color: greyColor,
                  ),
                ),
              ),
              SizedBox(width: 25.dp),
              Image.asset("img/Icon/right.png", width: 14.dp, height: 24.dp),
            ],
          ),

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
                    "支付宝账户",
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
                  GetBuilder<WithdrawalLogic>(builder: (e) {
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
        title: const Text("提现"),
        actions: [
          /// 金币收益
          GestureDetector(
            onTap: () => logic.goToGoldIncome(),
            behavior: HitTestBehavior.translucent,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 40.dp),
              child: const Text(
                "金币收益",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60.dp),

            /// 总余额
            const Text("总余额（元）"),

            SizedBox(height: 35.dp),

            /// 金币余额
            Text(
              "99.75",
              style: TextStyle(
                fontSize: 60.dp,
                fontFamily: "Rany",
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 120.dp),

            /// 选择列表
            SelectList(
              data: state,
              onTap: (index) => logic.selectAmount(index),
            ),

            SizedBox(height: 120.dp),

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
                child: Text(
                  "提现",
                  style: TextStyle(
                    fontSize: 36.dp,
                    color: Colors.white,
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
