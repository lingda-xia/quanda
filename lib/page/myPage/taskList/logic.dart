import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/interaction.dart';
import 'package:quanda/model/LongList.dart';
import 'package:quanda/model/publish/TaskOrder.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 任务人列表的逻辑层
class TaskListLogic extends GetxController {
  TaskListState state = TaskListState();

  @override
  void onInit() {
    super.onInit();

    state.id = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();

    /// 倒计时
    countDown();
  }

  @override
  void onClose() {
    super.onClose();
    if (state.timer != null) {
      state.timer.cancel();
    }
  }

  /// 获取任务人列表
  Future<LongList> getList(int page) {
    /// 等待请求完成
    Completer<LongList> completer = Completer();

    /// 发起请求
    InteractionRequest.taskOrderList(
        taskId: state.id,
        page: page,
        success: (data) {
          /// 重置列表状态关闭
          state.reload = false;

          /// 列表数据
          List res = data.records;

          List<TaskOrder> list = [];
          for (int i = 0; i < res.length; i++) {
            list.add(TaskOrder.fromJson(res[i]));
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

  /// 倒计时
  countDown() {
    state.timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      update();
    });
  }

  /// 前往私聊页面
  void goToPrivateChat(int id, String name) {
    Get.toNamed("${RouteConfig.privateChat}?id=$id&name=$name");
  }
}
