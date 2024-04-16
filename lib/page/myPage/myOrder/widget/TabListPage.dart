import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/refreshLoading/view.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/personal/OrderEntity.dart';
import 'package:quanda/utils/function/countDown.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import '../logic.dart';
import '../state.dart';

/// tab列表页面
class TabListPage extends StatefulWidget {
  const TabListPage({
    Key? key,
    required this.data,
    required this.logic,
    required this.status,
  }) : super(key: key);

  /// 数据源
  final MyOrderState data;

  /// 逻辑层
  final MyOrderLogic logic;

  /// 订单状态
  final int status;

  @override
  State<TabListPage> createState() => _TabListPageState();
}

class _TabListPageState extends State<TabListPage>
    with AutomaticKeepAliveClientMixin {
  /// 倒计时
  String countDown(String date) {
    String time = "0";

    /// 倒计时  预留支付时间 300秒
    time = CountDown.countDown(date, 300 * 1000);

    return time;
  }

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

  /// 淡灰色边框按钮
  Widget lightGreyButton(String title, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 58.dp,
        padding: EdgeInsets.symmetric(horizontal: 20.dp),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromRGBO(82, 84, 90, 1),
            width: 2.dp,
          ),
          borderRadius: BorderRadius.circular(29.dp),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: const Color.fromRGBO(82, 84, 90, 1),
            fontSize: 26.dp,
          ),
        ),
      ),
    );
  }

  /// 禁用按钮
  Widget disableButton(String title, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
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
      ),
    );
  }

  /// 黄色边框按钮
  Widget yellowButton(String title, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 58.dp,
        padding: EdgeInsets.symmetric(horizontal: 16.dp),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromRGBO(246, 209, 60, 1),
            width: 2.dp,
          ),
          borderRadius: BorderRadius.circular(29.dp),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: const Color.fromRGBO(246, 209, 60, 1),
            fontSize: 26.dp,
          ),
        ),
      ),
    );
  }

  /// 黄色背景按钮
  Widget yellowBgButton(String title, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 120.dp,
        height: 58.dp,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("img/Icon/fahuo.png")),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 26.dp,
          ),
        ),
      ),
    );
  }

  /// 任务状态头部
  Widget taskHead(OrderEntity item) {
    Widget widget = Container();

    if (item.orderStatus == 1) {
      widget = Text(
        "待参加",
        style: TextStyle(
          fontSize: 24.dp,
          color: orange,
        ),
      );
    } else if (item.orderStatus == 2) {
      widget = Text(
        "核验完成",
        style: TextStyle(
          fontSize: 24.dp,
          color: orange,
        ),
      );
    } else if (item.orderStatus == 3) {
      widget = Text(
        "已完成",
        style: TextStyle(
          fontSize: 24.dp,
          color: const Color.fromRGBO(82, 84, 90, 1),
        ),
      );
    } else if (item.orderStatus == 6) {
      widget = Text(
        "已取消",
        style: TextStyle(
          fontSize: 24.dp,
          color: const Color.fromRGBO(82, 84, 90, 1),
        ),
      );
    }

    return widget;
  }

  /// 闲置状态头部  todo 待优化
  Widget idleHead(OrderEntity item) {
    Widget widget = Container();

    if (item.orderStatus == 0) {
      widget = Text(
        "待支付：剩余${countDown(item.createTime)}秒",
        style: TextStyle(
          fontSize: 24.dp,
          color: orange,
        ),
      );
    } else if (item.orderStatus == 1) {
      widget = Text(
        "等待卖家发货",
        style: TextStyle(
          fontSize: 24.dp,
          color: greyColor,
        ),
      );
    } else if (item.orderStatus == 2) {
      widget = Text(
        "待收货",
        style: TextStyle(
          fontSize: 24.dp,
          color: greyColor,
        ),
      );
    } else if (item.orderStatus == 3) {
      widget = Text(
        "已收货",
        style: TextStyle(
          fontSize: 24.dp,
          color: greyColor,
        ),
      );
    } else if (item.orderStatus == 5) {
      widget = Text(
        "已退款",
        style: TextStyle(
          fontSize: 24.dp,
          color: const Color.fromRGBO(82, 84, 90, 1),
        ),
      );
    } else if (item.orderStatus == 6) {
      widget = Text(
        "已取消",
        style: TextStyle(
          fontSize: 24.dp,
          color: const Color.fromRGBO(82, 84, 90, 1),
        ),
      );
    }

    return widget;
  }

  /// 任务区域
  Widget taskArea(OrderEntity item) {
    return Row(
      children: [
        /// 下单时间
        Text(
          "下单时间：${item.createTime}",
          style: TextStyle(
            color: darkGreyColor,
            fontSize: 20.dp,
          ),
        ),

        const Expanded(child: SizedBox()),

        /// 未参与状态
        item.orderStatus == 1
            ? greyButton(
                "取消任务",
                () => widget.logic.openDialog(
                  "是否取消该任务",
                  "取消后将无法再次接下该任务",
                  () => widget.logic
                      .cancelOrder(item.id.toString(), widget.status),
                ),
              )
            : Container(),

        SizedBox(width: 30.dp),

        /// 未参与状态
        item.orderStatus == 1
            ? yellowBgButton(
                "核验码",
                () => widget.logic
                    .goToVerificationCode(item.orderType, item.sourceOrderId))
            : Container(),

        /// 未参与状态
        item.orderStatus == 2 ? yellowButton("参与中", () {}) : Container(),

        /// 已完成状态
        item.orderStatus == 3 ? lightGreyButton("已完成", () {}) : Container(),
      ],
    );
  }

  /// 闲置区域
  Widget idleArea(OrderEntity item) {
    return Row(
      children: [
        /// 下单时间
        Text(
          "下单时间：${item.createTime}",
          style: TextStyle(
            color: darkGreyColor,
            fontSize: 20.dp,
          ),
        ),

        const Expanded(child: SizedBox()),

        /// 代发货状态
        item.orderStatus == 0
            ? greyButton(
                "取消订单",
                () => widget.logic.openDialog(
                  "是否取消该订单",
                  "取消后将无法再次购买该订单",
                  () => widget.logic
                      .cancelOrder(item.id.toString(), widget.status),
                ),
              )
            : Container(),

        /// 代收货状态 和 代发货状态
        item.orderStatus == 2 || item.orderStatus == 1
            ? greyButton(
                /// 是否已申请退款
                item.refundStatus == 1 ? "申请中" : "申请退款",
                item.refundStatus == 1
                    ? () {}
                    : () => widget.logic.openDialog(
                          "是否申请退款",
                          "若遇退款纠纷请于平台反馈",
                          () => widget.logic.refundOrder(item.id.toString()),
                        ),
              )
            : Container(),

        SizedBox(width: 20.dp),

        /// 已退款状态
        item.orderStatus == 5 ? lightGreyButton("已经退款", () {}) : Container(),

        /// 代收货状态
        item.orderStatus == 2
            ? GestureDetector(
                onTap: () => widget.logic.openDialog(
                  "是否确认收货",
                  "确认后您的付款将直接打给卖家",
                  () => widget.logic
                      .idleOrderConfirm(item.sourceOrderId.toString()),
                ),
                child: Container(
                  width: 136.dp,
                  height: 58.dp,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("img/Icon/confirm.png")),
                  ),
                  child: Text(
                    "确认收货",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.dp,
                    ),
                  ),
                ),
              )
            : Container(),

        /// 代发货状态
        item.orderStatus == 1
            ? yellowBgButton(
                "核验码",
                () => widget.logic
                    .goToVerificationCode(item.orderType, item.sourceOrderId),
              )
            : Container(),

        /// 代发货状态
        item.orderStatus == 0
            ? yellowBgButton(
                "付款",
                () => widget.logic.openPayment(
                    item.sourceOrderId, item.totalMoney.toString()),
              )
            : Container(),
      ],
    );
  }

  /// 内容 图片和标题等
  Widget content(OrderEntity item) {
    return Row(
      children: [
        /// 图片展示
        ClipRRect(
          borderRadius: BorderRadius.circular(4.dp),
          child: CachedImage(
            imgUrl: item.mediaList[0].filePath,
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
                item.goodsTitle,
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
                  item.orderType == 1 ? "可赚圈达币：" : "圈达币：",
                  style: TextStyle(
                    color: greyColor,
                    fontSize: 24.dp,
                  ),
                ),
                Text(
                  item.totalMoney.toString(),
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

  /// 列表的item
  Widget item(OrderEntity item) {
    return GestureDetector(
      /// 前往详情页
      onTap: () => {},
      child: Container(
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
                    imgUrl: item.userInfo.avatarUrl == ""
                        ? "${RequestApi.baseUrl}/api/static/boy.png"
                        : item.userInfo.avatarUrl,
                    width: 46.dp,
                    height: 46.dp,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10.dp),

                /// 名称
                Text(
                  item.userInfo.nickname,
                  style: TextStyle(
                    fontSize: 24.dp,
                  ),
                ),
                const Expanded(child: SizedBox()),

                /// 任务状态头部
                Visibility(
                  visible: item.orderType == 1,
                  child: taskHead(item),
                ),

                /// 闲置状态头部
                Visibility(
                  visible: item.orderType == 2,
                  child: idleHead(item),
                ),
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
            content(item),

            /// 任务状态  和 待参加状态 显示
            Visibility(
              visible: item.orderType == 1 && item.orderStatus == 1,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  "请前往商家任务地点出示",
                  style: TextStyle(
                    color: const Color.fromRGBO(247, 145, 45, 1),
                    fontSize: 24.dp,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.dp),

            /// 任务区域
            Visibility(
              visible: item.orderType == 1,
              child: taskArea(item),
            ),

            /// 闲置区域
            Visibility(
              visible: item.orderType == 2,
              child: idleArea(item),
            ),
          ],
        ),
      ),
    );
  }

  /// 用于重置列表
  Widget reload(Function reset) {
    return GetBuilder<MyOrderLogic>(builder: (_) {
      /// 如果状态改变  重置列表
      if (widget.data.reload[widget.status] ?? false) {
        reset();
      }
      return Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    /// 页面保活
    super.build(context);

    print("----------${widget.status}");

    /// 刷新和加载组件  自定义widget
    return RefreshLoad(
      /// 初始化请求
      init: (page) => widget.logic.getList(widget.status, page),

      /// 用于重置列表
      resetList: (reset) => reload(reset),

      /// 加载为空的提示
      emptyTips: "暂无订单~",

      /// 加载为空的图片widget
      emptyWidget: Image.asset(
        "img/bigIcon/order_empty.png",
        width: 400.dp,
        height: 270.dp,
      ),

      child: GetBuilder<MyOrderLogic>(builder: (_) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 35.dp),
          children: [
            for (int i = 0; i < widget.data.listMap[widget.status]!.length; i++)
              item(widget.data.listMap[widget.status]![i])
          ],
        );
      }),
    );
  }

  /// 页面保活
  @override
  bool get wantKeepAlive => true;
}
