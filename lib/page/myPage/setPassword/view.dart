import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';

/// 设置密码页面
class SetPassword extends StatelessWidget {
  SetPassword({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(SetPasswordLogic());

  /// 数据层
  final state = Get.find<SetPasswordLogic>().state;

  /// 底部区域
  Widget bottomArea() {
    return GestureDetector(
      onTap: state.password.characters.length >= 8 &&
              state.reconfirm.characters.length >= 8
          ? logic.confirm
          : null,
      child: Container(
        height: 96.dp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48.dp),
          color: state.password.characters.length >= 8 &&
                  state.reconfirm.characters.length >= 8
              ? paleGreenColor
              : const Color.fromRGBO(48, 55, 56, 1),
        ),
        child: Text(
          "确认",
          style: TextStyle(fontSize: 30.dp, color: Colors.white),
        ),
      ),
    );
  }

  /// 获取输入框的Border属性，可公用
  OutlineInputBorder _getEditBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(45.dp)),
      borderSide: BorderSide.none,
    );
  }

  /// 输入密码
  Widget inputPassword() {
    return SizedBox(
      height: 90.dp,
      child: GetBuilder<SetPasswordLogic>(builder: (e) {
        return TextField(
          /// 文本控制器
          controller: state.textController,

          /// 是否隐藏密码
          obscureText: state.hide,

          focusNode: state.mFocusNode,

          /// 最大行数
          maxLines: 1,

          /// 监听输入改变的时候
          onChanged: logic.passwordChange,

          /// 输入的文本样式
          style: TextStyle(
            color: themeWhite,
            fontSize: 30.dp,
          ),

          /// 光标颜色
          cursorColor: themeWhite,

          /// 装饰
          decoration: InputDecoration(
            /// 未输入时提示的内容
            hintText: "请输入新的密码",

            /// 提示的文本样式
            hintStyle: TextStyle(
              color: greyColor,
              fontSize: 30.dp,
              fontFamily: "PingFang SC",
            ),

            /// 左侧隐藏或显示密码图标
            suffixIcon: GetBuilder<SetPasswordLogic>(builder: (e) {
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
                        padding: EdgeInsets.only(right: 60.dp, left: 10.dp),
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
                EdgeInsets.symmetric(horizontal: 50.dp, vertical: 25.dp),

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

  /// 确认密码
  Widget confirmPassword() {
    return SizedBox(
      height: 90.dp,
      child: GetBuilder<SetPasswordLogic>(builder: (e) {
        return TextField(
          /// 最大行数
          maxLines: 1,

          /// 监听输入改变的时候
          onChanged: logic.again,

          focusNode: state.qFocusNode,

          /// 是否隐藏密码
          obscureText: state.hide,

          /// 输入的文本样式
          style: TextStyle(
            color: themeWhite,
            fontSize: 30.dp,
          ),

          /// 光标颜色
          cursorColor: themeWhite,

          /// 装饰
          decoration: InputDecoration(
            /// 未输入时提示的内容
            hintText: "再次输入",

            /// 提示的文本样式
            hintStyle: TextStyle(
              color: greyColor,
              fontSize: 30.dp,
              fontFamily: "PingFang SC",
            ),

            /// 内边距
            contentPadding:
                EdgeInsets.symmetric(horizontal: 50.dp, vertical: 25.dp),

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          /// 回退键
          leading: const BackButton(),
          title: const Text("设置密码"),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 70.dp),
          children: [
            SizedBox(height: 40.dp),
            Padding(
              padding: EdgeInsets.only(left: 16.dp),
              child: Text(
                "设置密码",
                style: TextStyle(
                  fontSize: 36.dp,
                ),
              ),
            ),

            SizedBox(height: 40.dp),

            /// 请输入新的密码
            inputPassword(),

            SizedBox(height: 20.dp),

            /// 密码提示
            Padding(
              padding: EdgeInsets.only(left: 16.dp),
              child: Text(
                "密码至少8位，至少含数字/字母/字符两种组合",
                style: TextStyle(
                  color: darkGreyColor,
                  fontSize: 20.dp,
                ),
              ),
            ),

            SizedBox(height: 40.dp),

            /// 再次输入
            confirmPassword(),

            SizedBox(height: 100.dp),

            GetBuilder<SetPasswordLogic>(builder: (_) {
              /// 底部按钮
              return bottomArea();
            })
          ],
        ));
  }
}
