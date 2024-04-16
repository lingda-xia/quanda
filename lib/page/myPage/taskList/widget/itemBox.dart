import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/publish/TaskOrder.dart';
import 'package:quanda/utils/function/countDown.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import '../logic.dart';
import '../state.dart';

/// 列表的item
class ItemBox extends StatelessWidget {
  const ItemBox({
    Key? key,
    required this.state,
    required this.logic,
    required this.index,
  }) : super(key: key);

  /// 数据源
  final TaskListState state;

  /// 逻辑层
  final TaskListLogic logic;

  /// 列表索引
  final int index;

  /// 倒计时
  /// [date] 参与时间
  /// [taskTime] 任务时长
  String countDown(String date, int taskTime) {
    String time = "0";

    print("参与时间------$date");
    print("任务时长------$taskTime");

    /// 倒计时
    time = CountDown.countDown(date, taskTime * 60 * 1000);

    return time;
  }

  /// 黄色边框按钮
  Widget yellowButton(String title) {
    return GestureDetector(
      onTap: () => {},
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

  /// 内容 图片和标题等
  Widget content(TaskOrder item) {
    return Row(
      children: [
        /// 图片展示
        ClipRRect(
          borderRadius: BorderRadius.circular(4.dp),
          child: CachedImage(
            imgUrl: item.mediaUrl,
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
                  "可得圈达币：",
                  style: TextStyle(
                    color: greyColor,
                    fontSize: 24.dp,
                  ),
                ),
                Text(
                  item.totalMoney.toString(),
                  style: const TextStyle(
                      color: Color.fromRGBO(246, 209, 60, 1),
                      fontFamily: "Rany"),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  /// 头部状态区域
  Widget head(TaskOrder item) {
    Widget widget = Container();

    if(item.orderStatus == 1) {
      widget = Text(
        "待核验",
        style: TextStyle(
          color: const Color.fromRGBO(246, 209, 60, 1),
          fontSize: 24.dp,
        ),
      );
    } else if(item.orderStatus == 2) {
      widget = Text(
        "参与中：剩余${countDown(item.checkTime!, item.taskTime)}秒",
        style: TextStyle(
          color: const Color.fromRGBO(246, 209, 60, 1),
          fontSize: 24.dp,
        ),
      );
    } else if(item.orderStatus == 3) {
      widget = Text(
        "已完成",
        style: TextStyle(
          color: const Color.fromRGBO(82, 84, 90, 1),
          fontSize: 24.dp,
        ),
      );
    } else if(item.orderStatus == 4) {
      widget = Text(
        "已取消",
        style: TextStyle(
          color: const Color.fromRGBO(82, 84, 90, 1),
          fontSize: 24.dp,
        ),
      );
    }

    return widget;
  }

  /// 底部区域
  Widget bottom(TaskOrder item) {
    return Row(
      children: [
        Text(
          "参与时间：${item.createTime}",
          style: TextStyle(
            color: darkGreyColor,
            fontSize: 20.dp,
          ),
        ),

        const Expanded(child: SizedBox()),

        /// 未参与状态
        item.orderStatus == 1 ? lightGreyButton("未参与", () {}) : Container(),

        SizedBox(width: 30.dp),

        /// 已完成状态
        item.orderStatus == 3 ? lightGreyButton("已完成", () {}) : Container(),

        /// 参与中状态
        item.orderStatus == 2 ? yellowButton("参与中") : Container(),

        /// 私聊按钮
        item.orderStatus == 1
            ? GestureDetector(
          onTap: () =>
              logic.goToPrivateChat(item.userId, item.userInfo.nickname),
          child: Image.asset(
            "img/Icon/privateLetter.png",
            width: 60.dp,
            height: 60.dp,
          ),
        )
            : Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    /// 列表item
    TaskOrder item = state.list[index];

    return Container(
      padding: EdgeInsets.all(30.dp),
      margin: EdgeInsets.only(bottom: 30.dp),
      decoration: BoxDecoration(
        color: blackGrey,
        borderRadius: BorderRadius.circular(14.dp),
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
              SizedBox(width: 8.dp),

              /// 名称
              Text(
                item.userInfo.nickname,
                style: TextStyle(
                  fontSize: 24.dp,
                ),
              ),
              const Expanded(child: SizedBox()),

              /// 头部右边的区域
              head(item),
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

          SizedBox(height: 40.dp),

          /// 底部区域
          bottom(item),
        ],
      ),
    );
  }
}
