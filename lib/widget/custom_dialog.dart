import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

/// 自定义对话框
class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    required this.confirm,
    required this.content,
    this.cancel,
    this.cancelText,
    this.confirmText,
    this.tips,
    this.color = const Color.fromRGBO(51, 51, 51, 1),
  }) : super(key: key);

  /// 取消事件
  final NoParameterCallback? cancel;

  /// 取消文本
  final String? cancelText;

  /// 确认文本
  final String? confirmText;

  /// 内容
  final String content;

  /// 提示内容的文本颜色
  final Color color;

  /// 提示内容
  final String? tips;

  /// 确认事件
  final NoParameterCallback confirm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        child: Container(
          width: 500.dp,
          height: 350.dp,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.dp),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.dp),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        content,
                        style: TextStyle(
                          color: color,
                          fontSize: 40.dp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      tips != null ? SizedBox(height: 50.dp) : Container(),

                      /// 提示内容
                      tips != null
                          ? Text(
                              tips!,
                              style: const TextStyle(
                                color: Color.fromRGBO(153, 153, 153, 1),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),

              /// 下划线
              Divider(
                height: 1.dp,
                thickness: 1.dp,
                color: const Color.fromRGBO(238, 238, 238, 1),
              ),

              /// 按钮区域
              Row(
                children: [
                  /// 取消
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                        if (cancel != null) {
                          cancel!();
                        }
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        height: 96.dp,
                        alignment: Alignment.center,
                        child: Text(
                          cancelText ?? "取消",
                          style: TextStyle(
                            color: const Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 36.dp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// 确定
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        Get.back();
                        confirm();
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        height: 96.dp,
                        color: paleGreenColor,
                        alignment: Alignment.center,
                        child: Text(
                          confirmText ?? "确认",
                          style: TextStyle(
                            color: const Color.fromRGBO(51, 51, 51, 1),
                            fontSize: 36.dp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
