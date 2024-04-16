import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/personal.dart';
import 'package:quanda/model/LongList.dart';
import 'package:quanda/model/personal/FollowEntity.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 粉丝关注的逻辑层
class FansFollowLogic extends GetxController {
  FansFollowState state = FansFollowState();

  @override
  void onInit() {
    super.onInit();
  }

  /// 获取关注和粉丝列表
  Future<LongList> getList(int type, int page) {
    /// 等待请求完成
    Completer<LongList> completer = Completer();

    /// 发起请求
    PersonalRequest.followList(
        type: type,
        page: page,
        success: (data) {
          /// 重置列表状态关闭
          state.reload[type] = false;
          /// 列表数据
          List res = data.records;

          List<FollowEntity> list = [];
          for (int i = 0; i < res.length; i++) {
            list.add(FollowEntity.fromJson(res[i]));
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
        });

    return completer.future;
  }

  /// 前往核验码
  void goToVerificationCode() {
    Get.toNamed(RouteConfig.verificationCode);
  }

}
