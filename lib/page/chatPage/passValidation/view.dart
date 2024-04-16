import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';

/// 通过验证页面
class PassValidation extends StatelessWidget {
  PassValidation({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(PassValidationLogic());

  /// 数据层
  final state = Get.find<PassValidationLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("通过验证"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.dp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 设置备注
            Text(
              "设置备注",
              style: TextStyle(
                fontSize: 30.dp,
              ),
            ),
            SizedBox(height: 20.dp),

            /// 输入备注 输入框
            ClipRRect(
              borderRadius: BorderRadius.circular(10.dp),
              child: TextField(
                /// 控制器
                controller: state.textController,

                /// 最大行数
                maxLines: 1,

                /// 监听输入改变的时候
                onChanged: logic.onSearch,

                /// 输入的文本样式
                style: TextStyle(
                  color: themeWhite,
                  fontSize: 28.dp,
                ),

                /// 光标颜色
                cursorColor: themeWhite,

                /// 将确定按钮换为完成
                textInputAction: TextInputAction.done,

                /// 装饰
                decoration: InputDecoration(
                  /// 未输入时提示的内容
                  hintText: "请输入备注",

                  /// 提示的文本样式
                  hintStyle: TextStyle(
                    color: greyColor,
                    fontSize: 28.dp,
                    fontFamily: "PingFang SC",
                  ),

                  /// 内边距
                  contentPadding: EdgeInsets.symmetric(horizontal: 35.dp),

                  /// 是否填充
                  filled: true,

                  /// 填充的颜色  类似背景颜色
                  fillColor: blackGrey,

                  /// 边框
                  border: InputBorder.none,
                ),
              ),
            ),

            SizedBox(height: 50.dp),

            /// 设置标签
            Text(
              "设置标签",
              style: TextStyle(
                fontSize: 30.dp,
              ),
            ),
            SizedBox(height: 20.dp),

            /// 添加标签
            GestureDetector(
              /// 前往选择标签页
              onTap: () => logic.goToSelectLabel(),
              behavior: HitTestBehavior.translucent,
              child: Container(
                height: 100.dp,
                padding: EdgeInsets.symmetric(horizontal: 35.dp),
                decoration: BoxDecoration(
                  color: blackGrey,
                  borderRadius: BorderRadius.circular(10.dp),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder<PassValidationLogic>(builder: (_) {
                      return Text(
                        state.label,
                        style: TextStyle(
                          color: greyColor,
                          fontSize: 28.dp,
                        ),
                      );
                    }),
                    Icon(
                      Icons.chevron_right,
                      color: iconColor,
                      size: 40.dp,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 150.dp),

            /// 通过验证
            GestureDetector(
              onTap: logic.agreeFriend,
              behavior: HitTestBehavior.translucent,
              child: Container(
                height: 96.dp,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: paleGreenColor,
                  borderRadius: BorderRadius.circular(10.dp),
                ),
                child: Text(
                  "通过验证",
                  style: TextStyle(
                    fontSize: 36.dp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
