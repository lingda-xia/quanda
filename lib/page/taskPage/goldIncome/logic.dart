import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/task.dart';
import 'package:quanda/model/LongList.dart';
import 'package:quanda/model/task/ProfitEntity.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 金币收益 的逻辑层
class GoldIncomeLogic extends GetxController {
  GoldIncomeState state = GoldIncomeState();

  @override
  void onInit() {
    super.onInit();
  }

  /// 获取收益列表
  Future<LongList> getList(int type, int page) {
    /// 等待请求完成
    Completer<LongList> completer = Completer();

    /// 发起请求
    TaskRequest.profitList(
        type: type,
        page: page,
        success: (data) {
          /// 重置列表状态关闭
          state.reload[type] = false;

          /// 列表数据
          List res = data.records;

          List<ProfitEntity> list = [];
          for (int i = 0; i < res.length; i++) {
            list.add(ProfitEntity.fromJson(res[i]));
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
        },);

    return completer.future;
  }

  /// 前往核验码
  void goToVerificationCode() {
    Get.toNamed(RouteConfig.verificationCode);
  }

}
