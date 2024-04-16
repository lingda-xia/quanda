import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';

/// 登录 自助换绑 新手机号 页面
class LoginBindChange extends StatelessWidget {
  LoginBindChange({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(LoginBindChangeLogic());

  /// 数据层
  final state = Get.find<LoginBindChangeLogic>().state;

  /// 底部区域
  Widget bottomArea() {
    return GestureDetector(
      onTap: state.code.isNotEmpty && state.phone.length == 11
          ? logic.nextStep
          : null,
      child: Container(
        height: 90.dp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48.dp),
          color: state.code.isNotEmpty && state.phone.length == 11
              ? paleGreenColor
              : const Color.fromRGBO(48, 55, 56, 1),
        ),
        child: Text(
          "提交",
          style: TextStyle(fontSize: 30.dp, color: Colors.white),
        ),
      ),
    );
  }

  /// 输入新手机号
  Widget phoneNumber() {
    return SizedBox(
      height: 130.dp,
      child: Stack(
        children: [
          TextField(
            /// 文本控制器
            controller: state.textController,

            /// 键盘类型
            keyboardType: TextInputType.number,

            /// 最大长度
            maxLength: 11,

            /// 监听输入改变的时候
            onChanged: logic.phoneChange,

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
              hintText: "请输入新手机号",

              /// 提示的文本样式
              hintStyle: TextStyle(
                color: greyColor,
                fontSize: 26.dp,
                fontFamily: "PingFang SC",
              ),

              /// 计数文本样式
              counterStyle: const TextStyle(color: Colors.transparent),

              /// 内边距
              contentPadding: EdgeInsets.only(right: 80.dp, left: 120.dp),

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
            child: GetBuilder<LoginBindChangeLogic>(builder: (e) {
              return GestureDetector(
                onTap: logic.empty,
                behavior: HitTestBehavior.translucent,
                child: Container(
                  padding: EdgeInsets.only(right: 70.dp),
                  child: Image.asset("img/Icon/chacha.png",
                      width: 30.dp, height: 30.dp),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  /// 输入验证码
  Widget inputCode() {
    return SizedBox(
      height: 90.dp,
      child: Stack(
        children: [
          /// 输入框
          TextField(
            /// 最大行数
            maxLines: 1,

            /// 监听输入改变的时候
            onChanged: logic.changeCode,

            /// 键盘类型
            keyboardType: TextInputType.number,

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
              hintText: "请输入验证码",

              /// 提示的文本样式
              hintStyle: TextStyle(
                color: greyColor,
                fontSize: 30.dp,
                fontFamily: "PingFang SC",
              ),

              /// 内边距
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 50.dp, vertical: 0.dp),

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

          /// 获取验证码
          Positioned(
            top: 0.dp,
            right: 0.dp,
            child: GestureDetector(
              onTap: state.allow ? logic.getSmsCode : null,
              behavior: HitTestBehavior.translucent,
              child: Container(
                height: 90.dp,
                padding: EdgeInsets.only(right: 40.dp, left: 30.dp),
                alignment: Alignment.center,
                child: Text(
                  state.allow ? "获取验证码" : "${state.time}s",
                  style: TextStyle(
                    fontSize: 24.dp,
                    color: paleGreenColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          /// |
          Positioned(
            top: 28.dp,
            right: 190.dp,
            child: Container(
              width: 3.dp,
              height: 35.dp,
              color: const Color.fromRGBO(221, 221, 221, 1),
            ),
          ),
        ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          /// 回退键
          leading: const BackButton(),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 70.dp),
          children: [
            SizedBox(height: 30.dp),
            Padding(
              padding: EdgeInsets.only(left: 20.dp),
              child: Text(
                "自助换绑",
                style: TextStyle(
                  fontSize: 36.dp,
                ),
              ),
            ),

            SizedBox(height: 40.dp),

            /// 输入新手机号
            phoneNumber(),

            /// 输入验证码
            inputCode(),

            SizedBox(height: 70.dp),

            /// 底部按钮
            bottomArea(),

            SizedBox(height: 45.dp),

            Text(
              "注：本流程适用于原注册手机号不再使用，无法获取验证码的情况下，自助进行绑定手机的更换本流程适用于原注册手机号不再使用无法获取验证码的情况下本流程适用于原注册手机号不再使用。",
              style: TextStyle(fontSize: 20.dp, color: greyColor, height: 1.6),
            ),
          ],
        ));
  }
}
