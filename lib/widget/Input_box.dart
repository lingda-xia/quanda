import 'package:flutter/material.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/screen.dart';

/// 输入框
class InputBox extends StatelessWidget {
  const InputBox({
    Key? key,
    required this.onTap,
    required this.title
  }) : super(key: key);

  /// 点击跳转到搜索页面
  final NoParameterCallback onTap;

  /// 显示的标题
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 76.dp,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(28, 34, 36, 1),
          borderRadius: BorderRadius.circular(38.dp),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// 搜索图标
            Icon(
              Icons.search,
              color: const Color.fromRGBO(118, 122, 134, 1),
              size: 40.dp,
            ),
            SizedBox(width: 10.dp),
            Text(
              title,
              style: TextStyle(
                color: const Color.fromRGBO(132, 132, 142, 1),
                fontSize: 24.dp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
