import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';

/// 系统设置页面
class SystemSetting extends StatelessWidget {
  SystemSetting({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(SystemSettingLogic());

  /// 数据层
  final state = Get.find<SystemSettingLogic>().state;

  /// 列
  Widget line(String title, {required NoParameterCallback onTap ,String? subtitle}) {
    return GestureDetector(
      onTap: () => onTap(),
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30.dp),
        child: Row(
          children: [
            /// 标题
            Text(
              title,
              style: TextStyle(
                fontSize: 30.dp,
              ),
            ),
            Expanded(
                child: subtitle != null
                    ? Text(
                  subtitle,
                  style: TextStyle(
                    color: greyColor,
                    fontSize: 28.dp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                )
                    : const SizedBox()),
            SizedBox(width: 15.dp),
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
        title: const Text("系统设置"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30.dp, vertical: 20.dp),
        children: [
          /// 第一区域
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.dp),
            decoration: BoxDecoration(
              color: blackGrey,
              borderRadius: BorderRadius.circular(14.dp),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                line("个人信息", subtitle: "头像、昵称、实名认证等", onTap: () => logic.goToPersonalData()),
                line("账号安全", subtitle: "修改账号、修改密码、绑定等", onTap: () => logic.goToAccountSecurity()),
                line("黑名单", subtitle: "查看、解除黑名单等", onTap: () => logic.goToBlacklist()),
              ],
            ),
          ),
          SizedBox(height: 30.dp),

          /// 第二区域
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.dp),
            decoration: BoxDecoration(
              color: blackGrey,
              borderRadius: BorderRadius.circular(14.dp),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                line("清空缓存", subtitle: "59.38M", onTap: () => {}),
                line("关于圈达", onTap: () => logic.goToAbout()),
                line("意见反馈", onTap: () => logic.goToFeedback()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
