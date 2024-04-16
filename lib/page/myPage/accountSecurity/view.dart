import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';

/// 账号安全页面
class AccountSecurity extends StatelessWidget {
  AccountSecurity({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(AccountSecurityLogic());

  /// 数据层
  final state = Get.find<AccountSecurityLogic>().state;

  /// 列
  Widget line(String title,
      {required NoParameterCallback onTap, String? subtitle}) {
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
        title: const Text("账号安全"),
      ),
      body: GetBuilder<AccountSecurityLogic>(
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              line("手机号",
                  subtitle: state.info.phone,
                  onTap: () => logic.goToChangeNumber()),
              line("登录密码",
                  subtitle: "未设置", onTap: () => logic.goToSetPassword()),
              line("注销账号", onTap: () => logic.goToAccountCancellation()),
            ],
          );
        },
      ),
    );
  }
}
