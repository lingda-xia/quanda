import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/chat_list_view.dart';

import 'logic.dart';

/// 临时会话页面
class TemporarySession extends StatelessWidget {
  TemporarySession({Key? key}) : super(key: key);

  /// 逻辑层
  final logic = Get.put(SessionLogic());

  /// 数据层
  final state = Get.find<SessionLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("临时会话"),
      ),
      body: ListView(
        padding: EdgeInsets.all(30.dp),
        children: [
          /// 会话列表的item  自定义widget
          ChatListView(
            /// 会话信息
            sessionInfo: const {
              "imgUrl": "${RequestApi.imgBaseUrl}temporary_session.png",
              "title": "临时会话",
            },
            /// 前往
            onTap: (){
            },
          ),
          /// 会话列表的item  自定义widget
          ChatListView(
            /// 会话信息
            sessionInfo: const {
              "imgUrl": "${RequestApi.imgBaseUrl}temporary_session.png",
              "title": "临时会话",
            },
            /// 前往
            onTap: (){
            },
          ),
        ],
      ),
    );
  }
}
