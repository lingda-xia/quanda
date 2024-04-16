import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/chat.dart';
import 'package:quanda/model/chat/LabelEntity.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 选择标签的逻辑层
class SelectLabelLogic extends GetxController {
  SelectLabelState state = SelectLabelState();

  @override
  void onInit() {
    super.onInit();
    if(Get.arguments != null) {
      state.id = Get.arguments;
    }
  }

  @override
  void onReady() {
    super.onReady();

    /// 获取标签列表
    tagList();
  }

  /// 获取标签列表
  tagList() {
    /// 发起请求
    ChatRequest.tagList(
      success: (data) {
        state.list = data;
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 移动好友到标签
  tagFriendMove() {
    /// 发起请求
    ChatRequest.tagFriendMove(
      tagId: state.select.id.toString(),
      toUserId: state.id,
      success: (data) {
        Get.back(result: "success");
      },
      fail: (code, msg) {},
    );
  }

  /// 确定
  determine() {
    /// 表示从查看好友信息页面过来的  需要更换标签
    if(state.id != "") {
      /// 移动好友到标签
      tagFriendMove();
    } else {
      /// 验证好友页面所需值
      Get.back(result: state.select);
    }
  }

  /// 前往搜索页
  void goToSearchPage() {
    Get.toNamed(RouteConfig.search);
  }

  /// 选择标签
  void onChanged(LabelEntity value) {
    state.select = value;
    update();
  }
}