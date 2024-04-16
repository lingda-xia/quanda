import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/personal.dart';
import 'package:quanda/model/LongList.dart';
import 'package:quanda/model/personal/FeedbackInfo.dart';
import 'state.dart';

/// 历史反馈的逻辑层
class HistoricalFeedbackLogic extends GetxController {
  HistoricalFeedbackState state = HistoricalFeedbackState();

  @override
  void onInit() {
    super.onInit();
  }

  /// 获取发布列表
  Future<LongList> getList(int page) async {
    /// 等待请求完成
    Completer<LongList> completer = Completer();

    /// 发起请求
    PersonalRequest.feedBackList(
        page: page,
        success: (data) {
          /// 重置列表状态关闭
          state.reload = false;

          List res = data.records;

          List<FeedbackInfo> list = [];

          for (int i = 0; i < res.length; i++) {
            list.add(FeedbackInfo.fromJson(res[i]));
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

}
