import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';

/// 获取短信验证码
class GetCode extends StatelessWidget {
  GetCode({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(GetCodeLogic());

  /// 数据层
  final state = Get.find<GetCodeLogic>().state;

  /// 输入框样式
  final PinTheme defaultPinTheme = PinTheme(
    width: 40,
    height: 40,
    textStyle: TextStyle(
      fontSize: 40.dp,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.dp),
      color: const Color.fromRGBO(23, 31, 33, 1),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.dp),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.dp),
              child: const Text("请输入验证码"),
            ),
            SizedBox(height: 50.dp),
            /// 验证码
            Align(
              alignment: Alignment.center,
              child: Pinput(
                controller: state.pinController,
                focusNode: state.focusNode,
                length: 6,

                /// android短信自动填充方法
                androidSmsAutofillMethod:
                AndroidSmsAutofillMethod.smsRetrieverApi,

                /// 在Android上收听多条短信
                listenForMultipleSmsOnAndroid: false,

                /// pinput自动验证模式
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                onAppPrivateCommand: (str, map) {
                  print("这是什么$str----------$map");
                },
                defaultPinTheme: defaultPinTheme,

                /// 验证器
                validator: (value) {
                  // return value == '2222' ? null : 'Pin不正确';
                },

                /// 在剪贴板上找到
                onClipboardFound: (value) {
                  debugPrint('在剪贴板上找到: $value');
                  /// 刚进入页面不需要立刻赋值
                  if(state.start) {
                    state.pinController.setText(value);
                  }
                },

                /// 触觉反馈型
                hapticFeedbackType: HapticFeedbackType.lightImpact,

                /// 完成
                onCompleted: (pin) {
                  /// 完成后登录
                  logic.onCompleted(pin);
                  debugPrint('完成-----: $pin');
                },
                onChanged: (value) {
                  debugPrint('改变-----: $value');
                },

                /// 光标
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: paleGreenColor,
                    ),
                  ],
                ),

                // /// 聚焦Pin主题
                // focusedPinTheme: defaultPinTheme.copyWith(
                //   decoration: defaultPinTheme.decoration!.copyWith(
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                // ),
                //
                // /// 提交Pin主题
                // submittedPinTheme: defaultPinTheme.copyWith(
                //   decoration: defaultPinTheme.decoration!.copyWith(
                //     borderRadius: BorderRadius.circular(15),
                //   ),
                // ),
              ),
            ),

            SizedBox(height: 60.dp),

            GetBuilder<GetCodeLogic>(builder: (_) {
              return Align(
                alignment: Alignment.center,
                child: Text(
                  "已发送验证码至${state.phone}",
                  style: TextStyle(
                    fontSize: 24.dp,
                    color: darkGreyColor,
                  ),
                ),
              );
            }),

            SizedBox(height: 100.dp),

            /// 重新发送
            GetBuilder<GetCodeLogic>(builder: (_) {
              return Stack(
                children: [
                  ///  允许点击
                  Visibility(
                    visible: state.allow,
                    child: GestureDetector(
                      onTap: logic.getSmsCode,
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
                          "重新发送",
                          style: TextStyle(
                            fontSize: 30.dp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// 灰色按钮  不允许点击
                  Visibility(
                    visible: !state.allow,
                    child: Container(
                      height: 90.dp,
                      margin: EdgeInsets.symmetric(horizontal: 70.dp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45.dp),
                        color: const Color.fromRGBO(48, 55, 56, 1),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "重新发送（${state.time}）",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );

            }),
          ],
        ),
      ),
    );
  }
}
