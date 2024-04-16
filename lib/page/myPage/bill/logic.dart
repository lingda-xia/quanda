import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/personal.dart';
import 'package:quanda/model/LongList.dart';
import 'package:quanda/model/personal/BillEntity.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 账单的逻辑层
class BillLogic extends GetxController {
  BillState state = BillState();

  @override
  void onInit() {
    super.onInit();
  }

  /// 获取账单列表
  Future<LongList> getList(String time, int listPage) {
    /// 等待请求完成
    Completer<LongList> completer = Completer();

    /// 发起请求
    PersonalRequest.accountList(
        time: time,
        listPage: listPage,
        success: (data) {
          /// 列表数据
          List res = data.records;

          List<BillEntity> list = [];
          for (int i = 0; i < res.length; i++) {
            list.add(BillEntity.fromJson(res[i]));
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
          /// 将错误code输出
          completer.completeError(code);
        });

    return completer.future;
  }

  /// 前往搜索页
  void goToSearchPage() {
    Get.toNamed(RouteConfig.search);
  }
}
