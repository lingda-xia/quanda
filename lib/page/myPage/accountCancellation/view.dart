import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';

/// 账号注销页面
class AccountCancellation extends StatelessWidget {
  AccountCancellation({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(AccountCancellationLogic());

  /// 数据层
  final state = Get.find<AccountCancellationLogic>().state;

  /// 底部按钮
  Widget bottomArea() {
    return GestureDetector(
      onTap: state.agree ? logic.goToCancellation : null,
      child: UnconstrainedBox(
        child: Container(
          width: 170.dp,
          height: 74.dp,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.dp),
            color: state.agree
                ? paleGreenColor
                : const Color.fromRGBO(48, 55, 56, 1),
          ),
          child: Text(
            "下一步",
            style: TextStyle(fontSize: 30.dp, color: Colors.white),
          ),
        ),
      ),
    );
  }

  /// 注销协议
  Widget agreement() {
    return GetBuilder<AccountCancellationLogic>(builder: (e) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// 是否同意协议
          GestureDetector(
            onTap: () => logic.change(),
            behavior: HitTestBehavior.translucent,
            child: state.agree
                ? Padding(
                    padding: EdgeInsets.all(20.dp),
                    child: Container(
                      width: 30.dp,
                      height: 30.dp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.dp),
                        color: paleGreenColor,
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(20.dp),
                    child: Container(
                      width: 30.dp,
                      height: 30.dp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.dp),
                        color: themeWhite,
                      ),
                    ),
                  ),
          ),

          /// 注销协议
          GestureDetector(
            onTap: () => {},
            child: RichText(
              text: TextSpan(
                text: '我已阅读并同意“',
                style: TextStyle(
                  fontSize: 28.dp,
                ),
                children: const <TextSpan>[
                  TextSpan(
                      text: '注销协议', style: TextStyle(color: paleGreenColor)),
                  TextSpan(text: '”'),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          /// 回退键
          leading: const BackButton(),
          title: const Text("账号注销"),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 46.dp),
          children: [
            SizedBox(height: 40.dp),
            Text(
              "注销前请认真阅读以下重要提醒。账号注销后注销前请认真阅读以下重要提醒。账号注销后:",
              style: TextStyle(
                fontSize: 30.dp,
              ),
            ),

            SizedBox(height: 50.dp),

            Text(
              "1,无法登录、使用圈达账号，并移除该账号下的所有登",
              style: TextStyle(
                fontSize: 28.dp,
                color: greyColor,
              ),
            ),

            SizedBox(height: 80.dp),

            Text(
              "同时需满足以下条件：",
              style: TextStyle(
                fontSize: 30.dp,
              ),
            ),

            SizedBox(height: 35.dp),

            Text(
              "1，是否存在交易中闲置与任务",
              style: TextStyle(
                fontSize: 28.dp,
                color: greyColor,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 40.dp),
              child: Text(
                "该账号下不能有交易中的订单，否则无法注销该账号",
                style: TextStyle(
                  fontSize: 24.dp,
                ),
              ),
            ),

            SizedBox(height: 300.dp),

            /// 注销协议
            agreement(),

            SizedBox(height: 70.dp),

            GetBuilder<AccountCancellationLogic>(builder: (_) {
              /// 底部按钮
              return bottomArea();
            })
          ],
        ));
  }
}
