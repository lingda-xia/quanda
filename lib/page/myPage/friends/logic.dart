import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 好友的逻辑层
class FriendsLogic extends GetxController {
  FriendsState state = FriendsState();

  @override
  void onInit() {
    super.onInit();
  }

  /// 前往搜索页
  void goToSearchPage() {
    Get.toNamed(RouteConfig.search);
  }

  /// 更新复选框的值
  void upDateChecked(index) {
    /// 取消选择好友
    if (state.friendsList[index].isChecked) {
      /// 取消选择好友
      state.friendsList[index].isChecked = false;

    } else {
      /// 选择好友
      state.friendsList[index].isChecked = true;
    }
    update();
  }


}
