import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import '../logic.dart';
import '../state.dart';

/// 钱包
class Wallet extends StatelessWidget {
  const Wallet({
    Key? key,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  /// 数据源
  final MyState data;

  /// 点击事件
  final NoParameterCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.dp, vertical: 40.dp),
        margin: EdgeInsets.symmetric(horizontal: 16.dp),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(23, 31, 33, 0.5),
          borderRadius: BorderRadius.circular(20.dp),
        ),
        child: Row(
          children: [
            Image.asset(
              "img/bigIcon/my_wallet.png",
              width: 82.dp,
              height: 82.dp,
            ),

            SizedBox(width: 20.dp),

            /// 我的钱包
            const Text("我的钱包"),

            const Expanded(child: SizedBox()),

            Image.asset(
              "img/Icon/GoldCoin.png",
              width: 32.dp,
              height: 32.dp,
            ),

            SizedBox(width: 16.dp),

            GetBuilder<MyLogic>(builder: (e) {
              return Text(
                data.userInfo.balance.toString(),
                style: TextStyle(fontSize: 40.dp, fontFamily: "Rany"),
              );
            }),
          ],
        ),
      ),
    );
  }
}
