import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';

/// 自助换绑页面
class ChangeBinding extends StatelessWidget {
  ChangeBinding({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(ChangeBindingLogic());

  /// 数据层
  final state = Get.find<ChangeBindingLogic>().state;

  /// 底部区域
  Widget bottomArea() {
    return GestureDetector(
      onTap: () => logic.nextStep(),
      child: Container(
        height: 96.dp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48.dp),
          color: paleGreenColor,
        ),
        child: Text(
          "下一步：人脸核验",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          /// 回退键
          leading: const BackButton(),
          title: const Text("自助换绑"),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 70.dp),
          children: [
            SizedBox(height: 40.dp),
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

            /// 请输入名字
            SizedBox(
              height: 90.dp,
              child: TextField(
                /// 文本控制器
                controller: state.nameController,

                /// 最大行数
                maxLines: 1,

                /// 监听输入改变的时候
                onChanged: logic.nameChange,

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
                  hintText: "请输入姓名",

                  /// 提示的文本样式
                  hintStyle: TextStyle(
                    color: greyColor,
                    fontSize: 30.dp,
                    fontFamily: "PingFang SC",
                  ),

                  /// 左侧清空图标
                  suffixIcon: GestureDetector(
                    onTap: () => logic.empty(),
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      padding: EdgeInsets.only(right: 60.dp, left: 10.dp),
                      child: Image.asset(
                        "img/Icon/chacha.png",
                        width: 30.dp,
                        height: 30.dp,
                      ),
                    ),
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
              ),
            ),

            SizedBox(height: 26.dp),

            /// 请输入身份证
            SizedBox(
              height: 90.dp,
              child: TextField(
                /// 最大行数
                maxLines: 1,

                /// 监听输入改变的时候
                onChanged: logic.changeID,

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
                  hintText: "请输入身份证号",

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
              ),
            ),

            SizedBox(height: 70.dp),

            /// 底部按钮
            bottomArea(),

            SizedBox(height: 70.dp),

            Text(
              "说明：本流程适用于原注册手机号不再使用，无法获取验证码的情况下，自助进行绑定手机的更换本流程适用于原注册手机号不再使用无法获取验证码的情况下本流程适用于原注册手机号不再使用。",
              style: TextStyle(
                fontSize: 20.dp,
                color: darkGreyColor,
              ),
            ),
          ],
        ));
  }
}
