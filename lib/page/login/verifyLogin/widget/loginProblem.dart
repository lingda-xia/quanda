import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import '../logic.dart';

/// 登录遇到问题弹出框
class LoginProblem extends StatelessWidget {
  const LoginProblem({
    Key? key,
    required this.logic,
  }) : super(key: key);

  /// 逻辑层
  final VerifyLoginLogic logic;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 460.dp,
      child: Column(
        children: [
          SizedBox(height: 20.dp),
          /// 无法登录
          GestureDetector(
            onTap: () => logic.goToUnableToLogin(),
            behavior: HitTestBehavior.translucent,
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 30.dp),
              child: Text(
                "无法登录",
                style: TextStyle(
                  color: paleGreenColor,
                  fontSize: 34.dp,
                ),
              ),
            ),
          ),
          /// 找回密码
          GestureDetector(
            onTap: logic.goToRetrievePassword,
            behavior: HitTestBehavior.translucent,
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 30.dp),
              child: Text(
                "找回密码",
                style: TextStyle(
                  color: paleGreenColor,
                  fontSize: 34.dp,
                ),
              ),
            ),
          ),
          /// 自助换绑
          GestureDetector(
            onTap: () => logic.goToLoginBindChange(),
            behavior: HitTestBehavior.translucent,
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 30.dp),
              child: Text(
                "自助换绑",
                style: TextStyle(
                  color: paleGreenColor,
                  fontSize: 34.dp,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.dp),
          /// 取消
          GestureDetector(
            onTap: () => Get.back(),
            behavior: HitTestBehavior.translucent,
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 30.dp),
              child: Text(
                "取消",
                style: TextStyle(
                  fontSize: 34.dp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
