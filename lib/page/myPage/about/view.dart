import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';

/// 关于圈达页面
class About extends StatelessWidget {
  About({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(AboutLogic());

  /// 数据层
  final state = Get.find<AboutLogic>().state;

  /// 列
  Widget line(String title, {required NoParameterCallback onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30.dp, horizontal: 30.dp),
        child: Row(
          children: [
            /// 标题
            Text(
              title,
              style: TextStyle(
                fontSize: 30.dp,
              ),
            ),
            const Expanded(child: SizedBox()),
            Icon(
              Icons.chevron_right,
              size: 50.dp,
              color: greyColor,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("关于圈达"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 当前版本
          Container(
            padding: EdgeInsets.symmetric(vertical: 30.dp, horizontal: 30.dp),
            child: Row(
              children: [
                /// 标题
                Text(
                  "当前版本",
                  style: TextStyle(
                    fontSize: 30.dp,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Text(
                  "8.23",
                  style: TextStyle(
                    color: greyColor,
                    fontSize: 28.dp,
                  ),
                ),
              ],
            ),
          ),
          line("用户协议", onTap: () => logic.goToPersonalData()),
          line("隐私政策", onTap: () => logic.goToPersonalData()),
          line("相关许可证", onTap: () => logic.goToBlacklist()),
        ],
      ),
    );
  }
}
