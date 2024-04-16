import 'dart:async';

import 'package:get/get.dart';
import 'package:quanda/api/chat.dart';
import 'package:quanda/model/LongList.dart';
import 'package:quanda/model/chat/SystemMsg.dart';
import 'state.dart';

/// 系统通知 逻辑层
class NoticeLogic extends GetxController {
  final NoticeState state = NoticeState();

  /// 获取互动列表
  Future<LongList> getList(int page) {
    /// 等待请求完成
    Completer<LongList> completer = Completer();

    /// 发起请求
    ChatRequest.systemMsgList(
        page: page,
        success: (data) {
          /// 重置列表状态关闭
          state.reload = false;

          List res = data.records;

          List<SystemMsg> list = [];
          for (int i = 0; i < res.length; i++) {
            list.add(SystemMsg.fromJson(res[i]));
          }

          if (data.current == 1) {
            state.list = list;
          } else {
            state.list.addAll(list);
          }

          /// 将数据返回
          completer.complete(data);
          update();
        },
        fail: (code, msg) {
          /// 重置列表状态关闭
          state.reload = false;
          /// 将错误code输出
          completer.completeError(code);
        },);

    return completer.future;
  }

  /// 查看更多
  seeMore() {
    state.num = 5;
    update();
  }
}