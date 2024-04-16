import 'package:flutter/material.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

/// 功能事件Widget
class FunctionEvent extends StatelessWidget {
  const FunctionEvent({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  /// 点击事件
  final NoParameterCallback onTap;

  /// 标题
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => onTap(),
          child: Container(
            alignment: Alignment.center,
            height: 96.dp,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 32.dp,
                color: paleGreenColor,
              ),
            ),
          ),
        ),
        /// 下划线
        Divider(
          height: 1.dp,
          thickness: 1.dp,
          color: lightBlackDivider,
        ),
      ],
    );
  }
}
