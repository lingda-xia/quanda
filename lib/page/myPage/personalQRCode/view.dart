import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';
import 'dart:ui' as ui;

import 'logic.dart';

/// 个人二维码页面
class PersonalQRCode extends StatelessWidget {
  PersonalQRCode({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(PersonalQRCodeLogic());

  /// 数据层
  final state = Get.find<PersonalQRCodeLogic>().state;

  /// 底部按钮
  Widget bottomArea() {
    return GestureDetector(
      /// 关闭页面
      onTap: () => logic.closePage(),
      child: Container(
        width: 300.dp,
        height: 96.dp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.dp),
          color: paleGreenColor,
        ),
        child: Text(
          "关闭页面",
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
          title: const Text("个人二维码"),
        ),
        body: Column(
          children: [
            SizedBox(height: 130.dp),

            GetBuilder<PersonalQRCodeLogic>(builder: (_) {
              /// 二维码生成
              final qrFutureBuilder = QrPainter(
                emptyColor: Colors.white,
                data: "userId=${state.info.userId}",
                version: QrVersions.auto,
                gapless: true,
              );

              return Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 582.dp,
                    margin: EdgeInsets.symmetric(horizontal: 84.dp),
                    padding: EdgeInsets.all(30.dp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.dp),
                      color: blackGrey,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 60.dp),

                        /// 用户名称
                        Text(
                          state.info.nickname,
                          style: TextStyle(
                            fontSize: 36.dp,
                          ),
                        ),
                        SizedBox(height: 30.dp),

                        /// 二维码绘制
                        Visibility(
                          visible: state.qrcodeStatus == 1,
                          child: Container(
                            width: 380.dp,
                            height: 380.dp,
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: CustomPaint(
                              size: Size.square(350.dp),
                              painter: qrFutureBuilder,
                            ),
                          ),
                        ),

                        SizedBox(height: 20.dp),

                        Text(
                          "未开启二维码添加功能",
                          style: TextStyle(
                            fontSize: 26.dp,
                            color: greyColor,
                          ),
                        ),

                        SizedBox(height: 10.dp),

                        Text(
                          "可以在设置>隐私设置>添加我的方式里打允许",
                          style: TextStyle(
                            fontSize: 26.dp,
                            color: greyColor,
                          ),
                        ),

                        /// 保存二维码
                        Visibility(
                          visible: state.qrcodeStatus == 1,
                          child: GestureDetector(
                            onTap: () =>
                                logic.requestPermission(qrFutureBuilder),
                            behavior: HitTestBehavior.translucent,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: 30.dp),
                              child: Text(
                                "保存二维码",
                                style: TextStyle(
                                  fontSize: 30.dp,
                                  color: paleGreenColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 用户头像
                  Positioned(
                    top: -60.dp,
                    child: CircleAvatar(
                      radius: 65.dp,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(state.info.avatarUrl == ""
                          ? "${RequestApi.baseUrl}/api/static/boy.png"
                          : state.info.avatarUrl),
                    ),
                  ),
                ],
              );
            }),

            SizedBox(height: 180.dp),

            /// 底部按钮
            bottomArea(),
          ],
        ));
  }
}
