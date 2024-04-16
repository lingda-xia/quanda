import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';
import 'package:quanda/widget/login_bg.dart';

import 'logic.dart';
import 'widget/loginProblem.dart';

/// 密码登陆页面
class PasswordLogin extends StatelessWidget {
  PasswordLogin({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(PasswordLoginLogic());

  /// 数据层
  final state = Get.find<PasswordLoginLogic>().state;

  /// 显示底部弹出框
  void showBottomPopup(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: blackGrey,
      barrierColor: const Color.fromRGBO(7, 17, 20, 0.84),
      /// 设置圆角  圆角矩形
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(60.dp),
              topLeft: Radius.circular(60.dp))),
      builder: (BuildContext context) {
        /// 底部弹窗  自定义widget
        return LoginProblem(
          logic: logic,
        );
      },
    );
  }

  /// 输入手机号
  Widget inputPhone() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.dp),
      height: 90.dp,
      child: Stack(
        children: [
          TextField(
            /// 文本控制器
            controller: state.textController,

            /// 键盘类型
            keyboardType: TextInputType.number,

            /// 焦点控制
            focusNode: state.focusNode,

            /// 最大长度
            maxLength: 11,

            /// 监听输入改变的时候
            onChanged: logic.phoneInput,

            /// 输入的文本样式
            style: TextStyle(
              color: themeWhite,
              fontSize: 26.dp,
            ),

            /// 光标颜色
            cursorColor: themeWhite,

            /// 装饰
            decoration: InputDecoration(
              /// 未输入时提示的内容
              hintText: "在这里输入手机号",

              /// 提示的文本样式
              hintStyle: TextStyle(
                color: greyColor,
                fontSize: 26.dp,
                fontFamily: "PingFang SC",
              ),

              counterText: "",

              /// 内边距
              contentPadding: EdgeInsets.only(right: 80.dp, left: 160.dp),

              /// 是否填充
              filled: true,

              /// 填充的颜色  类似背景颜色
              fillColor: blackGrey,

              /// 聚焦后的边框
              focusedBorder: _getEditBorder(),

              /// 未聚焦的边框
              enabledBorder: _getEditBorder(),
            ),
          ),

          /// 86
          Positioned(
            top: 30.dp,
            left: 40.dp,
            child: Text(
              "+86",
              style: TextStyle(
                fontSize: 28.dp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          /// |
          Positioned(
            top: 28.dp,
            left: 100.dp,
            child: Container(
              width: 3.dp,
              height: 35.dp,
              color: const Color.fromRGBO(221, 221, 221, 1),
            ),
          ),

          /// 清空图标
          Positioned(
              right: 0,
              height: 90.dp,
              child: GetBuilder<PasswordLoginLogic>(builder: (e) {
                return GestureDetector(
                  onTap: logic.empty,
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    padding: EdgeInsets.only(right: 70.dp),
                    child: Image.asset("img/Icon/chacha.png",
                        width: 30.dp, height: 30.dp),
                  ),
                );
              })),
        ],
      ),
    );
  }

  /// 输入密码
  Widget inputPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.dp),
      height: 90.dp,
      child: GetBuilder<PasswordLoginLogic>(builder: (e) {
        return TextField(
          /// 是否隐藏密码
          obscureText: state.hide,

          /// 最大行数
          maxLines: 1,

          /// 焦点控制
          focusNode: state.pwFocusNode,

          /// 监听输入改变的时候
          onChanged: logic.passwordChange,

          /// 输入的文本样式
          style: TextStyle(
            color: themeWhite,
            fontSize: 26.dp,
          ),

          /// 光标颜色
          cursorColor: themeWhite,

          /// 将确定按钮换为搜索
          textInputAction: TextInputAction.search,

          /// 装饰
          decoration: InputDecoration(
            /// 未输入时提示的内容
            hintText: "在这里输入密码",

            /// 提示的文本样式
            hintStyle: TextStyle(
              color: greyColor,
              fontSize: 26.dp,
              fontFamily: "PingFang SC",
            ),

            /// 左侧隐藏或显示密码图标
            suffixIcon: GetBuilder<PasswordLoginLogic>(builder: (e) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Visibility(
                    visible: state.hide,
                    child: GestureDetector(
                      onTap: () => logic.changeHide(),
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        height: 90.dp,
                        padding: EdgeInsets.only(right: 70.dp, left: 10.dp),
                        child: Image.asset(
                          "img/Icon/closedEyes.png",
                          width: 30.dp,
                          height: 30.dp,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !state.hide,
                    child: Container(
                      padding: EdgeInsets.only(right: 60.dp, left: 10.dp),
                      child: GestureDetector(
                        onTap: () => logic.changeHide(),
                        child: Image.asset(
                          "img/Icon/openEyes.png",
                          width: 30.dp,
                          height: 30.dp,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),

            /// 内边距
            contentPadding:
                EdgeInsets.symmetric(horizontal: 80.dp, vertical: 0.dp),

            /// 是否填充
            filled: true,

            /// 填充的颜色  类似背景颜色
            fillColor: blackGrey,

            /// 聚焦后的边框
            focusedBorder: _getEditBorder(),

            /// 未聚焦的边框
            enabledBorder: _getEditBorder(),
          ),
        );
      }),
    );
  }

  /// 获取输入框的Border属性，可公用
  OutlineInputBorder _getEditBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(45.dp)),
      borderSide: BorderSide.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    print("页面执行了");
    /// 登陆背景图  自定义widget
    return LoginBG(
      children: [
        SizedBox(height: 220.dp),

        SizedBox(height: 20.dp),

        /// 输入手机号
        inputPhone(),

        SizedBox(height: 30.dp),

        /// 输入密码
        inputPassword(),

        /// 验证码登录 和  遇到的问题
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// 验证码登录
            GestureDetector(
              onTap: () => logic.goToVerifyLogin(),
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30.dp, horizontal: 60.dp),
                child: Text(
                  "验证码登录",
                  style: TextStyle(
                    fontSize: 28.dp,
                    color: paleGreenColor,
                  ),
                ),
              ),
            ),

            /// 登录遇到问题
            GestureDetector(
              onTap: () => showBottomPopup(context),
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30.dp, horizontal: 60.dp),
                child: Text(
                  "登录遇到问题",
                  style: TextStyle(
                    fontSize: 28.dp,
                    color: paleGreenColor,
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 80.dp),

        /// 登录
        GetBuilder<PasswordLoginLogic>(builder: (e){
          return Stack(
            children: [
              ///  允许登录
              Visibility(
                visible: state.allow,
                child: GestureDetector(
                  onTap: () => logic.confirm(),
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
                      "登录",
                      style: TextStyle(
                        fontSize: 30.dp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              /// 灰色按钮  不允许登录
              Visibility(
                visible: !state.allow,
                child: Container(
                  height: 96.dp,
                  margin: EdgeInsets.symmetric(horizontal: 30.dp),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(48, 55, 56, 1),
                    borderRadius: BorderRadius.circular(45.dp),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "登录",
                    style: TextStyle(
                      fontSize: 30.dp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),


        SizedBox(height: 50.dp),

        /// 协议
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.dp),
          child: RichText(
            textAlign: TextAlign.center,
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
