import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';

/// 登录 自助换绑 原手机号 页面
class OriginalNumber extends StatelessWidget {
  OriginalNumber({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(OriginalNumberLogic());

  /// 数据层
  final state = Get.find<OriginalNumberLogic>().state;

  /// 底部区域
  Widget bottomArea() {
    return GestureDetector(
      onTap: () => logic.nextStep(),
      child: Container(
        height: 90.dp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48.dp),
          color: paleGreenColor,
        ),
        child: Text(
          "下一步",
          style: TextStyle(fontSize: 30.dp, color: Colors.white),
        ),
      ),
    );
  }

  /// 输入手机号
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
              hintText: "请输入原手机号",

              /// 提示的文本样式
              hintStyle: TextStyle(
                color: greyColor,
                fontSize: 26.dp,
                fontFamily: "PingFang SC",
              ),

              /// 计数文本样式
              counterStyle: const TextStyle(color: Colors.transparent),

              /// 内边距
              contentPadding: EdgeInsets.only(right: 80.dp, left: 45.dp),

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

          /// 清空图标
          Positioned(
              right: 0,
              height: 90.dp,
              child: GetBuilder<OriginalNumberLogic>(builder: (e) {
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

            SizedBox(height: 30.dp),

            /// 底部按钮
            bottomArea(),

            SizedBox(height: 45.dp),
          ],
        ));
  }
}
