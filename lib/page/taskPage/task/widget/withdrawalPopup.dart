import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/page/taskPage/task/logic.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import '../state.dart';

/// 提现弹窗
class WithdrawalPopup extends StatelessWidget {
  const WithdrawalPopup({
    Key? key,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  /// 数据源
  final TaskState data;

  /// 立即提现
  final NoParameterCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// 背景
            Container(
              width: 595.dp,
              height: 754.dp,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("img/bigIcon/sign_pop.png"),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 230.dp),

                  /// 签到列表
                  GetBuilder<TaskLogic>(builder: (_) {
                    return Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 60.dp,
                      runSpacing: 30.dp,
                      children: [
                        for (int i = 0; i < data.signList.length; i++)
                          Container(
                            width: 110.dp,
                            height: 145.dp,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("img/Icon/"
                                        "${data.signList[i]?.status == 2 ? "already_sign" : "stay_sign"}.png"))),
                            child: Column(
                              children: [
                                SizedBox(height: 10.dp),
                                Text(
                                  data.signTitle[i],
                                  style: TextStyle(
                                    fontSize: 20.dp,
                                    color: data.signList[i]?.status == 2
                                        ? Colors.white
                                        : greyColor,
                                  ),
                                ),
                                SizedBox(height: 70.dp),
                                Text(
                                  data.signList[i]?.status == 2 ? "已签到" : "待签到",
                                  style: TextStyle(
                                    fontSize: 20.dp,
                                    color: data.signList[i]?.status == 2
                                        ? Colors.white
                                        : greyColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  }),
                  SizedBox(height: 45.dp),

                  /// 立即提现
                  GestureDetector(
                    onTap: onTap,
                    child: Image.asset(
                      "img/Icon/withdraw_button.png",
                      width: 455.dp,
                      height: 98.dp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.dp),

            /// 关闭按钮
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                "img/Icon/X.png",
                width: 58.dp,
                height: 58.dp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
