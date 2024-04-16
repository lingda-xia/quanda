import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';

/// 无法登录页面
class UnableToLogin extends StatelessWidget {
  UnableToLogin({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(UnableToLoginLogic());

  /// 数据层
  final state = Get.find<UnableToLoginLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("无法登录"),
      ),
      body: ListView(
        padding: EdgeInsets.all(35.dp),
        children: [
          Text(
            "账号无法登录",
            style: TextStyle(
              fontSize: 30.dp,
            ),
          ),
          SizedBox(height: 20.dp),
          RichText(
            text: TextSpan(
              text: '1、若您注册的手机号已不再使用，无法获取验证码，或已经忘记手机号，可点击',
              style: TextStyle(
                fontSize: 28.dp,
                color: greyColor,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '自助换绑',
                  style: const TextStyle(color: paleGreenColor),
                  recognizer: TapGestureRecognizer()..onTap = () => logic.goToLoginBindChange(),
                ),
                const TextSpan(text: '，更换绑定手机号;')
              ],
            ),
          ),
          Text(
            "2、若您的账号因存在异常或其他原因被封禁，可根据封禁页面提示进行自助申诉或人工申诉;",
            style: TextStyle(
              fontSize: 28.dp,
              color: greyColor
            ),
          ),
          Text(
            "3、若您验证码输入错误次数过多，请您1小时后再次获取;",
            style: TextStyle(
                fontSize: 28.dp,
                color: greyColor
            ),
          ),
          Text(
            "4、若您当日验证码获取次数已达上限，请您于24小时后再次获取，同时建议您可以使用密码登录(若忘记密码，可返回上级页面，点击登录遇到问题-找回密码进行修改);",
            style: TextStyle(
                fontSize: 28.dp,
                color: greyColor
            ),
          ),

          RichText(
            text: TextSpan(
              text: '5、如若上述说明未能解决您的登录问题，可点击进行',
              style: TextStyle(
                fontSize: 28.dp,
                color: greyColor,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '意见反馈',
                  style: const TextStyle(color: paleGreenColor),
                  recognizer: TapGestureRecognizer()..onTap = () => logic.goToFeedback(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
