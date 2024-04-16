import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/personal.dart';
import 'package:quanda/model/LongList.dart';
import 'package:quanda/model/personal/CollectEntity.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/widget/custom_dialog.dart';
import 'state.dart';

/// 我的收藏的逻辑层
class MyCollectionLogic extends GetxController {
  MyCollectionState state = MyCollectionState();

  @override
  void onInit() {
    super.onInit();
  }

  /// 获取收藏列表
  Future<LongList> getList(int type, int page) {
    /// 等待请求完成
    Completer<LongList> completer = Completer();

    /// 发起请求
    PersonalRequest.collectList(
      type: type,
      page: page,
      success: (data) {
        /// 重置列表状态关闭
        state.reload[type] = false;

        /// 列表数据
        List res = data.records;

        List<CollectEntity> list = [];
        for (int i = 0; i < res.length; i++) {
          list.add(CollectEntity.fromJson(res[i]));
        }

        if (data.current == 1) {
          state.listMap[type] = list;
        } else {
          state.listMap[type]?.addAll(list);
        }

        /// 将数据返回
        completer.complete(data);
        update();
      },
      fail: (code, msg) {
        /// 重置列表状态关闭
        state.reload[type] = false;

        /// 将错误code输出
        completer.completeError(code);
      },
    );

    return completer.future;
  }

  /// 删除收藏
  collectDel(int id, int type) {
    /// 发起请求
    PersonalRequest.collectDel(
      ids: [id],
      success: (data) {
        /// 重置列表状态
        state.reload[type] = true;
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 打开提示对话框
  Future openDialog(int id, int type) async {
    await Get.dialog(
      /// 自定义对话框
      CustomDialog(
        /// 确认事件
        confirm: () => collectDel(id, type),

        /// 内容
        content: "是否删除该收藏",

        /// 取消文本
        cancelText: "取消",

        /// 确认文本
        confirmText: "确认",
      ),

      /// 打开蒙层
      barrierDismissible: false,
    );
  }
}
