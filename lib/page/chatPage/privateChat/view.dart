import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/page/chatPage/privateChat/widget/chatInput.dart';
import 'package:quanda/page/chatPage/tencent_im/msg_logic.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'logic.dart';
import 'widget/leftChatBox.dart';
import 'widget/rightChatBox.dart';

/// 单聊页面
class PrivateChat extends StatelessWidget {
  PrivateChat({Key? key}) : super(key: key);

  /// 逻辑层
  final logic = Get.put(PrivateChatLogic());

  /// 数据层
  final state = Get.find<PrivateChatLogic>().state;

  /// 腾讯im 聊天 数据层
  final msg = Get.find<MsgLogic>().state;

  /// 获取聊天的时间
  String getTimeForMessage(int timeStamp) {
    var nowTime = DateTime.now();
    nowTime = DateTime(nowTime.year, nowTime.month, nowTime.day);
    var fTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    final String timeStr = "${fTime.hour}:${fTime.minute}";
    // 一年外 年月日 + 时间
    if (nowTime.year != fTime.year) {
      return '${fTime.year}-${fTime.month}-${fTime.day} $timeStr';
    }
    // 一年内一周外 月日 + 时间
    if (fTime.isBefore(nowTime.subtract(const Duration(days: 7)))) {
      return '${fTime.month}-${fTime.day} $timeStr';
    }
    // 一周内一天外 星期 + 时间
    if (fTime.isBefore(nowTime.subtract(const Duration(days: 1)))) {
      return '${state.weekdayList[fTime.weekday]} $timeStr';
    }
    // 昨日 昨天 + 时间
    if (nowTime.day != fTime.day) {
      return '昨天 $timeStr';
    }
    // 同年月日 时间
    return timeStr;
  }

  /// 信息列表item
  Widget listItem(List<V2TimMessage> list, int index) {

    /// 消息列表item
    final V2TimMessage item = list[index];

    /// 是否显示时间
    late bool show = true;

    /// 如果不是最后一条消息
    if(index != list.length - 1) {

      /// 上一条发送的消息时间戳  秒
      final int previous = list[index + 1].timestamp!;
      /// 该条消息发送时间
      final int current = list[index].timestamp!;

      /// 限制两分钟内显示同一时间
      show = current > (previous + 120);
    }

    /// 主要内容
    Widget content = Container();

    late Widget widget = Column(
      children: [
        show
            ? Container(
                margin: EdgeInsets.symmetric(vertical: 20.dp),
                child: Text(
                  getTimeForMessage(item.timestamp!),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color.fromRGBO(115, 117, 124, 1),
                    fontSize: 24.dp,
                  ),
                ),
              )
            : Container(),
        content,
      ],
    );

    /// 发送者是否是自己
    bool self = item.isSelf ?? false;

    if (self) {
      content = RightChatBox(
        data: item,
      );
    } else {
      content = LeftChatBox(
        data: item,
      );
    }

    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: GetBuilder<PrivateChatLogic>(
          builder: (_) {
            return Text(state.name);
          },
        ),
      ),

      /// 安全区域
      body: SafeArea(
        child: Column(
          children: [
            /// 聊天列表
            Expanded(
              child: GetBuilder<MsgLogic>(
                builder: (_) {
                  /// 消息列表
                  final list = msg.messageListMap[state.id] ?? [];

                  return EasyRefresh(
                    /// 控制器
                    controller: state.controller,

                    /// 头部
                    footer: CupertinoFooter(
                      foregroundColor: Colors.white,
                      emptyWidget: Text(
                        "没有更多数据了",
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 24.dp,
                        ),
                      ),
                    ),
                    onLoad: () async {
                      await logic.onLoad();
                    },

                    child: ListView.builder(
                      controller: state.listController,
                      padding: EdgeInsets.all(30.dp),
                      reverse: true,
                      itemBuilder: (context, index) {
                        return listItem(list, index);
                      },
                      itemCount: list.length,
                    ),
                  );
                },
              ),
            ),

            /// 聊天输入框
            ChatInput(
              /// 数据源
              data: state,

              logic: logic,
            ),
          ],
        ),
      ),
    );
  }
}
