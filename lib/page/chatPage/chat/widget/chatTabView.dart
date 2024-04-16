import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/chat/NoticeEntity.dart';
import 'package:quanda/page/chatPage/tencent_im/conversation_logic.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:get/get.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';

import '../logic.dart';
import '../state.dart';

/// 聊天页面的顶部tab 聊天
class ChatTabView extends StatelessWidget {
  ChatTabView(
      {Key? key,
      required this.getLogic,
      required this.data,
      required this.notice})
      : super(key: key);

  /// 逻辑层
  final ChatLogic getLogic;

  /// 系统通知
  final NoticeEntity notice;

  /// 会话列表
  final List<V2TimConversation?> data;

  /// 腾讯im逻辑层
  final state = Get.find<ConversationLogic>().state;

  /// 系统通知时间转换
  String change() {
    String str = "";

    if(notice.createTime != null) {
      int value = DateTime.parse(notice.createTime!).millisecondsSinceEpoch;

      final time = DateTime.fromMillisecondsSinceEpoch(value);

      str = "${time.hour}:${time.minute}";
    }

    return str;
  }

  /// 系统通知
  Widget noticeView() {
    return GetBuilder<ConversationLogic>(builder: (_) {
      return GestureDetector(
        onTap: getLogic.goToSystemNotice,
        behavior: HitTestBehavior.translucent,
        child: Container(
          margin: EdgeInsets.only(bottom: 20.dp),
          child: Row(
            children: [
              /// 头像
              CircleAvatar(
                radius: 50.dp,

                /// 为加载成功时显示的背景色
                backgroundColor: Colors.white,
                backgroundImage: const AssetImage(
                    "img/bigIcon/system_notification.png"),
              ),

              SizedBox(
                width: 30.dp,
              ),

              /// 会话标题和内容
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "系统通知",
                        style: TextStyle(
                          fontSize: 30.dp,
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Text(
                        change(),
                        style: TextStyle(
                          fontSize: 24.dp,
                          color: const Color.fromRGBO(64, 67, 73, 1),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 18.dp),

                  Text(
                    notice.info.isNotEmpty ? notice.info : "暂无系统通知",
                    style: TextStyle(
                      fontSize: 24.dp,
                      color: const Color.fromRGBO(64, 67, 73, 1),
                    ),
                    maxLines: 1,
                  ),
                  SizedBox(height: 30.dp),

                  /// 下划线
                  Divider(
                    height: 1.dp,
                    color: const Color.fromRGBO(22, 28, 30, 1),
                  ),
                ],
              )),
            ],
          ),
        ),
      );
    });
  }

  /// 会话列表
  Widget listItem(V2TimConversation? item) {
    return GestureDetector(
      onTap: () => getLogic.goToPrivateChat(
        item?.userID.toString() ?? "",
        item?.showName.toString() ?? "用户名称",
      ),
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.dp),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                /// 头像
                CircleAvatar(
                  radius: 50.dp,

                  /// 为加载成功时显示的背景色
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(item?.faceUrl == ""
                      ? "${RequestApi.baseUrl}/api/static/boy.png"
                      : item?.faceUrl ?? "${RequestApi.baseUrl}/api/static/boy.png"),
                ),

                /// 红点
                item?.unreadCount == 0
                    ? Container()
                    : Positioned(
                        top: -4.dp,
                        right: 4.dp,
                        child: Container(
                          width: 30.dp,
                          height: 30.dp,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.dp),
                            color: const Color.fromRGBO(255, 77, 96, 1),
                          ),
                          child: Text(
                            item?.unreadCount.toString() ?? "0",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.dp,
                            ),
                          ),
                        ),
                      ),
              ],
            ),

            SizedBox(
              width: 30.dp,
            ),

            /// 会话标题和内容
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.dp),
                Row(
                  children: [
                    Text(
                      item?.showName ?? "用户名称",
                      style: TextStyle(
                        fontSize: 30.dp,
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                      getLogic.timeChange(item?.lastMessage!.timestamp ?? 0),
                      style: TextStyle(
                        fontSize: 24.dp,
                        color: const Color.fromRGBO(64, 67, 73, 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.dp),

                /// 文本消息
                Visibility(
                  visible: item?.lastMessage!.textElem != null,
                  child: Text(
                    item?.lastMessage!.textElem?.text ?? "",
                    style: TextStyle(
                      fontSize: 24.dp,
                      color: const Color.fromRGBO(64, 67, 73, 1),
                    ),
                    maxLines: 1,
                  ),
                ),

                /// 图片消息
                Visibility(
                  visible: item?.lastMessage!.imageElem != null,
                  child: Text(
                    "[图片]",
                    style: TextStyle(
                      fontSize: 24.dp,
                      color: const Color.fromRGBO(64, 67, 73, 1),
                    ),
                    maxLines: 1,
                  ),
                ),

                SizedBox(height: 30.dp),

                /// 下划线
                Divider(
                  height: 1.dp,
                  color: const Color.fromRGBO(22, 28, 30, 1),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(30.dp),
      children: [
        ///  系统通知
        noticeView(),

        /// 会话列表
        GetBuilder<ConversationLogic>(builder: (_) {
          return Column(
            children: [
              for (int i = 0; i < state.conversationList.length; i++)
                listItem(state.conversationList[i])
            ],
          );
        }),
      ],
    );
  }
}
