import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import '../logic.dart';
import '../state.dart';
import 'bottomPopup.dart';

/// 详情部分
class DetailBox extends StatelessWidget {
  const DetailBox({
    Key? key,
    required this.state,
    required this.logic,
  }) : super(key: key);

  /// 数据源
  final IdleOrderDetailsState state;

  /// 逻辑层
  final IdleOrderDetailsLogic logic;

  /// 灰色边框按钮
  Widget greyButton(String title, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 58.dp,
        padding: EdgeInsets.symmetric(horizontal: 16.dp),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: greyColor,
            width: 2.dp,
          ),
          borderRadius: BorderRadius.circular(29.dp),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: greyColor,
            fontSize: 26.dp,
          ),
        ),
      ),
    );
  }

  /// 禁用按钮
  Widget disableButton(String title) {
    return Container(
      width: 112.dp,
      height: 58.dp,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: darkGreyColor,
        borderRadius: BorderRadius.circular(29.dp),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 26.dp,
        ),
      ),
    );
  }

  /// 按钮区域
  Widget buttonArea(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        /// 同意退款  申请退款状态
        state.data.orderStatus == 4
            ? greyButton(
                "同意退款",
                () => logic.openDialog(
                  "确认是否同意退款",
                  () => logic.agreeRefund(),
                ),
              )
            : Container(),

        SizedBox(width: 30.dp),

        /// 拒绝退款  申请退款状态
        state.data.orderStatus == 4
            ? greyButton(
                "拒绝退款",
                () => logic.openDialog(
                  "确认是否拒绝退款",
                  () => logic.refuseRefund(),
                ),
              )
            : Container(),

        SizedBox(width: 30.dp),

        /// 删除订单
        greyButton(
          "删除订单",
          () => logic.openDialog(
            "是否删除该订单",
            () => logic.idleOrderDel(),
          ),
        ),

        SizedBox(width: 30.dp),

        /// 发货  待发货状态
        state.data.orderStatus == 1
            ? GestureDetector(
                onTap: () {
                  Get.dialog(
                    BottomPopup(
                      data: state,
                      logic: logic,
                    ),

                    /// 打开蒙层
                    barrierDismissible: false,
                  );
                },
                child: Container(
                  height: 58.dp,
                  padding: EdgeInsets.symmetric(horizontal: 30.dp),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("img/Icon/fahuo.png")),
                  ),
                  child: Text(
                    "发货",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.dp,
                    ),
                  ),
                ),
              )
            : Container(),

        /// 已发货
        state.data.orderStatus == 2 ? disableButton("已发货") : Container(),

        /// 已收货
        state.data.orderStatus == 3 ? disableButton("已收货") : Container(),

        /// 申请退款
        state.data.orderStatus == 4 ? disableButton("申请退款") : Container(),

        /// 已退款
        state.data.orderStatus == 5 ? disableButton("已退款") : Container(),

        /// 已结束
        state.data.orderStatus == 5 ? disableButton("已结束") : Container(),
      ],
    );
  }

  /// 手机号码显示处理
  String phone() {
    String str = "";

    if (state.data.userDeliveryInfo != null) {
      str = state.data.userDeliveryInfo!.phone.replaceRange(3, 7, "****");
    }

    return str;
  }

  /// 底部收货地址区域
  Widget bottom() {
    return Container(
      decoration: BoxDecoration(
        color: blackGrey,
        borderRadius: BorderRadius.circular(14.dp),
      ),
      child: Column(
        children: [
          SizedBox(height: 32.dp),
          Row(
            children: [
              Text(
                "收货人信息：",
                style: TextStyle(
                  fontSize: 26.dp,
                ),
              ),
              const Expanded(child: SizedBox()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${state.data.userDeliveryInfo?.contact} ${phone()}",
                    style: TextStyle(
                      fontSize: 26.dp,
                    ),
                  ),
                  SizedBox(height: 10.dp),

                  /// 地区
                  Text(
                    state.data.userDeliveryInfo!.areaAddress,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 22.dp,
                      color: greyColor,
                    ),
                  ),

                  SizedBox(height: 4.dp),

                  /// 详细地址
                  Text(
                    state.data.userDeliveryInfo!.address,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 22.dp,
                      color: greyColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 内容 图片和标题等
  Widget content() {
    return Row(
      children: [
        /// 图片展示
        ClipRRect(
          borderRadius: BorderRadius.circular(4.dp),
          child: CachedImage(
            imgUrl: state.data.mediaUrl,
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
            Container(
              height: 70.dp,
              constraints: BoxConstraints(
                maxWidth: 482.dp,
              ),
              child: Text(
                state.data.goodsTitle,
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
                  "可得圈达币：",
                  style: TextStyle(
                    color: greyColor,
                    fontSize: 24.dp,
                  ),
                ),
                Text(
                  state.data.totalMoney.toString(),
                  style: TextStyle(
                    color: const Color.fromRGBO(246, 209, 60, 1),
                    fontSize: 30.dp,
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  /// 头部部分
  Widget head() {
    return Row(
      children: [
        /// 头像
        ClipRRect(
          borderRadius: BorderRadius.circular(23.dp),
          child: CachedImage(
            imgUrl: state.data.userInfo.avatarUrl == ""
                ? "${RequestApi.baseUrl}/api/static/boy.png"
                : state.data.userInfo.avatarUrl,
            width: 46.dp,
            height: 46.dp,
          ),
        ),

        SizedBox(width: 8.dp),

        /// 名称
        Text(
          state.data.userInfo.nickname,
          style: TextStyle(
            fontSize: 24.dp,
          ),
        ),

        const Expanded(child: SizedBox()),

        Text(
          state.status[state.data.orderStatus],
          style: TextStyle(
            color: greyColor,
            fontSize: 24.dp,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.dp),
      decoration: BoxDecoration(
        color: blackGrey,
        borderRadius: BorderRadius.circular(14.dp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 头部部分
          head(),

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

          SizedBox(height: 30.dp),

          /// 参与时间
          Text(
            "参与时间：${state.data.createTime}",
            style: TextStyle(
              color: darkGreyColor,
              fontSize: 20.dp,
            ),
          ),

          SizedBox(height: 40.dp),

          /// 按钮区域
          buttonArea(context),

          SizedBox(height: 30.dp),

          /// 下划线
          Divider(
            height: 1.dp,
            thickness: 1.dp,
            color: const Color.fromRGBO(44, 48, 47, 1),
          ),

          /// 底部区域  上门自提不显示
          state.data.userDeliveryInfo != null && state.data.logisticsType == 1
              ? bottom()
              : Container(),
        ],
      ),
    );
  }
}
