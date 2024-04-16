import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';

/// 认证成功页面
class AuthenticationOk extends StatelessWidget {
  AuthenticationOk({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(AuthenticationOkLogic());

  /// 数据层
  final state = Get.find<AuthenticationOkLogic>().state;

  /// 确认按钮
  Widget bottomArea() {
    return GestureDetector(
      onTap: () => print("点击了"),
      child: Container(
        height: 96.dp,
        margin: EdgeInsets.symmetric(horizontal: 125.dp),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48.dp),
          color: paleGreenColor,
        ),
        child: Text(
          "确认",
          style: TextStyle(fontSize: 36.dp, color: Colors.white),
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
        title: const Text("认证成功"),
      ),
      body: Column(
        children: [
          SizedBox(height: 100.dp),
          CachedImage(
            imgUrl: "${RequestApi.imgBaseUrl}authentication.png",
            width: 540.dp,
            height: 274.dp,
          ),
          SizedBox(height: 80.dp),
          Text(
            "认证成功",
            style: TextStyle(
              fontSize: 36.dp,
            ),
          ),
          SizedBox(height: 90.dp),

          /// 确认按钮
          bottomArea(),
        ],
      ),
    );
  }
}
