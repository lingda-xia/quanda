import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'widget/chatTabView.dart';
import 'widget/remindTabView.dart';

/// 聊天页面
class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 逻辑层
    final logic = Get.put(ChatLogic());

    /// 数据层
    final state = Get.find<ChatLogic>().state;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          /// 左边区域
          leading: Container(
            padding: EdgeInsets.only(left: 160.dp),
          ),

          /// 中间区域
          title: Container(
            /// 水平的padding
            padding: EdgeInsets.only(left: 145.dp, right: 160.dp),
            child: TabBar(
              /// 激活后的文本颜色
              labelColor: const Color.fromRGBO(223, 226, 235, 1),

              /// 激活后的文本样式
              labelStyle: TextStyle(
                fontSize: 36.dp,
                fontWeight: FontWeight.bold,
                fontFamily: "PingFang SC",
              ),

              /// 未激活的文本样式
              unselectedLabelStyle: TextStyle(
                  fontSize: 30.dp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "PingFang SC",
                  color: const Color.fromRGBO(115, 117, 124, 1)),

              /// 标签之间的padding
              labelPadding: const EdgeInsets.symmetric(horizontal: 0.1),

              /// 未激活的颜色
              unselectedLabelColor: const Color.fromRGBO(115, 117, 124, 1),

              /// 指示器颜色
              indicatorColor: Colors.transparent,
              tabs: const <Widget>[
                Tab(text: '聊天'),
                Tab(text: '提醒'),
              ],
            ),
          ),

          /// 右边区域
          actions: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: [
                /// 顶部小人图标
                InkWell(
                  onTap: () {
                    /// 前往通讯录页面
                    logic.goToMailList();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10.dp),
                    child: Image.asset(
                      "img/Icon/mailList.png",
                      width: 34.dp,
                      height: 40.dp,
                    ),
                  ),
                ),

                // /// 小人图标上的红点
                // Positioned(
                //   top: 40.dp,
                //   right: 4.dp,
                //   child: Container(
                //     width: 10.dp,
                //     height: 10.dp,
                //     decoration: const BoxDecoration(
                //       color: Color.fromRGBO(255, 77, 96, 1),
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(5.0),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox(
              width: 40.dp,
            ),
          ],
        ),
        body: TabBarView(children: [
          GetBuilder<ChatLogic>(builder: (_) {

            /// tab选择聊天时的页面  自定义widget
            return ChatTabView(
              getLogic: logic,
              data: state.conversationList,
              notice: state.notice,
            );
          }),

          /// tab选择提醒时的页面  自定义widget
          const RemindTabView(),
        ]),
      ),
    );
  }
}
