import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';

/// 核验码页面createTime
class VerificationCode extends StatelessWidget {
  VerificationCode({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(VerificationCodeLogic());

  /// 数据层
  final state = Get.find<VerificationCodeLogic>().state;

  /// 内容 图片和标题等
  Widget content() {
    return Row(
      children: [
        /// 图片展示
        ClipRRect(
          borderRadius: BorderRadius.circular(4.dp),
          child: CachedImage(
            imgUrl: state.info.goodsImgUrl,
            width: 116.dp,
            height: 116.dp,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 20.dp),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 标题
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 482.dp,
                minHeight: 60.dp,
              ),
              child: Text(
                state.info.goodsTitle,
                style: TextStyle(
                  fontSize: 28.dp,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 12.dp),

            /// 可获得圈达币
            Row(
              children: [
                Text(
                  state.type == "1" ? "可赚圈达币：" : "圈达币：",
                  style: TextStyle(
                    color: greyColor,
                    fontSize: 24.dp,
                  ),
                ),
                Text(
                  state.info.money.toString(),
                  style: TextStyle(
                    color: const Color.fromRGBO(246, 209, 60, 1),
                    fontSize: 30.dp,
                    fontFamily: "Rany",
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("核验码"),
      ),
      body: ListView(
        padding: EdgeInsets.all(30.dp),
        children: [
          /// 二维码
          Container(
            decoration: BoxDecoration(
              color: blackGrey,
              borderRadius: BorderRadius.circular(14.dp),
            ),
            padding: EdgeInsets.symmetric(vertical: 20.dp),
            alignment: Alignment.center,
            child: Column(
              children: [
                /// 二维码绘制
                GetBuilder<VerificationCodeLogic>(builder: (_) {
                  /// 生成二维码
                  QrPainter qrFutureBuilder = QrPainter(
                    emptyColor: Colors.white,
                    data:
                        "code=${state.info.checkCode},id=${state.info.sourceOrderId},rid=${state.info.releaseId},type=${state.info.type}",
                    version: QrVersions.auto,
                    gapless: true,
                  );

                  return Container(
                    width: 240.dp,
                    height: 240.dp,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: CustomPaint(
                      size: Size.square(220.dp),
                      painter: qrFutureBuilder,
                    ),
                  );
                }),

                SizedBox(height: 10.dp),
                Text(
                  "核验码",
                  style: TextStyle(
                    color: greyColor,
                    fontSize: 24.dp,
                  ),
                ),
                SizedBox(height: 8.dp),
              ],
            ),
          ),

          SizedBox(height: 25.dp),

          /// 订单信息
          GetBuilder<VerificationCodeLogic>(builder: (_) {
            return Container(
              padding: EdgeInsets.only(
                  left: 30.dp, right: 30.dp, top: 20.dp, bottom: 30.dp),
              margin: EdgeInsets.only(bottom: 20.dp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.dp),
                color: blackGrey,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 用户头像和名称以及右边区域
                  Row(
                    children: [
                      /// 头像
                      ClipRRect(
                        borderRadius: BorderRadius.circular(23.dp),
                        child: CachedImage(
                          imgUrl: state.info.userInfo.avatarUrl == ""
                              ? "${RequestApi.baseUrl}/api/static/boy.png"
                              : state.info.userInfo.avatarUrl,
                          width: 46.dp,
                          height: 46.dp,
                          fit: BoxFit.cover,
                        ),
                      ),

                      SizedBox(width: 10.dp),

                      /// 名称
                      Text(
                        state.info.userInfo.nickname,
                        style: TextStyle(
                          fontSize: 24.dp,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),

                  SizedBox(height: 10.dp),

                  /// 下划线
                  Divider(
                    height: 1.dp,
                    thickness: 1.dp,
                    color: const Color.fromRGBO(44, 48, 47, 1),
                  ),

                  SizedBox(height: 20.dp),

                  /// 内容 图片和标题等
                  content(),

                  SizedBox(height: 20.dp),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      /// 下单时间
                      Text(
                        "下单时间：${state.info.createTime}",
                        style: TextStyle(
                          color: darkGreyColor,
                          fontSize: 20.dp,
                        ),
                      ),

                      /// 私聊按钮
                      GestureDetector(
                        onTap: logic.goToPrivateChat,
                        child: Image.asset(
                          "img/Icon/privateLetter.png",
                          width: 60.dp,
                          height: 60.dp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),

          /// 温馨提示
          Container(
            decoration: BoxDecoration(
              color: blackGrey,
              borderRadius: BorderRadius.circular(14.dp),
            ),
            padding: EdgeInsets.all(25.dp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "温馨提示：",
                  style: TextStyle(
                    fontSize: 30.dp,
                  ),
                ),
                SizedBox(height: 20.dp),
                Text(
                  "闲置互动：联系发布者，提供核验码，扫码核验后，商量获得。",
                  style: TextStyle(
                    fontSize: 22.dp,
                    color: greyColor,
                  ),
                ),
                Text(
                  "任务互动：到任务点出示核验码，核验完成后即可参与任务。",
                  style: TextStyle(
                    fontSize: 22.dp,
                    color: greyColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
