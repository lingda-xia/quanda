import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';
import 'package:quanda/widget/login_bg.dart';

import 'logic.dart';

/// 一键登陆页面
class OneClickLogin extends StatelessWidget {
  OneClickLogin({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(OneClickLoginLogic());

  /// 数据层
  final state = Get.find<OneClickLoginLogic>().state;

  @override
  Widget build(BuildContext context) {
    /// 登陆背景图  自定义widget
    return LoginBG(
      children: [
        SizedBox(height: 340.dp),

        /// 手机号
        Text(
          "135****5798",
          style: TextStyle(
            fontSize: 66.dp,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20.dp),

        /// 其他账号登陆
        GestureDetector(
          onTap: () => {},
          child: Text(
            "其他账号登录",
            style: TextStyle(
              fontSize: 26.dp,
              color: paleGreenColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 90.dp),

        /// 一键登陆
        GestureDetector(
          onTap: () => {},
          child: Container(
            height: 96.dp,
            margin: EdgeInsets.symmetric(horizontal: 30.dp),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("img/Icon/login_button.png"),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              "本机号码一键登录",
              style: TextStyle(
                fontSize: 30.dp,
                color: Colors.white,
              ),
            ),
          ),
        ),

        SizedBox(height: 70.dp),

        /// 协议
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.dp),
          child: RichText(
            // textAlign: TextAlign.center,
            text: TextSpan(
              text: '登录注册即表示同意 ',
              style: TextStyle(
                fontSize: 24.dp,
                color: greyColor,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '圈达用户协议',
                  style: const TextStyle(color: Colors.white),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                const TextSpan(text: ' 和 '),
                TextSpan(
                  text: '隐私协议',
                  style: const TextStyle(color: Colors.white),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                const TextSpan(text: ' 及 '),
                TextSpan(
                  text: '中国移动认证服务条款',
                  style: const TextStyle(color: Colors.white),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
