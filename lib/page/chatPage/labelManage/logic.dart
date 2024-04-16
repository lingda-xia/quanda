import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/chat.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 标签管理的逻辑层
class LabelManageLogic extends GetxController {
  LabelManageState state = LabelManageState();

  @override
  void onInit() {
    super.onInit();
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

  /// 删除标签
  tagDel(String id) {
    /// 发起请求
    ChatRequest.tagDel(
      id: id,
      success: (data) {
        /// 获取标签列表
        tagList();
      },
      fail: (code, msg) {},
    );
  }

  /// 前往新建标签页
  void goToNewLabel() async {
    var data = await Get.toNamed(RouteConfig.newLabel);
    if(data == "success") {
      /// 获取标签列表
      tagList();
    }
  }

  /// 前往设置标签页面
  void goToSetLabel(int id, String name) async {
    var data = await Get.toNamed("${RouteConfig.setLabel}?id=$id&name=$name");
    if(data == "success") {
      /// 获取标签列表
      tagList();
    }
  }
}
